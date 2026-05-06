<template>
  <div class="grading-page">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/teacher' }">教师首页</el-breadcrumb-item>
      <el-breadcrumb-item>考试批改</el-breadcrumb-item>
    </el-breadcrumb>

    <!-- 页面标题 -->
    <div class="page-header">
      <h2 class="page-title">考试批改中心</h2>
      <p class="page-desc">点击考试卡片查看学生答题情况</p>
    </div>

    <!-- 主体内容区 - 左右布局 -->
    <div class="main-content">
      <!-- 左侧：考试列表 -->
      <div class="exams-panel" :class="{ collapsed: sidebarCollapsed }">
        <template v-if="!sidebarCollapsed">
          <div class="panel-header">
            <div class="panel-title">考试列表</div>
            <el-button text size="small" @click="sidebarCollapsed = true" class="collapse-btn">
              <el-icon><DArrowLeft /></el-icon>
            </el-button>
          </div>
          <div class="exam-list" ref="examListRef" @scroll="handleExamScroll" v-loading="loading">
            <div
              v-for="exam in displayedExams"
              :key="exam.id"
              class="exam-card"
              :class="{ active: selectedExamId === exam.id }"
              @click="handleExamClick(exam.id)"
            >
              <div class="exam-info">
                <span class="exam-name">{{ exam.examName }}</span>
                <span class="exam-time">{{ formatDateTime(exam.examDate) }}</span>
              </div>
              <div class="exam-badge" v-if="getPendingCount(exam.id) > 0">
                {{ getPendingCount(exam.id) }} 待批
              </div>
              <el-icon class="exam-arrow"><ArrowRight /></el-icon>
            </div>
            <el-empty v-if="!examList.length" description="暂无可批改的考试" />
            <div v-if="loadingMoreExams" class="loading-more">
              <el-icon class="is-loading"><Loading /></el-icon>
              <span>加载中...</span>
            </div>
            <div v-if="!hasMoreExams && displayedExams.length > 0" class="no-more-data">
              已加载全部 {{ examList.length }} 个考试
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
      <div class="details-panel" v-if="selectedExam">
        <!-- 考试信息卡 -->
        <div class="exam-header-card">
          <div class="exam-header-info">
            <div class="exam-header-name">{{ selectedExam.examName }}</div>
            <div class="exam-header-meta">
              <span>考试时间：{{ formatDateTime(selectedExam.examDate) }}</span>
            </div>
          </div>
        </div>

        <!-- 统计卡片 -->
        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-value">{{ pendingStudents.length }}</div>
            <div class="stat-label">待批学生</div>
          </div>
          <div class="stat-card">
            <div class="stat-value">{{ totalPending }}</div>
            <div class="stat-label">待批题目</div>
          </div>
          <div class="stat-card">
            <div class="stat-value">{{ avgAutoScore }}</div>
            <div class="stat-label">平均自动分</div>
          </div>
        </div>

        <!-- 监考预警 -->
        <div class="invigilation-section" v-loading="invigilationLoading">
          <el-card class="invigilation-card">
            <div class="invigilation-head">
              <div>
                <h3>监考预警</h3>
                <p>学生切换标签页或窗口失焦时会自动记录</p>
              </div>
              <el-button size="small" @click="loadInvigilationEvents(selectedExamId)">刷新</el-button>
            </div>

            <div class="invigilation-metrics">
              <span>异常次数：<strong>{{ invigilationTotal }}</strong></span>
              <span>涉及学生：<strong>{{ affectedStudents }}</strong></span>
              <span>最近发生：<strong>{{ formatDateTime(invigilationLatestAt) }}</strong></span>
            </div>

            <el-table :data="invigilationSummary" size="small" max-height="200" empty-text="暂无监考异常">
              <el-table-column prop="studentName" label="学生" min-width="120" />
              <el-table-column prop="studentNo" label="学号" width="120" />
              <el-table-column prop="warningCount" label="异常次数" width="80" />
              <el-table-column label="最近时间" min-width="160">
                <template #default="{ row }">{{ formatDateTime(row.latestAt) }}</template>
              </el-table-column>
            </el-table>

            <div class="event-subtitle">最近事件</div>
            <div class="event-list" ref="eventListRef" @scroll="handleEventScroll">
              <div v-if="!displayedEvents.length" class="empty-events">暂无事件明细</div>
              <div v-for="event in displayedEvents" :key="event.id || event.occurredAt" class="event-item">
                <div class="event-time">{{ formatDateTime(event.occurredAt) }}</div>
                <div class="event-student">{{ event.studentName }} ({{ event.studentNo }})</div>
                <div class="event-type">
                  <el-tag size="small" :type="eventTagType(event.eventType)">{{ eventTypeText(event.eventType) }}</el-tag>
                </div>
                <div class="event-desc">{{ event.eventDesc }}</div>
              </div>
              <div v-if="loadingMoreEvents" class="loading-more">
                <el-icon class="is-loading"><Loading /></el-icon>
                <span>加载中...</span>
              </div>
              <div v-if="!hasMoreEvents && displayedEvents.length > 0" class="no-more-events">
                已加载全部 {{ invigilationEvents.length }} 条事件
              </div>
            </div>
          </el-card>
        </div>

        <!-- 学生列表 -->
        <div class="students-section">
          <div class="section-title">待批改学生</div>
          <div class="student-list" v-if="pendingStudents.length > 0">
            <div
              v-for="student in paginatedStudents"
              :key="student.studentId"
              class="student-item"
              @click="openGradingDialog(student)"
            >
              <div class="student-info">
                <div class="student-avatar">{{ student.studentName?.charAt(0) || 'S' }}</div>
                <div class="student-details">
                  <div class="student-name">{{ student.studentName }}</div>
                  <div class="student-meta">{{ student.studentNo }}</div>
                </div>
              </div>
              <div class="student-score">
                <span class="score-text">待批 {{ student.pendingCount }} 题</span>
                <span class="score-auto">自动 {{ student.autoScore || 0 }} 分</span>
              </div>
              <el-icon class="item-arrow"><ArrowRight /></el-icon>
            </div>
          </div>
          <div v-else class="empty-student-list">
            <el-empty description="没有待批改的学生" :image-size="60" />
          </div>
          <el-pagination
            v-if="pendingStudents.length > 0"
            v-model:current-page="pagination.page"
            v-model:page-size="pagination.pageSize"
            :page-sizes="[10, 20, 50]"
            :total="pendingStudents.length"
            layout="total, prev, pager, next"
            @size-change="handlePageChange"
            @current-change="handlePageChange"
            class="list-pagination"
          />
        </div>
      </div>

      <!-- 空状态 -->
      <div class="empty-panel" v-else>
        <el-empty description="请从左侧选择一个考试" />
      </div>
    </div>

    <!-- 批改对话框 -->
    <el-dialog v-model="gradingDialogVisible" title="按题批改" width="900px" destroy-on-close>
      <div class="grading-head">
        <div>学生：{{ currentStudent?.studentName || '-' }}</div>
        <div>学号：{{ currentStudent?.studentNo || '-' }}</div>
        <div class="auto-score">自动分：{{ currentStudent?.autoScore ?? 0 }}</div>
      </div>

      <el-scrollbar height="480">
        <div v-if="!pendingQuestions.length" class="empty-q">该学生暂时无待批题目</div>
        <el-card v-for="(q, index) in pendingQuestions" :key="q.questionId" class="question-card" shadow="never">
          <div class="q-top">
            <strong>题目 {{ index + 1 }}</strong>
            <span>满分 {{ q.fullScore }} 分</span>
          </div>
          <div class="q-content" v-html="q.questionContent"></div>
          <div class="q-answer">
            <div class="label">学生答案</div>
            <div class="value">{{ q.studentAnswer || '未作答' }}</div>
          </div>
          <div class="q-score">
            <span>给分</span>
            <el-input-number v-model="q.score" :min="0" :max="q.fullScore" />
          </div>
        </el-card>
      </el-scrollbar>

      <template #footer>
        <el-button @click="gradingDialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="submitting" @click="submitGrades">提交批改</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue'
import { ElMessage } from 'element-plus'
import { Loading, ArrowRight, DArrowLeft, DArrowRight } from '@element-plus/icons-vue'
import { teacherApi } from '@/api/index.js'

const loading = ref(false)
const submitting = ref(false)
const invigilationLoading = ref(false)
const loadingMoreEvents = ref(false)
const loadingMoreExams = ref(false)
const sidebarCollapsed = ref(false)

const examList = ref([])
const selectedExamId = ref(null)
const pendingStudents = ref([])

const gradingDialogVisible = ref(false)
const currentStudent = ref(null)
const pendingQuestions = ref([])

const invigilationTotal = ref(0)
const affectedStudents = ref(0)
const invigilationLatestAt = ref(null)
const invigilationSummary = ref([])
const invigilationEvents = ref([])

const eventListRef = ref(null)
const examListRef = ref(null)
const INITIAL_EVENT_COUNT = 15
const LOAD_MORE_EVENT_COUNT = 10
const eventDisplayCount = ref(INITIAL_EVENT_COUNT)

const INITIAL_EXAM_COUNT = 10
const LOAD_MORE_EXAM_COUNT = 8
const examDisplayCount = ref(INITIAL_EXAM_COUNT)

const pagination = ref({ page: 1, pageSize: 24 })

const displayedExams = computed(() => {
  return examList.value.slice(0, examDisplayCount.value)
})

const hasMoreExams = computed(() => {
  return examDisplayCount.value < examList.value.length
})

const displayedEvents = computed(() => {
  return invigilationEvents.value.slice(0, eventDisplayCount.value)
})

const hasMoreEvents = computed(() => {
  return eventDisplayCount.value < invigilationEvents.value.length
})

const selectedExam = computed(() => {
  return examList.value.find(exam => exam.id === selectedExamId.value)
})

const totalPending = computed(() => pendingStudents.value.reduce((sum, s) => sum + (s.pendingCount || 0), 0))
const avgAutoScore = computed(() => {
  if (!pendingStudents.value.length) return 0
  const total = pendingStudents.value.reduce((sum, s) => sum + (s.autoScore || 0), 0)
  return Math.round(total / pendingStudents.value.length)
})
const paginatedStudents = computed(() => {
  const start = (pagination.value.page - 1) * pagination.value.pageSize
  const end = start + pagination.value.pageSize
  return pendingStudents.value.slice(start, end)
})

onMounted(loadPendingExams)

function getPendingCount(examId) {
  return 0
}

function resetInvigilationState() {
  invigilationTotal.value = 0
  affectedStudents.value = 0
  invigilationLatestAt.value = null
  invigilationSummary.value = []
  invigilationEvents.value = []
}

function formatDateTime(value) {
  if (!value) return '-'
  return new Date(value).toLocaleString('zh-CN')
}

function eventTagType(type) {
  if (type === 'TAB_HIDDEN') return 'warning'
  if (type === 'WINDOW_BLUR') return 'danger'
  return 'info'
}

function eventTypeText(type) {
  if (type === 'TAB_HIDDEN') return '切换标签页'
  if (type === 'WINDOW_BLUR') return '窗口失焦'
  return type || '-'
}

async function loadPendingExams() {
  try {
    const res = await teacherApi.grading.getPendingExams()
    examList.value = res.data || []
    examDisplayCount.value = INITIAL_EXAM_COUNT
  } catch {
    ElMessage.error('加载考试列表失败')
  }
}

const loadMoreExams = () => {
  if (loadingMoreExams.value || !hasMoreExams.value) return
  loadingMoreExams.value = true
  setTimeout(() => {
    examDisplayCount.value += LOAD_MORE_EXAM_COUNT
    loadingMoreExams.value = false
  }, 300)
}

const handleExamScroll = (e) => {
  const { scrollTop, scrollHeight, clientHeight } = e.target
  if (scrollHeight - scrollTop - clientHeight < 50) {
    loadMoreExams()
  }
}

async function loadPendingStudents(examId) {
  const res = await teacherApi.grading.getPendingStudents(examId)
  pendingStudents.value = res.data || []
}

async function loadInvigilationEvents(examId) {
  if (!examId) {
    resetInvigilationState()
    return
  }
  invigilationLoading.value = true
  try {
    const res = await teacherApi.grading.getInvigilationEvents(examId)
    invigilationTotal.value = res.data?.totalEvents || 0
    affectedStudents.value = res.data?.affectedStudents || 0
    invigilationLatestAt.value = res.data?.latestAt || null
    invigilationSummary.value = res.data?.studentSummary || []
    invigilationEvents.value = res.data?.events || []
    eventDisplayCount.value = INITIAL_EVENT_COUNT
  } catch {
    ElMessage.error('加载监考记录失败')
  } finally {
    invigilationLoading.value = false
  }
}

const loadMoreEvents = () => {
  if (loadingMoreEvents.value || !hasMoreEvents.value) return
  loadingMoreEvents.value = true
  setTimeout(() => {
    eventDisplayCount.value += LOAD_MORE_EVENT_COUNT
    loadingMoreEvents.value = false
  }, 300)
}

const handleEventScroll = (e) => {
  const { scrollTop, scrollHeight, clientHeight } = e.target
  if (scrollHeight - scrollTop - clientHeight < 50) {
    loadMoreEvents()
  }
}

async function handleExamClick(examId) {
  selectedExamId.value = examId
  pagination.value.page = 1
  loading.value = true
  try {
    await Promise.all([loadPendingStudents(examId), loadInvigilationEvents(examId)])
  } catch {
    ElMessage.error('加载考试数据失败')
  } finally {
    loading.value = false
  }
}

async function handlePageChange() {
  // 分页变化不需要重新加载
}

async function openGradingDialog(student) {
  currentStudent.value = student
  gradingDialogVisible.value = true
  try {
    const res = await teacherApi.grading.getStudentQuestions(selectedExamId.value, student.studentId)
    pendingQuestions.value = (res.data?.questions || []).map((q) => ({ ...q, score: q.currentScore || 0 }))
  } catch {
    ElMessage.error('加载题目失败')
  }
}

async function submitGrades() {
  if (!currentStudent.value) return
  submitting.value = true
  try {
    const grades = pendingQuestions.value.map((q) => ({ questionId: q.questionId, score: q.score }))
    await teacherApi.grading.submitAllGrades(selectedExamId.value, currentStudent.value.studentId, grades)
    ElMessage.success('批改已提交')
    gradingDialogVisible.value = false
    await handleExamClick(selectedExamId.value)
  } catch {
    ElMessage.error('提交失败')
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped>
.grading-page {
  padding: 24px;
  background: #f5f5f7;
  min-height: 100vh;
}

.breadcrumb {
  margin-bottom: 24px;
}

.page-header {
  margin-bottom: 24px;
  padding: 20px 24px;
  background: #ffffff;
  border-radius: 20px;
}

.page-title {
  margin: 0 0 4px 0;
  font-size: 22px;
  font-weight: 700;
  color: #1d1d1f;
}

.page-desc {
  margin: 0;
  font-size: 13px;
  color: #6e6e73;
}

.main-content {
  display: flex;
  gap: 24px;
}

.exams-panel {
  width: 300px;
  flex-shrink: 0;
  background: #ffffff;
  border-radius: 16px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  transition: all 0.3s ease;
  max-height: calc(100vh - 160px);
  position: sticky;
  top: 24px;
}

.exams-panel.collapsed {
  width: 56px;
  padding: 12px 8px;
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
  color: #6e6e73;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  white-space: nowrap;
}

.collapse-btn {
  color: #6e6e73;
  padding: 8px;
  border-radius: 10px;
  transition: all 0.25s ease;
}

.collapse-btn:hover {
  color: #4caf50;
  background: #f5f5f7;
}

.exam-list {
  flex: 1;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.loading-more,
.no-more-data {
  padding: 12px;
  text-align: center;
  color: #9ca3af;
  font-size: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.loading-more .el-icon {
  font-size: 16px;
}

.exam-card {
  display: flex;
  align-items: center;
  padding: 14px 16px;
  background: #f5f5f7;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.25s ease;
  border: 2px solid transparent;
}

.exam-card:hover {
  background: #e8e8ed;
}

.exam-card.active {
  background: #e6f4ea;
  border-color: #4caf50;
}

.exam-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 4px;
  min-width: 0;
}

.exam-name {
  font-size: 14px;
  font-weight: 600;
  color: #1d1d1f;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.exam-time {
  font-size: 11px;
  color: #6e6e73;
}

.exam-badge {
  background: #fef3c7;
  color: #92400e;
  font-size: 11px;
  font-weight: 600;
  padding: 4px 8px;
  border-radius: 10px;
  white-space: nowrap;
}

.exam-arrow {
  color: #6e6e73;
  font-size: 14px;
  margin-left: 8px;
}

.exam-card.active .exam-arrow {
  color: #4caf50;
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

.expand-icon {
  font-size: 22px;
  font-weight: 600;
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
  background: #ffffff;
  border-radius: 16px;
  min-height: 400px;
}

.exam-header-card {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 24px;
  background: #ffffff;
  border-radius: 16px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.exam-header-name {
  font-size: 18px;
  font-weight: 700;
  color: #1d1d1f;
  margin-bottom: 4px;
}

.exam-header-meta {
  font-size: 13px;
  color: #6e6e73;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}

.stat-card {
  background: #ffffff;
  padding: 20px;
  border-radius: 14px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  text-align: center;
}

.stat-value {
  font-size: 28px;
  font-weight: 700;
  color: #1d1d1f;
  margin-bottom: 4px;
}

.stat-label {
  font-size: 13px;
  color: #6e6e73;
}

.invigilation-section {
  margin-bottom: 0;
}

.invigilation-card {
  border-radius: 16px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.invigilation-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.invigilation-head h3 {
  margin: 0 0 4px 0;
  font-size: 15px;
  font-weight: 600;
  color: #1d1d1f;
}

.invigilation-head p {
  margin: 0;
  font-size: 12px;
  color: #6e6e73;
}

.invigilation-metrics {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
  color: #374151;
  font-size: 13px;
  margin-bottom: 16px;
}

.invigilation-metrics strong {
  color: #1d1d1f;
}

.event-subtitle {
  margin: 16px 0 12px;
  font-size: 14px;
  font-weight: 600;
  color: #1d1d1f;
}

.event-list {
  max-height: 280px;
  overflow-y: auto;
  scrollbar-width: thin;
}

.empty-events {
  padding: 30px;
  text-align: center;
  color: #9ca3af;
  font-size: 13px;
}

.event-item {
  display: grid;
  grid-template-columns: 160px 140px 90px 1fr;
  gap: 12px;
  align-items: center;
  padding: 10px 0;
  border-bottom: 1px solid #f0f0f0;
  font-size: 13px;
}

.event-item:last-child {
  border-bottom: none;
}

.event-time {
  color: #6e6e73;
  font-size: 12px;
}

.event-student {
  color: #374151;
}

.event-desc {
  color: #6e6e73;
  font-size: 12px;
}

.loading-more,
.no-more-events {
  padding: 12px;
  text-align: center;
  color: #9ca3af;
  font-size: 12px;
}

.loading-more {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.loading-more .el-icon {
  font-size: 16px;
}

.students-section {
  background: #ffffff;
  border-radius: 16px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.section-title {
  font-size: 15px;
  font-weight: 600;
  color: #1d1d1f;
  margin-bottom: 16px;
}

.student-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.empty-student-list {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 40px 0;
}

.student-item {
  display: flex;
  align-items: center;
  padding: 14px 16px;
  background: #f5f5f7;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.25s ease;
}

.student-item:hover {
  background: #e8e8ed;
  transform: translateX(4px);
}

.student-info {
  display: flex;
  align-items: center;
  gap: 12px;
  flex: 1;
}

.student-avatar {
  width: 40px;
  height: 40px;
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
  font-size: 14px;
  font-weight: 600;
  color: #1d1d1f;
}

.student-meta {
  font-size: 12px;
  color: #6e6e73;
}

.student-score {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 2px;
  margin-right: 12px;
}

.score-text {
  font-size: 13px;
  font-weight: 600;
  color: #f59e0b;
}

.score-auto {
  font-size: 12px;
  color: #6e6e73;
}

.item-arrow {
  color: #6e6e73;
  font-size: 14px;
}

.list-pagination {
  margin-top: 16px;
  display: flex;
  justify-content: flex-end;
}

.grading-head {
  display: flex;
  gap: 20px;
  align-items: center;
  margin-bottom: 16px;
  padding: 12px 16px;
  background: #f5f5f7;
  border-radius: 10px;
  color: #374151;
  font-size: 14px;
}

.auto-score {
  color: #4caf50;
  font-weight: 700;
}

.empty-q {
  color: #9ca3af;
  padding: 40px;
  text-align: center;
}

.question-card {
  margin-bottom: 12px;
  border-radius: 12px;
}

.q-top {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
  color: #1d1d1f;
  font-size: 14px;
}

.q-content {
  background: #f5f5f7;
  border-radius: 8px;
  padding: 12px;
  margin-bottom: 10px;
  color: #374151;
}

.q-answer {
  border: 1px dashed #d1d5db;
  border-radius: 8px;
  padding: 12px;
  margin-bottom: 10px;
}

.q-answer .label {
  font-size: 12px;
  color: #6e6e73;
  margin-bottom: 6px;
}

.q-answer .value {
  color: #1d1d1f;
  white-space: pre-wrap;
  word-break: break-word;
  font-size: 13px;
}

.q-score {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 14px;
  color: #374151;
}

:deep(.el-table) {
  font-size: 13px;
}

:deep(.el-table th.el-table__cell) {
  background-color: #fafafa;
  font-weight: 600;
  color: #6e6e73;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

:deep(.el-table__row:hover > td.el-table__cell) {
  background-color: #fafafa !important;
}

@media (max-width: 1024px) {
  .main-content {
    flex-direction: column;
  }

  .exams-panel {
    width: 100%;
    max-height: none;
    position: static;
  }

  .event-item {
    grid-template-columns: 1fr 1fr;
  }
}
</style>
