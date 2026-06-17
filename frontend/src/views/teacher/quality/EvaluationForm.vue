<template>
  <div class="evaluation-page wabi-page">
    <!-- 页面头部 -->
    <div class="wabi-header">
      <div class="header-left">
        <el-button :icon="ArrowLeft" @click="$router.back()" text class="wabi-btn-text">返回</el-button>
        <div class="header-info">
          <h1 class="wabi-title">学生课程评价</h1>
          <span class="wabi-subtitle">开课ID: {{ offeringId }}</span>
        </div>
      </div>
      <div class="header-actions">
        <el-button @click="goReports" class="wabi-btn-ghost">查看报告</el-button>
      </div>
    </div>

    <!-- 主体内容 -->
    <div class="wabi-body" v-loading="loading">
      <!-- 评价统计概览 -->
      <div class="stats-overview">
        <div class="stat-card">
          <div class="stat-value">{{ stats.totalCount }}</div>
          <div class="stat-label">参与评价人数</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">{{ stats.overallSatisfaction }}%</div>
          <div class="stat-label">总体满意度</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">{{ stats.teachingQuality }}</div>
          <div class="stat-label">教学质量评分</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">{{ stats.courseContent }}</div>
          <div class="stat-label">课程内容评分</div>
        </div>
      </div>

      <!-- 评价维度统计 -->
      <div class="wabi-card section-card">
        <div class="wabi-card-header">
          <span class="wabi-card-title">评价维度统计</span>
        </div>
        <div class="wabi-card-content">
          <div class="dimension-list">
            <div v-for="dim in dimensions" :key="dim.key" class="dimension-item">
              <div class="dimension-header">
                <span class="dimension-label">{{ dim.label }}</span>
                <span class="dimension-score">{{ dim.score }}</span>
              </div>
              <div class="dimension-bar">
                <div class="dimension-fill" :style="{ width: (dim.score / 5 * 100) + '%' }"></div>
              </div>
              <div class="dimension-distribution">
                <span v-for="i in 5" :key="i" class="dist-item">
                  {{ i }}星: {{ dim.distribution[i] || 0 }}人
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 学生文字评价 -->
      <div class="wabi-card section-card">
        <div class="wabi-card-header">
          <span class="wabi-card-title">学生文字评价</span>
          <span class="wabi-tag">{{ studentComments.length }} 条</span>
        </div>
        <div class="wabi-card-content">
          <div v-if="!studentComments.length" class="wabi-empty">
            <p class="wabi-empty-text">暂无文字评价</p>
          </div>
          <div v-else class="comment-list">
            <div v-for="(comment, index) in studentComments" :key="index" class="comment-item">
              <div class="comment-header">
                <span class="comment-student">{{ comment.studentName || '匿名学生' }}</span>
                <span class="comment-time">{{ formatDate(comment.createTime) }}</span>
              </div>
              <div class="comment-content">{{ comment.content }}</div>
              <div v-if="comment.suggestion" class="comment-suggestion">
                <span class="suggestion-label">建议：</span>
                {{ comment.suggestion }}
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 教师分析总结 -->
      <div class="wabi-card section-card">
        <div class="wabi-card-header">
          <span class="wabi-card-title">教师分析总结</span>
          <div class="header-btns">
            <el-button
              type="primary"
              size="small"
              plain
              @click="onAiGenerateConclusion"
              :loading="aiLoading.conclusion"
              class="wabi-btn-ghost"
            >
              AI 生成分析
            </el-button>
            <el-button
              type="primary"
              size="small"
              @click="onSaveAnalysis"
              :loading="saving"
              class="wabi-btn-primary"
            >
              保存分析
            </el-button>
          </div>
        </div>
        <div class="wabi-card-content">
          <el-form :model="analysisForm" label-width="120" class="wabi-form">
            <el-form-item label="课程存在问题">
              <el-input
                v-model="analysisForm.existingIssues"
                type="textarea"
                :rows="3"
                placeholder="根据学生评价，总结课程存在的主要问题..."
              />
            </el-form-item>
            <el-form-item label="评价有效性分析">
              <el-input
                v-model="analysisForm.evaluationValidity"
                type="textarea"
                :rows="3"
                placeholder="分析本次评价的有效性和代表性..."
              />
            </el-form-item>
            <el-form-item label="上轮改进情况">
              <el-input
                v-model="analysisForm.lastRoundImprovements"
                type="textarea"
                :rows="3"
                placeholder="上一轮评价中发现问题的改进情况..."
              />
            </el-form-item>
            <el-form-item label="改进措施">
              <el-input
                v-model="analysisForm.conclusionAndSuggestions"
                type="textarea"
                :rows="4"
                placeholder="针对本次评价结果，提出具体的改进措施..."
              />
            </el-form-item>
          </el-form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowLeft } from '@element-plus/icons-vue'
import { qualityEvalApi, aiAssistApi } from '@/api'

const route = useRoute()
const router = useRouter()
const offeringId = computed(() => Number(route.params.offeringId))

const loading = ref(false)
const saving = ref(false)
const evaluationId = ref(null)

// 评价统计数据
const stats = reactive({
  totalCount: 0,
  overallSatisfaction: 0,
  teachingQuality: 0,
  courseContent: 0
})

// 评价维度
const dimensions = ref([
  { key: 'teachingQuality', label: '教学质量', score: 0, distribution: {} },
  { key: 'courseContent', label: '课程内容', score: 0, distribution: {} },
  { key: 'learningResources', label: '学习资源', score: 0, distribution: {} },
  { key: 'assessmentMethod', label: '考核方式', score: 0, distribution: {} },
  { key: 'learningEffect', label: '学习效果', score: 0, distribution: {} }
])

// 学生文字评价
const studentComments = ref([])

// 教师分析表单
const analysisForm = reactive({
  existingIssues: '',
  evaluationValidity: '',
  lastRoundImprovements: '',
  conclusionAndSuggestions: ''
})

const aiLoading = reactive({
  conclusion: false,
  lastRound: false
})

const formatDate = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleString('zh-CN')
}

// 加载评价数据
const loadEvaluationData = async () => {
  loading.value = true
  try {
    // 加载评价统计（后端接口可能不存在，静默处理）
    try {
      const statsRes = await qualityEvalApi.getStats(offeringId.value)
      if (statsRes.data) {
        Object.assign(stats, statsRes.data)
      }
    } catch (e) {
      console.warn('评价统计接口不可用，跳过:', e.message)
    }

    // 加载评价维度数据
    try {
      const dimRes = await qualityEvalApi.getDimensions(offeringId.value)
      if (dimRes.data) {
        dimensions.value = dimRes.data
      }
    } catch (e) {
      console.warn('评价维度接口不可用，跳过:', e.message)
    }

    // 加载学生文字评价
    try {
      const commentsRes = await qualityEvalApi.getComments(offeringId.value)
      if (commentsRes.data) {
        studentComments.value = commentsRes.data
      }
    } catch (e) {
      console.warn('学生评价接口不可用，跳过:', e.message)
    }

    // 加载教师分析（如果有）
    try {
      const analysisRes = await qualityEvalApi.latest(offeringId.value)
      if (analysisRes.data) {
        evaluationId.value = analysisRes.data.evaluationId
        analysisForm.existingIssues = analysisRes.data.existingIssues || ''
        analysisForm.evaluationValidity = analysisRes.data.evaluationValidity || ''
        analysisForm.lastRoundImprovements = analysisRes.data.lastRoundImprovements || ''
        analysisForm.conclusionAndSuggestions = analysisRes.data.conclusionAndSuggestions || ''
      }
    } catch (e) {
      console.warn('教师分析接口不可用，跳过:', e.message)
    }
  } catch (error) {
    console.error('加载评价数据失败:', error)
  } finally {
    loading.value = false
  }
}

// 保存教师分析
const onSaveAnalysis = async () => {
  saving.value = true
  try {
    if (evaluationId.value) {
      await qualityEvalApi.save(evaluationId.value, analysisForm)
    } else {
      const res = await qualityEvalApi.create({
        offeringId: offeringId.value,
        ...analysisForm
      })
      evaluationId.value = res.data?.evaluationId
    }
    ElMessage.success('分析已保存')
  } catch (error) {
    ElMessage.error('保存失败')
  } finally {
    saving.value = false
  }
}

// AI 生成全部分析字段
const onAiGenerateConclusion = async () => {
  if (!evaluationId.value) {
    ElMessage.warning('请先保存一次分析')
    return
  }
  aiLoading.conclusion = true
  try {
    // 并行调用 4 个 AI 接口
    const [res1, res2, res3, res4] = await Promise.all([
      aiAssistApi.qualityExistingIssues(evaluationId.value),
      aiAssistApi.qualityEvaluationValidity(evaluationId.value),
      aiAssistApi.lastRound(offeringId.value),
      aiAssistApi.qualityConclusion(evaluationId.value)
    ])
    if (res1.data?.content) analysisForm.existingIssues = res1.data.content
    if (res2.data?.content) analysisForm.evaluationValidity = res2.data.content
    if (res3.data?.content) analysisForm.lastRoundImprovements = res3.data.content
    if (res4.data?.content) analysisForm.conclusionAndSuggestions = res4.data.content
    ElMessage.success('AI 已生成全部分析')
  } catch (e) {
    ElMessage.error('AI 生成失败：' + (e.message || '未知错误'))
  } finally {
    aiLoading.conclusion = false
  }
}

const goReports = () => router.push(`/teacher/reports/${offeringId.value}`)

onMounted(loadEvaluationData)
</script>

<style scoped>
.evaluation-page {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 24px;
  background: var(--wabi-surface, #fff);
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
  position: sticky;
  top: 0;
  z-index: 10;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.header-info {
  display: flex;
  flex-direction: column;
}

.wabi-title {
  font-size: 18px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
  line-height: 1.4;
}

.wabi-subtitle {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.header-actions {
  display: flex;
  gap: 8px;
}

.wabi-body {
  padding: 24px;
  max-width: 1000px;
  margin: 0 auto;
  animation: wabi-fade-in 0.4s ease;
}

@keyframes wabi-fade-in {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 统计概览 */
.stats-overview {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
  margin-bottom: 24px;
}

.stat-card {
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  padding: 20px;
  text-align: center;
}

.stat-value {
  font-size: 28px;
  font-weight: 600;
  color: var(--wabi-accent, #7a8b6f);
  font-family: 'Georgia', serif;
}

.stat-label {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-top: 4px;
}

/* 区域卡片 */
.section-card {
  margin-bottom: 24px;
}

.section-card .wabi-card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-btns {
  display: flex;
  gap: 8px;
}

/* 评价维度 */
.dimension-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.dimension-item {
  padding: 16px;
  background: var(--wabi-surface-warm, #faf9f7);
  border-radius: 6px;
}

.dimension-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.dimension-label {
  font-size: 14px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
}

.dimension-score {
  font-size: 18px;
  font-weight: 600;
  color: var(--wabi-accent, #7a8b6f);
  font-family: 'Georgia', serif;
}

.dimension-bar {
  height: 8px;
  background: var(--wabi-border-light, #f0ece8);
  border-radius: 4px;
  overflow: hidden;
  margin-bottom: 8px;
}

.dimension-fill {
  height: 100%;
  background: var(--wabi-accent, #7a8b6f);
  border-radius: 4px;
  transition: width 0.3s ease;
}

.dimension-distribution {
  display: flex;
  gap: 12px;
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 学生评价列表 */
.comment-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.comment-item {
  padding: 16px;
  background: var(--wabi-surface-warm, #faf9f7);
  border-radius: 6px;
  border-left: 3px solid var(--wabi-accent, #7a8b6f);
}

.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.comment-student {
  font-size: 14px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
}

.comment-time {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.comment-content {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
  line-height: 1.6;
  margin-bottom: 8px;
}

.comment-suggestion {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  padding-top: 8px;
  border-top: 1px dashed var(--wabi-border, #e8e4df);
}

.suggestion-label {
  font-weight: 500;
}

/* 标签 */
.wabi-tag {
  display: inline-block;
  padding: 2px 8px;
  background: var(--wabi-border-light, #f0ece8);
  color: var(--wabi-text-secondary, #8a8580);
  font-size: 12px;
  border-radius: 2px;
}

/* 空状态 */
.wabi-empty {
  padding: 40px 0;
  text-align: center;
}

.wabi-empty-text {
  color: var(--wabi-text-secondary, #8a8580);
  font-size: 14px;
  margin: 0;
}

/* 按钮 */
.wabi-btn-primary {
  background: var(--wabi-accent, #7a8b6f);
  border-color: var(--wabi-accent, #7a8b6f);
  border-radius: 4px;
}

.wabi-btn-primary:hover {
  background: #6b7d60;
  border-color: #6b7d60;
}

.wabi-btn-ghost {
  border-color: var(--wabi-border, #e8e4df);
  color: var(--wabi-text-secondary, #8a8580);
  border-radius: 4px;
}

.wabi-btn-ghost:hover {
  border-color: var(--wabi-accent, #7a8b6f);
  color: var(--wabi-accent, #7a8b6f);
}

/* 响应式 */
@media (max-width: 768px) {
  .wabi-header {
    flex-direction: column;
    gap: 12px;
    align-items: flex-start;
  }

  .wabi-body {
    padding: 16px;
  }

  .stats-overview {
    grid-template-columns: repeat(2, 1fr);
  }

  .section-card .wabi-card-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }

  .header-btns {
    width: 100%;
  }

  .dimension-distribution {
    flex-wrap: wrap;
  }
}
</style>
