<template>
  <div class="my-achievement-page">
    <PageHeader title="我的课程达成度" subtitle="查看本学期每门课的目标达成情况，了解自身知识掌握程度" :icon="DataAnalysis">
      <template #actions>
        <el-select v-model="selectedOfferingId" placeholder="选择开课" style="width:300px" @change="fetch">
          <el-option
            v-for="o in offerings"
            :key="o.offeringId"
            :label="`${o.semester} · ${o.clazzNo} · ${courseNameOf(o)}`"
            :value="o.offeringId"
          />
        </el-select>
      </template>
    </PageHeader>

    <EmptyState v-if="!loading && !offerings.length" description="暂无可查看的开课" hint="请联系任课教师添加您到班级" />

    <template v-else>
      <el-row v-if="data" :gutter="16" class="stat-row">
        <el-col :xs="24" :sm="8">
          <StatCard
            label="总达成度"
            :value="(Number(data.totalAchievement || 0) * 100).toFixed(1)"
            suffix="%"
            :variant="totalVariant"
            :icon="DataAnalysis"
            :hint="totalHint"
          />
        </el-col>
        <el-col :xs="24" :sm="8">
          <StatCard label="加权得分" :value="Number(data.totalWeightedScore || 0).toFixed(1)" :icon="Trophy" hint="Σ(实际得分 × 权重)" />
        </el-col>
        <el-col :xs="24" :sm="8">
          <StatCard label="加权满分" :value="Number(data.totalWeightedMax || 0).toFixed(1)" :icon="Medal" hint="Σ(满分 × 权重)" />
        </el-col>
      </el-row>

      <TableCard v-if="data" title="各课程目标达成情况" subtitle="达成度 ≥ 100% 表示该目标已达成" :icon="Aim">
        <div v-loading="loading">
          <div v-for="(value, objId) in (data.objectiveAchievements || {})" :key="objId" class="obj-row">
            <div class="obj-header">
              <div class="obj-info">
                <span class="obj-code">{{ objMap[objId]?.code || `目标 ${objId}` }}</span>
                <p v-if="objMap[objId]?.description" class="obj-desc">{{ objMap[objId].description }}</p>
              </div>
              <el-tag :type="Number(value) >= 1 ? 'success' : (Number(value) >= 0.7 ? 'warning' : 'danger')" size="large">
                {{ (Number(value) * 100).toFixed(1) }}%
              </el-tag>
            </div>
            <el-progress
              :percentage="Math.min(100, Number(value) * 100)"
              :status="Number(value) >= 1 ? 'success' : (Number(value) >= 0.7 ? 'warning' : 'exception')"
              :stroke-width="14"
              :format="(v) => `${v.toFixed(0)}%`"
            />
          </div>
        </div>
      </TableCard>

      <EmptyState v-else-if="!loading" description="请选择开课查看您的达成度" hint="使用上方下拉切换" />
    </template>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { DataAnalysis, Trophy, Medal, Aim } from '@element-plus/icons-vue'
import { achievementApi, studentTeachingApi } from '@/api'
import PageHeader from '@/components/common/PageHeader.vue'
import TableCard from '@/components/common/TableCard.vue'
import StatCard from '@/components/common/StatCard.vue'
import EmptyState from '@/components/common/EmptyState.vue'

const offerings = ref([])
const selectedOfferingId = ref(null)
const data = ref(null)
const loading = ref(false)
const objMap = ref({})
const courseMap = ref({})

const totalVariant = computed(() => {
  const v = Number(data.value?.totalAchievement || 0)
  if (v >= 1) return 'success'
  if (v >= 0.7) return 'warning'
  return 'danger'
})
const totalHint = computed(() => {
  const v = Number(data.value?.totalAchievement || 0)
  if (v >= 1) return '已达成课程期望'
  if (v >= 0.7) return '接近达成，建议巩固薄弱点'
  return '未达成，需重点关注'
})

const courseNameOf = (o) => courseMap.value[o.courseId]?.nameCn || `课程#${o.courseId}`

const loadOfferings = async () => {
  console.log('[达成度] 开始加载开课列表...')
  try {
    const res = await studentTeachingApi.myOfferings()
    console.log('[达成度] 开课列表API响应:', res)
    console.log('[达成度] 开课数据:', res.data)
    offerings.value = res.data || []
    console.log('[达成度] 加载到', offerings.value.length, '个开课')
    if (offerings.value.length) {
      selectedOfferingId.value = offerings.value[0].offeringId
      console.log('[达成度] 自动选择第一个开课:', selectedOfferingId.value)
      await fetch()
    } else {
      console.log('[达成度] 没有开课数据')
    }
  } catch (e) {
    console.error('[达成度] 加载开课列表失败:', e)
    throw e
  }
}

const loadCourses = async () => {
  try {
    const allOfferings = offerings.value
    courseMap.value = Object.fromEntries(
      allOfferings.filter(o => o.courseName).map(o => [o.courseId, { nameCn: o.courseName }])
    )
    console.log('[达成度] 课程映射:', courseMap.value)
  } catch (e) { /* ignore */ }
}

const fetch = async () => {
  if (!selectedOfferingId.value) return
  loading.value = true
  console.log('[达成度] 加载达成度数据, offeringId:', selectedOfferingId.value)
  try {
    const res = await achievementApi.mine(selectedOfferingId.value)
    console.log('[达成度] 达成度API响应:', res)
    console.log('[达成度] 达成度数据:', res.data)
    data.value = res.data
    const offering = offerings.value.find(o => o.offeringId === selectedOfferingId.value)
    console.log('[达成度] 当前开课:', offering)
    if (offering?.courseId) {
      try {
        const objRes = await studentTeachingApi.objectives(offering.courseId)
        console.log('[达成度] 课程目标:', objRes.data)
        objMap.value = Object.fromEntries((objRes.data || []).map(o => [o.objectiveId, o]))
      } catch (e) {
        console.warn('[达成度] 加载课程目标失败:', e)
      }
    }
  } catch (e) {
    console.error('[达成度] 加载达成度失败:', e)
    ElMessage.error('加载达成度失败：' + (e?.message || e))
  } finally {
    loading.value = false
  }
}

onMounted(async () => {
  console.log('[达成度] 页面挂载，开始加载数据...')
  console.log('[达成度] 当前token:', localStorage.getItem('token') ? '已设置' : '未设置')
  try {
    await loadOfferings()
    await loadCourses()
  } catch (e) {
    console.error('[达成度] 初始化失败:', e)
    ElMessage.error('加载开课列表失败：' + (e?.message || e))
  }
})
</script>

<style lang="scss" scoped>
.my-achievement-page { padding: 20px; }
.stat-row { margin-bottom: 16px; }

.obj-row {
  padding: 18px 0;
  border-bottom: 1px dashed #f0f0f0;
  &:last-child { border-bottom: none; }
}

.obj-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 10px;
  gap: 12px;
}

.obj-info { flex: 1; min-width: 0; }

.obj-code {
  font-weight: 600;
  color: #1d1d1f;
  font-size: 14px;
}

.obj-desc {
  margin: 4px 0 0 0;
  font-size: 12px;
  color: #6e6e73;
  line-height: 1.5;
}
</style>
