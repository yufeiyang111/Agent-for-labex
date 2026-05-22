<template>
  <div class="homework-page">
    <el-card class="page-header">
      <div class="header-content">
        <div>
          <h2>作业中心</h2>
          <p class="subtitle">支持填空、选择、解答、编程四类题目在线作答</p>
        </div>
        <el-select v-model="filterStatus" class="filter-select" placeholder="筛选状态">
          <el-option label="全部" :value="0" />
          <el-option label="进行中" :value="1" />
          <el-option label="已截止" :value="2" />
          <el-option label="已提交" :value="3" />
        </el-select>
      </div>
    </el-card>

    <div v-loading="loading" class="homework-list">
      <el-empty v-if="filteredHomeworks.length === 0 && !loading" description="暂无作业" />

      <transition-group name="list" tag="div" class="homework-grid">
        <el-card v-for="hw in paginatedHomeworks" :key="hw.homeworkId" class="homework-card" shadow="hover">
          <div class="card-header">
            <div class="hw-name">{{ hw.homeworkName }}</div>
            <el-tag :type="getStatusType(hw)" size="small" effect="plain">{{ getStatusText(hw) }}</el-tag>
          </div>

          <div class="hw-content" v-html="hw.content || '暂无作业说明'" />

          <div class="hw-meta">
            <div class="meta-item">
              <el-icon><Clock /></el-icon>
              <span>截止：{{ formatDate(hw.deadline) }}</span>
            </div>
            <div class="meta-item" v-if="getMySubmission(hw.homeworkId)?.score !== null && getMySubmission(hw.homeworkId)?.score !== undefined">
              <el-icon><Histogram /></el-icon>
              <span>得分：{{ getMySubmission(hw.homeworkId)?.score }}</span>
            </div>
          </div>

          <div class="card-footer">
            <el-button type="primary" :disabled="isOverdue(hw.deadline)" @click="openWorkDialog(hw)">
              <el-icon><Edit /></el-icon>
              {{ isOverdue(hw.deadline) ? '已截止' : '进入作业' }}
            </el-button>
            <el-button plain @click="viewSubmissionDetail(hw)" :disabled="!getMySubmission(hw.homeworkId)">
              <el-icon><View /></el-icon>
              查看结果
            </el-button>
          </div>
        </el-card>
      </transition-group>
    </div>

    <div class="pagination-wrapper" v-if="filteredHomeworks.length > 0">
      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :page-sizes="[6, 12, 24, 48]"
        :total="filteredHomeworks.length"
        layout="total, sizes, prev, pager, next, jumper"
        background
      />
    </div>

    <el-dialog
      v-model="workDialogVisible"
      :title="currentHomework?.homeworkName || '作业答题'"
      width="1300px"
      class="work-dialog"
      :close-on-click-modal="false"
    >
      <div class="work-layout" v-loading="questionLoading">
        <aside class="question-sidebar">
          <div class="sidebar-title">题目列表</div>
          <div class="sidebar-items">
            <button
              v-for="(q, idx) in homeworkQuestions"
              :key="q.id"
              type="button"
              class="sidebar-item"
              :class="{ answered: hasAnswered(q), active: currentQuestionIndex === idx }"
              @click="currentQuestionIndex = idx"
            >
              <span>{{ idx + 1 }}</span>
              <small>{{ getQuestionTypeName(q.type) }}</small>
            </button>
          </div>
          <div class="sidebar-stats">
            <div>已作答 {{ answeredCount }} / {{ homeworkQuestions.length }}</div>
            <el-progress :percentage="progressPercent" :show-text="false" :stroke-width="8" />
          </div>
        </aside>

        <main class="question-main" v-if="currentQuestion">
          <div class="question-head">
            <div class="left">
              <span class="no">第 {{ currentQuestionIndex + 1 }} 题</span>
              <el-tag type="info" size="small">{{ getQuestionTypeName(currentQuestion.type) }}</el-tag>
              <el-tag type="warning" size="small">{{ currentQuestion.score || 10 }} 分</el-tag>
            </div>
            <div class="right">
              <el-button size="small" @click="switchQuestion(-1)" :disabled="currentQuestionIndex === 0">上一题</el-button>
              <el-button size="small" @click="switchQuestion(1)" :disabled="currentQuestionIndex >= homeworkQuestions.length - 1">下一题</el-button>
            </div>
          </div>

          <div class="question-content" v-html="currentQuestion.question" />

          <section class="answer-section">
            <template v-if="currentQuestion.type === 1">
              <div class="fill-blank-container">
                <div v-for="(blank, idx) in getBlankCount(currentQuestion.question)" :key="idx" class="fill-blank-row">
                  <span class="blank-label">第 {{ idx + 1 }} 空:</span>
                  <el-input
                    v-model="fillAnswers[currentQuestion.id + '_' + idx]"
                    :placeholder="'请输入第' + (idx + 1) + '个空的答案'"
                    @input="debouncedSaveFillBlank(currentQuestion)"
                    class="fill-input"
                  />
                </div>
              </div>
            </template>

            <template v-else-if="currentQuestion.type === 2">
              <el-radio-group v-model="answers[currentQuestion.id]" class="option-group" @change="saveAnswer(currentQuestion)">
                <el-radio v-for="(opt, key) in parseQuestionOptions(currentQuestion.options)" :key="key" :value="key">
                  <strong>{{ key }}.</strong> {{ opt }}
                </el-radio>
              </el-radio-group>
            </template>

            <template v-else-if="currentQuestion.type === 5 || currentQuestion.type === 7">
              <el-input v-model="answers[currentQuestion.id]" type="textarea" :rows="8" placeholder="请输入解答内容" @input="debouncedSave(currentQuestion)" />
              <p class="manual-tip">本题为人工批改题，提交后由老师赋分。</p>
            </template>

            <template v-else-if="currentQuestion.type === 6">
              <div class="code-toolbar">
                <el-select v-model="programmingLang[currentQuestion.id]" style="width: 140px">
                  <el-option label="Java" value="java" />
                  <el-option label="C" value="c" />
                </el-select>
                <el-button type="primary" @click="runTests(currentQuestion)" :loading="runningQuestionId === currentQuestion.id">运行测试</el-button>
                <span class="test-count">测试点：{{ currentQuestion.testCaseCount || 0 }}</span>
              </div>

              <MonacoEditor
                  v-model="answers[currentQuestion.id]"
                  :language="programmingLang[currentQuestion.id] || 'java'"
                  height="320px"
                  @input="debouncedSave(currentQuestion)"
                />

              <div class="judge-panel" v-if="judgeResults[currentQuestion.id]">
                <div class="judge-summary">
                  <el-tag :type="judgeStatusType(judgeResults[currentQuestion.id].status)">
                    {{ judgeStatusText(judgeResults[currentQuestion.id].status) }}
                  </el-tag>
                  <span>通过 {{ judgeResults[currentQuestion.id].passedCount || 0 }} / {{ judgeResults[currentQuestion.id].totalCount || 0 }}</span>
                </div>

                <div v-if="judgeResults[currentQuestion.id].compileError" class="compile-error">
                  <strong>编译错误：</strong>
                  <pre>{{ judgeResults[currentQuestion.id].compileError }}</pre>
                </div>

                <el-table
                  v-if="judgeResults[currentQuestion.id].details && judgeResults[currentQuestion.id].details.length"
                  :data="judgeResults[currentQuestion.id].details"
                  size="small"
                  border
                >
                  <el-table-column label="测试点" width="130">
                    <template #default="{ row, $index }">{{ row.name || `test_${$index + 1}` }}</template>
                  </el-table-column>
                  <el-table-column label="提示" min-width="120">
                    <template #default="{ row }">{{ row.hint || '-' }}</template>
                  </el-table-column>
                  <el-table-column label="内存(KB)" width="110">
                    <template #default="{ row }">{{ row.memoryKb ?? '-' }}</template>
                  </el-table-column>
                  <el-table-column label="用时(ms)" width="110">
                    <template #default="{ row }">{{ row.timeMs ?? '-' }}</template>
                  </el-table-column>
                  <el-table-column label="结果" width="120">
                    <template #default="{ row }">
                      <el-tag :type="row.passed ? 'success' : 'danger'">{{ row.resultText || (row.passed ? '答案正确' : '答案错误') }}</el-tag>
                    </template>
                  </el-table-column>
                  <el-table-column label="得分" width="100">
                    <template #default="{ row, $index }">
                      {{ calcCaseScoreText(currentQuestion, judgeResults[currentQuestion.id], row, $index) }}
                    </template>
                  </el-table-column>
                  <el-table-column prop="actualOutput" label="实际输出" min-width="220" show-overflow-tooltip />
                </el-table>
              </div>
            </template>

            <template v-else>
              <el-input v-model="answers[currentQuestion.id]" type="textarea" :rows="4" placeholder="请输入答案" @input="debouncedSave(currentQuestion)" />
            </template>
          </section>
        </main>
      </div>

      <template #footer>
        <div class="dialog-footer">
          <div class="left">已保存答题 {{ answeredCount }} / {{ homeworkQuestions.length }}</div>
          <div class="right">
            <el-button @click="workDialogVisible = false">关闭</el-button>
            <el-button @click="saveAllAnswers" :loading="saving">暂存</el-button>
            <el-button type="primary" @click="submitHomeworkAnswers" :loading="submitting">提交作业</el-button>
          </div>
        </div>
      </template>
    </el-dialog>

    <el-dialog v-model="detailDialogVisible" :title="'提交结果 - ' + (detailHomework?.homeworkName || '')" width="760px">
      <div v-if="currentSubmission" class="submission-detail">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="提交时间">{{ formatDate(currentSubmission.submitTime) }}</el-descriptions-item>
          <el-descriptions-item label="得分">{{ currentSubmission.score ?? '待批改' }}</el-descriptions-item>
          <el-descriptions-item label="状态" :span="2">{{ currentSubmission.remark || '暂无评语' }}</el-descriptions-item>
        </el-descriptions>
      </div>
      <template #footer>
        <el-button @click="detailDialogVisible = false">关闭</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { computed, onMounted, reactive, ref, watch } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Clock, Edit, Histogram, View } from '@element-plus/icons-vue'
import { studentApi } from '@/api'

const loading = ref(false)
const questionLoading = ref(false)
const homeworks = ref([])
const mySubmissions = ref({})
const currentPage = ref(1)
const pageSize = ref(12)
const filterStatus = ref(0)

const workDialogVisible = ref(false)
const detailDialogVisible = ref(false)
const currentHomework = ref(null)
const detailHomework = ref(null)
const currentSubmission = ref(null)

const homeworkQuestions = ref([])
const currentQuestionIndex = ref(0)
const answers = reactive({})
const fillAnswers = reactive({})
const programmingLang = reactive({})
const judgeResults = reactive({})
const runningQuestionId = ref(null)
const saving = ref(false)
const submitting = ref(false)
let debounceTimer = null

function getBlankCount(question) {
  if (!question) return 1
  const matches = question.match(/________/g)
  return matches ? matches.length : 1
}

function getFillAnswerKey(questionId, idx) {
  return questionId + '_' + idx
}

function debouncedSaveFillBlank(question) {
  clearTimeout(debounceTimer)
  debounceTimer = setTimeout(() => {
    saveFillAnswers(question)
  }, 1000)
}

function saveFillAnswers(question) {
  const blanks = getBlankCount(question.question)
  const parts = []
  for (let i = 0; i < blanks; i++) {
    const val = fillAnswers[question.id + '_' + i] || ''
    parts.push(val.trim())
  }
  answers[question.id] = parts.join('|||')
}

const filteredHomeworks = computed(() => {
  if (filterStatus.value === 0) return homeworks.value
  return homeworks.value.filter((hw) => {
    if (filterStatus.value === 1) return !isOverdue(hw.deadline) && hw.state === 1
    if (filterStatus.value === 2) return isOverdue(hw.deadline) || hw.state !== 1
    if (filterStatus.value === 3) return !!getMySubmission(hw.homeworkId)
    return true
  })
})

const paginatedHomeworks = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value
  return filteredHomeworks.value.slice(start, start + pageSize.value)
})

const currentQuestion = computed(() => homeworkQuestions.value[currentQuestionIndex.value] || null)

const answeredCount = computed(() => homeworkQuestions.value.filter(hasAnswered).length)

const progressPercent = computed(() => {
  if (homeworkQuestions.value.length === 0) return 0
  return Math.round((answeredCount.value / homeworkQuestions.value.length) * 100)
})

onMounted(loadHomeworks)

async function loadHomeworks() {
  loading.value = true
  try {
    const [hwRes, subRes] = await Promise.all([
      studentApi.homework.list(),
      studentApi.homework.getMyList()
    ])
    homeworks.value = hwRes.data?.records || []
    const submissions = subRes.data || []
    mySubmissions.value = {}
    submissions.forEach((s) => {
      mySubmissions.value[s.homeworkId] = s
    })
  } finally {
    loading.value = false
  }
}

function getMySubmission(homeworkId) {
  return mySubmissions.value[homeworkId]
}

function getStatusType(hw) {
  if (getMySubmission(hw.homeworkId)) return 'success'
  if (isOverdue(hw.deadline)) return 'danger'
  if (hw.state !== 1) return 'info'
  return 'warning'
}

function getStatusText(hw) {
  if (getMySubmission(hw.homeworkId)) return '已提交'
  if (isOverdue(hw.deadline)) return '已截止'
  if (hw.state !== 1) return '已禁用'
  return '进行中'
}

function isOverdue(deadline) {
  return deadline && new Date(deadline) < new Date()
}

function formatDate(date) {
  if (!date) return '-'
  return new Date(date).toLocaleString('zh-CN')
}

function getQuestionTypeName(type) {
  const typeMap = { 1: '填空题', 2: '选择题', 5: '解答题', 6: '编程题', 7: '解答题' }
  return typeMap[type] || '题目'
}

function parseQuestionOptions(options) {
  if (!options) return {}
  if (typeof options === 'object') return options
  try {
    return JSON.parse(options)
  } catch {
    return {}
  }
}

function hasAnswered(q) {
  const val = answers[q.id]
  return val !== undefined && val !== null && String(val).trim() !== ''
}

function switchQuestion(step) {
  const next = currentQuestionIndex.value + step
  if (next >= 0 && next < homeworkQuestions.value.length) {
    currentQuestionIndex.value = next
  }
}

async function openWorkDialog(hw) {
  currentHomework.value = hw
  currentQuestionIndex.value = 0
  homeworkQuestions.value = []
  Object.keys(answers).forEach((k) => delete answers[k])
  Object.keys(fillAnswers).forEach((k) => delete fillAnswers[k])
  Object.keys(programmingLang).forEach((k) => delete programmingLang[k])
  Object.keys(judgeResults).forEach((k) => delete judgeResults[k])

  workDialogVisible.value = true
  questionLoading.value = true
  try {
    const [detailRes, answerRes] = await Promise.all([
      studentApi.homework.getDetail(hw.homeworkId),
      studentApi.homework.getMyAnswers(hw.homeworkId)
    ])

    homeworkQuestions.value = detailRes.data?.questions || []
    const answerMap = {}
    ;(answerRes.data || []).forEach((item) => {
      answerMap[item.questionId] = item.myAnswer || ''
    })

    homeworkQuestions.value.forEach((q) => {
      if (q.type === 6) {
        const parsed = parseProgrammingAnswer(answerMap[q.id])
        answers[q.id] = parsed.code
        programmingLang[q.id] = parsed.language
      } else if (q.type === 1) {
        // 填空题：恢复每个空的答案
        const parts = (answerMap[q.id] || '').split('|||')
        parts.forEach((val, idx) => {
          fillAnswers[q.id + '_' + idx] = val
        })
        answers[q.id] = answerMap[q.id] || ''
      } else {
        answers[q.id] = answerMap[q.id] || ''
      }
    })
  } catch (error) {
    ElMessage.error(error?.message || '加载作业题目失败')
  } finally {
    questionLoading.value = false
  }
}

function parseProgrammingAnswer(value) {
  if (!value) return { language: 'java', code: '' }
  try {
    const parsed = JSON.parse(value)
    if (parsed && typeof parsed === 'object' && parsed.code !== undefined) {
      const language = parsed.language === 'c' ? 'c' : 'java'
      return { language, code: parsed.code || '' }
    }
  } catch {
    // ignore
  }
  return { language: 'java', code: value }
}

function serializeProgrammingAnswer(questionId) {
  return JSON.stringify({
    language: programmingLang[questionId] === 'c' ? 'c' : 'java',
    code: answers[questionId] || ''
  })
}

function getAnswerPayload(question) {
  if (question.type === 6) return serializeProgrammingAnswer(question.id)
  return answers[question.id] || ''
}

function debouncedSave(question) {
  if (debounceTimer) clearTimeout(debounceTimer)
  debounceTimer = setTimeout(() => saveAnswer(question), 450)
}

async function saveAnswer(question) {
  if (!currentHomework.value) return
  try {
    await studentApi.homework.saveAnswer(currentHomework.value.homeworkId, question.id, getAnswerPayload(question))
  } catch {
    // silent autosave failure
  }
}

async function saveAllAnswers() {
  if (!currentHomework.value) return
  saving.value = true
  try {
    for (const q of homeworkQuestions.value) {
      await studentApi.homework.saveAnswer(currentHomework.value.homeworkId, q.id, getAnswerPayload(q))
    }
    ElMessage.success('已保存')
  } catch (error) {
    ElMessage.error(error?.message || '保存失败')
  } finally {
    saving.value = false
  }
}

async function runTests(question) {
  if (!currentHomework.value) return
  const code = answers[question.id] || ''
  if (!code.trim()) {
    ElMessage.warning('请先编写代码')
    return
  }
  runningQuestionId.value = question.id
  try {
    const res = await studentApi.homework.runProgrammingTests(
      currentHomework.value.homeworkId,
      question.id,
      code,
      programmingLang[question.id] || 'java'
    )
    judgeResults[question.id] = res.data || {}
  } catch (error) {
    ElMessage.error(error?.message || '运行测试失败')
  } finally {
    runningQuestionId.value = null
  }
}

function judgeStatusType(status) {
  if (status === 'ALL_PASS') return 'success'
  if (status === 'PARTIAL_PASS') return 'warning'
  return 'danger'
}

function judgeStatusText(status) {
  if (status === 'ALL_PASS') return '答案正确'
  if (status === 'PARTIAL_PASS') return '部分通过'
  if (status === 'COMPILE_ERROR') return '编译错误'
  return '答案错误'
}

function calcCaseScoreText(question, judge, row, index) {
  const full = Number(question?.score || 10)
  const details = judge?.details || []
  const weights = details.map((d) => Number(d?.weight || 1))
  const totalWeight = Number(judge?.totalWeight || weights.reduce((a, b) => a + b, 0) || 0)
  if (!totalWeight || !details.length) return row?.passed ? `${full}/${full}` : `0/${full}`

  const basePoints = weights.map((w) => Math.floor((full * w) / totalWeight))
  let used = basePoints.reduce((a, b) => a + b, 0)
  let remain = Math.max(0, full - used)
  for (let i = 0; i < basePoints.length && remain > 0; i++) {
    basePoints[i] += 1
    remain--
  }

  const caseFull = basePoints[index] ?? 0
  const earned = row?.passed ? caseFull : 0
  return `${earned}/${caseFull}`
}

async function submitHomeworkAnswers() {
  if (!currentHomework.value) return
  try {
    await ElMessageBox.confirm('确认提交作业？系统将自动判分客观题与编程题。', '提示', { type: 'warning' })
  } catch {
    return
  }

  submitting.value = true
  try {
    await saveAllAnswers()
    const res = await studentApi.homework.submitAnswers(currentHomework.value.homeworkId)
    const autoScore = res.data?.autoScore ?? 0
    const totalScore = res.data?.totalScore ?? 0
    const pending = !!res.data?.pendingManualGrading
    ElMessage.success(`提交成功：${autoScore}/${totalScore}${pending ? '（含待人工批改题）' : ''}`)
    workDialogVisible.value = false
    await loadHomeworks()
  } catch (error) {
    ElMessage.error(error?.message || '提交失败')
  } finally {
    submitting.value = false
  }
}

function viewSubmissionDetail(hw) {
  detailHomework.value = hw
  currentSubmission.value = getMySubmission(hw.homeworkId)
  detailDialogVisible.value = true
}

watch(filterStatus, () => {
  currentPage.value = 1
})
</script>

<style lang="scss" scoped>
.homework-page {
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

.filter-select {
  width: 160px;
}

.homework-grid {
  display: grid;
  gap: 16px;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
}

.homework-card {
  border-radius: 8px;
  border: 1px solid #d9dee7;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  border-bottom: 1px solid #eceff4;
  padding-bottom: 10px;
}

.hw-name {
  font-size: 16px;
  font-weight: 600;
  color: #111827;
}

.hw-content {
  margin-top: 12px;
  color: #475467;
  min-height: 44px;
  line-height: 1.6;
}

.hw-meta {
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

.pagination-wrapper {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}

:deep(.work-dialog .el-dialog__body) {
  padding-top: 12px;
}

.work-layout {
  display: grid;
  grid-template-columns: 280px minmax(0, 1fr);
  gap: 16px;
  min-height: 600px;
}

.question-sidebar {
  border: 1px solid #d9dee7;
  border-radius: 8px;
  background: #fbfcff;
  padding: 12px;
  display: flex;
  flex-direction: column;
}

.sidebar-title {
  font-size: 15px;
  font-weight: 600;
  color: #1f2a3d;
  margin-bottom: 10px;
}

.sidebar-items {
  flex: 1;
  overflow-y: auto;
  display: grid;
  gap: 8px;
  align-content: start;
  grid-auto-rows: max-content;
}

.sidebar-item {
  border: 1px solid #d3d9e5;
  background: #fff;
  border-radius: 8px;
  padding: 8px 10px;
  text-align: left;
  display: flex;
  justify-content: space-between;
  align-items: center;
  cursor: pointer;
}

.sidebar-item span {
  font-weight: 600;
}

.sidebar-item small {
  color: #667085;
}

.sidebar-item.answered {
  border-color: #22a06b;
  background: #ecfdf3;
}

.sidebar-item.active {
  border-color: #2f6ef5;
  box-shadow: 0 0 0 2px rgba(47, 110, 245, 0.16);
}

.sidebar-stats {
  margin-top: 12px;
  color: #475467;
  font-size: 13px;
}

.question-main {
  border: 1px solid #d9dee7;
  border-radius: 8px;
  padding: 16px;
  overflow-y: auto;
}

.question-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.question-head .left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.question-head .no {
  font-weight: 600;
}

.question-content {
  border-top: 1px solid #eceff4;
  border-bottom: 1px solid #eceff4;
  padding: 14px 0;
  line-height: 1.7;
  color: #101828;
}

.answer-section {
  margin-top: 14px;
}

.fill-blank-container {
  display: flex;
  flex-direction: column;
  gap: 12px;

  .fill-blank-row {
    display: flex;
    align-items: center;
    gap: 12px;

    .blank-label {
      font-weight: 500;
      color: #101828;
      min-width: 70px;
    }

    .fill-input {
      flex: 1;
    }
  }
}

.option-group {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.manual-tip {
  margin-top: 8px;
  color: #9a6700;
  font-size: 12px;
}

.code-toolbar {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 10px;
}

.test-count {
  color: #667085;
  font-size: 13px;
}

:deep(.code-input textarea) {
  font-family: Consolas, Monaco, monospace;
  font-size: 13px;
  line-height: 1.55;
}

.judge-panel {
  margin-top: 12px;
  border: 1px solid #d9dee7;
  border-radius: 8px;
  padding: 12px;
  background: #fcfdff;
}

.judge-summary {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 10px;
}

.compile-error {
  margin-bottom: 10px;
}

.compile-error pre {
  margin: 8px 0 0;
  background: #1f2937;
  color: #f9fafb;
  padding: 10px;
  border-radius: 6px;
  white-space: pre-wrap;
}

.dialog-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.dialog-footer .left {
  color: #475467;
}

.dialog-footer .right {
  display: flex;
  gap: 8px;
}

.submission-detail {
  padding-top: 4px;
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

@media (max-width: 980px) {
  .work-layout {
    grid-template-columns: 1fr;
  }
}
</style>
