<template>
  <div class="score-page">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/teacher' }">教师首页</el-breadcrumb-item>
      <el-breadcrumb-item>成绩管理</el-breadcrumb-item>
    </el-breadcrumb>

    <!-- 页面标题 -->
    <div class="page-header">
      <h2 class="page-title">成绩管理</h2>
      <p class="page-desc">点击实验卡片查看学生答题情况</p>
    </div>

    <!-- 主体内容区 - 左右布局 -->
    <div class="main-content">
      <!-- 左侧：实验列表 -->
      <div class="experiments-panel" :class="{ collapsed: sidebarCollapsed }">
        <template v-if="!sidebarCollapsed">
          <div class="panel-header">
            <div class="panel-title">实验列表</div>
            <el-button text size="small" @click="sidebarCollapsed = true" class="collapse-btn">
              <el-icon><DArrowLeft /></el-icon>
            </el-button>
          </div>
          <div
            class="experiment-list"
            ref="experimentListRef"
            @scroll="handleExperimentScroll"
            v-loading="loading"
          >
            <div
              v-for="exp in displayedExperiments"
              :key="exp.experimentId"
              class="experiment-card"
              :class="{ active: selectedExperimentId === exp.experimentId }"
              @click="handleExperimentClick(exp.experimentId)"
            >
              <div class="exp-info">
                <span class="exp-no">{{ exp.experimentNo }}</span>
                <span class="exp-name">{{ exp.experimentName }}</span>
              </div>
              <el-icon class="exp-arrow"><ArrowRight /></el-icon>
            </div>
            <el-empty v-if="!experimentOptions.length" description="暂无可用实验" />

            <!-- 加载更多提示 -->
            <div v-if="hasMoreExperiments && !loadingMore" class="load-more-trigger" ref="loadMoreTrigger">
              <span class="load-hint">下拉加载更多</span>
            </div>
            <div v-if="loadingMore" class="loading-more">
              <el-icon class="is-loading"><Loading /></el-icon>
              <span>加载中...</span>
            </div>
            <div v-if="!hasMoreExperiments && displayedExperiments.length > 0" class="no-more-data">
              已加载全部 {{ experimentOptions.length }} 个实验
            </div>
          </div>
        </template>
        <template v-else>
          <div class="expand-placeholder" @click="sidebarCollapsed = false">
            <el-icon class="expand-icon"><DArrowRight /></el-icon>
          </div>
        </template>
      </div>

      <!-- 右侧：答题详情 -->
      <div class="details-panel" v-if="selectedExperiment">
        <!-- 实验信息卡 -->
        <div class="exp-header-card">
          <div class="exp-header-info">
            <div class="exp-header-name">{{ selectedExperiment.experimentName }}</div>
            <div class="exp-header-meta">
              <span>实验编号：{{ selectedExperiment.experimentNo }}</span>
            </div>
          </div>
          <el-button type="success" @click="handleExportExcel">
            <el-icon><Download /></el-icon>
            导出成绩
          </el-button>
        </div>

        <!-- 统计卡片 -->
        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-value">{{ pagination.total }}</div>
            <div class="stat-label">学生总数</div>
          </div>
          <div class="stat-card">
            <div class="stat-value">{{ gradedCount }}</div>
            <div class="stat-label">待批题目</div>
          </div>
          <div class="stat-card">
            <div class="stat-value">{{ avgScore }}</div>
            <div class="stat-label">平均得分</div>
          </div>
        </div>

        <!-- 学生列表 -->
        <div class="students-section">
          <div class="section-title">学生答题情况</div>
          <div class="student-list">
            <div
              v-for="student in studentAnswerList"
              :key="student.studentId"
              class="student-item"
              @click="handleViewDetail(student)"
            >
              <div class="student-info">
                <div class="student-avatar">
                  {{ student.studentName?.charAt(0) || 'S' }}
                </div>
                <div class="student-details">
                  <div class="student-name">{{ student.studentName }}</div>
                  <div class="student-meta">{{ student.studentNo }} · {{ student.clazzNo }}</div>
                </div>
              </div>
              <div class="student-score">
                <span class="score-badge" :class="getScoreClass(student)">
                  {{ student.totalScore || 0 }} / {{ student.maxScore || 0 }}
                </span>
                <span class="status-text" :class="student.status === '已评分' ? 'success' : 'pending'">
                  {{ student.status || '待评分' }}
                </span>
              </div>
              <el-icon class="item-arrow"><ArrowRight /></el-icon>
            </div>
          </div>

          <!-- 分页 -->
          <el-pagination
            v-model:current-page="pagination.page"
            v-model:page-size="pagination.pageSize"
            :page-sizes="[10, 20, 50]"
            :total="pagination.total"
            layout="total, prev, pager, next"
            @size-change="handleSizeChange"
            @current-change="handlePageChange"
            class="list-pagination"
          />
        </div>
      </div>

      <!-- 空状态 -->
      <div class="empty-panel" v-else>
        <el-empty description="请从左侧选择一个实验" />
      </div>
    </div>

    <!-- 学生答题详情对话框 -->
    <el-dialog
      v-model="detailDialogVisible"
      title="答题详情"
      width="850px"
      class="detail-dialog"
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

        <!-- 题目列表 - 卡片式纵向布局 -->
        <div class="questions-container">
          <div class="questions-title">
            <span>答题详情</span>
            <span class="questions-tip">修改评分后点击保存或批量保存</span>
          </div>

          <div v-if="!currentStudentDetail.items?.length" class="no-data">
            暂无题目数据
          </div>

          <div v-else class="question-cards">
            <el-card
              v-for="(item, index) in currentStudentDetail.items"
              :key="item.studentItemId || index"
              class="question-card"
              shadow="never"
            >
              <template #header>
                <div class="card-header">
                  <div class="question-info">
                    <el-tag type="info" size="small">第 {{ index + 1 }} 题</el-tag>
                    <span class="question-no">编号: {{ item.itemNo }}</span>
                    <span class="question-name">{{ item.name }}</span>
                  </div>
                  <div class="question-score">
                    <span class="score-label">满分 {{ item.maxScore }} 分</span>
                  </div>
                </div>
              </template>

              <div class="card-body">
                <div class="answer-section">
                  <div class="section-header">
                    <span class="section-icon student">学生</span>
                    <span class="section-label">学生答案</span>
                  </div>
                  <div class="answer-block student-answer" :class="{ empty: !item.studentAnswer || item.studentAnswer === '未作答' }">
                    <template v-if="item.studentAnswer && item.studentAnswer !== '未作答'">
                      <pre class="answer-text">{{ item.studentAnswer }}</pre>
                    </template>
                    <template v-else>
                      <span class="no-answer-text">该题未作答</span>
                    </template>
                  </div>
                </div>

                <div class="answer-section">
                  <div class="section-header">
                    <span class="section-icon std">标准</span>
                    <span class="section-label">标准答案</span>
                  </div>
                  <div class="answer-block std-answer">
                    <pre class="answer-text">{{ item.answer || '-' }}</pre>
                  </div>
                </div>

                <div class="score-section">
                  <div class="section-header">
                    <span class="section-label">评分</span>
                  </div>
                  <div class="score-control">
                    <template v-if="item.studentItemId">
                      <el-input-number
                        v-model="item.score"
                        :min="0"
                        :max="item.maxScore"
                        size="default"
                        controls-position="right"
                      />
                      <el-button
                        type="success"
                        size="default"
                        @click="handleItemScoreChange(item)"
                        class="save-btn"
                      >
                        保存
                      </el-button>
                    </template>
                    <template v-else>
                      <span class="not-submitted">未提交</span>
                    </template>
                  </div>
                </div>
              </div>
            </el-card>
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
import { ref, reactive, computed, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { Download, User, Edit, CircleCheck, ArrowRight, DArrowLeft, DArrowRight, Loading } from '@element-plus/icons-vue'
import { teacherApi } from '@/api/index.js'

// 响应式数据
const loading = ref(false)
const loadingMore = ref(false)
const experimentOptions = ref([])
const studentAnswerList = ref([])
const selectedExperimentId = ref(null)
const detailDialogVisible = ref(false)
const currentStudentDetail = ref(null)
const sidebarCollapsed = ref(false)

// 实验列表 ref
const experimentListRef = ref(null)
const loadMoreTrigger = ref(null)

// 初始显示数量和每次加载数量
const INITIAL_COUNT = 8
const LOAD_MORE_COUNT = 5
const displayCount = ref(INITIAL_COUNT)

// 当前选中的实验
const selectedExperiment = computed(() => {
  return experimentOptions.value.find(exp => exp.experimentId === selectedExperimentId.value)
})

// 显示的实验列表（动态加载）
const displayedExperiments = computed(() => {
  return experimentOptions.value.slice(0, displayCount.value)
})

// 是否还有更多实验可加载
const hasMoreExperiments = computed(() => {
  return displayCount.value < experimentOptions.value.length
})

// 分页
const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

// 计算属性
const gradedCount = computed(() => {
  return studentAnswerList.value.reduce((sum, s) => sum + ((s.itemCount || 0) - (s.scoredCount || 0)), 0)
})

const avgScore = computed(() => {
  if (!studentAnswerList.value.length) return 0
  const total = studentAnswerList.value.reduce((sum, s) => sum + (s.totalScore || 0), 0)
  return Math.round(total / studentAnswerList.value.length)
})

const getProgressColor = (row) => {
  const percent = row.maxScore > 0 ? (row.totalScore / row.maxScore) * 100 : 0
  if (percent >= 80) return '#67c23a'
  if (percent >= 50) return '#e6a23c'
  return '#909399'
}

const getScoreClass = (row) => {
  const percent = row.maxScore > 0 ? (row.totalScore / row.maxScore) * 100 : 0
  if (percent >= 80) return 'high'
  if (percent >= 50) return 'medium'
  return 'low'
}

// 加载实验列表（下拉框）
const loadExperimentList = async () => {
  try {
    const response = await teacherApi.experiment.getEnabled()
    experimentOptions.value = response.data || []
    displayCount.value = INITIAL_COUNT // 重置显示数量
  } catch (error) {
    console.error('加载实验列表失败', error)
  }
}

// 加载更多实验
const loadMoreExperiments = () => {
  if (loadingMore.value || !hasMoreExperiments.value) return
  loadingMore.value = true

  // 模拟加载延迟，实际项目中可能不需要
  setTimeout(() => {
    displayCount.value += LOAD_MORE_COUNT
    loadingMore.value = false
  }, 300)
}

// 实验列表滚动处理 - 无限滚动
const handleExperimentScroll = (e) => {
  const { scrollTop, scrollHeight, clientHeight } = e.target
  // 当滚动到距离底部约 50px 时触发加载
  if (scrollHeight - scrollTop - clientHeight < 50) {
    loadMoreExperiments()
  }
}

// 点击实验卡片
const handleExperimentClick = (expId) => {
  selectedExperimentId.value = expId
  pagination.page = 1
  loadStudentAnswerList()
}

// 加载学生答题列表
const loadStudentAnswerList = async () => {
  if (!selectedExperimentId.value) return

  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize
    }
    const response = await teacherApi.score.getStudentAnswers(selectedExperimentId.value)
    const data = response.data || {}
    studentAnswerList.value = data.list || []
    pagination.total = data.total || 0
  } catch (error) {
    ElMessage.error('加载学生答题列表失败')
    console.error(error)
  } finally {
    loading.value = false
  }
}

// 分页变化
const handleSizeChange = () => {
  pagination.page = 1
  loadStudentAnswerList()
}

const handlePageChange = () => {
  loadStudentAnswerList()
}

// 查看详情
const handleViewDetail = async (row) => {
  try {
    const response = await teacherApi.score.getStudentDetail(
      row.studentId,
      selectedExperimentId.value
    )
    currentStudentDetail.value = response.data || {}
    detailDialogVisible.value = true
  } catch (error) {
    ElMessage.error('加载详情失败')
    console.error(error)
  }
}

// 题目分数变化
const handleItemScoreChange = async (row) => {
  if (!row.studentItemId) return

  try {
    await teacherApi.score.scoreItem(row.studentItemId, row.score)

    // 更新总分
    if (currentStudentDetail.value) {
      let total = 0
      currentStudentDetail.value.items.forEach(item => {
        if (item.score != null) {
          total += item.score
        }
      })
      currentStudentDetail.value.totalScore = total
    }

    ElMessage.success('评分已保存')
  } catch (error) {
    ElMessage.error('评分失败')
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
    await teacherApi.score.export(selectedExperimentId.value)
    ElMessage.success('导出功能待实现')
  } catch (error) {
    ElMessage.error('导出失败')
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
        await teacherApi.score.scoreItem(item.studentItemId, item.score)
      }
    }
    ElMessage.success('批量保存成功')
    detailDialogVisible.value = false
    loadStudentAnswerList()
  } catch (error) {
    ElMessage.error('批量保存失败')
    console.error(error)
  }
}

// 页面初始化
onMounted(() => {
  loadExperimentList()
})
</script>

<style scoped>
.score-page {
  padding: 20px;
  background: #f0f2f5;
  min-height: calc(100vh - 84px);
  width: 100%;
  box-sizing: border-box;
}

.breadcrumb {
  margin-bottom: 20px;
}

.page-header {
  margin-bottom: 24px;
  padding: 16px 20px;
  background: #fff;
  border-radius: 10px;
}

.page-title {
  margin: 0 0 4px 0;
  font-size: 24px;
  font-weight: 600;
  color: #1d1d1f;
}

.page-desc {
  margin: 0;
  font-size: 14px;
  color: #86868b;
}

.main-content {
  display: flex;
  gap: 24px;
  min-height: calc(100vh - 200px);
  background: #f0f2f5;
  padding: 4px;
  border-radius: 12px;
}

.experiments-panel {
  width: 280px;
  flex-shrink: 0;
  background: #fff;
  border-radius: 10px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  transition: all 0.3s ease;
  overflow: hidden;
}

.experiments-panel.collapsed {
  width: 60px;
  padding: 12px 6px;
}

.panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.panel-title {
  font-size: 12px;
  font-weight: 600;
  color: #86868b;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  padding-left: 8px;
  white-space: nowrap;
}

.collapse-btn {
  color: #86868b;
  padding: 8px;
  border-radius: 10px;
  transition: all 0.25s ease;
}

.collapse-btn:hover {
  color: #4caf50;
  background: #f5f5f7;
}

.experiment-list {
  flex: 1;
  overflow-y: auto;
  scrollbar-width: thin;
}

.load-more-trigger {
  padding: 16px;
  text-align: center;
  cursor: pointer;
}

.load-hint {
  font-size: 12px;
  color: #9ca3af;
  transition: color 0.2s ease;
}

.load-hint:hover {
  color: #4caf50;
}

.loading-more {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 16px;
  color: #9ca3af;
  font-size: 12px;
}

.loading-more .el-icon {
  font-size: 16px;
}

.no-more-data {
  padding: 16px;
  text-align: center;
  color: #c0c4cc;
  font-size: 12px;
}

.expand-placeholder {
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: #909399;
  min-height: 48px;
  border-radius: 12px;
  transition: all 0.25s cubic-bezier(0.25, 0.1, 0.25, 1);
  background: #f5f5f7;
  border: 1px dashed #e0e0e0;
}

.expand-placeholder:hover {
  background: #e8f5e9;
  border-color: #4caf50;
  color: #4caf50;
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.15);
}

.expand-placeholder .expand-icon {
  font-size: 22px;
  font-weight: 600;
}

.experiment-card {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 14px 16px;
  background: #f5f5f7;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.2s ease;
  border: 2px solid transparent;
}

.experiment-card:hover {
  background: #e8e8ed;
}

.experiment-card.active {
  background: #e8f4ff;
  border-color: #007aff;
}

.exp-info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.exp-no {
  font-size: 11px;
  color: #86868b;
}

.exp-name {
  font-size: 14px;
  font-weight: 500;
  color: #1d1d1f;
}

.exp-arrow {
  color: #86868b;
  font-size: 14px;
}

.experiment-card.active .exp-arrow {
  color: #007aff;
}

.details-panel {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.empty-panel {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #fff;
  border-radius: 12px;
}

.exp-header-card {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 24px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
}

.exp-header-name {
  font-size: 20px;
  font-weight: 600;
  color: #1d1d1f;
  margin-bottom: 4px;
}

.exp-header-meta {
  font-size: 13px;
  color: #86868b;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}

.stat-card {
  background: #fff;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
  text-align: center;
}

.stat-value {
  font-size: 32px;
  font-weight: 700;
  color: #1d1d1f;
  margin-bottom: 4px;
}

.stat-label {
  font-size: 13px;
  color: #86868b;
}

.students-section {
  background: #fff;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
}

.section-title {
  font-size: 16px;
  font-weight: 600;
  color: #1d1d1f;
  margin-bottom: 16px;
}

.student-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.student-item {
  display: flex;
  align-items: center;
  padding: 16px;
  background: #f5f5f7;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.student-item:hover {
  background: #e8e8ed;
}

.student-info {
  display: flex;
  align-items: center;
  gap: 14px;
  flex: 1;
}

.student-avatar {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: #5b8def;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  font-weight: 600;
}

.student-details {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.student-name {
  font-size: 15px;
  font-weight: 500;
  color: #1d1d1f;
}

.student-meta {
  font-size: 12px;
  color: #86868b;
}

.student-score {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 4px;
  margin-right: 12px;
}

.score-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 13px;
  font-weight: 500;
  background: #f5f5f7;
  color: #1d1d1f;
}

.score-badge.high {
  background: #d1fae5;
  color: #065f46;
}

.score-badge.medium {
  background: #fef3c7;
  color: #92400e;
}

.score-badge.low {
  background: #fee2e2;
  color: #991b1b;
}

.status-text {
  font-size: 12px;
  color: #86868b;
}

.status-text.success {
  color: #34c759;
}

.status-text.pending {
  color: #ff9500;
}

.item-arrow {
  color: #86868b;
  font-size: 14px;
}

.list-pagination {
  margin-top: 16px;
  display: flex;
  justify-content: flex-end;
}

.list-pagination :deep(.el-pagination__total) {
  color: #86868b;
  font-size: 13px;
}

.list-pagination :deep(.el-pager li) {
  border-radius: 8px;
  background: transparent;
  color: #1d1d1f;
  font-weight: 400;
  min-width: 32px;
  height: 32px;
  line-height: 32px;
}

.list-pagination :deep(.el-pager li:hover) {
  color: #007aff;
}

.list-pagination :deep(.el-pager li.is-active) {
  background: #007aff;
  color: #fff;
  border-radius: 8px;
}

.detail-dialog :deep(.el-dialog__body) {
  padding: 20px;
  width: 100%;
  box-sizing: border-box;
}

.detail-dialog :deep(.el-dialog__header) {
  padding: 16px 20px;
  border-bottom: 1px solid #ebeef5;
}

.detail-dialog :deep(.el-dialog__footer) {
  padding: 12px 20px;
  border-top: 1px solid #ebeef5;
}

.detail-wrapper {
  display: flex;
  flex-direction: column;
  gap: 20px;
  width: 100%;
  box-sizing: border-box;
}

.detail-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: #e8f5e9;
  border-radius: 10px;
  border: 1px solid #c8e6c9;
  width: 100%;
  box-sizing: border-box;
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
  color: #67a068;
}

.tag-value {
  font-size: 14px;
  font-weight: 600;
  color: #303133;
}

.score-overview {
  display: flex;
  align-items: baseline;
  gap: 6px;
}

.overview-label {
  font-size: 13px;
  color: #67a068;
  margin-right: 4px;
}

.overview-score {
  font-size: 28px;
  font-weight: 700;
  color: #4caf50;
}

.overview-divider {
  font-size: 18px;
  color: #c0c4cc;
}

.overview-max {
  font-size: 16px;
  color: #909399;
}

.questions-container {
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 100%;
}

.questions-title {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 14px;
  font-weight: 600;
  color: #303133;
  width: 100%;
}

.questions-tip {
  font-size: 12px;
  font-weight: 400;
  color: #909399;
}

.no-data {
  padding: 40px;
  text-align: center;
  color: #909399;
  background: #f5f7fa;
  border-radius: 8px;
  width: 100%;
}

.question-cards {
  display: flex;
  flex-direction: column;
  gap: 16px;
  max-height: 500px;
  overflow-y: auto;
  padding-right: 4px;
  width: 100%;
}

.question-cards::-webkit-scrollbar {
  width: 6px;
}

.question-cards::-webkit-scrollbar-thumb {
  background: #dcdfe6;
  border-radius: 3px;
}

.question-card {
  border: 1px solid #ebeef5;
  border-radius: 10px;
  width: 100%;
  box-sizing: border-box;
}

:deep(.question-card .el-card__header) {
  padding: 12px 16px;
  background: #fafafa;
  border-bottom: 1px solid #ebeef5;
  width: 100%;
  box-sizing: border-box;
}

:deep(.question-card .el-card__body) {
  padding: 16px;
  width: 100%;
  box-sizing: border-box;
}

:deep(.question-card) {
  width: 100% !important;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.question-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.question-no {
  font-size: 12px;
  color: #909399;
}

.question-name {
  font-size: 14px;
  font-weight: 500;
  color: #303133;
}

.question-score {
  display: flex;
  align-items: center;
}

.score-label {
  font-size: 13px;
  color: #909399;
}

.card-body {
  display: flex;
  flex-direction: column;
  gap: 20px;
  padding: 4px 0;
}

.answer-section {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.section-header {
  display: flex;
  align-items: center;
  gap: 8px;
}

.section-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 22px;
  border-radius: 4px;
  font-size: 11px;
  font-weight: 600;
  color: #fff;
}

.section-icon.student {
  background: #909399;
}

.section-icon.std {
  background: #67c23a;
}

.section-label {
  font-size: 13px;
  color: #606266;
  font-weight: 500;
}

.answer-block {
  background: #f5f7fa;
  border-radius: 8px;
  padding: 14px 16px;
  border: 1px solid #ebeef5;
}

.answer-block.student-answer.empty {
  background: #fafafa;
  border-color: #ebeef5;
}

.answer-block.std-answer {
  background: #f0f9f0;
  border-color: #c8e6c9;
}

.answer-text {
  margin: 0;
  padding: 0;
  font-size: 14px;
  color: #303133;
  line-height: 1.8;
  white-space: pre-wrap;
  word-break: break-word;
  font-family: inherit;
}

.student-answer.empty .answer-text {
  color: #c0c4cc;
  font-style: italic;
}

.std-answer .answer-text {
  color: #4caf50;
}

.no-answer-text {
  color: #c0c4cc;
  font-style: italic;
  font-size: 13px;
}

.score-section {
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding-top: 4px;
}

.score-control {
  display: flex;
  align-items: center;
  gap: 12px;
}

.save-btn {
  height: 32px;
  padding: 0 16px;
}

.not-submitted {
  color: #c0c4cc;
  font-style: italic;
  font-size: 13px;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

.el-empty {
  padding: 60px 0;
}
</style>
