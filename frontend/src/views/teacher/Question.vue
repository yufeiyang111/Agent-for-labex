<template>
  <div class="question-page wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-left">
          <h2 class="page-title">题库管理</h2>
          <div class="filter-wrapper">
            <el-select v-model="searchType" placeholder="题型" clearable @change="handleSearch" size="small" class="type-select">
              <el-option label="填空题" :value="1" />
              <el-option label="选择题" :value="2" />
              <el-option label="判断题" :value="4" />
              <el-option label="简答题" :value="5" />
              <el-option label="编程题" :value="6" />
            </el-select>
            <el-input
              v-model="searchQuery"
              placeholder="搜索题目内容"
              clearable
              @clear="handleSearch"
              @keyup.enter="handleSearch"
              size="small"
              class="wabi-search"
            >
              <template #prefix><el-icon><Search /></el-icon></template>
            </el-input>
          </div>
        </div>
        <el-button type="primary" :icon="Plus" @click="handleAdd" class="wabi-btn-primary">
          新增题目
        </el-button>
      </div>

      <!-- 列表容器 -->
      <div class="list-container">
        <div class="list-content" v-loading="loading">
          <div v-if="!loading && !questionList.length" class="list-empty">
            <el-empty description="暂无题目数据" />
          </div>
          <div v-else class="question-list">
            <div v-for="q in questionList" :key="q.id" class="question-item">
              <div class="question-info">
                <div class="question-header">
                  <span class="question-id">#{{ q.id }}</span>
                  <span class="wabi-tag" :class="getTypeClass(q.type)">{{ q.typeName || getTypeName(q.type) }}</span>
                  <span class="wabi-tag" :class="q.state === 1 ? 'wabi-tag-accent' : ''">
                    {{ q.state === 1 ? '启用' : '禁用' }}
                  </span>
                </div>
                <div class="question-text">{{ shortText(q.question, 150) }}</div>
              </div>
              <div class="question-actions">
                <el-button size="small" text @click="handleEdit(q)" class="wabi-btn-text">编辑</el-button>
                <el-button size="small" text type="danger" @click="handleDelete(q)" class="wabi-btn-text wabi-btn-danger">删除</el-button>
              </div>
            </div>
          </div>
        </div>

        <!-- 分页 -->
        <div class="list-pagination" v-if="pagination.total > 0">
          <el-pagination
            v-model:current-page="pagination.page"
            v-model:page-size="pagination.pageSize"
            :page-sizes="[20, 40, 60, 100]"
            :total="pagination.total"
            layout="total, sizes, prev, pager, next, jumper"
            @size-change="loadQuestionList"
            @current-change="loadQuestionList"
          />
        </div>
      </div>
    </div>

    <!-- 编辑题目对话框 -->
    <el-dialog v-model="editDialogVisible" :title="isEdit ? '编辑题目' : '新增题目'" width="800" class="wabi-dialog">
      <el-form ref="editFormRef" :model="editForm" :rules="editRules" label-width="100" class="wabi-form">
        <el-form-item label="题型" prop="type">
          <el-select v-model="editForm.type" placeholder="选择题型" style="width: 100%" @change="onTypeChange">
            <el-option label="填空题" :value="1" />
            <el-option label="单选题" :value="2" />
            <el-option label="多选题" :value="3" />
            <el-option label="判断题" :value="4" />
            <el-option label="简答题" :value="5" />
            <el-option label="编程题" :value="6" />
            <el-option label="综合题" :value="7" />
          </el-select>
        </el-form-item>
        <el-form-item label="题目内容" prop="question">
          <el-input v-model="editForm.question" type="textarea" :rows="6" placeholder="请输入题目内容" />
        </el-form-item>
        <!-- 填空题：多个答案输入框 -->
        <template v-if="editForm.type === 1">
          <el-form-item label="答案">
            <div v-for="(blank, idx) in editForm.fillBlanks" :key="idx" class="option-item">
              <el-input v-model="editForm.fillBlanks[idx]" :placeholder="`第 ${idx + 1} 空答案`" />
              <el-button text type="danger" @click="editForm.fillBlanks.splice(idx, 1)" v-if="editForm.fillBlanks.length > 1">删除</el-button>
            </div>
            <el-button text @click="editForm.fillBlanks.push('')" class="add-option-btn">添加一空</el-button>
          </el-form-item>
        </template>

        <!-- 选择题：选项 key + 内容分离，答案 radio -->
        <template v-if="editForm.type === 2 || editForm.type === 3">
          <el-form-item label="选项">
            <div v-for="(opt, idx) in editForm.choiceOptions" :key="idx" class="option-item">
              <span class="option-key">{{ opt.key }}.</span>
              <el-input v-model="opt.content" :placeholder="`选项 ${opt.key} 内容`" style="flex: 1" />
              <el-button text type="danger" @click="removeChoiceOption(idx)" v-if="editForm.choiceOptions.length > 2">删除</el-button>
            </div>
            <el-button text @click="addChoiceOption" class="add-option-btn">添加选项</el-button>
          </el-form-item>
          <el-form-item label="正确答案" prop="answer">
            <el-radio-group v-if="editForm.type === 2" v-model="editForm.answer">
              <el-radio v-for="opt in editForm.choiceOptions" :key="opt.key" :value="opt.key">{{ opt.key }}</el-radio>
            </el-radio-group>
            <el-checkbox-group v-else v-model="editForm.answer">
              <el-checkbox v-for="opt in editForm.choiceOptions" :key="opt.key" :value="opt.key" :label="opt.key">{{ opt.key }}</el-checkbox>
            </el-checkbox-group>
          </el-form-item>
        </template>

        <!-- 编程题：测试用例编辑 -->
        <template v-if="editForm.type === 6">
          <el-form-item label="测试用例">
            <div v-for="(tc, idx) in editForm.testCases" :key="idx" class="test-case-item">
              <div class="test-case-header">
                <span class="test-case-label">用例 {{ idx + 1 }}</span>
                <el-button text type="danger" size="small" @click="removeTestCase(idx)" v-if="editForm.testCases.length > 1">删除</el-button>
              </div>
              <el-input v-model="tc.input" type="textarea" :rows="2" placeholder="输入 (input)" />
              <el-input v-model="tc.expectedOutput" type="textarea" :rows="2" placeholder="期望输出 (expectedOutput)" />
              <el-input-number v-model="tc.scoreWeight" :min="0" :max="100" :step="0.1" size="small" placeholder="分值权重" />
            </div>
            <el-button text @click="addTestCase" class="add-option-btn">添加测试用例</el-button>
          </el-form-item>
        </template>

        <!-- 其他题型：通用答案输入 -->
        <el-form-item label="正确答案" prop="answer" v-if="editForm.type !== 2 && editForm.type !== 3 && editForm.type !== 6">
          <el-input v-model="editForm.answer" type="textarea" :rows="3" placeholder="请输入正确答案" />
        </el-form-item>
        <el-form-item label="解析">
          <el-input v-model="editForm.analysis" type="textarea" :rows="3" placeholder="请输入答案解析" />
        </el-form-item>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="分值">
              <el-input-number v-model="editForm.score" :min="1" :max="100" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="难度">
              <el-select v-model="editForm.difficulty" placeholder="选择难度" style="width: 100%">
                <el-option label="简单" :value="1" />
                <el-option label="中等" :value="2" />
                <el-option label="困难" :value="3" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="状态">
          <el-switch v-model="editForm.state" :active-value="1" :inactive-value="0" active-text="启用" inactive-text="禁用" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="editDialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleSave" :loading="saving" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search } from '@element-plus/icons-vue'
import { teacherApi } from '@/api'

const questionApi = teacherApi.question

const loading = ref(false)
const saving = ref(false)
const questionList = ref([])
const searchQuery = ref('')
const searchType = ref('')
const editDialogVisible = ref(false)
const editFormRef = ref()
const isEdit = ref(false)

const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const editForm = reactive({
  id: null,
  type: 2,
  question: '',
  options: ['', '', '', ''],
  answer: '',
  analysis: '',
  score: 10,
  difficulty: 2,
  state: 1,
  choiceOptions: [
    { key: 'A', content: '' },
    { key: 'B', content: '' },
    { key: 'C', content: '' },
    { key: 'D', content: '' }
  ],
  testCases: [{ input: '', expectedOutput: '', scoreWeight: 1 }],
  fillBlanks: ['']
})

const editRules = {
  type: [{ required: true, message: '请选择题型', trigger: 'change' }],
  question: [{ required: true, message: '请输入题目内容', trigger: 'blur' }],
  answer: [{ required: true, message: '请输入正确答案', trigger: 'blur' }]
}

const getTypeName = (type) => ({
  1: '填空题',
  2: '单选题',
  3: '多选题',
  4: '判断题',
  5: '简答题',
  6: '编程题',
  7: '综合题'
}[type] || '未知')

const getTypeClass = (type) => ({
  1: '',
  2: 'wabi-tag-accent',
  3: 'wabi-tag-accent',
  4: '',
  5: 'wabi-tag-warning',
  6: 'wabi-tag-info',
  7: 'wabi-tag-warning'
}[type] || '')

const onTypeChange = (type) => {
  if (type === 1) {
    // 填空题
    editForm.fillBlanks = editForm.fillBlanks.length ? editForm.fillBlanks : ['']
    editForm.answer = ''
  } else if (type === 2 || type === 3) {
    // 选择题
    editForm.choiceOptions = editForm.choiceOptions.length >= 2 ? editForm.choiceOptions : [
      { key: 'A', content: '' },
      { key: 'B', content: '' },
      { key: 'C', content: '' },
      { key: 'D', content: '' }
    ]
    editForm.answer = ''
  } else if (type === 6) {
    // 编程题
    editForm.testCases = editForm.testCases.length ? editForm.testCases : [{ input: '', expectedOutput: '', scoreWeight: 1 }]
    editForm.answer = ''
  } else {
    editForm.answer = ''
  }
}

const addChoiceOption = () => {
  const keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  const nextKey = keys[editForm.choiceOptions.length] || String(editForm.choiceOptions.length)
  editForm.choiceOptions.push({ key: nextKey, content: '' })
}

const removeChoiceOption = (index) => {
  editForm.choiceOptions.splice(index, 1)
  editForm.choiceOptions.forEach((opt, i) => {
    opt.key = String.fromCharCode(65 + i)
  })
}

const addTestCase = () => {
  editForm.testCases.push({ input: '', expectedOutput: '', scoreWeight: 1 })
}

const removeTestCase = (index) => {
  if (editForm.testCases.length > 1) {
    editForm.testCases.splice(index, 1)
  }
}

const shortText = (text, len) => {
  if (!text) return ''
  return text.length > len ? text.substring(0, len) + '...' : text
}

const loadQuestionList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize,
      keyword: searchQuery.value || undefined,
      type: searchType.value || undefined
    }
    const res = await questionApi.list(params)
    questionList.value = res.data?.list || res.data || []
    pagination.total = res.data?.total || questionList.value.length
  } catch (error) {
    console.error('加载题目列表失败:', error)
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadQuestionList()
}

const resetForm = () => {
  Object.assign(editForm, {
    id: null,
    type: 2,
    question: '',
    options: ['', '', '', ''],
    answer: '',
    analysis: '',
    score: 10,
    difficulty: 2,
    state: 1,
    choiceOptions: [
      { key: 'A', content: '' },
      { key: 'B', content: '' },
      { key: 'C', content: '' },
      { key: 'D', content: '' }
    ],
    testCases: [{ input: '', expectedOutput: '', scoreWeight: 1 }],
    fillBlanks: ['']
  })
}

const handleAdd = () => {
  resetForm()
  isEdit.value = false
  editDialogVisible.value = true
}

const handleEdit = (row) => {
  const parsedOptions = row.options ? JSON.parse(row.options) : []
  let choiceOptions = [
    { key: 'A', content: '' },
    { key: 'B', content: '' },
    { key: 'C', content: '' },
    { key: 'D', content: '' }
  ]
  let testCases = [{ input: '', expectedOutput: '', scoreWeight: 1 }]
  let fillBlanks = ['']
  let options = ['', '', '', '']
  let answer = row.answer || ''

  if (row.type === 1) {
    // 填空题：answer 可能是用 ||| 分隔的多个答案
    fillBlanks = answer ? answer.split('|||') : ['']
  } else if (row.type === 2 || row.type === 3) {
    // 选择题：options 是 [{key, content}] 或字符串数组
    if (parsedOptions.length && typeof parsedOptions[0] === 'object') {
      choiceOptions = parsedOptions
    } else {
      choiceOptions = parsedOptions.map((opt, i) => ({
        key: String.fromCharCode(65 + i),
        content: opt
      }))
    }
    options = parsedOptions
  } else if (row.type === 6) {
    // 编程题：testCases 从 answer 或 options 解析
    try {
      const parsed = row.answer ? JSON.parse(row.answer) : null
      if (parsed && Array.isArray(parsed)) {
        testCases = parsed
      }
    } catch (e) {
      // ignore
    }
    answer = ''
  }

  Object.assign(editForm, {
    id: row.id,
    type: row.type,
    question: row.question || '',
    options: options,
    answer: answer,
    analysis: row.analysis || '',
    score: row.score || 10,
    difficulty: row.difficulty || 2,
    state: row.state,
    choiceOptions: choiceOptions,
    testCases: testCases,
    fillBlanks: fillBlanks
  })
  isEdit.value = true
  editDialogVisible.value = true
}

const handleSave = async () => {
  try {
    await editFormRef.value.validate()
    saving.value = true
    let data = { ...editForm }

    if (editForm.type === 1) {
      // 填空题：answer 用 ||| 分隔多个答案
      data.answer = editForm.fillBlanks.join('|||')
      data.options = ''
    } else if (editForm.type === 2 || editForm.type === 3) {
      // 选择题：options 存 [{key, content}]，answer 存选中的 key
      data.options = JSON.stringify(editForm.choiceOptions)
      data.answer = editForm.answer
    } else if (editForm.type === 6) {
      // 编程题：testCases 存在 answer 字段
      data.answer = JSON.stringify(editForm.testCases)
      data.options = ''
    } else {
      data.options = JSON.stringify(editForm.options)
    }

    // 删除前端专用字段
    delete data.choiceOptions
    delete data.testCases
    delete data.fillBlanks

    if (isEdit.value) {
      await questionApi.update(editForm.id, data)
      ElMessage.success('更新成功')
    } else {
      await questionApi.add(data)
      ElMessage.success('创建成功')
    }
    editDialogVisible.value = false
    loadQuestionList()
  } catch (error) {
    console.error('保存失败:', error)
  } finally {
    saving.value = false
  }
}

const handleDelete = async (row) => {
  await ElMessageBox.confirm('确定删除该题目?', '提示', { type: 'warning' })
  await questionApi.delete(row.id)
  ElMessage.success('已删除')
  loadQuestionList()
}

onMounted(loadQuestionList)
</script>

<style scoped>
.question-page {
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
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.page-title {
  font-size: 18px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
}

.filter-wrapper {
  display: flex;
  gap: 8px;
}

.type-select {
  width: 120px;
}

.wabi-search {
  width: 200px;
}

/* 列表容器 */
.list-container {
  flex: 1;
  min-height: 0;
  display: flex;
  flex-direction: column;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: var(--wabi-radius, 3px);
  overflow: hidden;
}

.list-content {
  flex: 1;
  min-height: 0;
  overflow-y: auto;
  padding: 0;
}

.list-empty {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  min-height: 200px;
}

/* 分页 */
.list-pagination {
  flex-shrink: 0;
  display: flex;
  justify-content: center;
  padding: 16px 20px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
  background: var(--wabi-surface-warm, #faf9f7);
}

/* 题目列表 */
.question-list {
  display: flex;
  flex-direction: column;
}

.question-item {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 16px 20px;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
  transition: background 0.2s ease;
}

.question-item:hover {
  background: var(--wabi-accent-light, #e8ede5);
}

.question-item:last-child {
  border-bottom: none;
}

.question-info {
  flex: 1;
  min-width: 0;
}

.question-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 8px;
}

.question-id {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  font-family: monospace;
}

.question-text {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
  line-height: 1.6;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.question-actions {
  flex-shrink: 0;
  display: flex;
  gap: 4px;
  margin-left: 16px;
}

/* 选项 */
.option-item {
  display: flex;
  gap: 8px;
  margin-bottom: 8px;
}

.add-option-btn {
  margin-top: 8px;
}

.option-key {
  font-weight: 600;
  color: var(--wabi-accent, #7a8b6f);
  min-width: 24px;
  line-height: 32px;
}

.test-case-item {
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 4px;
  padding: 12px;
  margin-bottom: 12px;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.test-case-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.test-case-label {
  font-size: 13px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
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

.wabi-tag-info {
  background: #e8f0f5;
  color: #6b8a9a;
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

.wabi-btn-text {
  color: var(--wabi-text-secondary, #8a8580);
}

.wabi-btn-text:hover {
  color: var(--wabi-accent, #7a8b6f);
}

.wabi-btn-danger:hover {
  color: #c47c7c;
}

/* 响应式 */
@media (max-width: 768px) {
  .wabi-body {
    padding: 16px;
  }

  .page-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }

  .header-left {
    flex-direction: column;
    align-items: flex-start;
  }

  .question-item {
    flex-direction: column;
  }

  .question-actions {
    margin-left: 0;
    margin-top: 12px;
  }
}
</style>
