<template>
  <div class="training-set-page">
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/teacher' }">教师首页</el-breadcrumb-item>
      <el-breadcrumb-item>题目训练</el-breadcrumb-item>
    </el-breadcrumb>

    <section class="hero">
      <div>
        <h2>题目训练</h2>
        <p>创建训练集，从题库选题，供学生自主练习。</p>
      </div>
      <div class="hero-actions">
        <el-button type="success" @click="handleAdd">
          <el-icon><Plus /></el-icon> 新建训练集
        </el-button>
      </div>
    </section>

    <section v-loading="loading">
      <el-empty v-if="trainingSets.length === 0" description="暂无训练集" />
      <div v-else class="card-grid">
        <el-card v-for="ts in trainingSets" :key="ts.trainingSetId" class="training-card" shadow="hover">
          <div class="card-top">
            <div class="title">{{ ts.name }}</div>
            <el-tag :type="ts.state === 1 ? 'success' : 'info'" effect="plain">{{ ts.state === 1 ? '启用' : '禁用' }}</el-tag>
          </div>
          <div class="desc">{{ ts.description || '暂无描述' }}</div>
          <div class="meta-list">
            <div>总分：{{ ts.totalScore || 0 }}</div>
            <div>创建时间：{{ formatDate(ts.createTime) }}</div>
          </div>
          <div class="actions">
            <el-button type="primary" plain size="small" @click="handleEdit(ts)">编辑</el-button>
            <el-button type="warning" plain size="small" @click="handleQuestions(ts)">题目</el-button>
            <el-button type="success" plain size="small" @click="handleRecords(ts)">记录</el-button>
            <el-button type="danger" plain size="small" @click="handleDelete(ts)">删除</el-button>
          </div>
        </el-card>
      </div>
    </section>

    <!-- Create/Edit Dialog -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="520px">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="80px">
        <el-form-item label="名称" prop="name">
          <el-input v-model="formData.name" placeholder="请输入训练集名称" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="formData.description" type="textarea" :rows="3" placeholder="请输入训练集描述" />
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
        <el-button type="primary" :loading="submitting" @click="handleSubmit">保存</el-button>
      </template>
    </el-dialog>

    <!-- Question Management Dialog -->
    <el-dialog v-model="questionDialogVisible" :title="'题目管理 - ' + (currentTs?.name || '')" width="1080px" destroy-on-close>
      <div class="question-toolbar">
        <el-select v-model="questionType" placeholder="题目类型" clearable style="width: 140px">
          <el-option label="全部类型" :value="null" />
          <el-option label="填空题" :value="1" />
          <el-option label="单选题" :value="2" />
          <el-option label="多选题" :value="3" />
          <el-option label="判断题" :value="4" />
          <el-option label="简答题" :value="5" />
          <el-option label="编程题" :value="6" />
          <el-option label="综合题" :value="7" />
        </el-select>
        <el-input v-model="questionKeyword" placeholder="搜索题目内容" clearable style="width: 200px" @keyup.enter="loadAvailableQuestions" />
        <el-button type="primary" @click="loadAvailableQuestions">筛选</el-button>
        <el-button type="info" plain @click="resetQuestionFilter">重置</el-button>
        <div style="flex:1"></div>
        <el-button type="success" :disabled="selectedQuestions.length === 0" @click="confirmAddQuestions">
          添加选中（{{ selectedQuestions.length }}）
        </el-button>
      </div>
      <el-table :data="availableQuestions" @selection-change="handleSelectionChange" stripe height="320" v-loading="questionLoading">
        <el-table-column type="selection" width="55" />
        <el-table-column prop="id" label="ID" min-width="80" />
        <el-table-column label="类型" width="90">
          <template #default="{ row }"><el-tag>{{ getTypeName(row.type) }}</el-tag></template>
        </el-table-column>
        <el-table-column label="题目内容" min-width="420">
          <template #default="{ row }">{{ shortText(row.question, 130) }}</template>
        </el-table-column>
        <el-table-column label="分值" width="80">
          <template #default="{ row }">{{ row.score || 10 }}</template>
        </el-table-column>
      </el-table>
      <div class="pagination-wrapper">
        <el-pagination
          v-model:current-page="questionPagination.page"
          v-model:page-size="questionPagination.pageSize"
          :page-sizes="[10, 20, 50, 100]"
          :total="questionPagination.total"
          :background="true"
          layout="total, sizes, prev, pager, next, jumper"
          @current-change="handleQuestionPageChange"
          @size-change="handleQuestionSizeChange"
        />
      </div>

      <div class="current-questions" v-if="currentQuestions.length > 0">
        <h4>当前训练集题目（{{ currentQuestions.length }}）</h4>
        <el-table :data="currentQuestions" stripe size="small" height="220">
          <el-table-column prop="questionId" label="ID" min-width="80" />
          <el-table-column label="类型" width="90">
            <template #default="{ row }"><el-tag>{{ getTypeName(row.type) }}</el-tag></template>
          </el-table-column>
          <el-table-column label="题目内容" min-width="320">
            <template #default="{ row }">{{ shortText(row.question, 100) }}</template>
          </el-table-column>
          <el-table-column label="分值" width="80">
            <template #default="{ row }">{{ row.score ?? '-' }}</template>
          </el-table-column>
          <el-table-column label="操作" width="100">
            <template #default="{ row }">
              <el-button type="danger" size="small" @click="removeQuestion(row.questionId)">移除</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-dialog>

    <!-- Student Records Dialog -->
    <el-dialog v-model="recordDialogVisible" :title="'学生记录 - ' + (currentTs?.name || '')" width="1060px" destroy-on-close>
      <el-table :data="studentRecords" stripe height="480" v-loading="recordLoading">
        <el-table-column prop="studentId" label="学号" width="100" />
        <el-table-column label="得分" width="100">
          <template #default="{ row }">{{ row.score ?? '-' }} / {{ row.totalScore }}</template>
        </el-table-column>
        <el-table-column label="正确/总题数" width="130">
          <template #default="{ row }">{{ row.correctCount ?? '-' }} / {{ row.totalQuestions ?? '-' }}</template>
        </el-table-column>
        <el-table-column label="尝试次数" width="100">
          <template #default="{ row }">{{ row.attemptCount }}</template>
        </el-table-column>
        <el-table-column label="提交时间" min-width="160">
          <template #default="{ row }">{{ formatDate(row.submitTime) }}</template>
        </el-table-column>
        <el-table-column label="操作" width="120">
          <template #default="{ row }">
            <el-button size="small" type="primary" plain @click="viewStudentDetail(row)">详情</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>

    <!-- Student Detail Dialog -->
    <el-dialog v-model="detailDialogVisible" title="学生答题详情" width="900px" destroy-on-close>
      <el-table :data="studentDetailAnswers" stripe height="520">
        <el-table-column label="类型" width="80">
          <template #default="{ row }"><el-tag>{{ getTypeName(row.type) }}</el-tag></template>
        </el-table-column>
        <el-table-column label="题目" min-width="260">
          <template #default="{ row }">{{ shortText(row.question, 80) }}</template>
        </el-table-column>
        <el-table-column label="学生答案" min-width="160">
          <template #default="{ row }">{{ row.myAnswer || '-' }}</template>
        </el-table-column>
        <el-table-column label="得分" width="80">
          <template #default="{ row }">{{ row.score ?? '-' }}</template>
        </el-table-column>
        <el-table-column label="正确" width="80">
          <template #default="{ row }">
            <el-tag :type="row.isCorrect === 1 ? 'success' : 'danger'" size="small">
              {{ row.isCorrect === 1 ? '是' : '否' }}
            </el-tag>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script setup>
import { onMounted, ref, reactive, computed } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { trainingApi } from '@/api'

const loading = ref(false)
const submitting = ref(false)
const trainingSets = ref([])
const dialogVisible = ref(false)
const isEdit = ref(false)
const formRef = ref(null)
const currentTs = ref(null)

const questionDialogVisible = ref(false)
const questionType = ref(null)
const questionKeyword = ref('')
const questionLoading = ref(false)
const availableQuestions = ref([])
const selectedQuestions = ref([])
const currentQuestions = ref([])

// 分页相关
const questionPagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const recordDialogVisible = ref(false)
const recordLoading = ref(false)
const studentRecords = ref([])

const detailDialogVisible = ref(false)
const studentDetailAnswers = ref([])

const formData = reactive({
  trainingSetId: null,
  name: '',
  description: '',
  state: 1
})

const formRules = {
  name: [{ required: true, message: '请输入训练集名称', trigger: 'blur' }]
}

const dialogTitle = computed(() => (isEdit.value ? '编辑训练集' : '新建训练集'))

const typeMap = { 1: '填空题', 2: '单选题', 3: '多选题', 4: '判断题', 5: '简答题', 6: '编程题', 7: '综合题' }

function getTypeName(type) {
  return typeMap[type] || `类型${type || '-'}`
}

function shortText(text, length = 100) {
  if (!text) return '-'
  return text.length > length ? text.slice(0, length) + '...' : text
}

function formatDate(date) {
  if (!date) return '-'
  return new Date(date).toLocaleString('zh-CN')
}

async function loadTrainingSets() {
  loading.value = true
  try {
    const res = await trainingApi.teacher.all()
    trainingSets.value = res.data || []
  } catch {
    ElMessage.error('加载训练集列表失败')
  } finally {
    loading.value = false
  }
}

function resetForm() {
  formData.trainingSetId = null
  formData.name = ''
  formData.description = ''
  formData.state = 1
}

function handleAdd() {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
}

function handleEdit(ts) {
  formData.trainingSetId = ts.trainingSetId
  formData.name = ts.name
  formData.description = ts.description || ''
  formData.state = ts.state
  isEdit.value = true
  dialogVisible.value = true
}

async function handleSubmit() {
  try {
    await formRef.value.validate()
    submitting.value = true
    if (isEdit.value) {
      await trainingApi.teacher.update(formData.trainingSetId, formData)
      ElMessage.success('更新成功')
    } else {
      await trainingApi.teacher.add(formData)
      ElMessage.success('新建成功')
    }
    dialogVisible.value = false
    loadTrainingSets()
  } catch (error) {
    if (error !== false) ElMessage.error('操作失败')
  } finally {
    submitting.value = false
  }
}

function handleDelete(ts) {
  ElMessageBox.confirm(`确认删除训练集 "${ts.name}" 吗？`, '提示', { type: 'warning' })
    .then(async () => {
      try {
        await trainingApi.teacher.delete(ts.trainingSetId)
        ElMessage.success('删除成功')
        loadTrainingSets()
      } catch {
        ElMessage.error('删除失败')
      }
    })
    .catch(() => {})
}

async function handleQuestions(ts) {
  currentTs.value = ts
  selectedQuestions.value = []
  questionType.value = null
  questionKeyword.value = ''
  questionPagination.page = 1
  questionDialogVisible.value = true
  await loadCurrentQuestions(ts.trainingSetId)
  await loadAvailableQuestions()
}

async function loadCurrentQuestions(trainingSetId) {
  try {
    const res = await trainingApi.teacher.getQuestions(trainingSetId || currentTs.value.trainingSetId)
    currentQuestions.value = res.data || []
  } catch {
    ElMessage.error('加载当前题目失败')
  }
}

async function loadAvailableQuestions() {
  questionLoading.value = true
  try {
    const params = {
      page: questionPagination.page,
      pageSize: questionPagination.pageSize
    }
    if (questionType.value) {
      params.type = questionType.value
    }
    if (questionKeyword.value) {
      params.keyword = questionKeyword.value
    }
    const res = await trainingApi.teacher.getAvailableQuestions(params)
    const data = res.data
    if (data && data.list) {
      availableQuestions.value = data.list || []
      questionPagination.total = data.total || 0
    } else if (data && Array.isArray(data)) {
      availableQuestions.value = data
      questionPagination.total = data.length
    } else {
      availableQuestions.value = []
      questionPagination.total = 0
    }
  } catch {
    ElMessage.error('加载题库失败')
  } finally {
    questionLoading.value = false
  }
}

function resetQuestionFilter() {
  questionType.value = null
  questionKeyword.value = ''
  questionPagination.page = 1
  loadAvailableQuestions()
}

function handleQuestionPageChange(page) {
  questionPagination.page = page
  loadAvailableQuestions()
}

function handleQuestionSizeChange(size) {
  questionPagination.pageSize = size
  questionPagination.page = 1
  loadAvailableQuestions()
}

function handleSelectionChange(selection) {
  selectedQuestions.value = selection
}

async function confirmAddQuestions() {
  if (!selectedQuestions.value.length) return
  try {
    const questionIds = selectedQuestions.value.map((q) => q.id)
    await trainingApi.teacher.addQuestions(currentTs.value.trainingSetId, questionIds)
    ElMessage.success('添加成功')
    selectedQuestions.value = []
    await loadCurrentQuestions()
  } catch {
    ElMessage.error('添加失败')
  }
}

async function removeQuestion(questionId) {
  try {
    await trainingApi.teacher.removeQuestion(currentTs.value.trainingSetId, questionId)
    ElMessage.success('移除成功')
    await loadCurrentQuestions()
  } catch {
    ElMessage.error('移除失败')
  }
}

async function handleRecords(ts) {
  currentTs.value = ts
  recordDialogVisible.value = true
  recordLoading.value = true
  try {
    const res = await trainingApi.teacher.getStudentRecords(ts.trainingSetId)
    studentRecords.value = res.data || []
  } catch {
    ElMessage.error('加载学生记录失败')
  } finally {
    recordLoading.value = false
  }
}

async function viewStudentDetail(record) {
  try {
    const res = await trainingApi.teacher.getStudentDetail(
      currentTs.value.trainingSetId,
      record.studentId,
      record.id
    )
    studentDetailAnswers.value = res.data || []
    detailDialogVisible.value = true
  } catch {
    ElMessage.error('加载答题详情失败')
  }
}

onMounted(loadTrainingSets)
</script>

<style scoped>
.training-set-page { padding: 20px; }
.breadcrumb { margin-bottom: 16px; }
.hero { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 20px; gap: 10px; }
.hero h2 { margin: 0; font-size: 26px; color: #111827; }
.hero p { margin: 6px 0 0; color: #6b7280; font-size: 13px; }
.hero-actions { display: flex; gap: 8px; }

.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
  gap: 16px;
}

.training-card {
  border-radius: 14px;
  border: 1px solid #e5e7eb;
  transition: all 0.25s;
}
.training-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 28px rgba(0,0,0,0.1);
}

.card-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
.title { font-size: 16px; font-weight: 700; color: #111827; }
.desc { min-height: 36px; color: #4b5563; font-size: 13px; margin-bottom: 10px; line-height: 1.5; }
.meta-list { display: flex; flex-direction: column; gap: 4px; margin-bottom: 10px; color: #374151; font-size: 13px; }
.actions { display: flex; gap: 8px; flex-wrap: wrap; }

.question-toolbar { display: flex; align-items: center; gap: 8px; margin-bottom: 12px; }
.pagination-wrapper { display: flex; justify-content: flex-end; margin-top: 12px; }
.current-questions { margin-top: 16px; }
.current-questions h4 { margin: 0 0 8px; color: #111827; }
</style>
