<template>
  <div class="practice-page" v-loading="pageLoading">
    <el-card class="practice-header">
      <div class="header-left">
        <el-button @click="goBack" text>
          <el-icon><ArrowLeft /></el-icon> 返回
        </el-button>
        <h2>{{ trainingSet?.name || '答题练习' }}</h2>
      </div>
      <div class="header-right">
        <span v-if="saving" class="save-indicator saving">保存中...</span>
        <span v-else-if="saveSuccess" class="save-indicator success">已保存</span>
        <el-button type="primary" @click="handleSubmit" :loading="submitting" :disabled="submitted">
          {{ submitted ? '已提交' : '提交批改' }}
        </el-button>
        <el-button @click="handleRetry" :disabled="!submitted" :loading="retrying">再来一次</el-button>
      </div>
    </el-card>

    <div class="work-layout" v-if="questions.length > 0">
      <!-- Left sidebar: question navigation -->
      <aside class="question-sidebar">
        <div class="sidebar-title">题目列表</div>
        <div class="sidebar-items">
          <button
            v-for="(q, idx) in questions"
            :key="q.questionId"
            type="button"
            class="sidebar-item"
            :class="{
              answered: hasAnswered(q),
              active: currentIndex === idx,
              correct: submitted && getResult(q)?.status === 'CORRECT',
              wrong: submitted && getResult(q)?.status === 'WRONG'
            }"
            @click="currentIndex = idx"
          >
            <span>{{ idx + 1 }}</span>
            <small>{{ getTypeName(q.type) }}</small>
          </button>
        </div>
        <div class="sidebar-stats">
          <div>已作答 {{ answeredCount }} / {{ questions.length }}</div>
          <el-progress :percentage="progressPercent" :show-text="false" :stroke-width="8" />
        </div>
      </aside>

      <!-- Right: question content + answer area -->
      <main class="question-main">
        <div class="question-head">
          <div class="left">
            <span class="no">第 {{ currentIndex + 1 }} 题</span>
            <el-tag effect="plain">{{ getTypeName(currentQuestion.type) }}</el-tag>
            <el-tag type="warning" effect="plain">{{ getQuestionScore(currentQuestion) }} 分</el-tag>
            <el-tag v-if="submitted" :type="getResult(currentQuestion)?.status === 'CORRECT' ? 'success' : 'danger'">
              {{ getResult(currentQuestion)?.status === 'CORRECT' ? '正确' : (getResult(currentQuestion)?.status === 'WRONG' ? '错误' : '待批改') }}
            </el-tag>
          </div>
          <div class="right">
            <el-button size="small" @click="switchQuestion(-1)" :disabled="currentIndex === 0">上一题</el-button>
            <el-button size="small" @click="switchQuestion(1)" :disabled="currentIndex >= questions.length - 1">下一题</el-button>
          </div>
        </div>

        <!-- Question content -->
        <div class="question-content" v-html="currentQuestion.question" />

        <!-- Answer area -->
        <section class="answer-section">
          <!-- Fill-blank (type 1) -->
          <template v-if="currentQuestion.type === 1">
            <div class="fill-blank-container">
              <div v-for="(blank, idx) in getBlankCount(currentQuestion.question)" :key="idx" class="fill-blank-row">
                <span class="blank-label">第 {{ idx + 1 }} 空:</span>
                <el-input
                  v-model="fillAnswers[currentQuestion.questionId + '_' + idx]"
                  :placeholder="'请输入答案'"
                  :disabled="submitted"
                  @input="debouncedSaveFillBlank(currentQuestion)"
                />
              </div>
            </div>
          </template>

          <!-- Single choice (type 2) -->
          <template v-else-if="currentQuestion.type === 2">
            <el-radio-group v-model="answers[currentQuestion.questionId]" :disabled="submitted" class="option-group" @change="saveAnswer(currentQuestion)">
              <el-radio v-for="(opt, key) in parseOptions(currentQuestion.options)" :key="key" :value="String(key)">
                <strong>{{ key }}.</strong> {{ opt }}
              </el-radio>
            </el-radio-group>
          </template>

          <!-- Multiple choice (type 3) -->
          <template v-else-if="currentQuestion.type === 3">
            <el-checkbox-group v-model="multiAnswers[currentQuestion.questionId]" :disabled="submitted" @change="saveMultiAnswer(currentQuestion)">
              <el-checkbox v-for="(opt, key) in parseOptions(currentQuestion.options)" :key="key" :value="String(key)">
                <strong>{{ key }}.</strong> {{ opt }}
              </el-checkbox>
            </el-checkbox-group>
          </template>

          <!-- Judgment (type 4) -->
          <template v-else-if="currentQuestion.type === 4">
            <el-radio-group v-model="answers[currentQuestion.questionId]" :disabled="submitted" @change="saveAnswer(currentQuestion)">
              <el-radio value="true">正确</el-radio>
              <el-radio value="false">错误</el-radio>
            </el-radio-group>
          </template>

          <!-- Short answer / Comprehensive (type 5, 7) -->
          <template v-else-if="currentQuestion.type === 5 || currentQuestion.type === 7">
            <el-input
              v-model="answers[currentQuestion.questionId]"
              type="textarea"
              :rows="8"
              :disabled="submitted"
              placeholder="请输入解答内容"
              @input="debouncedSave(currentQuestion)"
            />
            <p class="manual-tip">本题为人工批改题，提交后请对照参考答案。</p>
          </template>

          <!-- Programming (type 6) -->
          <template v-else-if="currentQuestion.type === 6">
            <div class="code-toolbar">
              <el-select v-model="programmingLang[currentQuestion.questionId]" style="width: 140px" :disabled="submitted">
                <el-option label="Java" value="java" />
                <el-option label="C" value="c" />
              </el-select>
              <el-button type="primary" @click="runTests(currentQuestion)" :loading="runningQuestionId === currentQuestion.questionId" :disabled="submitted">
                运行测试
              </el-button>
              <span class="test-count" v-if="currentQuestion.testCaseCount !== undefined">测试点：{{ currentQuestion.testCaseCount }}</span>
              <span class="template-hint" v-if="currentQuestion.templateCode">有模板代码</span>
            </div>

            <MonacoEditor
              v-model="answers[currentQuestion.questionId]"
              :language="programmingLang[currentQuestion.questionId] || 'java'"
              height="320px"
              @update:modelValue="debouncedSave(currentQuestion)"
            />

            <!-- Judge panel: test case results -->
            <div class="judge-panel" v-if="judgeResults[currentQuestion.questionId]">
              <div class="judge-summary">
                <el-tag :type="judgeStatusType(judgeResults[currentQuestion.questionId].status)">
                  {{ judgeStatusText(judgeResults[currentQuestion.questionId].status) }}
                </el-tag>
                <span>通过 {{ judgeResults[currentQuestion.questionId].passedCount || 0 }} / {{ judgeResults[currentQuestion.questionId].totalCount || 0 }}</span>
              </div>

              <div v-if="judgeResults[currentQuestion.questionId].compileError" class="compile-error">
                <strong>编译错误：</strong>
                <pre>{{ judgeResults[currentQuestion.questionId].compileError }}</pre>
              </div>

              <el-table
                v-if="judgeResults[currentQuestion.questionId].details && judgeResults[currentQuestion.questionId].details.length"
                :data="judgeResults[currentQuestion.questionId].details"
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
                    {{ calcCaseScoreText(currentQuestion, judgeResults[currentQuestion.questionId], row, $index) }}
                  </template>
                </el-table-column>
                <el-table-column prop="actualOutput" label="实际输出" min-width="220" show-overflow-tooltip />
              </el-table>
            </div>

                      </template>

          <!-- Fallback -->
          <template v-else>
            <el-input v-model="answers[currentQuestion.questionId]" type="textarea" :rows="4" :disabled="submitted" placeholder="请输入答案" @input="debouncedSave(currentQuestion)" />
          </template>
        </section>

        <!-- Result display (after submit) -->
        <section v-if="submitted && resultMap[currentQuestion.questionId]" class="result-section">
          <el-divider />
          <div class="result-item">
            <div class="result-label">你的答案：</div>
            <div class="result-value">{{ formatAnswer(resultMap[currentQuestion.questionId]?.myAnswer, currentQuestion.type) || '(未作答)' }}</div>
          </div>
          <div class="result-item" v-if="currentQuestion.type !== 6">
            <div class="result-label">正确答案：</div>
            <div class="result-value correct-answer">{{ resultMap[currentQuestion.questionId]?.correctAnswer || '(无)' }}</div>
          </div>
          <div class="result-item" v-if="resultMap[currentQuestion.questionId]?.analysis">
            <div class="result-label">解析：</div>
            <div class="result-value analysis-text">{{ resultMap[currentQuestion.questionId]?.analysis }}</div>
          </div>
          <div class="result-score">
            得分：<span :class="getResult(currentQuestion)?.status === 'CORRECT' ? 'score-correct' : 'score-wrong'">
              {{ resultMap[currentQuestion.questionId]?.score ?? '-' }} / {{ getQuestionScore(currentQuestion) }}
            </span>
          </div>

          <!-- Judge details for programming questions after submit -->
          <div v-if="currentQuestion.type === 6 && resultMap[currentQuestion.questionId]?.judgeResult" class="judge-panel">
            <div class="judge-summary">
              <el-tag :type="judgeStatusType(resultMap[currentQuestion.questionId]?.status)">
                {{ judgeStatusText(resultMap[currentQuestion.questionId]?.status) }}
              </el-tag>
            </div>
            <el-table
              :data="resultMap[currentQuestion.questionId]?.judgeResult?.details || []"
              size="small"
              border
            >
              <el-table-column label="测试点" width="130">
                <template #default="{ row, $index }">{{ row.name || `test_${$index + 1}` }}</template>
              </el-table-column>
              <el-table-column label="结果" width="120">
                <template #default="{ row }">
                  <el-tag :type="row.passed ? 'success' : 'danger'">{{ row.passed ? '通过' : '失败' }}</el-tag>
                </template>
              </el-table-column>
              <el-table-column prop="actualOutput" label="实际输出" min-width="220" show-overflow-tooltip />
            </el-table>
          </div>
        </section>
      </main>
    </div>

    <el-empty v-else-if="!pageLoading" description="该训练集暂无题目" />

    <!-- Submit result summary dialog -->
    <el-dialog v-model="resultDialogVisible" title="提交结果" width="600px" :close-on-click-modal="false">
      <div class="result-summary" v-if="submitResult">
        <div class="summary-stats">
          <div class="stat">
            <div class="stat-value">{{ submitResult.myScore ?? 0 }}</div>
            <div class="stat-label">得分</div>
          </div>
          <div class="stat">
            <div class="stat-value">{{ submitResult.totalScore ?? 0 }}</div>
            <div class="stat-label">总分</div>
          </div>
          <div class="stat">
            <div class="stat-value">{{ correctCount }}</div>
            <div class="stat-label">正确</div>
          </div>
          <div class="stat">
            <div class="stat-value">{{ wrongCount }}</div>
            <div class="stat-label">错误</div>
          </div>
        </div>
        <el-table :data="submitResult.questionResults || []" stripe size="small" height="300">
          <el-table-column type="expand" v-if="hasJudgeResult">
            <template #default="{ row }">
              <div v-if="row.judgeResult" class="result-judge-detail">
                <div class="judge-summary" style="margin-bottom:8px">
                  <span>通过 {{ countPassed(row.judgeResult) }} / {{ (row.judgeResult.details || []).length }}</span>
                </div>
                <el-table :data="row.judgeResult.details || []" size="small" border>
                  <el-table-column label="测试点" width="130">
                    <template #default="{ row: tc, $index }">{{ tc.name || `test_${$index + 1}` }}</template>
                  </el-table-column>
                  <el-table-column label="结果" width="100">
                    <template #default="{ row: tc }">
                      <el-tag :type="tc.passed ? 'success' : 'danger'" size="small">{{ tc.passed ? '通过' : '失败' }}</el-tag>
                    </template>
                  </el-table-column>
                  <el-table-column prop="actualOutput" label="输出" min-width="200" show-overflow-tooltip />
                </el-table>
              </div>
            </template>
          </el-table-column>
          <el-table-column label="题目" min-width="200">
            <template #default="{ row }">{{ shortText(row.question, 60) }}</template>
          </el-table-column>
          <el-table-column label="得分" width="80">
            <template #default="{ row }">{{ row.score ?? '-' }}</template>
          </el-table-column>
          <el-table-column label="状态" width="100">
            <template #default="{ row }">
              <el-tag :type="row.status === 'CORRECT' ? 'success' : (row.status === 'WRONG' ? 'danger' : 'warning')" size="small">
                {{ row.status === 'CORRECT' ? '正确' : (row.status === 'WRONG' ? '错误' : (row.status === 'PARTIAL' ? '部分正确' : (row.status === 'MANUAL_REFER' ? '待批改' : '待运行'))) }}
              </el-tag>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <template #footer>
        <el-button @click="resultDialogVisible = false">关闭</el-button>
        <el-button type="primary" @click="handleRetry">再来一次</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { computed, onMounted, onBeforeUnmount, reactive, ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { ArrowLeft } from '@element-plus/icons-vue'
import { trainingApi } from '@/api'
import MonacoEditor from '@/components/MonacoEditor.vue'

const route = useRoute()
const router = useRouter()
const trainingSetId = Number(route.params.id)

const pageLoading = ref(false)
const trainingSet = ref(null)
const questions = ref([])
const currentIndex = ref(0)
const answers = reactive({})
const fillAnswers = reactive({})
const multiAnswers = reactive({})
const programmingLang = reactive({})
const judgeResults = reactive({})
const runningQuestionId = ref(null)
const submitted = ref(false)
const submitting = ref(false)
const retrying = ref(false)
const resultMap = reactive({})  // questionId -> { score, status, myAnswer, correctAnswer, analysis }
const submitResult = ref(null)
const resultDialogVisible = ref(false)
let debounceTimer = null
const saving = ref(false)
const saveSuccess = ref(false)

const currentQuestion = computed(() => questions.value[currentIndex.value] || null)

const answeredCount = computed(() => {
  return questions.value.filter((q) => hasAnswered(q)).length
})

const progressPercent = computed(() => {
  if (questions.value.length === 0) return 0
  return Math.round((answeredCount.value / questions.value.length) * 100)
})

const correctCount = computed(() => {
  return (submitResult.value?.questionResults || []).filter((r) => r.status === 'CORRECT').length
})

const wrongCount = computed(() => {
  return (submitResult.value?.questionResults || []).filter((r) => r.status === 'WRONG').length
})

const hasJudgeResult = computed(() => {
  return (submitResult.value?.questionResults || []).some((r) => r.judgeResult && r.type === 6)
})

function countPassed(judgeResult) {
  if (!judgeResult?.details) return 0
  return judgeResult.details.filter((d) => d.passed).length
}

const typeMap = { 1: '填空', 2: '单选', 3: '多选', 4: '判断', 5: '简答', 6: '编程', 7: '综合' }

function getTypeName(type) {
  return typeMap[type] || `类型${type || '-'}`
}

function shortText(text, len = 100) {
  if (!text) return '-'
  return text.length > len ? text.slice(0, len) + '...' : text
}

function formatDate(date) {
  if (!date) return '-'
  return new Date(date).toLocaleString('zh-CN')
}

function parseOptions(options) {
  if (!options) return {}
  if (typeof options === 'object') return options
  try {
    return JSON.parse(options)
  } catch {
    return {}
  }
}

function getBlankCount(question) {
  if (!question) return 1
  const matches = question.match(/________/g)
  return matches ? matches.length : 1
}

function getQuestionScore(q) {
  return q.score || 10
}

function hasAnswered(q) {
  if (q.type === 3) {
    const val = multiAnswers[q.questionId]
    return val && val.length > 0
  }
  const val = answers[q.questionId]
  return val !== undefined && val !== null && String(val).trim() !== ''
}

function getResult(q) {
  return resultMap[q.questionId] || null
}

function formatAnswer(answer, type) {
  if (!answer) return ''
  if (type === 3) {
    try {
      const arr = JSON.parse(answer)
      return Array.isArray(arr) ? arr.join(', ') : answer
    } catch {
      return answer
    }
  }
  // Programming: try to extract code from JSON wrapping
  if (type === 6) {
    try {
      const parsed = JSON.parse(answer)
      if (parsed && parsed.code) return parsed.code
    } catch { /* ignore */ }
  }
  return answer
}

function formatOutput(result) {
  if (!result) return '(no output)'
  return JSON.stringify(result, null, 2)
}

function judgeStatusType(status) {
  if (status === 'ALL_PASS' || status === 'CORRECT') return 'success'
  if (status === 'PARTIAL_PASS' || status === 'PARTIAL') return 'warning'
  return 'danger'
}

function judgeStatusText(status) {
  if (status === 'ALL_PASS' || status === 'CORRECT') return '答案正确'
  if (status === 'PARTIAL_PASS' || status === 'PARTIAL') return '部分通过'
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

function serializeProgrammingAnswer(questionId) {
  return JSON.stringify({
    language: programmingLang[questionId] === 'c' ? 'c' : 'java',
    code: answers[questionId] || ''
  })
}

function parseProgrammingAnswer(value) {
  if (!value) return { language: 'java', code: '' }
  try {
    const parsed = JSON.parse(value)
    if (parsed && typeof parsed === 'object' && parsed.code !== undefined) {
      return {
        language: parsed.language === 'c' ? 'c' : 'java',
        code: parsed.code || ''
      }
    }
  } catch { /* ignore */ }
  return { language: 'java', code: value }
}

function switchQuestion(step) {
  const next = currentIndex.value + step
  if (next >= 0 && next < questions.value.length) {
    currentIndex.value = next
  }
}

function goBack() {
  router.push('/student/training')
}

async function loadData() {
  pageLoading.value = true
  try {
    const [tsRes, qRes] = await Promise.all([
      trainingApi.student.get(trainingSetId),
      trainingApi.student.getQuestions(trainingSetId)
    ])
    trainingSet.value = tsRes.data
    questions.value = qRes.data || []

    // Initialize programming language from question data
    questions.value.forEach((q) => {
      if (q.type === 6) {
        programmingLang[q.questionId] = q.language || 'java'
      }
    })

    // Check if there's a saved answer from the latest attempt (submitted or not)
    try {
      const recordsRes = await trainingApi.student.myRecords(trainingSetId)
      const records = recordsRes.data || []
      // Load the most recent attempt (highest attemptCount)
      const latestAttempt = records.length > 0 ? records[0] : null
      if (latestAttempt) {
        // Load saved answers
        const resultRes = await trainingApi.student.getResult(trainingSetId, latestAttempt.id)
        const savedAnswers = resultRes.data?.questionResults || []
        savedAnswers.forEach((sa) => {
          if (sa.questionId && sa.myAnswer) {
            if (sa.type === 3) {
              try {
                multiAnswers[sa.questionId] = JSON.parse(sa.myAnswer)
              } catch {
                multiAnswers[sa.questionId] = []
              }
              answers[sa.questionId] = sa.myAnswer
            } else if (sa.type === 1) {
              const parts = sa.myAnswer.split('|||')
              parts.forEach((val, idx) => {
                fillAnswers[sa.questionId + '_' + idx] = val
              })
              answers[sa.questionId] = sa.myAnswer
            } else if (sa.type === 6) {
              const parsed = parseProgrammingAnswer(sa.myAnswer)
              answers[sa.questionId] = parsed.code
              programmingLang[sa.questionId] = parsed.language
            } else if (sa.type === 2) {
              answers[sa.questionId] = sa.myAnswer
            } else {
              answers[sa.questionId] = sa.myAnswer
            }
          }
          // Restore judge results for programming questions
          // Only load into judgeResults for UNSUBMITTED attempts (run-tests results)
          // For submitted attempts, judgeResult is shown in result-section only
          if (sa.type === 6 && sa.judgeResult && (sa.score === null || sa.submitTime === null)) {
            judgeResults[sa.questionId] = sa.judgeResult
          }
          // Only restore result map if not already set from a submitted attempt
          // (submitted results have score/judgeResult; loaded records may have null status)
          if (sa.score !== null || sa.judgeResult) {
            if (!resultMap[sa.questionId]) {
              resultMap[sa.questionId] = sa
            }
          }
        })
        // If this was a submitted attempt, mark as submitted
        if (latestAttempt.score !== null && latestAttempt.submitTime !== null) {
          submitted.value = true
          submitResult.value = resultRes.data
        }
      } else {
        // No saved answers: pre-fill template code for programming questions
        questions.value.forEach((q) => {
          if (q.type === 6 && q.templateCode && !answers[q.questionId]) {
            answers[q.questionId] = q.templateCode
          }
        })
      }
    } catch {
      // No saved answers: pre-fill template code
      questions.value.forEach((q) => {
        if (q.type === 6 && q.templateCode && !answers[q.questionId]) {
          answers[q.questionId] = q.templateCode
        }
      })
    }
  } catch {
    ElMessage.error('加载数据失败')
  } finally {
    pageLoading.value = false
  }
}

function debouncedSaveFillBlank(question) {
  clearTimeout(debounceTimer)
  debounceTimer = setTimeout(() => {
    saveFillBlank(question)
  }, 800)
}

function saveFillBlank(question) {
  const blanks = getBlankCount(question.question)
  const parts = []
  for (let i = 0; i < blanks; i++) {
    parts.push(fillAnswers[question.questionId + '_' + i] || '')
  }
  answers[question.questionId] = parts.join('|||')
  saveAnswer(question)
}

function saveMultiAnswer(question) {
  const val = multiAnswers[question.questionId] || []
  answers[question.questionId] = JSON.stringify(val)
  saveAnswer(question)
}

function debouncedSave(question) {
  clearTimeout(debounceTimer)
  debounceTimer = setTimeout(() => saveAnswer(question), 500)
}

async function saveAnswer(question) {
  saving.value = true
  saveSuccess.value = false
  try {
    let answer = answers[question.questionId] || ''
    if (question.type === 6) {
      answer = serializeProgrammingAnswer(question.questionId)
    }
    await trainingApi.student.saveAnswer(trainingSetId, question.questionId, answer)
    saveSuccess.value = true
  } catch {
    // silent autosave failure
  } finally {
    saving.value = false
  }
}

async function handleSubmit() {
  try {
    await ElMessageBox.confirm('确认提交批改？客观题将自动判分，主观题请对照参考答案。', '提示', { type: 'warning' })
  } catch {
    return
  }

  submitting.value = true
  try {
    // Save all answers first
    for (const q of questions.value) {
      let answer = answers[q.questionId] || ''
      if (q.type === 1) {
        const blanks = getBlankCount(q.question)
        const parts = []
        for (let i = 0; i < blanks; i++) {
          parts.push(fillAnswers[q.questionId + '_' + i] || '')
        }
        answer = parts.join('|||')
      } else if (q.type === 6) {
        answer = serializeProgrammingAnswer(q.questionId)
      }
      await trainingApi.student.saveAnswer(trainingSetId, q.questionId, answer)
    }

    const res = await trainingApi.student.submit(trainingSetId)
    submitResult.value = res.data

    // Build resultMap
    if (submitResult.value?.questionResults) {
      submitResult.value.questionResults.forEach((r) => {
        resultMap[r.questionId] = r
      })
    }

    submitted.value = true
    resultDialogVisible.value = true
  } catch {
    ElMessage.error('提交失败')
  } finally {
    submitting.value = false
  }
}

async function handleRetry() {
  retrying.value = true
  try {
    await trainingApi.student.retry(trainingSetId)
    // Reset state
    submitted.value = false
    submitResult.value = null
    Object.keys(resultMap).forEach((k) => delete resultMap[k])
    Object.keys(answers).forEach((k) => delete answers[k])
    Object.keys(fillAnswers).forEach((k) => delete fillAnswers[k])
    Object.keys(multiAnswers).forEach((k) => delete multiAnswers[k])
    Object.keys(judgeResults).forEach((k) => delete judgeResults[k])
    resultDialogVisible.value = false
    ElMessage.success('已重置，请重新作答')
  } catch {
    ElMessage.error('重置失败')
  } finally {
    retrying.value = false
  }
}

onMounted(loadData)

onBeforeUnmount(() => {
  // 清理防抖定时器，防止内存泄漏
  if (debounceTimer) {
    clearTimeout(debounceTimer)
    debounceTimer = null
  }
})

async function runTests(question) {
  const code = answers[question.questionId]
  const lang = programmingLang[question.questionId] || 'java'
  if (!code || !code.trim()) {
    ElMessage.warning('请先编写代码')
    return
  }
  runningQuestionId.value = question.questionId
  try {
    const res = await trainingApi.student.runProgrammingTests(
      trainingSetId,
      question.questionId,
      code,
      lang
    )
    judgeResults[question.questionId] = res.data || {}
  } catch (e) {
    ElMessage.error(e?.response?.data?.message || e?.message || '运行测试失败')
  } finally {
    runningQuestionId.value = null
  }
}
</script>

<style lang="scss" scoped>
.practice-page {
  max-width: 1400px;
  margin: 0 auto;
}

.practice-header {
  margin-bottom: 16px;
  border-radius: 8px;
  border: 1px solid #d9dee7;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.practice-header :deep(.el-card__body) {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.header-left h2 {
  margin: 0;
  font-size: 18px;
  color: #1f2a3d;
}

.header-right {
  display: flex;
  gap: 8px;
  align-items: center;
}

.save-indicator {
  font-size: 13px;
  margin-right: 8px;
}

.save-indicator.saving {
  color: #667085;
}

.save-indicator.success {
  color: #22a06b;
}

.work-layout {
  display: grid;
  grid-template-columns: 240px minmax(0, 1fr);
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
  transition: all 0.2s;
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

.sidebar-item.correct {
  border-color: #22a06b;
  background: #d1fae5;
}

.sidebar-item.wrong {
  border-color: #ef4444;
  background: #fef2f2;
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
  padding: 20px;
  overflow-y: auto;
}

.question-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.question-head .left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.question-head .no {
  font-weight: 600;
  font-size: 15px;
}

.question-content {
  border-top: 1px solid #eceff4;
  border-bottom: 1px solid #eceff4;
  padding: 14px 0;
  line-height: 1.7;
  color: #101828;
  white-space: pre-wrap;
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
  }
}

.option-group {
  display: flex;
  flex-direction: column;
  gap: 12px;
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

.code-editor-section { margin-bottom: 8px; }
.code-actions { margin-bottom: 10px; display: flex; gap: 8px; }
.code-output { border: 1px solid #e4e7ed; border-radius: 4px; overflow: hidden; margin-top: 8px; }
.code-output-header { padding: 8px 12px; background: #f5f7fa; font-size: 13px; font-weight: 500; color: #606266; border-bottom: 1px solid #e4e7ed; }
.code-output-body { padding: 12px; margin: 0; font-family: Consolas,monospace; font-size: 13px; line-height: 1.5; white-space: pre-wrap; word-break: break-all; background: #fff; color: #303133; max-height: 200px; overflow-y: auto; }
.code-output-body.output-error { color: #f56c6c; background: #fef0f0; }

.template-hint {
  font-size: 12px;
  color: #667085;
}

.test-count {
  color: #667085;
  font-size: 13px;
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

:deep(.code-input textarea) {
  font-family: Consolas, Monaco, monospace;
  font-size: 13px;
  line-height: 1.55;
}

.result-section {
  margin-top: 10px;
}

.result-item {
  margin-bottom: 10px;
}

.result-label {
  font-weight: 600;
  color: #374151;
  margin-bottom: 4px;
  font-size: 13px;
}

.result-value {
  color: #111827;
  line-height: 1.6;
  white-space: pre-wrap;
  background: #f9fafb;
  padding: 8px 12px;
  border-radius: 6px;
  border: 1px solid #e5e7eb;
}

.correct-answer {
  color: #059669;
  font-weight: 500;
}

.analysis-text {
  color: #6b7280;
  font-style: italic;
}

.result-score {
  font-size: 15px;
  font-weight: 600;
  margin-top: 10px;
}

.score-correct {
  color: #059669;
}

.score-wrong {
  color: #dc2626;
}

.result-summary {
  .summary-stats {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 12px;
    margin-bottom: 16px;

    .stat {
      text-align: center;
      padding: 12px;
      background: #f9fafb;
      border-radius: 8px;
      border: 1px solid #e5e7eb;

      .stat-value {
        font-size: 24px;
        font-weight: 700;
        color: #111827;
      }

      .stat-label {
        font-size: 12px;
        color: #6b7280;
        margin-top: 4px;
      }
    }
  }
}

.result-judge-detail {
  padding: 12px;
  background: #fafbfc;
  border-radius: 6px;
}

@media (max-width: 980px) {
  .work-layout {
    grid-template-columns: 1fr;
  }
}
</style>
