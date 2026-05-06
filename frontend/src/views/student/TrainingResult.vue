<template>
  <div class="result-page" v-loading="loading">
    <el-card class="result-header">
      <div class="header-left">
        <el-button @click="goBack" text>
          <el-icon><ArrowLeft /></el-icon> 返回
        </el-button>
        <h2>{{ result?.trainingSetName || '答题结果' }}</h2>
      </div>
      <div class="header-right">
        <el-button type="primary" @click="retry">再来一次</el-button>
      </div>
    </el-card>

    <el-card class="score-card" v-if="result">
      <div class="score-overview">
        <div class="score-main">
          <div class="score-circle" :class="scoreGradeClass">
            <div class="score-number">{{ result.score ?? 0 }}</div>
            <div class="score-divider">/</div>
            <div class="score-total">{{ result.totalScore }}</div>
          </div>
          <div class="score-label">
            第 {{ result.attemptCount }} 次尝试
          </div>
        </div>
        <div class="score-stats">
          <div class="stat-item">
            <div class="stat-value correct-count">{{ correctCount }}</div>
            <div class="stat-label">正确</div>
          </div>
          <div class="stat-item">
            <div class="stat-value wrong-count">{{ wrongCount }}</div>
            <div class="stat-label">错误</div>
          </div>
          <div class="stat-item">
            <div class="stat-value">{{ result.totalQuestions || questionResults.length }}</div>
            <div class="stat-label">总题数</div>
          </div>
          <div class="stat-item">
            <div class="stat-value">{{ formatDate(result.submitTime) }}</div>
            <div class="stat-label">提交时间</div>
          </div>
        </div>
      </div>
    </el-card>

    <el-card class="questions-card" v-if="questionResults.length > 0">
      <template #header>
        <div class="card-header">
          <span>题目详情</span>
        </div>
      </template>

      <div
        v-for="(item, idx) in questionResults"
        :key="item.questionId"
        class="question-item"
        :class="{ 'is-correct': isCorrect(item), 'is-wrong': !isCorrect(item) && item.score !== null }"
      >
        <div class="q-head">
          <div class="q-left">
            <span class="q-index">第 {{ idx + 1 }} 题</span>
            <el-tag size="small" effect="plain">{{ getTypeName(item.type) }}</el-tag>
            <el-tag :type="isCorrect(item) ? 'success' : (item.score === null ? 'warning' : 'danger')" size="small">
              {{ isCorrect(item) ? '正确' : (item.score === null ? '待批改' : '错误') }}
            </el-tag>
          </div>
          <div class="q-score">
            得分：<span :class="isCorrect(item) ? 'text-correct' : 'text-wrong'">{{ item.score ?? '-' }}</span> / {{ item.maxScore ?? '-' }}
          </div>
        </div>

        <div class="q-content" v-html="item.question" />

        <div class="q-answers">
          <div class="answer-row">
            <span class="label">你的答案：</span>
            <span class="value">{{ item.myAnswer || '(未作答)' }}</span>
          </div>
          <div class="answer-row">
            <span class="label correct-label">正确答案：</span>
            <span class="value correct-value">{{ item.correctAnswer || '(无)' }}</span>
          </div>
        </div>

        <div class="q-analysis" v-if="item.analysis">
          <span class="label">解析：</span>
          <span class="value">{{ item.analysis }}</span>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowLeft } from '@element-plus/icons-vue'
import { trainingApi } from '@/api'

const route = useRoute()
const router = useRouter()
const trainingSetId = Number(route.params.id)
const attemptId = Number(route.params.attemptId)

const loading = ref(false)
const result = ref(null)
const questionResults = ref([])

const correctCount = computed(() => questionResults.value.filter((item) => isCorrect(item)).length)
const wrongCount = computed(() => questionResults.value.filter((item) => !isCorrect(item) && item.score !== null).length)

const scoreGradeClass = computed(() => {
  if (!result.value) return ''
  const pct = result.value.totalScore > 0 ? (result.value.score / result.value.totalScore) : 0
  if (pct >= 0.8) return 'grade-excellent'
  if (pct >= 0.6) return 'grade-pass'
  return 'grade-fail'
})

const typeMap = { 1: '填空', 2: '单选', 3: '多选', 4: '判断', 5: '简答', 6: '编程', 7: '综合' }

function getTypeName(type) {
  return typeMap[type] || `类型${type || '-'}`
}

function isCorrect(item) {
  if (item.isCorrect === 1) return true
  if (item.isCorrect === 0) return false
  if (item.score !== null && item.maxScore && item.score >= item.maxScore) return true
  return false
}

function formatDate(date) {
  if (!date) return '-'
  return new Date(date).toLocaleString('zh-CN')
}

async function loadResult() {
  loading.value = true
  try {
    const res = await trainingApi.student.getResult(trainingSetId, attemptId)
    const data = res.data
    result.value = data

    const qResults = data.questionResults || []
    // Enrich with maxScore (infer from score and isCorrect)
    questionResults.value = qResults.map((r) => {
      // Try to get maxScore — for correct answers, score = maxScore
      let maxScore = r.maxScore
      if (maxScore === undefined || maxScore === null) {
        if (r.isCorrect === 1 && r.score !== null) {
          maxScore = r.score
        }
      }
      return { ...r, maxScore: maxScore ?? r.score ?? 0 }
    })
  } catch {
    ElMessage.error('加载结果失败')
  } finally {
    loading.value = false
  }
}

function goBack() {
  router.push('/student/training')
}

async function retry() {
  try {
    await trainingApi.student.retry(trainingSetId)
    router.push(`/student/training/${trainingSetId}/practice`)
  } catch {
    ElMessage.error('重试失败')
  }
}

onMounted(loadResult)
</script>

<style lang="scss" scoped>
.result-page {
  max-width: 1000px;
  margin: 0 auto;
}

.result-header {
  margin-bottom: 16px;
  border-radius: 8px;
  border: 1px solid #d9dee7;
}

.result-header :deep(.el-card__body) {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 12px;

  h2 {
    margin: 0;
    font-size: 18px;
    color: #1f2a3d;
  }
}

.header-right {
  display: flex;
  gap: 8px;
}

.score-card {
  margin-bottom: 16px;
  border-radius: 8px;
  border: 1px solid #d9dee7;
}

.score-overview {
  display: flex;
  align-items: center;
  gap: 40px;
}

.score-main {
  text-align: center;
}

.score-circle {
  display: flex;
  align-items: baseline;
  justify-content: center;
  gap: 4px;
  width: 120px;
  height: 120px;
  border-radius: 50%;
  border: 4px solid #e5e7eb;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-bottom: 8px;
}

.score-circle .score-number {
  font-size: 32px;
  font-weight: 700;
}

.score-circle .score-divider {
  font-size: 18px;
  color: #9ca3af;
}

.score-circle .score-total {
  font-size: 18px;
  color: #6b7280;
}

.score-circle.grade-excellent {
  border-color: #059669;
  .score-number { color: #059669; }
}

.score-circle.grade-pass {
  border-color: #f59e0b;
  .score-number { color: #f59e0b; }
}

.score-circle.grade-fail {
  border-color: #ef4444;
  .score-number { color: #ef4444; }
}

.score-label {
  color: #6b7280;
  font-size: 13px;
}

.score-stats {
  display: flex;
  gap: 32px;
  flex: 1;
}

.stat-item {
  text-align: center;
}

.stat-value {
  font-size: 22px;
  font-weight: 700;
}

.stat-label {
  font-size: 12px;
  color: #6b7280;
  margin-top: 4px;
}

.correct-count { color: #059669; }
.wrong-count { color: #ef4444; }

.questions-card {
  border-radius: 8px;
  border: 1px solid #d9dee7;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.question-item {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 16px;
  margin-bottom: 12px;
  transition: all 0.2s;
}

.question-item.is-correct {
  border-left: 4px solid #059669;
}

.question-item.is-wrong {
  border-left: 4px solid #ef4444;
}

.q-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.q-left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.q-index {
  font-weight: 600;
  color: #111827;
}

.q-score {
  font-size: 14px;
  color: #374151;

  .text-correct { color: #059669; font-weight: 600; }
  .text-wrong { color: #ef4444; font-weight: 600; }
}

.q-content {
  padding: 10px 0;
  line-height: 1.7;
  color: #101828;
  white-space: pre-wrap;
  border-top: 1px solid #eceff4;
  border-bottom: 1px solid #eceff4;
  margin-bottom: 10px;
}

.q-answers {
  display: flex;
  flex-direction: column;
  gap: 6px;
  margin-bottom: 8px;
}

.answer-row {
  display: flex;
  gap: 8px;
  font-size: 13px;

  .label {
    font-weight: 600;
    color: #374151;
    min-width: 80px;
  }

  .correct-label { color: #059669; }
  .value { color: #111827; }
  .correct-value { color: #059669; font-weight: 500; }
}

.q-analysis {
  background: #f9fafb;
  border-radius: 6px;
  padding: 10px;
  font-size: 13px;

  .label {
    font-weight: 600;
    color: #374151;
  }
  .value {
    color: #6b7280;
    font-style: italic;
  }
}
</style>
