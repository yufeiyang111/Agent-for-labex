<template>
  <div class="my-achievement-page">
    <el-card>
      <template #header>
        <div class="card-header">
          <span class="title">我的课程达成度</span>
          <el-select v-model="selectedOfferingId" placeholder="选择开课" style="width:300px" @change="fetch">
            <el-option v-for="o in offerings" :key="o.offeringId" :label="`${o.semester} - ${o.clazzNo}`" :value="o.offeringId" />
          </el-select>
        </div>
      </template>

      <div v-if="!data" class="empty">
        <el-empty description="请选择开课查看您的达成度" />
      </div>
      <div v-else v-loading="loading">
        <el-row :gutter="20">
          <el-col :span="8">
            <el-statistic title="总达成度" :value="(Number(data.totalAchievement || 0) * 100).toFixed(2)" suffix="%" />
          </el-col>
          <el-col :span="8">
            <el-statistic title="加权得分" :value="Number(data.totalWeightedScore || 0).toFixed(2)" />
          </el-col>
          <el-col :span="8">
            <el-statistic title="加权满分" :value="Number(data.totalWeightedMax || 0).toFixed(2)" />
          </el-col>
        </el-row>

        <el-divider>各课程目标达成情况</el-divider>

        <div v-for="(value, objId) in (data.objectiveAchievements || {})" :key="objId" class="obj-row">
          <div class="obj-header">
            <span>{{ objMap[objId]?.code || `目标 ${objId}` }}</span>
            <el-tag :type="Number(value) >= 1 ? 'success' : 'warning'">
              达成度：{{ (Number(value) * 100).toFixed(2) }}%
            </el-tag>
          </div>
          <el-progress :percentage="Math.min(100, Number(value) * 100)" :status="Number(value) >= 1 ? 'success' : 'warning'" />
          <p class="muted" v-if="objMap[objId]?.description">{{ objMap[objId].description }}</p>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { achievementApi, offeringApi, objectiveApi } from '@/api'

const offerings = ref([])
const selectedOfferingId = ref(null)
const data = ref(null)
const loading = ref(false)
const objMap = ref({})

onMounted(async () => {
  // 简化：从教师端列表 API 取所有开课（实际应有学生专属端点）
  const res = await offeringApi.list()
  offerings.value = res.data || []
  if (offerings.value.length) {
    selectedOfferingId.value = offerings.value[0].offeringId
    fetch()
  }
})

const fetch = async () => {
  if (!selectedOfferingId.value) return
  loading.value = true
  try {
    const res = await achievementApi.mine(selectedOfferingId.value)
    data.value = res.data
    const offering = offerings.value.find(o => o.offeringId === selectedOfferingId.value)
    if (offering?.courseId) {
      const objRes = await objectiveApi.list(offering.courseId)
      objMap.value = Object.fromEntries((objRes.data || []).map(o => [o.objectiveId, o]))
    }
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.my-achievement-page { padding: 20px; }
.card-header { display: flex; justify-content: space-between; align-items: center; }
.title { font-weight: 600; font-size: 16px; }
.muted { color: #909399; font-size: 13px; }
.empty { padding: 40px 0; }
.obj-row { padding: 14px 0; border-bottom: 1px solid #ebeef5; }
.obj-row:last-child { border-bottom: none; }
.obj-header { display: flex; justify-content: space-between; margin-bottom: 6px; font-weight: 500; }
</style>
