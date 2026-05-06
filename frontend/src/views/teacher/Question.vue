<template>
  <div class="question-page">
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/teacher' }">教师首页</el-breadcrumb-item>
      <el-breadcrumb-item>题库管理</el-breadcrumb-item>
    </el-breadcrumb>

    <div class="page-header">
      <h2 class="page-title">题库管理</h2>
      <div class="search-area">
        <el-select v-model="searchType" placeholder="题型" clearable style="width: 140px" @change="handleSearch">
          <el-option label="填空题" :value="1" />
          <el-option label="选择题" :value="2" />
          <el-option label="解答题" :value="5" />
          <el-option label="编程题" :value="6" />
        </el-select>
        <el-input
          v-model="searchQuery"
          placeholder="搜索题目内容"
          clearable
          @clear="handleSearch"
          @keyup.enter="handleSearch"
          class="search-input"
        >
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
        <el-button type="primary" @click="handleSearch">搜索</el-button>
      </div>
    </div>

    <div class="action-bar">
      <el-button type="success" @click="handleAdd">
        <el-icon><Plus /></el-icon>
        新增题目
      </el-button>
    </div>

    <el-card class="table-card" shadow="hover">
      <el-table :data="questionList" v-loading="loading" stripe>
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column label="类型" width="110">
          <template #default="{ row }">
            <el-tag :type="getTypeTag(row.type)">{{ row.typeName || getTypeName(row.type) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="题目内容" min-width="340">
          <template #default="{ row }">
            <div>{{ shortText(row.question, 120) }}</div>
          </template>
        </el-table-column>
        <el-table-column label="分值" width="90">
          <template #default="{ row }">{{ row.score || 10 }}</template>
        </el-table-column>
        <el-table-column label="出题人" width="100">
          <template #default="{ row }">{{ row.teacherName || '-' }}</template>
        </el-table-column>
        <el-table-column label="状态" width="90">
          <template #default="{ row }">
            <el-tag :type="row.state === 1 ? 'success' : 'info'">{{ row.state === 1 ? '启用' : '禁用' }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <div class="action-buttons">
              <el-button type="primary" size="small" plain @click="handleEdit(row)">编辑</el-button>
              <el-button type="danger" size="small" plain @click="handleDelete(row)">删除</el-button>
            </div>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination
        v-model:current-page="pagination.page"
        v-model:page-size="pagination.pageSize"
        :page-sizes="[20, 40, 60]"
        :total="pagination.total"
        layout="total, sizes, prev, pager, next"
        @size-change="loadQuestionList"
        @current-change="loadQuestionList"
        class="pagination"
      />
    </el-card>

    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="860px" destroy-on-close>
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="92px" class="question-form">
        <div class="form-grid">
          <el-form-item label="题目类型" prop="type">
            <el-select v-model="formData.type" placeholder="请选择题目类型" style="width: 100%" @change="onTypeChange">
              <el-option label="填空题" :value="1" />
              <el-option label="选择题" :value="2" />
              <el-option label="解答题" :value="5" />
              <el-option label="编程题" :value="6" />
            </el-select>
          </el-form-item>

          <el-form-item label="分值" prop="score">
            <el-input-number v-model="formData.score" :min="1" :max="100" />
          </el-form-item>
        </div>

        <el-form-item label="题目内容" prop="question">
          <el-input
            v-model="formData.question"
            type="textarea"
            :rows="4"
            placeholder="请输入题目描述"
          />
        </el-form-item>

        <template v-if="formData.type === 1">
          <el-form-item label="填空数量">
            <el-input-number v-model="formData.blankCount" :min="1" :max="10" @change="updateBlankPlaceholders" />
          </el-form-item>
          <el-form-item label="标准答案" prop="answer">
            <div class="answer-inputs">
              <div v-for="idx in formData.blankCount" :key="idx" class="answer-row">
                <span class="answer-label">第 {{ idx }} 空:</span>
                <el-input v-model="formData.answers[idx - 1]" placeholder="请输入答案" />
              </div>
            </div>
          </el-form-item>
        </template>

        <template v-if="formData.type === 2">
          <el-form-item label="选项配置" required>
            <div class="choice-editor">
              <div v-for="(item, idx) in choiceOptions" :key="idx" class="choice-row">
                <el-input v-model="item.key" maxlength="4" style="width: 80px" />
                <el-input v-model="item.content" placeholder="选项内容" />
                <el-button type="danger" plain @click="removeChoiceOption(idx)" :disabled="choiceOptions.length <= 2">
                  删除
                </el-button>
              </div>
              <el-button type="primary" plain @click="addChoiceOption">添加选项</el-button>
            </div>
          </el-form-item>
          <el-form-item label="正确答案" prop="answer">
            <el-radio-group v-model="choiceAnswer">
              <el-radio v-for="opt in validChoiceOptions" :key="opt.key" :value="opt.key">
                {{ opt.key }}
              </el-radio>
            </el-radio-group>
          </el-form-item>
        </template>

        <template v-if="formData.type === 5">
          <el-form-item label="参考答案">
            <el-input v-model="formData.answer" type="textarea" :rows="3" placeholder="可选：用于老师批改参考" />
          </el-form-item>
        </template>

        <template v-if="formData.type === 6">
          <el-form-item label="默认语言">
            <el-select v-model="programmingLanguage" style="width: 160px">
              <el-option label="Java" value="java" />
              <el-option label="C" value="c" />
            </el-select>
          </el-form-item>
          <el-form-item label="测试用例">
            <div class="test-cases">
              <div v-for="(tc, index) in testCases" :key="index" class="test-case-item">
                <div class="test-case-head">
                  <span>测试点 {{ index + 1 }}</span>
                  <el-button type="danger" plain size="small" @click="removeTestCase(index)" :disabled="testCases.length <= 1">
                    删除
                  </el-button>
                </div>
                <el-input v-model="tc.input" type="textarea" :rows="2" placeholder="输入（可为空）" />
                <el-input v-model="tc.expectedOutput" type="textarea" :rows="2" placeholder="期望输出" style="margin-top: 8px" />
                <div class="test-case-foot">
                  <span>权重</span>
                  <el-input-number v-model="tc.scoreWeight" :min="1" :max="100" size="small" />
                </div>
              </div>
              <el-button type="primary" plain @click="addTestCase">添加测试点</el-button>
            </div>
          </el-form-item>
        </template>

        <el-form-item label="答案解析">
          <el-input v-model="formData.analysis" type="textarea" :rows="2" placeholder="可选：答案解析" />
        </el-form-item>

        <el-form-item label="状态">
          <el-radio-group v-model="formData.state">
            <el-radio :value="1">启用</el-radio>
            <el-radio :value="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>

      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit" :loading="submitting">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { computed, onMounted, reactive, ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search } from '@element-plus/icons-vue'
import { teacherApi } from '@/api/index.js'

const loading = ref(false)
const submitting = ref(false)
const questionList = ref([])
const dialogVisible = ref(false)
const isEdit = ref(false)
const formRef = ref(null)
const searchQuery = ref('')
const searchType = ref(null)
const dialogTitle = computed(() => (isEdit.value ? '编辑题目' : '新增题目'))

const pagination = reactive({ page: 1, pageSize: 20, total: 0 })

const formData = reactive({
  id: null,
  type: 1,
  question: '',
  answer: '',
  analysis: '',
  options: '',
  score: 10,
  state: 1,
  blankCount: 1,
  answers: ['']
})

const programmingLanguage = ref('java')
const testCases = ref([{ input: '', expectedOutput: '', scoreWeight: 1 }])
const choiceOptions = ref([
  { key: 'A', content: '' },
  { key: 'B', content: '' }
])
const choiceAnswer = ref('A')

const validChoiceOptions = computed(() =>
  choiceOptions.value.filter((item) => item.key && String(item.key).trim() && item.content && String(item.content).trim())
)

const formRules = computed(() => ({
  type: [{ required: true, message: '请选择题目类型', trigger: 'change' }],
  question: [{ required: true, message: '请输入题目内容', trigger: 'blur' }],
  score: [{ required: true, message: '请输入分值', trigger: 'change' }],
  answer: formData.type === 1 || formData.type === 2
    ? [{ required: true, message: '请输入正确答案', trigger: 'blur' }]
    : []
}))

const getTypeName = (type) => {
  const map = { 1: '填空题', 2: '选择题', 5: '解答题', 6: '编程题' }
  return map[type] || `类型${type || '-'}`
}

const getTypeTag = (type) => {
  const map = { 1: 'warning', 2: 'primary', 5: 'success', 6: 'danger' }
  return map[type] || 'info'
}

const shortText = (text, length = 100) => {
  if (!text) return '-'
  return text.length > length ? `${text.slice(0, length)}...` : text
}

const resetForm = () => {
  Object.assign(formData, {
    id: null,
    type: 1,
    question: '',
    answer: '',
    analysis: '',
    options: '',
    score: 10,
    state: 1
  })
  programmingLanguage.value = 'java'
  testCases.value = [{ input: '', expectedOutput: '', scoreWeight: 1 }]
  choiceOptions.value = [
    { key: 'A', content: '' },
    { key: 'B', content: '' }
  ]
  choiceAnswer.value = 'A'
}

const onTypeChange = () => {
  if (formData.type === 1) {
    formData.blankCount = 0
    formData.answers = []
    // 第一个空不追加横线，让用户自己加
  } else if (formData.type === 2) {
    formData.answer = choiceAnswer.value
  } else if (formData.type === 6) {
    formData.answer = ''
    formData.options = JSON.stringify({ defaultLanguage: programmingLanguage.value })
  } else {
    formData.options = ''
  }
}

const updateBlankPlaceholders = () => {
  const count = formData.blankCount || 0
  const currentBlanks = (formData.question.match(/________/g) || []).length
  if (count > currentBlanks) {
    // 需要增加横线
    for (let i = currentBlanks; i < count; i++) {
      formData.question = formData.question.trim() + ' ________'
    }
  } else if (count < currentBlanks) {
    // 需要减少横线
    for (let i = currentBlanks; i > count; i--) {
      formData.question = formData.question.replace(/ ________$/, '')
    }
  }
  // 同步答案数组
  while (formData.answers.length < count) {
    formData.answers.push('')
  }
  while (formData.answers.length > count) {
    formData.answers.pop()
  }
}

const addChoiceOption = () => {
  const charCode = 65 + choiceOptions.value.length
  const key = String.fromCharCode(Math.min(charCode, 90))
  choiceOptions.value.push({ key, content: '' })
}

const removeChoiceOption = (index) => {
  if (choiceOptions.value.length <= 2) return
  const removed = choiceOptions.value[index]
  choiceOptions.value.splice(index, 1)
  if (removed.key === choiceAnswer.value) {
    choiceAnswer.value = choiceOptions.value[0]?.key || 'A'
  }
}

const addTestCase = () => {
  testCases.value.push({ input: '', expectedOutput: '', scoreWeight: 1 })
}

const removeTestCase = (index) => {
  if (testCases.value.length <= 1) return
  testCases.value.splice(index, 1)
}

const loadQuestionList = async () => {
  loading.value = true
  try {
    const params = { page: pagination.page, pageSize: pagination.pageSize }
    if (searchType.value) params.type = searchType.value
    if (searchQuery.value) params.keyword = searchQuery.value
    const response = await teacherApi.question.list(params)
    questionList.value = response.data?.list || []
    pagination.total = response.data?.total || 0
  } catch {
    ElMessage.error('加载题库失败')
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadQuestionList()
}

const handleAdd = () => {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
}

const loadQuestionForEdit = async (row) => {
  Object.assign(formData, {
    id: row.id,
    type: row.type,
    question: row.question || '',
    answer: row.answer || '',
    analysis: row.analysis || '',
    options: row.options || '',
    score: row.score || 10,
    state: row.state ?? 1
  })

  if (formData.type === 2 && formData.options) {
    try {
      const parsed = JSON.parse(formData.options)
      const keys = Object.keys(parsed)
      if (keys.length) {
        choiceOptions.value = keys.map((key) => ({ key, content: parsed[key] }))
      }
      choiceAnswer.value = formData.answer || keys[0] || 'A'
    } catch {
      choiceOptions.value = [
        { key: 'A', content: '' },
        { key: 'B', content: '' }
      ]
      choiceAnswer.value = 'A'
    }
  }

  if (formData.type === 6) {
    try {
      const parsedOptions = formData.options ? JSON.parse(formData.options) : {}
      programmingLanguage.value = parsedOptions.defaultLanguage === 'c' ? 'c' : 'java'
    } catch {
      programmingLanguage.value = 'java'
    }
    const res = await teacherApi.question.getTestCases(row.id)
    const dbCases = res.data || []
    testCases.value = dbCases.length
      ? dbCases.map((tc) => ({
          id: tc.id,
          input: tc.input || '',
          expectedOutput: tc.expectedOutput || '',
          scoreWeight: tc.scoreWeight || 1
        }))
      : [{ input: '', expectedOutput: '', scoreWeight: 1 }]
  } else {
    testCases.value = [{ input: '', expectedOutput: '', scoreWeight: 1 }]
  }
}

const handleEdit = async (row) => {
  resetForm()
  isEdit.value = true
  dialogVisible.value = true
  try {
    await loadQuestionForEdit(row)
  } catch {
    ElMessage.error('加载题目详情失败')
  }
}

const buildPayload = () => {
  const payload = {
    ...formData,
    question: formData.question?.trim() || '',
    answer: formData.answer || '',
    analysis: formData.analysis || '',
    options: '',
    score: formData.score || 10,
    state: formData.state ?? 1
  }

  if (formData.type === 1) {
    // 填空题：答案用|||分隔
    payload.answer = formData.answers?.filter(a => a).join('|||') || ''
  } else if (formData.type === 2) {
    const optionsObject = {}
    validChoiceOptions.value.forEach((opt) => {
      optionsObject[String(opt.key).trim()] = opt.content
    })
    payload.options = JSON.stringify(optionsObject)
    payload.answer = choiceAnswer.value
  } else if (formData.type === 6) {
    payload.answer = ''
    payload.options = JSON.stringify({ defaultLanguage: programmingLanguage.value })
  } else {
    payload.options = ''
  }

  return payload
}

const validateBeforeSubmit = () => {
  if (!formData.question || !formData.question.trim()) {
    ElMessage.warning('请先填写题目内容')
    return false
  }
  if (formData.type === 1 && (!formData.answer || !formData.answer.trim())) {
    ElMessage.warning('填空题必须填写标准答案')
    return false
  }
  if (formData.type === 2) {
    if (validChoiceOptions.value.length < 2) {
      ElMessage.warning('选择题至少配置两个有效选项')
      return false
    }
    const optionMap = {}
    validChoiceOptions.value.forEach((it) => { optionMap[it.key] = true })
    if (!optionMap[choiceAnswer.value]) {
      ElMessage.warning('请选择正确答案')
      return false
    }
  }
  if (formData.type === 6) {
    const validCaseCount = testCases.value.filter((tc) => (tc.expectedOutput || '').trim() !== '').length
    if (!validCaseCount) {
      ElMessage.warning('编程题至少需要一个测试点（包含期望输出）')
      return false
    }
  }
  return true
}

const saveProgrammingTestCases = async (questionId) => {
  if (formData.type !== 6) return
  const formatted = testCases.value
    .map((tc, index) => ({
      input: tc.input || '',
      expectedOutput: tc.expectedOutput || '',
      scoreWeight: tc.scoreWeight || 1,
      sortIndex: index
    }))
    .filter((tc) => tc.expectedOutput.trim() !== '')
  await teacherApi.question.saveTestCases(questionId, formatted)
}

const resolveCreatedQuestionId = async (addRes, payload) => {
  const rawData = addRes?.data
  if (typeof rawData === 'number') return rawData
  if (rawData?.id) return rawData.id
  if (rawData?.questionId) return rawData.questionId

  const normalized = (s) => String(s || '').replace(/\s+/g, ' ').trim()
  const keyword = normalized(payload.question).slice(0, 48)

  for (let attempt = 0; attempt < 3; attempt++) {
    const listRes = await teacherApi.question.list({
      page: 1,
      pageSize: 100,
      type: payload.type,
      keyword
    })
    const list = listRes.data?.list || []
    if (list.length === 0) {
      await new Promise((r) => setTimeout(r, 200))
      continue
    }

    const target = normalized(payload.question)
    const exact = list.find((item) => item?.type === payload.type && normalized(item?.question) === target)
    if (exact?.id) return exact.id

    if (list[0]?.id) return list[0].id
    await new Promise((r) => setTimeout(r, 200))
  }
  return null
}

const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    if (!validateBeforeSubmit()) return

    submitting.value = true
    const payload = buildPayload()
    let questionId = formData.id

    if (isEdit.value) {
      await teacherApi.question.update(formData.id, payload)
      questionId = formData.id
    } else {
      const res = await teacherApi.question.add(payload)
      questionId = await resolveCreatedQuestionId(res, payload)
    }

    if (!questionId) {
      // The question is likely created successfully, but the backend didn't return its id.
      // Avoid showing an error (users observe it did create), and refresh the list instead.
      ElMessage.warning('题目已创建到题库，但未获取到ID；列表已刷新，可在列表中找到该题继续编辑。')
      dialogVisible.value = false
      loadQuestionList()
      return
    }

    if (formData.type === 6) {
      await saveProgrammingTestCases(questionId)
    }

    ElMessage.success(isEdit.value ? '题目更新成功' : '题目创建成功')
    dialogVisible.value = false
    loadQuestionList()
  } catch (error) {
    if (error !== false) {
      ElMessage.error(error?.message || '保存失败')
    }
  } finally {
    submitting.value = false
  }
}

const handleDelete = (row) => {
  ElMessageBox.confirm(`确认删除题目 #${row.id} 吗？`, '提示', { type: 'warning' })
    .then(async () => {
      try {
        await teacherApi.question.delete(row.id)
        ElMessage.success('删除成功')
        loadQuestionList()
      } catch {
        ElMessage.error('删除失败')
      }
    })
    .catch(() => {})
}

onMounted(() => {
  loadQuestionList()
})
</script>

<style scoped>
.question-page {
  padding: 20px;
}

.breadcrumb {
  margin-bottom: 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  gap: 12px;
}

.page-title {
  font-size: 24px;
  font-weight: 600;
  color: #2d8a4e;
  margin: 0;
}

.search-area {
  display: flex;
  gap: 10px;
}

.search-input {
  width: 300px;
}

.action-bar {
  margin-bottom: 20px;
}

.table-card {
  border-radius: 10px;
}

.pagination {
  margin-top: 20px;
  justify-content: flex-end;
}

.action-buttons {
  display: flex;
  align-items: center;
  gap: 6px;
}

.question-form :deep(.el-form-item) {
  margin-bottom: 16px;
}

.form-grid {
  display: grid;
  grid-template-columns: 1fr 200px;
  gap: 14px;
}

.choice-editor {
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.choice-row {
  display: flex;
  align-items: center;
  gap: 8px;
}

.answer-inputs {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.answer-row {
  display: flex;
  align-items: center;
  gap: 10px;

  .answer-label {
    font-weight: 500;
    min-width: 60px;
    color: #606266;
  }

  .el-input {
    flex: 1;
  }
}

.test-cases {
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.test-case-item {
  border: 1px solid #e4e7ed;
  border-radius: 8px;
  padding: 10px;
}

.test-case-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
  color: #606266;
  font-size: 13px;
}

.test-case-foot {
  margin-top: 8px;
  display: flex;
  align-items: center;
  gap: 8px;
  color: #606266;
  font-size: 13px;
}

@media (max-width: 900px) {
  .form-grid {
    grid-template-columns: 1fr;
  }
}
</style>
