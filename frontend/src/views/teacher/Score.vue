<template>
  <div class="score-page wabi-page">
    <div class="wabi-body">
      <div class="page-header">
        <h2 class="page-title">成绩管理</h2>
        <p class="page-desc">点击实验卡片查看学生答题情况</p>
      </div>

      <div class="score-layout">
        <!-- 左侧实验列表 -->
        <div class="experiment-panel wabi-card">
          <div class="wabi-card-header">
            <span class="wabi-card-title">实验列表</span>
          </div>
          <div class="wabi-card-content">
            <div
              class="experiment-list"
              ref="experimentListRef"
              @scroll="handleExperimentScroll"
              v-loading="loading"
            >
              <div
                v-for="exp in displayedExperiments"
                :key="exp.experimentId"
                class="experiment-item"
                :class="{ active: selectedExperimentId === exp.experimentId }"
                @click="handleExperimentClick(exp.experimentId)"
              >
                <div class="exp-info">
                  <span class="exp-no">{{ exp.experimentNo }}</span>
                  <span class="exp-name">{{ exp.experimentName }}</span>
                </div>
              </div>
              <div v-if="!experimentOptions.length && !loading" class="wabi-empty">
                <p class="wabi-empty-text">暂无可用实验</p>
              </div>
              <div v-if="loadingMore" class="loading-more">加载中...</div>
            </div>
          </div>
        </div>

        <!-- 右侧成绩详情 -->
        <div class="score-detail wabi-card">
          <div class="wabi-card-header">
            <span class="wabi-card-title">{{ selectedExperimentName || '请选择实验' }}</span>
            <button
              v-if="selectedExperimentId"
              class="wabi-btn wabi-btn-export"
              @click="handleExportExcel"
            >导出成绩</button>
          </div>
          <div class="wabi-card-content">
            <div v-if="!selectedExperimentId" class="wabi-empty">
              <p class="wabi-empty-text">请从左侧选择一个实验</p>
            </div>
            <div v-else-if="loadingScores" class="loading-scores">加载中...</div>
            <div v-else-if="!scoreList.length" class="wabi-empty">
              <p class="wabi-empty-text">暂无成绩数据</p>
            </div>
            <div v-else class="score-list">
              <div v-for="score in paginatedScoreList" :key="score.studentId" class="score-item" @click="handleViewDetail(score)" style="cursor:pointer;">
                <div class="student-info">
                  <span class="student-no">{{ score.studentNo }}</span>
                  <span class="student-name">{{ score.studentName }}</span>
                </div>
                <div class="score-value" :class="getScoreClass(score.totalScore ?? score.score)">
                  {{ score.totalScore ?? score.score ?? '未提交' }}
                </div>
              </div>
            </div>
            <!-- 分页 -->
            <div class="wabi-pagination" v-if="scoreList.length">
              <el-pagination
                v-model:current-page="scorePagination.page"
                v-model:page-size="scorePagination.pageSize"
                :total="scorePagination.total"
                :page-sizes="[10, 20, 50, 100]"
                layout="total, sizes, prev, pager, next"
                @size-change="handleScorePageChange"
                @current-change="handleScorePageChange"
                small
                background
              />
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 学生答题详情弹窗 -->
    <el-dialog
      v-model="detailDialogVisible"
      title="答题详情"
      width="850px"
      class="wabi-detail-dialog"
      destroy-on-close
    >
      <div v-if="currentStudentDetail" class="detail-wrapper">
        <!-- 学生信息头部 -->
        <div class="detail-header">
          <div class="student-info-row">
            <div class="info-tag">
              <span class="tag-label">学号</span>
              <span class="tag-value">{{ currentStudentDetail.studentNo }}</span>
            </div>
            <div class="info-tag">
              <span class="tag-label">姓名</span>
              <span class="tag-value">{{ currentStudentDetail.studentName }}</span>
            </div>
            <div class="info-tag">
              <span class="tag-label">班级</span>
              <span class="tag-value">{{ currentStudentDetail.clazzNo }}</span>
            </div>
          </div>
          <div class="score-overview">
            <span class="overview-label">当前总分</span>
            <span class="overview-score">{{ currentStudentDetail.totalScore || 0 }}</span>
            <span class="overview-divider">/</span>
            <span class="overview-max">{{ currentStudentDetail.maxScore || 0 }}</span>
          </div>
        </div>

        <!-- 题目列表 -->
        <div class="questions-container">
          <div class="questions-title">
            <span>答题详情</span>
            <span class="questions-tip">修改评分后点击保存或批量保存</span>
          </div>

          <div v-if="!currentStudentDetail.items?.length" class="wabi-empty">
            <p class="wabi-empty-text">暂无题目数据</p>
          </div>

          <div v-else class="question-cards">
            <div
              v-for="(item, index) in currentStudentDetail.items"
              :key="item.studentItemId || index"
              class="question-card"
            >
              <div class="card-header">
                <div class="question-info">
                  <span class="question-index">第 {{ index + 1 }} 题</span>
                  <span class="question-no">{{ item.itemNo }}</span>
                  <span class="question-name">{{ item.name }}</span>
                </div>
                <div class="question-score">满分 {{ item.maxScore }} 分</div>
              </div>

              <div class="card-body">
                <div class="answer-section">
                  <div class="section-label">学生答案</div>
                  <div class="answer-block student-answer" :class="{ empty: !item.studentAnswer || item.studentAnswer === '未作答' }">
                    <pre v-if="item.studentAnswer && item.studentAnswer !== '未作答'" class="answer-text">{{ item.studentAnswer }}</pre>
                    <span v-else class="no-answer-text">该题未作答</span>
                  </div>
                </div>

                <div class="answer-section">
                  <div class="section-label">标准答案</div>
                  <div class="answer-block std-answer">
                    <pre class="answer-text">{{ item.answer || '-' }}</pre>
                  </div>
                </div>

                <div class="score-section">
                  <div class="section-label">评分</div>
                  <div class="score-control">
                    <template v-if="item.studentItemId">
                      <el-input-number
                        v-model="item.score"
                        :min="0"
                        :max="item.maxScore"
                        size="default"
                        controls-position="right"
                      />
                      <el-button type="primary" size="default" @click="handleItemScoreChange(item)">保存</el-button>
                    </template>
                    <span v-else class="not-submitted">未提交</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <template #footer>
        <div class="dialog-footer">
          <el-button @click="detailDialogVisible = false">关闭</el-button>
          <el-button type="primary" @click="handleBatchSave">保存全部</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { teacherApi } from '@/api'

const experimentApi = teacherApi.experiment
const scoreApi = teacherApi.score

const loading = ref(false)
const loadingMore = ref(false)
const loadingScores = ref(false)
const experimentOptions = ref([])
const scoreList = ref([])
const selectedExperimentId = ref(null)
const detailDialogVisible = ref(false)
const currentStudentDetail = ref(null)
const experimentListRef = ref()

// 成绩列表分页
const scorePagination = ref({ page: 1, pageSize: 20, total: 0 })
const paginatedScoreList = computed(() => {
  const start = (scorePagination.value.page - 1) * scorePagination.value.pageSize
  return scoreList.value.slice(start, start + scorePagination.value.pageSize)
})
const handleScorePageChange = () => {
  // computed 自动更新
}

const PAGE_SIZE = 20
const currentPage = ref(1)
const hasMore = ref(true)

const displayedExperiments = computed(() => experimentOptions.value)

const selectedExperimentName = computed(() => {
  const exp = experimentOptions.value.find(e => e.experimentId === selectedExperimentId.value)
  return exp?.experimentName || ''
})

const getScoreClass = (score) => {
  if (score == null) return ''
  if (score >= 90) return 'score-excellent'
  if (score >= 70) return 'score-good'
  if (score >= 60) return 'score-pass'
  return 'score-fail'
}

const loadExperiments = async (reset = false) => {
  if (reset) {
    currentPage.value = 1
    experimentOptions.value = []
    hasMore.value = true
  }
  loading.value = true
  try {
    const params = { page: currentPage.value, pageSize: PAGE_SIZE }
    const res = await experimentApi.list(params)
    const data = res.data?.list || res.data || []
    if (reset) {
      experimentOptions.value = data
    } else {
      experimentOptions.value.push(...data)
    }
    hasMore.value = data.length === PAGE_SIZE
  } catch (error) {
    console.error('加载实验列表失败:', error)
  } finally {
    loading.value = false
  }
}

const handleExperimentScroll = (e) => {
  const { scrollTop, scrollHeight, clientHeight } = e.target
  if (scrollHeight - scrollTop - clientHeight < 50 && !loadingMore.value && hasMore.value) {
    loadingMore.value = true
    currentPage.value++
    loadExperiments().finally(() => {
      loadingMore.value = false
    })
  }
}

const handleExperimentClick = async (experimentId) => {
  selectedExperimentId.value = experimentId
  loadingScores.value = true
  try {
    const res = await scoreApi.getByExperiment(experimentId)
    const data = res.data
    scoreList.value = data?.list || data || []
    scorePagination.value.total = data?.total || scoreList.value.length
    scorePagination.value.page = 1
  } catch (error) {
    console.error('加载成绩失败:', error)
  } finally {
    loadingScores.value = false
  }
}

// 查看学生详情
const handleViewDetail = async (student) => {
  try {
    const response = await scoreApi.getStudentDetail(
      student.studentId,
      selectedExperimentId.value
    )
    currentStudentDetail.value = response.data || {}
    detailDialogVisible.value = true
  } catch (error) {
    ElMessage.error('加载详情失败')
    console.error(error)
  }
}

// 单题评分保存
const handleItemScoreChange = async (item) => {
  if (!item.studentItemId) return
  try {
    await scoreApi.scoreItem(item.studentItemId, item.score)
    // 更新总分
    if (currentStudentDetail.value) {
      let total = 0
      currentStudentDetail.value.items.forEach(i => {
        if (i.score != null) total += i.score
      })
      currentStudentDetail.value.totalScore = total
    }
    ElMessage.success('评分已保存')
  } catch (error) {
    ElMessage.error('评分失败')
    console.error(error)
  }
}

// 批量保存
const handleBatchSave = async () => {
  if (!currentStudentDetail.value?.items) return
  try {
    const items = currentStudentDetail.value.items.filter(item => item.studentItemId)
    for (const item of items) {
      if (item.score != null) {
        await scoreApi.scoreItem(item.studentItemId, item.score)
      }
    }
    ElMessage.success('批量保存成功')
    detailDialogVisible.value = false
    // 刷新成绩列表
    handleExperimentClick(selectedExperimentId.value)
  } catch (error) {
    ElMessage.error('批量保存失败')
    console.error(error)
  }
}

// 导出Excel
const handleExportExcel = async () => {
  if (!selectedExperimentId.value) {
    ElMessage.warning('请先选择实验')
    return
  }
  try {
    ElMessage.info('正在生成Excel文件...')
    await scoreApi.export(selectedExperimentId.value)
    ElMessage.success('导出成功')
  } catch (error) {
    ElMessage.error('导出失败')
    console.error(error)
  }
}

onMounted(() => loadExperiments(true))
</script>

<style scoped>
.score-page {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-body {
  padding: 24px;
  max-width: 1400px;
  margin: 0 auto;
  animation: wabi-fade-in 0.4s ease;
}

@keyframes wabi-fade-in {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

.page-header {
  margin-bottom: 16px;
}

.page-title {
  font-size: 20px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0 0 4px 0;
}

.page-desc {
  font-size: 14px;
  color: var(--wabi-text-secondary, #8a8580);
  margin: 0;
}

/* 布局 */
.score-layout {
  display: grid;
  grid-template-columns: 320px 1fr;
  gap: 16px;
  min-height: 600px;
}

/* 实验面板 */
.experiment-list {
  max-height: 500px;
  overflow-y: auto;
}

.experiment-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px;
  cursor: pointer;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
  transition: all 0.2s ease;
}

.experiment-item:hover {
  background: var(--wabi-accent-light, #e8ede5);
}

.experiment-item.active {
  background: var(--wabi-accent-light, #e8ede5);
  border-left: 3px solid var(--wabi-accent, #7a8b6f);
}

.exp-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.exp-no {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  font-family: monospace;
}

.exp-name {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
}

/* 成绩列表 */
.score-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.score-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 4px;
}

.student-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.student-no {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  font-family: monospace;
}

.student-name {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
  font-weight: 500;
}

.score-value {
  font-size: 16px;
  font-weight: 600;
  font-family: 'Georgia', serif;
}

.score-excellent { color: #7a8b6f; }
.score-good { color: #6b8a9a; }
.score-pass { color: #a0937d; }
.score-fail { color: #c47c7c; }

.loading-more,
.loading-scores {
  text-align: center;
  padding: 16px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
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

/* 导出按钮 */
.wabi-btn {
  padding: 6px 16px;
  border: none;
  border-radius: 4px;
  font-size: 13px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.wabi-btn-export {
  background: var(--wabi-accent, #7a8b6f);
  color: #fff;
}

.wabi-btn-export:hover {
  opacity: 0.85;
}

/* 详情弹窗 */
.wabi-detail-dialog :deep(.el-dialog__header) {
  padding: 16px 20px;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
}

.wabi-detail-dialog :deep(.el-dialog__body) {
  padding: 20px;
}

.wabi-detail-dialog :deep(.el-dialog__footer) {
  padding: 12px 20px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
}

.detail-wrapper {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.detail-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: var(--wabi-accent-light, #e8ede5);
  border-radius: 8px;
  border: 1px solid var(--wabi-border, #e8e4df);
}

.student-info-row {
  display: flex;
  gap: 20px;
  flex: 1;
}

.info-tag {
  display: flex;
  align-items: center;
  gap: 8px;
}

.tag-label {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.tag-value {
  font-size: 14px;
  font-weight: 600;
  color: var(--wabi-text, #2c2c2c);
}

.score-overview {
  display: flex;
  align-items: baseline;
  gap: 6px;
}

.overview-label {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-right: 4px;
}

.overview-score {
  font-size: 28px;
  font-weight: 700;
  color: var(--wabi-accent, #7a8b6f);
}

.overview-divider {
  font-size: 18px;
  color: var(--wabi-border, #e8e4df);
}

.overview-max {
  font-size: 16px;
  color: var(--wabi-text-secondary, #8a8580);
}

.questions-container {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.questions-title {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 14px;
  font-weight: 600;
  color: var(--wabi-text, #2c2c2c);
}

.questions-tip {
  font-size: 12px;
  font-weight: 400;
  color: var(--wabi-text-secondary, #8a8580);
}

.question-cards {
  display: flex;
  flex-direction: column;
  gap: 12px;
  max-height: 500px;
  overflow-y: auto;
  padding-right: 4px;
}

.question-cards::-webkit-scrollbar {
  width: 6px;
}

.question-cards::-webkit-scrollbar-thumb {
  background: var(--wabi-border, #e8e4df);
  border-radius: 3px;
}

.question-card {
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 8px;
  overflow: hidden;
}

.question-card .card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  background: var(--wabi-bg, #f8f6f3);
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
}

.question-info {
  display: flex;
  align-items: center;
  gap: 10px;
}

.question-index {
  font-size: 13px;
  font-weight: 600;
  color: var(--wabi-accent, #7a8b6f);
}

.question-no {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  font-family: monospace;
}

.question-name {
  font-size: 14px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
}

.question-score {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.card-body {
  display: flex;
  flex-direction: column;
  gap: 16px;
  padding: 16px;
}

.answer-section {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.section-label {
  font-size: 13px;
  font-weight: 500;
  color: var(--wabi-text-secondary, #8a8580);
}

.answer-block {
  background: var(--wabi-bg, #f8f6f3);
  border-radius: 6px;
  padding: 12px 14px;
  border: 1px solid var(--wabi-border, #e8e4df);
}

.answer-block.student-answer.empty {
  background: var(--wabi-bg, #f8f6f3);
}

.answer-block.std-answer {
  background: var(--wabi-accent-light, #e8ede5);
  border-color: var(--wabi-accent, #7a8b6f);
}

.answer-text {
  margin: 0;
  padding: 0;
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
  line-height: 1.6;
  white-space: pre-wrap;
  word-break: break-word;
  font-family: inherit;
}

.no-answer-text {
  color: var(--wabi-text-secondary, #8a8580);
  font-style: italic;
  font-size: 13px;
}

.score-section {
  display: flex;
  flex-direction: column;
  gap: 6px;
  padding-top: 4px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
}

.score-control {
  display: flex;
  align-items: center;
  gap: 12px;
}

.not-submitted {
  color: var(--wabi-text-secondary, #8a8580);
  font-style: italic;
  font-size: 13px;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

/* 响应式 */
@media (max-width: 768px) {
  .wabi-body {
    padding: 16px;
  }

  .score-layout {
    grid-template-columns: 1fr;
  }

  .detail-header {
    flex-direction: column;
    gap: 12px;
    align-items: flex-start;
  }

  .student-info-row {
    flex-wrap: wrap;
    gap: 12px;
  }
}
</style>
