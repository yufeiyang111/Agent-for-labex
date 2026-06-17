<template>
  <div class="exam-page">
    <el-card class="page-header">
      <div class="header-row">
        <div>
          <h2>在线考试</h2>
          <p>支持填空、选择、解答、编程四种题型</p>
        </div>
        <el-select v-model="filterStatus" class="filter-select" placeholder="状态筛选">
          <el-option label="全部" :value="0" />
          <el-option label="进行中" :value="1" />
          <el-option label="未开始" :value="2" />
          <el-option label="已截止" :value="3" />
        </el-select>
      </div>
    </el-card>

    <el-card class="list-card" v-loading="loading" @scroll="handleScroll">
      <el-empty v-if="displayedExams.length === 0 && !loadingMore" description="暂无考试" />
      <div v-else class="exam-grid">
        <el-card v-for="exam in displayedExams" :key="exam.id" shadow="hover" class="exam-item">
          <div class="title-line">
            <span class="name">{{ exam.examName }}</span>
            <el-tag size="small" :type="statusType(exam)">{{ statusText(exam) }}</el-tag>
          </div>
          <div class="meta">试卷：{{ exam.paperName || '-' }}</div>
          <div class="meta">开始：{{ formatDate(exam.time) }}</div>
          <div class="meta">截止：{{ formatDate(exam.endTime) }}</div>
          <div class="meta">总分：{{ exam.totalScore || '-' }}</div>
          <div class="meta">题数：{{ exam.totalQuestions || '-' }}</div>
          <div class="actions">
            <el-button type="primary" :disabled="!canEnterExam(exam)" @click="openExam(exam)">
              {{ actionText(exam) }}
            </el-button>
          </div>
        </el-card>
      </div>
      <div v-if="loadingMore" class="loading-more">
        <el-icon class="is-loading"><Loading /></el-icon>
        <span>加载中...</span>
      </div>
      <div v-if="!hasMore && displayedExams.length > 0" class="no-more">
        已加载全部 {{ displayedExams.length }} 个考试
      </div>
    </el-card>

    <el-dialog
      v-model="examDialogVisible"
      :title="currentExam?.examName || '考试作答'"
      width="1100px"
      :close-on-click-modal="false"
      @close="stopRuntime"
    >
      <div v-if="examDetail">
        <el-result
          v-if="!examDetail.examStarted"
          icon="info"
          title="考试未开始"
          :sub-title="`开始时间：${formatDate(examDetail.startTime)}`"
        >
          <template #extra>
            <el-countdown
              v-if="examDetail.startTime"
              :value="new Date(examDetail.startTime).getTime()"
              @finish="reloadExamDetail"
            />
          </template>
        </el-result>

        <el-result
          v-else-if="examDetail.examEnded"
          icon="error"
          title="考试已截止"
          sub-title="已自动停止作答"
        />

        <template v-else>
          <div class="exam-bar">
            <div class="timer" :class="{ warn: timeLeft <= 300, danger: timeLeft <= 60 }">
              剩余时间：{{ formatCountdown(timeLeft) }}
            </div>
            <div class="progress">
              已答 {{ answeredCount }} / {{ totalQuestions }}
              <el-progress :percentage="progressPercent" :show-text="false" />
            </div>
            <div class="save-status">{{ saving ? '保存中...' : '自动保存已开启' }}</div>
            <div class="monitor-status">监考预警：{{ monitorWarningCount }}</div>
          </div>

          <div class="question-list">
            <div v-for="(q, idx) in examDetail.questions" :key="q.id" class="question-card">
              <div class="q-head">
                <div>第 {{ idx + 1 }} 题（{{ typeName(q.type) }}）</div>
                <div>{{ q.score || 10 }} 分</div>
              </div>
              <div class="q-body" v-html="q.question"></div>

              <template v-if="q.type === 1">
                <el-input v-model="answers[q.id]" type="textarea" :rows="3" @input="onAnswerInput(q.id)" />
              </template>

              <template v-else-if="q.type === 2">
                <el-radio-group v-model="answers[q.id]" @change="saveAnswer(q.id, answers[q.id])">
                  <el-radio v-for="(opt, key) in parseOptions(q.options)" :key="key" :value="key">{{ key }}. {{ opt }}</el-radio>
                </el-radio-group>
              </template>

              <template v-else-if="q.type === 3">
                <el-checkbox-group v-model="multiAnswers[q.id]" @change="saveAnswer(q.id, multiAnswers[q.id].join(','))">
                  <el-checkbox v-for="(opt, key) in parseOptions(q.options)" :key="key" :value="key">{{ key }}. {{ opt }}</el-checkbox>
                </el-checkbox-group>
              </template>

              <template v-else-if="q.type === 4">
                <el-radio-group v-model="answers[q.id]" @change="saveAnswer(q.id, answers[q.id])">
                  <el-radio value="true">正确</el-radio>
                  <el-radio value="false">错误</el-radio>
                </el-radio-group>
              </template>

              <template v-else-if="q.type === 6">
                <div class="programming-box">
                  <div class="programming-toolbar">
                    <el-select v-model="codeLanguages[q.id]" size="small" style="width: 110px">
                      <el-option label="Java" value="java" />
                      <el-option label="C" value="c" />
                    </el-select>
                    <el-button size="small" type="primary" :loading="running[q.id]" @click="runTests(q.id)">
                      运行测试点
                    </el-button>
                  </div>
                  <MonacoEditor
                    v-model="programmingCodes[q.id]"
                    :language="codeLanguages[q.id] || 'java'"
                    height="300px"
                    @input="onProgrammingInput(q.id)"
                  />
                  <div v-if="testResult[q.id]" class="judge-box">
                    <div class="judge-title">
                      状态：{{ testResult[q.id].status }}（{{ testResult[q.id].passedCount || 0 }}/{{ testResult[q.id].totalCount || 0 }}）
                    </div>
                    <div v-if="testResult[q.id].compileError" class="compile-error">{{ testResult[q.id].compileError }}</div>
                    <el-table v-if="Array.isArray(testResult[q.id].details)" :data="testResult[q.id].details" size="small">
                      <el-table-column prop="name" label="测试点" min-width="120" />
                      <el-table-column label="内存(KB)" width="100">
                        <template #default="{ row }">{{ row.memoryKb ?? '-' }}</template>
                      </el-table-column>
                      <el-table-column label="用时(ms)" width="100">
                        <template #default="{ row }">{{ row.timeMs ?? '-' }}</template>
                      </el-table-column>
                      <el-table-column prop="resultText" label="结果" width="120" />
                      <el-table-column label="实际输出" min-width="200">
                        <template #default="{ row }">
                          <pre class="actual-output">{{ row.actualOutput || '-' }}</pre>
                        </template>
                      </el-table-column>
                    </el-table>
                  </div>
                </div>
              </template>

              <template v-else>
                <el-input v-model="answers[q.id]" type="textarea" :rows="4" @input="onAnswerInput(q.id)" />
              </template>
            </div>
          </div>
        </template>
      </div>

      <template #footer>
        <el-button @click="examDialogVisible = false">关闭</el-button>
        <el-button type="warning" :loading="saving" @click="saveAll(false)" :disabled="examLocked">暂存</el-button>
        <el-button type="primary" :loading="submitting" @click="submitExam(false)" :disabled="examLocked">提交考试</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { computed, onMounted, onUnmounted, reactive, ref, watch } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Loading } from '@element-plus/icons-vue'
import { studentApi } from '@/api'

const loading = ref(false)
const loadingMore = ref(false)
const exams = ref([])
const currentPage = ref(1)
const pageSize = 12
const filterStatus = ref(0)
const displayedCount = ref(pageSize)
const gridRef = ref(null)

const displayedExams = computed(() => {
  return filteredExams.value.slice(0, displayedCount.value)
})

const hasMore = computed(() => {
  return displayedCount.value < filteredExams.value.length
})

const loadMore = () => {
  if (loadingMore.value || !hasMore.value) return
  loadingMore.value = true
  setTimeout(() => {
    displayedCount.value += pageSize
    loadingMore.value = false
  }, 300)
}

const handleScroll = (e) => {
  const { scrollTop, scrollHeight, clientHeight } = e.target
  if (scrollHeight - scrollTop - clientHeight < 100) {
    loadMore()
  }
}

const examDialogVisible = ref(false)
const currentExam = ref(null)
const examDetail = ref(null)
const submitting = ref(false)
const saving = ref(false)
const examLocked = ref(false)
const timeLeft = ref(0)
const monitorWarningCount = ref(0)

const answers = reactive({})
const multiAnswers = reactive({})
const programmingCodes = reactive({})
const codeLanguages = reactive({})
const testResult = reactive({})
const running = reactive({})

let countdownTimer = null
let autosaveTimer = null
let debounceTimer = null
let proctoringBound = false
const monitorLastReportAt = reactive({})

const filteredExams = computed(() => {
  const now = Date.now()
  if (filterStatus.value === 0) return exams.value
  if (filterStatus.value === 1) {
    return exams.value.filter(exam => isEnabled(exam) && (!exam.time || new Date(exam.time).getTime() <= now) && (!exam.endTime || new Date(exam.endTime).getTime() > now))
  }
  if (filterStatus.value === 2) {
    return exams.value.filter(exam => exam.time && new Date(exam.time).getTime() > now)
  }
  return exams.value.filter(exam => exam.endTime && new Date(exam.endTime).getTime() <= now)
})

const totalQuestions = computed(() => examDetail.value?.questions?.length || 0)

const answeredCount = computed(() => {
  if (!examDetail.value?.questions) return 0
  return examDetail.value.questions.filter((q) => {
    if (q.type === 3) {
      return (multiAnswers[q.id] || []).length > 0
    }
    if (q.type === 6) {
      return (programmingCodes[q.id] || '').trim().length > 0
    }
    return String(answers[q.id] || '').trim().length > 0
  }).length
})

const progressPercent = computed(() => (totalQuestions.value ? Math.round((answeredCount.value / totalQuestions.value) * 100) : 0))

const loadExams = async () => {
  loading.value = true
  try {
    const res = await studentApi.exam.list()
    const records = res.data?.records || res.data || []
    exams.value = Array.isArray(records) ? records : []
    displayedCount.value = pageSize
  } catch {
    ElMessage.error('加载考试列表失败')
  } finally {
    loading.value = false
  }
}

const isEnabled = (exam) => exam?.state === 1

const statusType = (exam) => {
  if (!isEnabled(exam)) return 'info'
  if (exam.endTime && new Date(exam.endTime) <= new Date()) return 'danger'
  if (exam.time && new Date(exam.time) > new Date()) return 'warning'
  return 'success'
}

const statusText = (exam) => {
  if (!isEnabled(exam)) return '禁用'
  if (exam.endTime && new Date(exam.endTime) <= new Date()) return '已截止'
  if (exam.time && new Date(exam.time) > new Date()) return '未开始'
  return '进行中'
}

const actionText = (exam) => {
  if (!isEnabled(exam)) return '未开放'
  if (exam.time && new Date(exam.time) > new Date()) return '查看倒计时'
  if (exam.endTime && new Date(exam.endTime) <= new Date()) return '已截止'
  return '进入考试'
}

const canEnterExam = (exam) => isEnabled(exam) && (!exam.endTime || new Date(exam.endTime) > new Date())

const formatDate = (value) => {
  if (!value) return '-'
  return new Date(value).toLocaleString('zh-CN')
}

const formatCountdown = (seconds) => {
  const s = Math.max(0, Number(seconds || 0))
  const h = Math.floor(s / 3600)
  const m = Math.floor((s % 3600) / 60)
  const sec = s % 60
  return `${String(h).padStart(2, '0')}:${String(m).padStart(2, '0')}:${String(sec).padStart(2, '0')}`
}

const typeName = (type) => {
  const map = { 1: '填空题', 2: '选择题', 3: '多选题', 4: '判断题', 5: '解答题', 6: '编程题', 7: '综合题' }
  return map[type] || '题目'
}

const parseOptions = (json) => {
  if (!json) return {}
  try {
    return JSON.parse(json)
  } catch {
    return {}
  }
}

const parseProgrammingAnswer = (raw) => {
  if (!raw) return { language: 'java', code: '' }
  try {
    const obj = JSON.parse(raw)
    if (obj && typeof obj === 'object' && typeof obj.code === 'string') {
      return {
        language: obj.language === 'c' ? 'c' : 'java',
        code: obj.code
      }
    }
  } catch {
    // 非JSON格式视为纯代码，回退到默认语言
  }
  return { language: 'java', code: raw }
}

const encodeProgrammingAnswer = (questionId) => {
  return JSON.stringify({
    language: codeLanguages[questionId] === 'c' ? 'c' : 'java',
    code: programmingCodes[questionId] || ''
  })
}

const clearState = () => {
  Object.keys(answers).forEach((k) => delete answers[k])
  Object.keys(multiAnswers).forEach((k) => delete multiAnswers[k])
  Object.keys(programmingCodes).forEach((k) => delete programmingCodes[k])
  Object.keys(codeLanguages).forEach((k) => delete codeLanguages[k])
  Object.keys(testResult).forEach((k) => delete testResult[k])
  Object.keys(running).forEach((k) => delete running[k])
  Object.keys(monitorLastReportAt).forEach((k) => delete monitorLastReportAt[k])
  monitorWarningCount.value = 0
}

const isExamActive = () => {
  return Boolean(
    examDialogVisible.value &&
    currentExam.value &&
    examDetail.value &&
    examDetail.value.examStarted &&
    !examDetail.value.examEnded &&
    !examLocked.value
  )
}

const reportMonitorEvent = async (eventType, detail = '') => {
  if (!isExamActive()) return
  const now = Date.now()
  const lastTs = monitorLastReportAt[eventType] || 0
  if (now - lastTs < 3000) return
  monitorLastReportAt[eventType] = now

  monitorWarningCount.value += 1
  if (monitorWarningCount.value <= 3 || monitorWarningCount.value % 5 === 0) {
    ElMessage.warning(`检测到切屏/失焦（第${monitorWarningCount.value}次），已记录并同步给教师端。`)
  }

  try {
    await studentApi.exam.reportMonitorEvent(currentExam.value.id, {
      eventType,
      detail,
      pageUrl: window.location.pathname
    })
  } catch (e) {
    console.warn('Failed to report monitor event:', e)
  }
}

const handleVisibilityChange = () => {
  if (document.hidden) {
    reportMonitorEvent('TAB_HIDDEN', '页面切到后台或切换标签页')
  }
}

const handleWindowBlur = () => {
  reportMonitorEvent('WINDOW_BLUR', '浏览器窗口失去焦点')
}

const startProctoring = () => {
  if (proctoringBound) return
  document.addEventListener('visibilitychange', handleVisibilityChange)
  window.addEventListener('blur', handleWindowBlur)
  proctoringBound = true
}

const stopProctoring = () => {
  if (!proctoringBound) return
  document.removeEventListener('visibilitychange', handleVisibilityChange)
  window.removeEventListener('blur', handleWindowBlur)
  proctoringBound = false
}

const openExam = async (exam) => {
  currentExam.value = exam
  examDialogVisible.value = true
  await reloadExamDetail()
}

const reloadExamDetail = async () => {
  if (!currentExam.value) return
  try {
    const res = await studentApi.exam.getDetail(currentExam.value.id)
    examDetail.value = res.data
    clearState()

    const questions = examDetail.value?.questions || []
    for (const q of questions) {
      if (q.type === 6) {
        codeLanguages[q.id] = 'java'
        programmingCodes[q.id] = ''
      } else if (q.type === 3) {
        multiAnswers[q.id] = []
      } else {
        answers[q.id] = ''
      }
    }

    const answerRes = await studentApi.exam.getMyAnswers(currentExam.value.id)
    for (const item of answerRes.data || []) {
      const q = questions.find((qq) => qq.id === item.questionId)
      if (!q) continue
      if (q.type === 3) {
        multiAnswers[q.id] = item.myAnswer ? item.myAnswer.split(',').filter(Boolean) : []
      } else if (q.type === 6) {
        const parsed = parseProgrammingAnswer(item.myAnswer || '')
        codeLanguages[q.id] = parsed.language
        programmingCodes[q.id] = parsed.code
      } else {
        answers[q.id] = item.myAnswer || ''
      }
    }

    startRuntime()
  } catch {
    ElMessage.error('加载考试失败')
  }
}

const startRuntime = () => {
  stopRuntime()
  if (!examDetail.value || !examDetail.value.examStarted || examDetail.value.examEnded) {
    examLocked.value = true
    return
  }
  examLocked.value = false
  startProctoring()
  const endTime = examDetail.value.endTime ? new Date(examDetail.value.endTime).getTime() : null
  if (endTime) {
    timeLeft.value = Math.max(0, Math.floor((endTime - Date.now()) / 1000))
    countdownTimer = setInterval(() => {
      const seconds = Math.max(0, Math.floor((endTime - Date.now()) / 1000))
      timeLeft.value = seconds
      if (seconds === 300) ElMessage.warning('距离截止还有5分钟')
      if (seconds === 60) ElMessage.warning('距离截止还有1分钟')
      if (seconds <= 0) {
        stopRuntime()
        ElMessage.error('考试已截止，系统正在自动提交')
        submitExam(true)
      }
    }, 1000)
  } else {
    timeLeft.value = 0
  }

  autosaveTimer = setInterval(() => saveAll(true), 15000)
}

const stopRuntime = () => {
  stopProctoring()
  if (countdownTimer) {
    clearInterval(countdownTimer)
    countdownTimer = null
  }
  if (autosaveTimer) {
    clearInterval(autosaveTimer)
    autosaveTimer = null
  }
  if (debounceTimer) {
    clearTimeout(debounceTimer)
    debounceTimer = null
  }
}

const saveAnswer = async (questionId, value) => {
  if (!currentExam.value || examLocked.value) return
  try {
    await studentApi.exam.saveAnswer(currentExam.value.id, questionId, value ?? '')
  } catch (e) {
    console.warn('Failed to save exam answer:', e)
    ElMessage.warning('答案保存失败，请检查网络连接')
  }
}

const onAnswerInput = (questionId) => {
  if (debounceTimer) clearTimeout(debounceTimer)
  debounceTimer = setTimeout(() => {
    saveAnswer(questionId, answers[questionId])
  }, 500)
}

const onProgrammingInput = (questionId) => {
  if (debounceTimer) clearTimeout(debounceTimer)
  debounceTimer = setTimeout(() => {
    saveAnswer(questionId, encodeProgrammingAnswer(questionId))
  }, 500)
}

const saveAll = async (silent = true) => {
  if (!currentExam.value || examLocked.value || saving.value) return
  saving.value = true
  try {
    const list = examDetail.value?.questions || []
    for (const q of list) {
      if (q.type === 3) {
        await saveAnswer(q.id, (multiAnswers[q.id] || []).join(','))
      } else if (q.type === 6) {
        await saveAnswer(q.id, encodeProgrammingAnswer(q.id))
      } else {
        await saveAnswer(q.id, answers[q.id] || '')
      }
    }
    if (!silent) ElMessage.success('暂存成功')
  } catch {
    if (!silent) ElMessage.error('暂存失败')
  } finally {
    saving.value = false
  }
}

const runTests = async (questionId) => {
  const code = programmingCodes[questionId] || ''
  if (!code.trim()) {
    ElMessage.warning('请先输入代码')
    return
  }
  running[questionId] = true
  try {
    const res = await studentApi.exam.runProgrammingTests(
      currentExam.value.id,
      questionId,
      code,
      codeLanguages[questionId] || 'java'
    )
    testResult[questionId] = res.data || {}
    await saveAnswer(questionId, encodeProgrammingAnswer(questionId))
  } catch (error) {
    ElMessage.error(error?.response?.data?.msg || '运行测试失败')
  } finally {
    running[questionId] = false
  }
}

const submitExam = async (auto = false) => {
  if (!currentExam.value || submitting.value) return
  if (!auto) {
    try {
      await ElMessageBox.confirm('确认提交考试？提交后将不能继续作答。', '提示', { type: 'warning' })
    } catch {
      return
    }
  }
  submitting.value = true
  stopRuntime()
  try {
    await saveAll(true)
    const res = await studentApi.exam.submit(currentExam.value.id)
    ElMessage.success(`提交成功：${res.data?.myScore ?? 0}/${res.data?.totalScore ?? 0}`)
    examDialogVisible.value = false
    examLocked.value = true
    await loadExams()
  } catch {
    ElMessage.error('提交失败')
    if (!auto) startRuntime()
  } finally {
    submitting.value = false
  }
}

watch(filterStatus, () => {
  displayedCount.value = pageSize
})

onMounted(loadExams)
onUnmounted(stopRuntime)
</script>

<style scoped>
.exam-page { height: calc(100vh - 64px); display: flex; flex-direction: column; overflow: hidden; }
.page-header { margin-bottom: 14px; flex-shrink: 0; }
.header-row { display: flex; justify-content: space-between; align-items: center; }
.header-row h2 { margin: 0; }
.header-row p { margin: 4px 0 0; color: #6b7280; font-size: 13px; }
.filter-select { width: 150px; }
.list-card { flex: 1; margin-bottom: 12px; display: flex; flex-direction: column; min-height: 0; overflow: hidden; }
.list-card :deep(.el-card__body) { flex: 1; overflow-y: auto; padding: 20px; display: flex; flex-direction: column; min-height: 0; }
.exam-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; align-content: start; }
.exam-item .title-line { display: flex; align-items: center; justify-content: space-between; margin-bottom: 8px; }
.exam-item .name { font-weight: 700; color: #111827; }
.exam-item .meta { color: #4b5563; font-size: 13px; margin-bottom: 4px; }
.actions { margin-top: 10px; }
.loading-more, .no-more { text-align: center; padding: 16px; color: #9ca3af; font-size: 13px; display: flex; align-items: center; justify-content: center; gap: 8px; flex-shrink: 0; }
.exam-bar { display: flex; align-items: center; gap: 12px; background: #f8fafc; border: 1px solid #e5e7eb; border-radius: 8px; padding: 10px 12px; margin-bottom: 12px; }
.timer { min-width: 160px; font-weight: 700; color: #065f46; }
.timer.warn { color: #92400e; }
.timer.danger { color: #b91c1c; }
.progress { flex: 1; font-size: 13px; color: #374151; }
.save-status { font-size: 12px; color: #6b7280; }
.monitor-status { font-size: 12px; color: #b45309; font-weight: 600; white-space: nowrap; }
.question-list { max-height: 60vh; overflow: auto; padding-right: 4px; }
.question-card { border: 1px solid #e5e7eb; border-radius: 8px; padding: 12px; margin-bottom: 12px; background: #fff; }
.q-head { display: flex; justify-content: space-between; font-weight: 700; margin-bottom: 8px; }
.q-body { margin-bottom: 10px; color: #111827; line-height: 1.7; }
.programming-box { border: 1px dashed #cbd5e1; border-radius: 8px; padding: 10px; }
.programming-toolbar { display: flex; gap: 8px; margin-bottom: 8px; }
.judge-box { margin-top: 10px; }
.judge-title { font-weight: 700; margin-bottom: 6px; color: #111827; }
.compile-error { white-space: pre-wrap; color: #b91c1c; background: #fff1f2; border: 1px solid #fecdd3; padding: 8px; border-radius: 6px; margin-bottom: 8px; }
.actual-output { margin: 0; font-size: 12px; white-space: pre-wrap; word-break: break-word; max-height: 80px; overflow: auto; }
</style>
