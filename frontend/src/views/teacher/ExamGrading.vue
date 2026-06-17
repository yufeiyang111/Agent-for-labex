<template>
  <div class="grading-page wabi-page">
    <div class="wabi-body">
      <div class="page-header">
        <h2 class="page-title">考试批改中心</h2>
        <p class="page-desc">点击考试卡片查看学生答题情况</p>
      </div>

      <div class="grading-layout">
        <!-- 左侧考试列表 -->
        <div class="exam-panel">
          <div class="panel-header">
            <span class="panel-title">考试列表</span>
            <el-select v-model="examFilter" size="small" style="width: 120px" @change="loadExams(true)">
              <el-option label="全部" value="all" />
              <el-option label="待批改" value="pending" />
              <el-option label="已批改" value="graded" />
            </el-select>
          </div>
          <div
            class="exam-list"
            ref="examListRef"
            @scroll="handleExamScroll"
            v-loading="loading"
          >
            <div
              v-for="exam in displayedExams"
              :key="exam.id"
              class="exam-item"
              :class="{ active: selectedExamId === exam.id }"
              @click="handleExamClick(exam.id)"
            >
              <div class="exam-info">
                <span class="exam-name">{{ exam.examName }}</span>
                <span class="exam-time">{{ formatDateTime(exam.examDate || exam.time) }}</span>
              </div>
              <span v-if="exam._pendingCount > 0" class="pending-badge">
                {{ exam._pendingCount }} 待批
              </span>
            </div>
            <div v-if="!examList.length && !loading" class="list-empty">
              <p>暂无考试</p>
            </div>
            <div v-if="loadingMoreExams" class="loading-more">加载中...</div>
          </div>
        </div>

        <!-- 右侧批改详情 -->
        <div class="grading-detail">
          <div class="panel-header">
            <span class="panel-title">{{ selectedExamName || '请选择考试' }}</span>
            <el-radio-group v-model="studentFilter" size="small" @change="filterStudents">
              <el-radio-button value="all">全部</el-radio-button>
              <el-radio-button value="pending">待批改</el-radio-button>
              <el-radio-button value="graded">已批改</el-radio-button>
            </el-radio-group>
          </div>
          <div class="detail-content" v-loading="loadingSubmissions">
            <div v-if="!selectedExamId" class="list-empty">
              <p>请从左侧选择一个考试</p>
            </div>
            <div v-else-if="!filteredSubmissions.length" class="list-empty">
              <p>{{ studentFilter === 'pending' ? '暂无待批改学生' : studentFilter === 'graded' ? '暂无已批改学生' : '暂无提交数据' }}</p>
            </div>
            <div v-else class="submission-list">
              <div v-for="sub in paginatedSubmissions" :key="sub.studentId" class="submission-item">
                <div class="student-info">
                  <span class="student-no">{{ sub.studentNo }}</span>
                  <span class="student-name">{{ sub.studentName }}</span>
                </div>
                <div class="submission-meta">
                  <span class="wabi-tag" :class="sub.graded ? 'wabi-tag-accent' : 'wabi-tag-warning'">
                    {{ sub.graded ? '已批改' : '待批改' }}
                  </span>
                  <span v-if="sub.finalScore != null" class="score">{{ sub.finalScore }} 分</span>
                  <span v-else-if="sub.autoScore != null" class="score auto-score">{{ sub.autoScore }} 分(自动)</span>
                </div>
                <el-button size="small" text @click="handleGrade(sub)" class="wabi-btn-text">
                  {{ sub.graded ? '查看' : '批改' }}
                </el-button>
              </div>
            </div>
          </div>
          <!-- 分页组件 - 固定在底部 -->
          <div v-if="filteredSubmissions.length" class="detail-pagination">
            <el-pagination
              v-model:current-page="subPagination.page"
              v-model:page-size="subPagination.pageSize"
              :total="filteredSubmissions.length"
              :page-sizes="[10, 20, 50, 100]"
              layout="total, sizes, prev, pager, next"
              small
              background
            />
          </div>
          <!-- 统计信息 -->
          <div v-if="submissions.length" class="detail-footer">
            <span>共 {{ submissions.length }} 名学生</span>
            <span>待批改：{{ submissions.filter(s => !s.graded).length }}</span>
            <span>已批改：{{ submissions.filter(s => s.graded).length }}</span>
          </div>
        </div>
      </div>
    </div>

    <!-- 批改对话框 -->
    <el-dialog v-model="gradeDialogVisible" :title="`批改 - ${currentStudent?.studentName || ''}`" width="1000" class="wabi-dialog">
      <div v-loading="loadingQuestions">
        <div v-if="!studentQuestions.length" class="list-empty">
          <p>暂无题目数据</p>
        </div>
        <div v-else class="grade-questions">
          <div v-for="(q, idx) in studentQuestions" :key="q.questionId" class="grade-question-item">
            <div class="question-header">
              <span class="question-index">{{ idx + 1 }}</span>
              <span class="question-type">{{ q.typeName }}</span>
              <span class="question-score">满分：{{ q.maxScore }}</span>
            </div>
            <div class="question-content">{{ q.question }}</div>
            <div class="student-answer">
              <div class="answer-label">学生答案：</div>
              <div class="answer-content">{{ q.studentAnswer || '未作答' }}</div>
            </div>
            <div v-if="q.correctAnswer" class="correct-answer">
              <div class="answer-label">参考答案：</div>
              <div class="answer-content">{{ q.correctAnswer }}</div>
            </div>
            <div class="grade-input">
              <span class="grade-label">评分：</span>
              <el-input-number
                v-model="q.score"
                :min="0"
                :max="q.maxScore"
                size="small"
                :disabled="currentStudent?.graded"
              />
              <span class="grade-max">/ {{ q.maxScore }}</span>
            </div>
          </div>
        </div>
      </div>
      <template #footer>
        <el-button @click="gradeDialogVisible = false" class="wabi-btn-ghost">
          {{ currentStudent?.graded ? '关闭' : '取消' }}
        </el-button>
        <el-button
          v-if="!currentStudent?.graded"
          type="primary"
          @click="submitGrade"
          :loading="submitting"
          class="wabi-btn-primary"
        >
          提交评分
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { teacherApi } from '@/api'

const gradingApi = teacherApi.grading
const examApi = teacherApi.exam

const loading = ref(false)
const loadingMoreExams = ref(false)
const loadingSubmissions = ref(false)
const loadingQuestions = ref(false)
const submitting = ref(false)
const examList = ref([])
const allSubmissions = ref([])
const submissions = ref([])
const selectedExamId = ref(null)
const examListRef = ref()
const gradeDialogVisible = ref(false)
const currentStudent = ref(null)
const studentQuestions = ref([])
const examFilter = ref('all')
const studentFilter = ref('all')

const PAGE_SIZE = 20
const currentPage = ref(1)
const hasMore = ref(true)

// 提交列表分页
const subPagination = ref({ page: 1, pageSize: 20, total: 0 })
const handleSubPageChange = () => {
  // computed 自动更新
}

const selectedExamName = computed(() => {
  const exam = examList.value.find(e => e.id === selectedExamId.value)
  return exam?.examName || ''
})

const displayedExams = computed(() => examList.value)

// 分页后的提交列表
const paginatedSubmissions = computed(() => {
  const start = (subPagination.value.page - 1) * subPagination.value.pageSize
  const end = start + subPagination.value.pageSize
  return filteredSubmissions.value.slice(start, end)
})

const filteredSubmissions = computed(() => {
  let result = submissions.value
  if (studentFilter.value === 'pending') {
    result = result.filter(s => !s.graded)
  } else if (studentFilter.value === 'graded') {
    result = result.filter(s => s.graded)
  }
  subPagination.value.total = result.length
  const start = (subPagination.value.page - 1) * subPagination.value.pageSize
  return result.slice(start, start + subPagination.value.pageSize)
})

const formatDateTime = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleString('zh-CN')
}

const filterStudents = () => {
  // computed 会自动更新
}

const loadExams = async (reset = false) => {
  if (reset) {
    currentPage.value = 1
    examList.value = []
    hasMore.value = true
  }
  loading.value = true
  try {
    const params = { page: currentPage.value, pageSize: PAGE_SIZE }
    const res = await examApi.list(params)
    let data = res.data?.list || res.data || []

    // 如果选择只显示待批改，需要过滤
    if (examFilter.value === 'pending') {
      // 这里简化处理，实际可能需要后端支持
      data = data.filter(exam => exam.state === 1)
    }

    if (reset) {
      examList.value = data
    } else {
      examList.value.push(...data)
    }
    hasMore.value = data.length === PAGE_SIZE
  } catch (error) {
    console.error('加载考试列表失败:', error)
  } finally {
    loading.value = false
  }
}

const handleExamScroll = (e) => {
  const { scrollTop, scrollHeight, clientHeight } = e.target
  if (scrollHeight - scrollTop - clientHeight < 50 && !loadingMoreExams.value && hasMore.value) {
    loadingMoreExams.value = true
    currentPage.value++
    loadExams().finally(() => {
      loadingMoreExams.value = false
    })
  }
}

const handleExamClick = async (examId) => {
  selectedExamId.value = examId
  loadingSubmissions.value = true
  studentFilter.value = 'all'
  subPagination.value.page = 1
  try {
    // 同时获取待批改和已批改的学生
    const [pendingRes, gradedRes] = await Promise.all([
      gradingApi.getPendingStudents(examId),
      gradingApi.getGradedStudents(examId)
    ])

    const pending = (pendingRes.data || []).map(s => ({ ...s, graded: false }))
    const graded = (gradedRes.data || []).map(s => ({ ...s, graded: true }))

    allSubmissions.value = [...pending, ...graded]
    submissions.value = allSubmissions.value

    // 更新考试列表中的待批改数量
    const exam = examList.value.find(e => e.id === examId)
    if (exam) {
      exam._pendingCount = pending.length
    }
  } catch (error) {
    console.error('加载提交列表失败:', error)
  } finally {
    loadingSubmissions.value = false
  }
}

const handleGrade = async (sub) => {
  currentStudent.value = sub
  gradeDialogVisible.value = true
  loadingQuestions.value = true
  try {
    const res = await gradingApi.getStudentQuestions(selectedExamId.value, sub.studentId)
    // 后端返回格式: { questions: [{ questionId, questionContent, fullScore, studentAnswer, currentScore, graded }] }
    const questions = res.data?.questions || res.data || []
    studentQuestions.value = questions.map(q => ({
      questionId: q.questionId,
      typeName: q.typeName || '简答题',
      question: q.questionContent || q.question,
      maxScore: q.fullScore || q.maxScore || 0,
      studentAnswer: q.studentAnswer || '',
      correctAnswer: q.correctAnswer || '',
      score: q.currentScore ?? q.score ?? 0
    }))
  } catch (error) {
    console.error('加载题目失败:', error)
  } finally {
    loadingQuestions.value = false
  }
}

const submitGrade = async () => {
  submitting.value = true
  try {
    const grades = studentQuestions.value.map(q => ({
      questionId: q.questionId,
      score: q.score
    }))
    await gradingApi.submitAllGrades(selectedExamId.value, currentStudent.value.studentId, grades)
    ElMessage.success('评分提交成功')
    gradeDialogVisible.value = false
    // 重新加载提交列表
    handleExamClick(selectedExamId.value)
  } catch (error) {
    ElMessage.error('提交失败')
  } finally {
    submitting.value = false
  }
}

onMounted(() => loadExams(true))
</script>

<style scoped>
.grading-page {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-body {
  padding: 24px;
  max-width: 1400px;
  margin: 0 auto;
  height: calc(100vh - 48px);
  display: flex;
  flex-direction: column;
  animation: wabi-fade-in 0.4s ease;
}

@keyframes wabi-fade-in {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 页面头部 */
.page-header {
  flex-shrink: 0;
  margin-bottom: 20px;
}

.page-title {
  font-size: 18px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0 0 4px 0;
}

.page-desc {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin: 0;
}

/* 布局 */
.grading-layout {
  flex: 1;
  display: flex;
  gap: 16px;
  min-height: 0;
}

/* 考试面板 */
.exam-panel {
  width: 320px;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  overflow: hidden;
}

.panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
  background: var(--wabi-surface-warm, #faf9f7);
}

.panel-title {
  font-size: 14px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
}

.exam-list {
  flex: 1;
  overflow-y: auto;
}

.exam-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  cursor: pointer;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
  transition: all 0.2s ease;
}

.exam-item:hover {
  background: var(--wabi-accent-light, #e8ede5);
}

.exam-item.active {
  background: var(--wabi-accent-light, #e8ede5);
  border-left: 3px solid var(--wabi-accent, #7a8b6f);
}

.exam-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
  flex: 1;
  min-width: 0;
}

.exam-name {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
  font-weight: 500;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.exam-time {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.pending-badge {
  display: inline-block;
  padding: 2px 8px;
  background: #f5efe4;
  color: #a0937d;
  font-size: 12px;
  border-radius: 10px;
  flex-shrink: 0;
}

/* 批改详情 */
.grading-detail {
  flex: 1;
  display: flex;
  flex-direction: column;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  overflow: hidden;
}

.detail-content {
  flex: 1;
  overflow-y: auto;
  min-height: 0;
}

/* 分页组件 - 固定在底部 */
.detail-pagination {
  display: flex;
  justify-content: center;
  padding: 12px 16px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
  background: var(--wabi-surface, #fff);
}

.detail-footer {
  display: flex;
  gap: 24px;
  padding: 12px 16px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
  background: var(--wabi-surface-warm, #faf9f7);
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 提交列表 */
.submission-list {
  display: flex;
  flex-direction: column;
}

.submission-item {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
  transition: background 0.2s ease;
}

.submission-item:hover {
  background: var(--wabi-accent-light, #e8ede5);
}

.student-info {
  flex: 1;
  display: flex;
  align-items: center;
  gap: 12px;
  min-width: 0;
}

.student-no {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  font-family: monospace;
  flex-shrink: 0;
}

.student-name {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
  font-weight: 500;
}

.submission-meta {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-right: 16px;
}

.score {
  font-size: 14px;
  font-weight: 600;
  color: var(--wabi-accent, #7a8b6f);
  font-family: 'Georgia', serif;
}

.auto-score {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  font-weight: 400;
}

/* 批改题目 */
.grade-questions {
  display: flex;
  flex-direction: column;
  gap: 16px;
  max-height: 60vh;
  overflow-y: auto;
  padding: 4px;
}

.grade-question-item {
  padding: 16px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
}

.question-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 8px;
}

.question-index {
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--wabi-accent-light, #e8ede5);
  color: var(--wabi-accent, #7a8b6f);
  font-size: 12px;
  font-weight: 600;
  border-radius: 4px;
}

.question-type {
  font-size: 12px;
  padding: 2px 8px;
  background: var(--wabi-border-light, #f0ece8);
  color: var(--wabi-text-secondary, #8a8580);
  border-radius: 2px;
}

.question-score {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-left: auto;
}

.question-content {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
  line-height: 1.6;
  margin-bottom: 12px;
}

.student-answer,
.correct-answer {
  margin-bottom: 12px;
}

.answer-label {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-bottom: 4px;
}

.answer-content {
  font-size: 13px;
  color: var(--wabi-text, #2c2c2c);
  padding: 8px 12px;
  background: var(--wabi-surface-warm, #faf9f7);
  border-radius: 4px;
  white-space: pre-wrap;
  word-break: break-all;
}

.correct-answer .answer-content {
  background: var(--wabi-accent-light, #e8ede5);
}

.grade-input {
  display: flex;
  align-items: center;
  gap: 8px;
  padding-top: 12px;
  border-top: 1px dashed var(--wabi-border, #e8e4df);
}

.grade-label {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.grade-max {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 空状态 */
.list-empty {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 40px 0;
  color: var(--wabi-text-secondary, #8a8580);
  font-size: 14px;
}

.loading-more {
  text-align: center;
  padding: 12px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
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

  .grading-layout {
    flex-direction: column;
  }

  .exam-panel {
    width: 100%;
    max-height: 300px;
  }
}
</style>
