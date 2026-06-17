<template>
  <div class="report-viewer wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-left">
          <el-button :icon="ArrowLeft" @click="$router.back()" text class="wabi-btn-text">返回</el-button>
          <h2 class="page-title">课程评价报告</h2>
          <span class="page-subtitle">开课ID: {{ offeringId }}</span>
        </div>
        <div class="header-actions">
          <el-button :icon="MagicStick" @click="onAiGenerateReport" :loading="aiLoading" class="wabi-btn-ghost">
            AI 生成报告
          </el-button>
          <el-button :icon="View" @click="showPreview = true" class="wabi-btn-ghost">
            预览汇编
          </el-button>
          <el-button :icon="Download" @click="onExportPdf" class="wabi-btn-ghost">
            导出 PDF
          </el-button>
        </div>
      </div>

      <!-- 标签页 -->
      <div class="wabi-card">
        <div class="wabi-card-header">
          <div class="tab-nav">
            <span
              v-for="tab in tabs"
              :key="tab.key"
              class="tab-item"
              :class="{ active: activeTab === tab.key }"
              @click="activeTab = tab.key"
            >
              {{ tab.label }}
            </span>
          </div>
        </div>
        <div class="wabi-card-content">
          <!-- 成绩统计表 -->
          <div v-if="activeTab === 'grade-stat'">
            <div class="toolbar">
              <el-button :icon="Download" @click="onExport('GRADE_STAT')" class="wabi-btn-ghost">
                导出 Excel
              </el-button>
            </div>
            <div class="info-grid" v-loading="loadings.gradeStat">
              <div class="info-item">
                <span class="info-label">教研室</span>
                <span class="info-value">{{ gradeStat.department || '-' }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">课程名称</span>
                <span class="info-value">{{ gradeStat.courseName || '-' }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">授课班级</span>
                <span class="info-value">{{ gradeStat.clazzNo || '-' }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">任课教师</span>
                <span class="info-value">{{ gradeStat.teacherName || '-' }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">期望值</span>
                <span class="info-value">{{ gradeStat.expectedValue }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">及格率</span>
                <span class="info-value">{{ gradeStat.passingRate }}%</span>
              </div>
              <div class="info-item">
                <span class="info-label">平均分</span>
                <span class="info-value">{{ gradeStat.avgScore }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">最高/最低</span>
                <span class="info-value">{{ gradeStat.maxScore }} / {{ gradeStat.minScore }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">达到期望</span>
                <span class="wabi-tag" :class="gradeStat.reachedExpected ? 'wabi-tag-accent' : 'wabi-tag-danger'">
                  {{ gradeStat.reachedExpected ? '是' : '否' }}
                </span>
              </div>
              <div class="info-item">
                <span class="info-label">正态分布</span>
                <span class="wabi-tag" :class="gradeStat.normalDistribution ? 'wabi-tag-accent' : 'wabi-tag-warning'">
                  {{ gradeStat.normalDistribution ? '是' : '否' }}
                </span>
              </div>
            </div>
            <div class="section-title">分数段分布</div>
            <div class="distribution-list">
              <div v-for="d in gradeStat.distribution" :key="d.range" class="distribution-item">
                <span class="dist-range">{{ d.range }}</span>
                <div class="dist-bar">
                  <div class="dist-fill" :style="{ width: d.percent + '%' }"></div>
                </div>
                <span class="dist-value">{{ d.count }}人 ({{ d.percent }}%)</span>
              </div>
            </div>
          </div>

          <!-- 考核合理性审核表 -->
          <div v-if="activeTab === 'consistency'">
            <div class="toolbar">
              <el-button :icon="Download" @click="onExport('CONSISTENCY')" class="wabi-btn-ghost">
                导出 Excel
              </el-button>
            </div>
            <div class="info-grid" v-loading="loadings.consistency">
              <div class="info-item">
                <span class="info-label">课程名称</span>
                <span class="info-value">{{ consistency.courseName }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">授课学时</span>
                <span class="info-value">{{ consistency.teachingHours }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">课程学分</span>
                <span class="info-value">{{ consistency.courseCredit }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">开课学期</span>
                <span class="info-value">{{ consistency.semester }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">授课对象</span>
                <span class="info-value">{{ consistency.teachingTarget }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">授课人数</span>
                <span class="info-value">{{ consistency.studentCount }}</span>
              </div>
            </div>
            <div class="section-title">考核合理性</div>
            <div class="consistency-list">
              <div v-for="row in consistency.rows" :key="row.objectiveCode" class="consistency-item">
                <div class="consistency-header">
                  <span class="obj-code">{{ row.objectiveCode }}</span>
                  <span class="obj-desc">{{ row.objectiveDescription }}</span>
                </div>
                <div class="consistency-meta">
                  <span>考核内容：{{ row.assessmentContent }}</span>
                  <span>考核方式：{{ row.assessmentMethod }}</span>
                  <span>分值：{{ row.assessmentScore }}</span>
                </div>
                <div class="consistency-comment">意见：{{ row.rationalityComment }}</div>
              </div>
            </div>
          </div>

          <!-- 达成情况评价报告 -->
          <div v-if="activeTab === 'attainment'">
            <div class="toolbar">
              <el-button :icon="Download" @click="onExport('ATTAINMENT')" class="wabi-btn-ghost">
                导出 Excel
              </el-button>
            </div>
            <div v-loading="loadings.attainment">
              <div class="section-title">一、课程基本信息</div>
              <div class="info-grid">
                <div class="info-item">
                  <span class="info-label">课程名称</span>
                  <span class="info-value">{{ attainment.basicInfo?.courseName }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">学期</span>
                  <span class="info-value">{{ attainment.basicInfo?.semester }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">理论学时</span>
                  <span class="info-value">{{ attainment.basicInfo?.theoryHours }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">实验学时</span>
                  <span class="info-value">{{ attainment.basicInfo?.labHours }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">任课教师</span>
                  <span class="info-value">{{ attainment.basicInfo?.teacherName }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">授课班级</span>
                  <span class="info-value">{{ attainment.basicInfo?.clazzNo }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">学生人数</span>
                  <span class="info-value">{{ attainment.basicInfo?.studentCount }}</span>
                </div>
              </div>
              <div class="section-title">二、课程目标达成情况</div>
              <div class="attainment-list">
                <div v-for="obj in attainment.objectiveSupports" :key="obj.objectiveCode" class="attainment-item">
                  <div class="attainment-header">
                    <span class="obj-code">{{ obj.objectiveCode }}</span>
                    <span class="obj-desc">{{ obj.objectiveDescription }}</span>
                  </div>
                  <div class="attainment-meta">
                    <span>支撑要求：{{ obj.supportedRequirements }}</span>
                    <span>支撑指标点：{{ obj.supportedIndicators }}</span>
                  </div>
                  <div class="attainment-method">达成途径：{{ obj.attainmentMethod }}</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- PDF预览弹窗 -->
    <PdfPreviewDialog
      v-model="showPreview"
      title="课程质量评价资料汇编预览"
      :url="exportApi.qualityCompendiumPreviewUrl(offeringId)"
      :downloadName="`课程质量评价资料汇编-${offeringId}.pdf`"
    />
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowLeft, Download, View, MagicStick } from '@element-plus/icons-vue'
import { exportApi, aiAssistApi, qualityReportApi } from '@/api'
import PdfPreviewDialog from '@/components/common/PdfPreviewDialog.vue'

const route = useRoute()
const offeringId = Number(route.params.offeringId)

const activeTab = ref('grade-stat')
const loading = ref(false)
const showPreview = ref(false)
const aiLoading = ref(false)
const evaluationId = ref(null)

const gradeStat = ref({})
const consistency = ref({ rows: [] })
const attainment = ref({ basicInfo: {}, objectiveSupports: [] })

const loadings = reactive({
  gradeStat: false,
  consistency: false,
  attainment: false
})

const tabs = [
  { key: 'grade-stat', label: '成绩统计' },
  { key: 'consistency', label: '考核合理性' },
  { key: 'attainment', label: '达成情况' }
]

const loadGradeStat = async () => {
  loadings.gradeStat = true
  try {
    const res = await qualityReportApi.gradeStat(offeringId)
    gradeStat.value = res.data || {}
  } catch (error) {
    console.error('加载成绩统计失败:', error)
  } finally {
    loadings.gradeStat = false
  }
}

const loadConsistency = async () => {
  loadings.consistency = true
  try {
    const res = await qualityReportApi.consistency(offeringId)
    consistency.value = res.data || { rows: [] }
  } catch (error) {
    console.error('加载考核合理性失败:', error)
  } finally {
    loadings.consistency = false
  }
}

const loadAttainment = async () => {
  loadings.attainment = true
  try {
    const res = await qualityReportApi.attainment(offeringId)
    attainment.value = res.data || { basicInfo: {}, objectiveSupports: [] }
  } catch (error) {
    console.error('加载达成情况失败:', error)
  } finally {
    loadings.attainment = false
  }
}

const onExport = (type) => {
  ElMessage.info('导出功能开发中')
}

const onExportPdf = () => {
  const url = `/api${exportApi.qualityCompendiumPreviewUrl(offeringId)}&token=${localStorage.getItem('token') || ''}`
  window.open(url, '_blank')
}

const onAiGenerateReport = async () => {
  if (!evaluationId.value) {
    ElMessage.warning('请先在评价页面完成教师分析总结')
    return
  }
  aiLoading.value = true
  const tasks = [
    { name: '课程存在问题', api: () => aiAssistApi.qualityExistingIssues(evaluationId.value) },
    { name: '评价有效性分析', api: () => aiAssistApi.qualityEvaluationValidity(evaluationId.value) },
    { name: '上轮改进情况', api: () => aiAssistApi.lastRound(offeringId) },
    { name: '改进措施', api: () => aiAssistApi.qualityConclusion(evaluationId.value) }
  ]
  let successCount = 0
  try {
    for (const task of tasks) {
      try {
        ElMessage.info(`正在生成：${task.name}...`)
        const res = await task.api()
        if (res.data?.content) successCount++
      } catch (e) {
        console.warn(`${task.name} 生成失败:`, e.message)
      }
    }
    if (successCount > 0) {
      ElMessage.success(`AI 已生成 ${successCount}/${tasks.length} 项分析，请在评价页面查看`)
    } else {
      ElMessage.warning('AI 未能生成内容，请稍后重试')
    }
  } finally {
    aiLoading.value = false
  }
}

onMounted(() => {
  loadGradeStat()
  loadConsistency()
  loadAttainment()
  // 尝试获取评价ID
  import('@/api').then(({ qualityEvalApi }) => {
    qualityEvalApi.latest(offeringId).then(res => {
      if (res.data?.evaluationId) {
        evaluationId.value = res.data.evaluationId
      }
    }).catch(() => {})
  })
})
</script>

<style scoped>
.report-viewer {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-body {
  padding: 24px;
  max-width: 1200px;
  margin: 0 auto;
  animation: wabi-fade-in 0.4s ease;
}

@keyframes wabi-fade-in {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 页面头部 */
.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  flex-wrap: wrap;
  gap: 16px;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.page-title {
  font-size: 20px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
}

.page-subtitle {
  font-size: 14px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 标签导航 */
.tab-nav {
  display: flex;
  gap: 4px;
}

.tab-item {
  padding: 8px 16px;
  font-size: 14px;
  color: var(--wabi-text-secondary, #8a8580);
  cursor: pointer;
  border-bottom: 2px solid transparent;
  transition: all 0.2s ease;
}

.tab-item:hover {
  color: var(--wabi-text, #2c2c2c);
}

.tab-item.active {
  color: var(--wabi-accent, #7a8b6f);
  border-bottom-color: var(--wabi-accent, #7a8b6f);
}

/* 工具栏 */
.toolbar {
  display: flex;
  gap: 8px;
  margin-bottom: 16px;
}

/* 信息网格 */
.info-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;
  margin-bottom: 24px;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
  padding: 12px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 4px;
}

.info-label {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.info-value {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
}

/* 区域标题 */
.section-title {
  font-size: 15px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 24px 0 16px 0;
  padding-bottom: 8px;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
}

/* 分数段分布 */
.distribution-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.distribution-item {
  display: flex;
  align-items: center;
  gap: 12px;
}

.dist-range {
  min-width: 80px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.dist-bar {
  flex: 1;
  height: 8px;
  background: var(--wabi-border-light, #f0ece8);
  border-radius: 4px;
  overflow: hidden;
}

.dist-fill {
  height: 100%;
  background: var(--wabi-accent, #7a8b6f);
  border-radius: 4px;
  transition: width 0.3s ease;
}

.dist-value {
  min-width: 100px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  text-align: right;
}

/* 考核合理性列表 */
.consistency-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.consistency-item {
  padding: 16px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
}

.consistency-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 8px;
}

.obj-code {
  font-family: monospace;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.obj-desc {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
}

.consistency-meta {
  display: flex;
  gap: 16px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-bottom: 8px;
}

.consistency-comment {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  padding-top: 8px;
  border-top: 1px dashed var(--wabi-border, #e8e4df);
}

/* 达成情况列表 */
.attainment-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.attainment-item {
  padding: 16px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
}

.attainment-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 8px;
}

.attainment-meta {
  display: flex;
  gap: 16px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-bottom: 8px;
}

.attainment-method {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  padding-top: 8px;
  border-top: 1px dashed var(--wabi-border, #e8e4df);
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

.wabi-tag-accent {
  background: var(--wabi-accent-light, #e8ede5);
  color: var(--wabi-accent, #7a8b6f);
}

.wabi-tag-warning {
  background: #f5efe4;
  color: #a0937d;
}

.wabi-tag-danger {
  background: #f5e8e8;
  color: #c47c7c;
}

/* 按钮 */
.wabi-btn-ghost {
  border-color: var(--wabi-border, #e8e4df);
  color: var(--wabi-text-secondary, #8a8580);
  border-radius: 4px;
}

.wabi-btn-ghost:hover {
  border-color: var(--wabi-accent, #7a8b6f);
  color: var(--wabi-accent, #7a8b6f);
}

.wabi-btn-text {
  color: var(--wabi-text-secondary, #8a8580);
}

.wabi-btn-text:hover {
  color: var(--wabi-accent, #7a8b6f);
}

/* 响应式 */
@media (max-width: 768px) {
  .wabi-body {
    padding: 16px;
  }

  .page-header {
    flex-direction: column;
    align-items: flex-start;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }

  .consistency-meta,
  .attainment-meta {
    flex-direction: column;
    gap: 4px;
  }
}
</style>
