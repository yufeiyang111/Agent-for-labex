<template>
  <div class="training-page">
    <el-card class="page-header">
      <div class="header-content">
        <div>
          <h2>题目训练</h2>
          <p class="subtitle">教师发布的训练集，自主练习，自动批改</p>
        </div>
      </div>
    </el-card>

    <div v-loading="loading" class="training-list">
      <el-empty v-if="trainingSets.length === 0 && !loading" description="暂无可用训练集" />

      <transition-group name="list" tag="div" class="card-grid">
        <el-card v-for="ts in trainingSets" :key="ts.trainingSetId" class="training-card" shadow="hover">
          <div class="card-top">
            <div class="ts-name">{{ ts.name }}</div>
          </div>

          <div class="ts-desc">{{ ts.description || '暂无描述' }}</div>

          <div class="ts-meta">
            <div class="meta-item">
              <el-icon><Tickets /></el-icon>
              <span>{{ ts.questionCount }} 题</span>
            </div>
            <div class="meta-item">
              <el-icon><Histogram /></el-icon>
              <span>总分 {{ ts.totalScore || 0 }}</span>
            </div>
            <div class="meta-item" v-if="getBestRecord(ts.trainingSetId)">
              <el-icon><SuccessFilled /></el-icon>
              <span>最高分 {{ getBestRecord(ts.trainingSetId)?.score ?? '-' }}</span>
            </div>
          </div>

          <div class="card-footer">
            <el-button type="primary" @click="startPractice(ts)">
              <el-icon><Edit /></el-icon>
              开始练习
            </el-button>
            <el-button plain @click="viewHistory(ts)" :disabled="!hasRecords(ts.trainingSetId)">
              <el-icon><View /></el-icon>
              历史记录
            </el-button>
          </div>
        </el-card>
      </transition-group>
    </div>

    <el-dialog v-model="historyDialogVisible" :title="'历史记录 - ' + (historyTs?.name || '')" width="760px">
      <el-table :data="historyRecords" stripe v-loading="historyLoading" height="400">
        <el-table-column label="尝试次数" width="120">
          <template #default="{ row }">第 {{ row.attemptCount }} 次</template>
        </el-table-column>
        <el-table-column label="得分" width="140">
          <template #default="{ row }">{{ row.score ?? '-' }} / {{ row.totalScore }}</template>
        </el-table-column>
        <el-table-column label="提交时间" min-width="180">
          <template #default="{ row }">{{ formatDate(row.submitTime) }}</template>
        </el-table-column>
        <el-table-column label="操作" width="120">
          <template #default="{ row }">
            <el-button size="small" type="primary" plain @click="viewResult(row)">查看结果</el-button>
          </template>
        </el-table-column>
      </el-table>
      <template #footer>
        <el-button @click="historyDialogVisible = false">关闭</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Edit, View, Tickets, Histogram, SuccessFilled } from '@element-plus/icons-vue'
import { trainingApi } from '@/api'

const router = useRouter()
const loading = ref(false)
const trainingSets = ref([])
const myRecords = ref({})

const historyDialogVisible = ref(false)
const historyLoading = ref(false)
const historyTs = ref(null)
const historyRecords = ref([])

function formatDate(date) {
  if (!date) return '-'
  return new Date(date).toLocaleString('zh-CN')
}

function getBestRecord(trainingSetId) {
  const records = myRecords.value[trainingSetId]
  if (!records || records.length === 0) return null
  return records.reduce((best, r) => {
    const bestScore = best.score ?? 0
    const rScore = r.score ?? 0
    return rScore > bestScore ? r : best
  })
}

function hasRecords(trainingSetId) {
  const records = myRecords.value[trainingSetId]
  return records && records.length > 0
}

async function loadTrainingSets() {
  loading.value = true
  try {
    const res = await trainingApi.student.list()
    trainingSets.value = res.data || []

    // Load records for each training set
    const recordPromises = trainingSets.value.map(async (ts) => {
      try {
        const recRes = await trainingApi.student.myRecords(ts.trainingSetId)
        myRecords.value[ts.trainingSetId] = recRes.data || []
      } catch {
        myRecords.value[ts.trainingSetId] = []
      }
    })
    await Promise.all(recordPromises)
  } catch {
    ElMessage.error('加载训练集失败')
  } finally {
    loading.value = false
  }
}

function startPractice(ts) {
  router.push(`/student/training/${ts.trainingSetId}/practice`)
}

async function viewHistory(ts) {
  historyTs.value = ts
  historyDialogVisible.value = true
  historyLoading.value = true
  try {
    const res = await trainingApi.student.myRecords(ts.trainingSetId)
    historyRecords.value = res.data || []
  } catch {
    ElMessage.error('加载历史记录失败')
  } finally {
    historyLoading.value = false
  }
}

function viewResult(record) {
  historyDialogVisible.value = false
  router.push(`/student/training/${historyTs.value.trainingSetId}/result/${record.id}`)
}

onMounted(loadTrainingSets)
</script>

<style lang="scss" scoped>
.training-page {
  max-width: 1360px;
  margin: 0 auto;
}

.page-header {
  margin-bottom: 20px;
  border-radius: 8px;
  border: 1px solid #d9dee7;
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

h2 {
  margin: 0;
  font-size: 22px;
  color: #1f2a3d;
}

.subtitle {
  margin: 8px 0 0;
  color: #667085;
}

.card-grid {
  display: grid;
  gap: 16px;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
}

.training-card {
  border-radius: 8px;
  border: 1px solid #d9dee7;
}

.card-top {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  border-bottom: 1px solid #eceff4;
  padding-bottom: 10px;
}

.ts-name {
  font-size: 16px;
  font-weight: 600;
  color: #111827;
}

.ts-desc {
  margin-top: 12px;
  color: #475467;
  min-height: 44px;
  line-height: 1.6;
}

.ts-meta {
  margin-top: 12px;
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 6px;
  color: #475467;
  font-size: 13px;
}

.card-footer {
  margin-top: 14px;
  display: flex;
  justify-content: space-between;
}

.list-enter-active,
.list-leave-active {
  transition: all 0.25s ease;
}
.list-enter-from,
.list-leave-to {
  opacity: 0;
  transform: translateY(10px);
}
</style>
