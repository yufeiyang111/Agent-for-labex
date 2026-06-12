<template>
  <div class="achievement-dashboard-page">
    <el-page-header @back="$router.back()" :content="`达成度分析 - 开课ID ${offeringId}`" />

    <el-row :gutter="20" class="mt-4">
      <el-col :span="12">
        <el-card>
          <template #header><span class="title">课程总目标达成情况</span></template>
          <div class="big-stat">
            <span class="stat-value">{{ (data.overallReachedRatio * 100).toFixed(2) }}%</span>
            <span class="stat-label">学生达到课程总目标比例</span>
          </div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <template #header><span class="title">操作</span></template>
          <el-button type="primary" :icon="Refresh" @click="onRecalc" :loading="loading">重新计算</el-button>
          <el-button type="success" :icon="Picture" @click="onSnapshot">创建快照</el-button>
          <p class="muted mt-2">快照用于评价报告固化历史数据</p>
        </el-card>
      </el-col>
    </el-row>

    <el-card class="mt-4">
      <template #header><span class="title">各课程目标达成度</span></template>
      <el-table :data="objectiveSummary" stripe v-loading="loading">
        <el-table-column prop="code" label="目标" width="160" />
        <el-table-column prop="description" label="描述" />
        <el-table-column label="达成度" width="140" align="center">
          <template #default="{ row }">
            <el-progress
              :percentage="Math.min(100, Number(row.value || 0) * 100)"
              :status="Number(row.value || 0) >= 1 ? 'success' : 'warning'"
            />
          </template>
        </el-table-column>
        <el-table-column label="达到/总数" width="120" align="center">
          <template #default="{ row }">{{ row.reachedCount }} / {{ row.totalCount }}</template>
        </el-table-column>
        <el-table-column label="班级平均" width="120" align="center">
          <template #default="{ row }">{{ (Number(row.avgScore || 0) * 100).toFixed(2) }}%</template>
        </el-table-column>
      </el-table>
    </el-card>

    <el-card class="mt-4">
      <template #header>
        <div class="card-header">
          <span class="title">学生明细</span>
          <el-input v-model="searchKeyword" placeholder="搜索学号/姓名" clearable style="width:240px" />
        </div>
      </template>
      <el-table :data="filteredStudents" stripe v-loading="loading" :max-height="500" border>
        <el-table-column prop="studentNo" label="学号" width="120" fixed />
        <el-table-column prop="studentName" label="姓名" width="120" fixed />
        <el-table-column
          v-for="obj in objectiveSummary"
          :key="obj.objectiveId"
          :label="obj.code"
          width="140"
          align="center"
        >
          <template #default="{ row }">
            <el-tag
              :type="(row.objectiveAchievements?.[obj.objectiveId] || 0) >= 1 ? 'success' : 'warning'"
              size="small"
            >
              {{ ((row.objectiveAchievements?.[obj.objectiveId] || 0) * 100).toFixed(2) }}%
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="总达成度" width="140" align="center" fixed="right">
          <template #default="{ row }">
            <el-tag :type="Number(row.totalAchievement || 0) >= 1 ? 'success' : 'danger'">
              {{ (Number(row.totalAchievement || 0) * 100).toFixed(2) }}%
            </el-tag>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Refresh, Picture } from '@element-plus/icons-vue'
import { achievementApi } from '@/api'

const route = useRoute()
const offeringId = computed(() => Number(route.params.offeringId))

const data = ref({ byObjective: {}, overallReachedRatio: 0, students: [] })
const loading = ref(false)
const searchKeyword = ref('')

const objectiveSummary = computed(() => Object.values(data.value.byObjective || {}))
const filteredStudents = computed(() => {
  if (!searchKeyword.value) return data.value.students || []
  const kw = searchKeyword.value.toLowerCase()
  return (data.value.students || []).filter(s =>
    s.studentNo?.includes(kw) || s.studentName?.toLowerCase().includes(kw)
  )
})

const fetch = async () => {
  loading.value = true
  try {
    const res = await achievementApi.offering(offeringId.value)
    data.value = res.data || { byObjective: {}, overallReachedRatio: 0, students: [] }
  } finally {
    loading.value = false
  }
}
onMounted(fetch)

const onRecalc = async () => {
  await achievementApi.recalc(offeringId.value)
  ElMessage.success('已重新计算')
  fetch()
}
const onSnapshot = async () => {
  await achievementApi.snapshot(offeringId.value, 'manual snapshot')
  ElMessage.success('快照已创建')
}
</script>

<style scoped>
.achievement-dashboard-page { padding: 20px; }
.card-header { display: flex; justify-content: space-between; align-items: center; }
.title { font-weight: 600; font-size: 16px; }
.muted { color: #909399; font-size: 13px; }
.mt-4 { margin-top: 16px; }
.mt-2 { margin-top: 8px; }
.big-stat { text-align: center; padding: 30px 0; }
.stat-value { display: block; font-size: 48px; font-weight: 700; color: #409eff; }
.stat-label { display: block; color: #606266; margin-top: 8px; }
</style>
