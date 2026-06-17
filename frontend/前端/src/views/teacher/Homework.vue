<template>
  <div class="homework-page wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-left">
          <h2 class="page-title">作业管理</h2>
          <el-input
            v-model="searchQuery"
            placeholder="搜索作业名称"
            clearable
            @clear="handleSearch"
            @keyup.enter="handleSearch"
            size="small"
            class="wabi-search"
          >
            <template #prefix><el-icon><Search /></el-icon></template>
          </el-input>
        </div>
        <el-button type="primary" :icon="Plus" @click="handleAdd" class="wabi-btn-primary">
          新增作业
        </el-button>
      </div>

      <!-- 统计卡片 -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-value">{{ pagination.total }}</div>
          <div class="stat-label">作业总数</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">{{ activeCount }}</div>
          <div class="stat-label">已启用</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">{{ overdueCount }}</div>
          <div class="stat-label">已过期</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">{{ avgScore }}</div>
          <div class="stat-label">平均总分</div>
        </div>
      </div>

      <!-- 列表容器 -->
      <div class="list-container">
        <div class="list-content" v-loading="loading">
          <div v-if="!loading && !homeworkList.length" class="list-empty">
            <el-empty description="暂无作业" />
          </div>
          <div v-else class="homework-list">
            <div v-for="hw in homeworkList" :key="hw.homeworkId" class="homework-item">
              <div class="homework-info">
                <div class="homework-header">
                  <h3 class="homework-name">{{ hw.homeworkName }}</h3>
                  <span class="wabi-tag" :class="hw.state === 1 ? 'wabi-tag-accent' : ''">
                    {{ hw.state === 1 ? '启用' : '禁用' }}
                  </span>
                </div>
                <div class="homework-desc">{{ hw.content || '暂无作业内容' }}</div>
                <div class="homework-meta">
                  <span :class="{ overdue: isOverdue(hw.deadline) }">
                    截止：{{ formatDate(hw.deadline) }}
                  </span>
                  <span>总分：{{ hw.totalScore || 100 }}</span>
                  <span v-if="hw.filePath">有附件</span>
                </div>
              </div>
              <div class="homework-actions">
                <el-button size="small" text @click="handleEdit(hw)" class="wabi-btn-text">编辑</el-button>
                <el-button size="small" text @click="handleQuestions(hw)" class="wabi-btn-text">题目</el-button>
                <el-button size="small" text @click="handleSubmissions(hw)" class="wabi-btn-text">批改</el-button>
                <el-button size="small" text type="danger" @click="handleDelete(hw)" class="wabi-btn-text wabi-btn-danger">删除</el-button>
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
            @size-change="loadHomeworkList"
            @current-change="loadHomeworkList"
          />
        </div>
      </div>
    </div>

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="600" class="wabi-dialog">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="100" class="wabi-form">
        <el-form-item label="作业名称" prop="homeworkName">
          <el-input v-model="formData.homeworkName" placeholder="请输入作业名称" />
        </el-form-item>
        <el-form-item label="作业内容">
          <el-input v-model="formData.content" type="textarea" :rows="4" placeholder="请输入作业内容说明" />
        </el-form-item>
        <el-form-item label="截止时间">
          <el-date-picker v-model="formData.deadline" type="datetime" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
        </el-form-item>
        <el-form-item label="总分">
          <el-input-number v-model="formData.totalScore" :min="1" :max="1000" style="width: 100%" />
        </el-form-item>
        <el-form-item label="上传附件">
          <el-upload :auto-upload="false" :limit="1" :on-change="handleFileChange" :on-remove="handleFileRemove" accept=".pdf,.doc,.docx,.zip">
            <template #trigger><el-button type="primary" class="wabi-btn-primary">选择文件</el-button></template>
          </el-upload>
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="formData.state">
            <el-radio :value="1">启用</el-radio>
            <el-radio :value="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleSubmit" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>

    <!-- 提交批改对话框 -->
    <el-dialog v-model="submissionDialogVisible" title="提交批改" width="1160" class="wabi-dialog">
      <div class="submission-layout">
        <div class="submission-left">
          <h4>学生提交列表</h4>
          <el-scrollbar height="520">
            <div v-if="submissionList.length === 0" class="empty-hint">暂无提交</div>
            <div
              v-for="row in submissionList"
              :key="row.id"
              class="submission-item"
              :class="{ active: activeSubmissionId === row.id }"
              @click="selectSubmission(row.id)"
            >
              <div class="line-1">
                <strong>{{ row.studentName || '-' }}</strong>
                <el-tag size="small" type="info">{{ row.filePath ? '文件' : '文本' }}</el-tag>
              </div>
              <div class="line-2">学号 {{ row.studentId }} · {{ formatDate(row.submitTime) }}</div>
              <div class="line-3">当前分数：{{ row.score ?? '-' }}</div>
            </div>
          </el-scrollbar>
        </div>
        <div class="submission-right">
          <template v-if="activeSubmission">
            <h4>提交详情</h4>
            <div class="detail-head">
              <span>{{ activeSubmission.studentName }}</span>
              <span>学号 {{ activeSubmission.studentId }}</span>
              <span>{{ formatDate(activeSubmission.submitTime) }}</span>
            </div>
            <el-form label-width="86" class="score-form">
              <el-form-item label="总评分">
                <el-input-number v-model="activeSubmission.score" :min="0" :max="1000" />
              </el-form-item>
              <el-form-item label="评语">
                <el-input v-model="activeSubmission.remark" type="textarea" :rows="4" />
              </el-form-item>
            </el-form>
            <div class="detail-actions">
              <el-button v-if="activeSubmission.filePath" type="warning" plain @click="handleDownload(activeSubmission)">下载附件</el-button>
              <el-button type="primary" plain @click="openQuestionGrading(activeSubmission)">按题批改</el-button>
              <el-button type="success" class="wabi-btn-primary" @click="saveScore(activeSubmission)">保存评分</el-button>
            </div>
          </template>
          <el-empty v-else description="请选择一条提交" />
        </div>
      </div>
    </el-dialog>

    <!-- 按题批改对话框 -->
    <el-dialog v-model="gradingDialogVisible" title="按题批改" width="1080" class="wabi-dialog" destroy-on-close>
      <div class="grading-toolbar">
        <div>学生：{{ gradingStudent.studentName || '-' }}（{{ gradingStudent.studentId || '-' }}）</div>
        <el-switch v-model="onlyManualPending" active-text="仅看待人工批改" inactive-text="显示全部题目" />
      </div>
      <el-scrollbar height="520" v-loading="gradingLoading">
        <div v-if="displayGradingItems.length === 0" class="empty-hint">暂无可批改题目</div>
        <el-card v-for="(row, idx) in displayGradingItems" :key="`${row.questionId}-${idx}`" class="grading-card" shadow="never">
          <div class="g-top">
            <div>
              <el-tag size="small">{{ getTypeName(row.type) }}</el-tag>
              <span class="g-index">题目 {{ idx + 1 }}</span>
            </div>
            <div class="g-score">满分 {{ row.maxScore ?? '-' }} · 当前 {{ row.score ?? '-' }}</div>
          </div>
          <div class="g-question">{{ shortText(row.question, 500) }}</div>
          <div class="g-answer">
            <div class="label">学生答案</div>
            <div class="value">{{ row.myAnswer || '-' }}</div>
          </div>
          <div class="g-action" v-if="isManualType(row.type)">
            <el-input-number v-model="row.editScore" :min="0" :max="row.maxScore || 100" />
            <el-button type="primary" class="wabi-btn-primary" :loading="savingQuestionId === row.questionId" @click="saveQuestionGrade(row)">保存该题</el-button>
          </div>
          <div class="g-action" v-else>
            <el-tag type="info">自动判分题</el-tag>
          </div>
        </el-card>
      </el-scrollbar>
    </el-dialog>

    <!-- 题目管理对话框 -->
    <el-dialog v-model="questionDialogVisible" title="作业题目管理" width="1080" class="wabi-dialog" destroy-on-close>
      <div class="question-mode">
        <el-radio-group v-model="questionAddMode">
          <el-radio-button value="bank">从题库添加</el-radio-button>
          <el-radio-button value="direct">直接添加</el-radio-button>
        </el-radio-group>
      </div>

      <template v-if="questionAddMode === 'bank'">
        <div class="question-toolbar">
          <el-select v-model="questionType" placeholder="题目类型" clearable style="width: 160px">
            <el-option label="填空题" :value="1" />
            <el-option label="选择题" :value="2" />
            <el-option label="解答题" :value="5" />
            <el-option label="编程题" :value="6" />
          </el-select>
          <el-button type="primary" class="wabi-btn-primary" @click="loadAvailableQuestions">筛选</el-button>
          <el-button type="success" class="wabi-btn-primary" :disabled="selectedQuestions.length === 0" @click="confirmAddQuestions">
            添加选中（{{ selectedQuestions.length }}）
          </el-button>
        </div>
        <el-table :data="availableQuestions" @selection-change="handleQuestionSelectionChange" stripe height="360" class="wabi-table">
          <el-table-column type="selection" width="55" />
          <el-table-column prop="id" label="ID" min-width="80" />
          <el-table-column label="类型" width="100">
            <template #default="{ row }"><el-tag>{{ getTypeName(row.type) }}</el-tag></template>
          </el-table-column>
          <el-table-column label="题目内容" min-width="420">
            <template #default="{ row }">{{ shortText(row.question, 130) }}</template>
          </el-table-column>
          <el-table-column label="分值" width="90">
            <template #default="{ row }">{{ row.score || 10 }}</template>
          </el-table-column>
        </el-table>
        <div class="pagination-wrapper">
          <el-pagination
            v-model:current-page="questionPagination.page"
            v-model:page-size="questionPagination.pageSize"
            :page-sizes="[10, 20, 50, 100]"
            :total="questionPagination.total"
            layout="total, sizes, prev, pager, next, jumper"
            @current-change="handleQuestionPageChange"
            @size-change="handleQuestionSizeChange"
          />
        </div>
      </template>

      <template v-else>
        <el-form :model="directForm" label-width="90" class="direct-form wabi-form">
          <el-form-item label="题型">
            <el-select v-model="directForm.type" style="width: 180px">
              <el-option label="填空题" :value="1" />
              <el-option label="选择题" :value="2" />
              <el-option label="解答题" :value="5" />
              <el-option label="编程题" :value="6" />
            </el-select>
          </el-form-item>
          <el-form-item label="题目内容">
            <el-input v-model="directForm.question" type="textarea" :rows="4" />
          </el-form-item>
          <el-form-item label="分值">
            <el-input-number v-model="directForm.score" :min="1" :max="100" />
          </el-form-item>
          <el-form-item label="答案解析">
            <el-input v-model="directForm.analysis" type="textarea" :rows="2" />
          </el-form-item>

          <template v-if="directForm.type === 1 || directForm.type === 5">
            <el-form-item :label="directForm.type === 1 ? '标准答案' : '参考答案'">
              <el-input v-model="directForm.answer" type="textarea" :rows="3" />
            </el-form-item>
          </template>

          <template v-if="directForm.type === 2">
            <el-form-item label="选项配置">
              <div class="choice-editor">
                <div v-for="(item, idx) in choiceOptions" :key="`${item.key}-${idx}`" class="choice-row">
                  <el-input v-model="item.key" style="width: 90px" />
                  <el-input v-model="item.content" />
                  <el-button type="danger" plain :disabled="choiceOptions.length <= 2" @click="removeChoiceOption(idx)">删除</el-button>
                </div>
                <el-button type="primary" plain @click="addChoiceOption">添加选项</el-button>
              </div>
            </el-form-item>
            <el-form-item label="正确答案">
              <el-radio-group v-model="choiceAnswer">
                <el-radio v-for="opt in validChoiceOptions" :key="opt.key" :value="opt.key">{{ opt.key }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </template>

          <template v-if="directForm.type === 6">
            <el-form-item label="默认语言">
              <el-select v-model="directForm.programmingLanguage" style="width: 140px">
                <el-option label="Java" value="java" />
                <el-option label="C" value="c" />
              </el-select>
            </el-form-item>
            <el-form-item label="测试点">
              <div class="test-cases-section">
                <div v-for="(tc, idx) in directTestCases" :key="idx" class="test-case-item">
                  <div class="test-case-title">
                    <span>测试点 {{ idx + 1 }}</span>
                    <el-button type="danger" plain :disabled="directTestCases.length <= 1" @click="removeTestCase(idx)">删除</el-button>
                  </div>
                  <el-input v-model="tc.input" type="textarea" :rows="2" placeholder="输入（可空）" />
                  <el-input v-model="tc.expectedOutput" type="textarea" :rows="2" placeholder="期望输出" style="margin-top: 8px" />
                  <div class="test-case-foot">
                    <span>权重</span>
                    <el-input-number v-model="tc.scoreWeight" :min="1" :max="100" />
                  </div>
                </div>
                <el-button type="primary" plain @click="addTestCase">添加测试点</el-button>
              </div>
            </el-form-item>
          </template>
        </el-form>
        <div class="direct-action">
          <el-button type="success" class="wabi-btn-primary" :loading="creatingQuestion" @click="createAndAddQuestion">创建并加入作业</el-button>
        </div>
      </template>

      <div class="current-questions" v-if="currentHomeworkQuestions.length > 0">
        <h4>当前作业题目</h4>
        <el-table :data="currentHomeworkQuestions" stripe size="small" height="220" class="wabi-table">
          <el-table-column prop="id" label="ID" min-width="80" />
          <el-table-column label="类型" width="100">
            <template #default="{ row }"><el-tag>{{ getTypeName(row.type) }}</el-tag></template>
          </el-table-column>
          <el-table-column label="题目内容" min-width="280">
            <template #default="{ row }">{{ shortText(row.question, 100) }}</template>
          </el-table-column>
          <el-table-column label="分值" width="90">
            <template #default="{ row }">{{ row.score ?? '-' }}</template>
          </el-table-column>
          <el-table-column label="操作" width="100">
            <template #default="{ row }"><el-button type="danger" size="small" @click="removeQuestion(row.id)">移除</el-button></template>
          </el-table-column>
        </el-table>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search } from '@element-plus/icons-vue'
import { teacherApi } from '@/api'

const homeworkApi = teacherApi.homework

// 基础状态
const loading = ref(false)
const submitting = ref(false)
const creatingQuestion = ref(false)
const homeworkList = ref([])
const searchQuery = ref('')
const isEdit = ref(false)
const formRef = ref(null)
const currentFile = ref(null)

// 新增/编辑对话框
const dialogVisible = ref(false)
const dialogTitle = computed(() => (isEdit.value ? '编辑作业' : '新增作业'))
const formData = reactive({
  homeworkId: null,
  homeworkName: '',
  content: '',
  deadline: null,
  totalScore: 100,
  filePath: '',
  fileSize: null,
  state: 1
})

const formRules = {
  homeworkName: [{ required: true, message: '请输入作业名称', trigger: 'blur' }]
}

// 提交批改相关
const submissionDialogVisible = ref(false)
const currentHomeworkId = ref(null)
const submissionList = ref([])
const activeSubmissionId = ref(null)

// 按题批改相关
const gradingDialogVisible = ref(false)
const gradingLoading = ref(false)
const savingQuestionId = ref(null)
const onlyManualPending = ref(true)
const gradingItems = ref([])
const gradingStudent = reactive({ studentId: null, studentName: '' })

// 题目管理相关
const questionDialogVisible = ref(false)
const questionAddMode = ref('bank')
const questionType = ref(null)
const availableQuestions = ref([])
const selectedQuestions = ref([])
const currentHomeworkQuestions = ref([])

// 题库分页
const questionPagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

// 手动创建题目表单
const directForm = reactive({
  type: 1,
  question: '',
  answer: '',
  analysis: '',
  score: 10,
  state: 1,
  programmingLanguage: 'java'
})
const choiceOptions = ref([{ key: 'A', content: '' }, { key: 'B', content: '' }])
const choiceAnswer = ref('A')
const directTestCases = ref([{ input: '', expectedOutput: '', scoreWeight: 1 }])

// 分页
const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

// 计算属性
const activeCount = computed(() => homeworkList.value.filter(h => h.state === 1).length)
const overdueCount = computed(() => homeworkList.value.filter(h => isOverdue(h.deadline)).length)
const avgScore = computed(() => {
  if (!homeworkList.value.length) return 0
  const sum = homeworkList.value.reduce((acc, h) => acc + (h.totalScore || 0), 0)
  return Math.round(sum / homeworkList.value.length)
})
const activeSubmission = computed(() => submissionList.value.find((x) => x.id === activeSubmissionId.value) || null)
const validChoiceOptions = computed(() => choiceOptions.value.filter((item) => item.key && item.content && String(item.key).trim()))

const manualTypes = new Set([5, 7])
const typeMap = { 1: '填空题', 2: '选择题', 5: '解答题', 6: '编程题' }

const displayGradingItems = computed(() => {
  if (!onlyManualPending.value) return gradingItems.value
  return gradingItems.value.filter((item) => isManualType(item.type) && !item.graded)
})

// 工具函数
const formatDate = (date) => {
  if (!date) return '未设置'
  return new Date(date).toLocaleString('zh-CN')
}

const isOverdue = (deadline) => {
  if (!deadline) return false
  return new Date(deadline) < new Date()
}

const shortText = (text, length = 100) => {
  if (!text) return '-'
  return text.length > length ? `${text.slice(0, length)}...` : text
}

const getTypeName = (type) => typeMap[type] || `类型${type || '-'}`

const isManualType = (type) => manualTypes.has(type)

// 作业列表加载
const loadHomeworkList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize,
      keyword: searchQuery.value || undefined
    }
    const res = await homeworkApi.list(params)
    homeworkList.value = res.data?.list || res.data || []
    pagination.total = res.data?.total || homeworkList.value.length
  } catch (error) {
    console.error('加载作业列表失败:', error)
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadHomeworkList()
}

// 新增/编辑
const resetForm = () => {
  Object.assign(formData, {
    homeworkId: null,
    homeworkName: '',
    content: '',
    deadline: null,
    totalScore: 100,
    filePath: '',
    fileSize: null,
    state: 1
  })
  currentFile.value = null
}

const handleAdd = () => {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
}

const handleEdit = (row) => {
  Object.assign(formData, {
    homeworkId: row.homeworkId,
    homeworkName: row.homeworkName,
    content: row.content,
    deadline: row.deadline,
    totalScore: row.totalScore || 100,
    filePath: row.filePath,
    fileSize: row.fileSize,
    state: row.state
  })
  isEdit.value = true
  dialogVisible.value = true
}

const handleFileChange = (file) => { currentFile.value = file.raw }
const handleFileRemove = () => { currentFile.value = null }

const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    submitting.value = true
    let filePath = formData.filePath
    if (currentFile.value) {
      const uploadRes = await homeworkApi.upload(currentFile.value)
      if (uploadRes.data) {
        filePath = uploadRes.data
        formData.fileSize = currentFile.value.size
      }
    }
    const data = { ...formData, filePath }
    if (isEdit.value) {
      await homeworkApi.update(formData.homeworkId, data)
      ElMessage.success('更新成功')
    } else {
      await homeworkApi.add(data)
      ElMessage.success('新增成功')
    }
    dialogVisible.value = false
    loadHomeworkList()
  } catch (error) {
    if (error !== false) ElMessage.error('操作失败')
  } finally {
    submitting.value = false
  }
}

const handleDelete = async (row) => {
  try {
    await ElMessageBox.confirm(`确认删除作业 "${row.homeworkName}" 吗？`, '提示', { type: 'warning' })
    await homeworkApi.delete(row.homeworkId)
    ElMessage.success('删除成功')
    loadHomeworkList()
  } catch {
    // 取消操作
  }
}

// 提交批改
const handleSubmissions = async (row) => {
  currentHomeworkId.value = row.homeworkId
  submissionDialogVisible.value = true
  try {
    const res = await homeworkApi.getSubmissions(row.homeworkId)
    submissionList.value = res.data || []
    activeSubmissionId.value = submissionList.value[0]?.id || null
  } catch {
    ElMessage.error('加载提交列表失败')
  }
}

const selectSubmission = (id) => { activeSubmissionId.value = id }

const saveScore = async (row) => {
  try {
    await homeworkApi.scoreSubmission(row.id, { score: row.score, remark: row.remark })
    ElMessage.success('评分成功')
  } catch {
    ElMessage.error('评分失败')
  }
}

const handleDownload = (row) => {
  window.open(`/teacher/homework/submission/download/${row.id}`, '_blank')
}

// 按题批改
const loadStudentQuestionAnswers = async (homeworkId, studentId) => {
  const res = await homeworkApi.getStudentAnswers(homeworkId, studentId)
  const raw = res.data || []
  gradingItems.value = raw.map((item) => ({ ...item, editScore: item.score ?? 0 }))
}

const openQuestionGrading = async (submissionRow) => {
  if (!currentHomeworkId.value) currentHomeworkId.value = submissionRow.homeworkId
  gradingStudent.studentId = submissionRow.studentId
  gradingStudent.studentName = submissionRow.studentName
  gradingDialogVisible.value = true
  gradingLoading.value = true
  try {
    await loadStudentQuestionAnswers(currentHomeworkId.value, submissionRow.studentId)
  } catch {
    ElMessage.error('加载按题批改数据失败')
  } finally {
    gradingLoading.value = false
  }
}

const saveQuestionGrade = async (row) => {
  const maxScore = row.maxScore ?? 100
  const score = Number(row.editScore)
  if (Number.isNaN(score) || score < 0 || score > maxScore) {
    ElMessage.warning(`分数范围应为 0-${maxScore}`)
    return
  }
  savingQuestionId.value = row.questionId
  try {
    await homeworkApi.scoreStudentQuestion(currentHomeworkId.value, gradingStudent.studentId, row.questionId, score)
    ElMessage.success('该题评分已保存')
    await loadStudentQuestionAnswers(currentHomeworkId.value, gradingStudent.studentId)
    const subRes = await homeworkApi.getSubmissions(currentHomeworkId.value)
    submissionList.value = subRes.data || []
  } catch {
    ElMessage.error('保存失败')
  } finally {
    savingQuestionId.value = null
  }
}

// 题目管理
const handleQuestions = async (row) => {
  currentHomeworkId.value = row.homeworkId
  questionAddMode.value = 'bank'
  selectedQuestions.value = []
  questionPagination.page = 1
  questionDialogVisible.value = true
  resetDirectForm()
  await loadCurrentQuestions()
  await loadAvailableQuestions()
}

const loadCurrentQuestions = async () => {
  try {
    const res = await homeworkApi.getQuestions(currentHomeworkId.value)
    currentHomeworkQuestions.value = (res.data || []).filter((q) => [1, 2, 5, 6].includes(q.type))
  } catch {
    ElMessage.error('加载当前作业题目失败')
  }
}

const loadAvailableQuestions = async () => {
  try {
    const params = {
      page: questionPagination.page,
      pageSize: questionPagination.pageSize
    }
    if (questionType.value) {
      params.type = questionType.value
    }
    const res = await homeworkApi.getAvailableQuestions(params)
    const data = res.data
    if (data && data.list) {
      availableQuestions.value = (data.list || []).filter((q) => [1, 2, 5, 6].includes(q.type))
      questionPagination.total = data.total || 0
    } else {
      availableQuestions.value = (res.data || []).filter((q) => [1, 2, 5, 6].includes(q.type))
      questionPagination.total = availableQuestions.value.length
    }
  } catch {
    ElMessage.error('加载题库失败')
  }
}

const handleQuestionPageChange = (page) => {
  questionPagination.page = page
  loadAvailableQuestions()
}

const handleQuestionSizeChange = (size) => {
  questionPagination.pageSize = size
  questionPagination.page = 1
  loadAvailableQuestions()
}

const handleQuestionSelectionChange = (selection) => { selectedQuestions.value = selection }

const confirmAddQuestions = async () => {
  if (!selectedQuestions.value.length) return
  try {
    const questionIds = selectedQuestions.value.map((q) => q.id)
    await homeworkApi.addQuestions(currentHomeworkId.value, questionIds)
    ElMessage.success('添加成功')
    selectedQuestions.value = []
    await loadCurrentQuestions()
  } catch {
    ElMessage.error('添加失败')
  }
}

const removeQuestion = async (questionId) => {
  try {
    await homeworkApi.removeQuestion(currentHomeworkId.value, questionId)
    ElMessage.success('移除成功')
    await loadCurrentQuestions()
  } catch {
    ElMessage.error('移除失败')
  }
}

// 手动创建题目
const resetDirectForm = () => {
  Object.assign(directForm, {
    type: 1,
    question: '',
    answer: '',
    analysis: '',
    score: 10,
    state: 1,
    programmingLanguage: 'java'
  })
  choiceOptions.value = [{ key: 'A', content: '' }, { key: 'B', content: '' }]
  choiceAnswer.value = 'A'
  directTestCases.value = [{ input: '', expectedOutput: '', scoreWeight: 1 }]
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
  if (removed?.key === choiceAnswer.value) {
    choiceAnswer.value = choiceOptions.value[0]?.key || ''
  }
}

const addTestCase = () => { directTestCases.value.push({ input: '', expectedOutput: '', scoreWeight: 1 }) }
const removeTestCase = (index) => { if (directTestCases.value.length > 1) directTestCases.value.splice(index, 1) }

const resolveCreatedQuestionId = async (addRes, payload) => {
  const rawData = addRes?.data
  if (typeof rawData === 'number') return rawData
  if (rawData?.id) return rawData.id
  if (rawData?.questionId) return rawData.questionId
  const normalized = (s) => String(s || '').replace(/\s+/g, ' ').trim()
  const keyword = normalized(payload.question).slice(0, 48)
  for (let attempt = 0; attempt < 3; attempt++) {
    const listRes = await teacherApi.question.list({ page: 1, pageSize: 100, type: payload.type, keyword })
    const list = listRes.data?.list || []
    if (list.length === 0) {
      await new Promise((r) => setTimeout(r, 200))
      continue
    }
    const target = normalized(payload.question)
    const exact = list.find((item) => item?.type === payload.type && normalized(item?.question) === target)
    if (exact?.id) return exact.id
    if (list[0]?.id) return list[0].id
  }
  return null
}

const createAndAddQuestion = async () => {
  if (!currentHomeworkId.value) return
  if (!directForm.question || !directForm.question.trim()) {
    ElMessage.warning('请先填写题目内容')
    return
  }
  if (directForm.type === 1 && (!directForm.answer || !directForm.answer.trim())) {
    ElMessage.warning('填空题必须填写标准答案')
    return
  }

  const payload = {
    type: directForm.type,
    question: directForm.question.trim(),
    score: directForm.score || 10,
    analysis: directForm.analysis || '',
    answer: directForm.answer || '',
    options: '',
    state: 1
  }

  if (directForm.type === 2) {
    const optionsObj = {}
    validChoiceOptions.value.forEach((item) => { optionsObj[String(item.key).trim()] = item.content })
    if (Object.keys(optionsObj).length < 2) {
      ElMessage.warning('选择题至少需要两个有效选项')
      return
    }
    if (!optionsObj[choiceAnswer.value]) {
      ElMessage.warning('请选择正确答案')
      return
    }
    payload.options = JSON.stringify(optionsObj)
    payload.answer = choiceAnswer.value
  }

  if (directForm.type === 6) {
    const validCases = directTestCases.value
      .map((tc, idx) => ({ input: tc.input || '', expectedOutput: tc.expectedOutput || '', scoreWeight: tc.scoreWeight || 1, sortIndex: idx }))
      .filter((tc) => tc.expectedOutput.trim() !== '')
    if (!validCases.length) {
      ElMessage.warning('编程题至少需要一个测试点')
      return
    }
    payload.options = JSON.stringify({ defaultLanguage: directForm.programmingLanguage })
    payload.answer = ''
    creatingQuestion.value = true
    try {
      const addRes = await teacherApi.question.add(payload)
      const questionId = await resolveCreatedQuestionId(addRes, payload)
      if (!questionId) {
        ElMessage.warning('题目已创建，但未拿到ID，请从题库模式手动添加')
        questionAddMode.value = 'bank'
        questionType.value = payload.type
        await loadAvailableQuestions()
        await loadCurrentQuestions()
        return
      }
      await teacherApi.question.saveTestCases(questionId, validCases)
      await homeworkApi.addQuestions(currentHomeworkId.value, [questionId])
      ElMessage.success('编程题创建并加入成功')
      resetDirectForm()
      await loadCurrentQuestions()
      await loadAvailableQuestions()
    } catch (error) {
      ElMessage.error(error?.message || '创建编程题失败')
    } finally {
      creatingQuestion.value = false
    }
    return
  }

  if (directForm.type === 5) {
    payload.answer = directForm.answer || ''
    payload.options = ''
  }

  creatingQuestion.value = true
  try {
    const addRes = await teacherApi.question.add(payload)
    const questionId = await resolveCreatedQuestionId(addRes, payload)
    if (!questionId) {
      ElMessage.warning('题目已创建，但未拿到ID，请从题库模式手动添加')
      questionAddMode.value = 'bank'
      questionType.value = payload.type
      await loadAvailableQuestions()
      await loadCurrentQuestions()
      return
    }
    await homeworkApi.addQuestions(currentHomeworkId.value, [questionId])
    ElMessage.success('题目创建并加入成功')
    resetDirectForm()
    await loadCurrentQuestions()
    await loadAvailableQuestions()
  } catch (error) {
    ElMessage.error(error?.message || '创建题目失败')
  } finally {
    creatingQuestion.value = false
  }
}

onMounted(() => loadHomeworkList())
</script>

<style scoped>
.homework-page {
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

.wabi-search {
  width: 200px;
}

/* 统计卡片 */
.stats-grid {
  flex-shrink: 0;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
  margin-bottom: 20px;
}

.stat-card {
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: var(--wabi-radius, 3px);
  padding: 16px;
  text-align: center;
}

.stat-value {
  font-size: 24px;
  font-weight: 500;
  color: var(--wabi-accent, #7a8b6f);
}

.stat-label {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-top: 4px;
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

/* 作业列表 */
.homework-list {
  display: flex;
  flex-direction: column;
}

.homework-item {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 16px 20px;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
  transition: background 0.2s ease;
}

.homework-item:hover {
  background: var(--wabi-accent-light, #e8ede5);
}

.homework-item:last-child {
  border-bottom: none;
}

.homework-info {
  flex: 1;
  min-width: 0;
}

.homework-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.homework-name {
  font-size: 15px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
}

.homework-desc {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-bottom: 4px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.homework-meta {
  display: flex;
  gap: 16px;
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.homework-meta .overdue {
  color: #c47c7c;
}

.homework-actions {
  flex-shrink: 0;
  display: flex;
  gap: 4px;
  margin-left: 16px;
}

/* 题目管理 */
.questions-header {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 20px;
}

.question-mode {
  margin-bottom: 20px;
}

.question-toolbar {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 20px;
  padding: 12px 16px;
  background: var(--wabi-surface-warm, #faf9f7);
  border-radius: 6px;
}

.pagination-wrapper {
  display: flex;
  justify-content: center;
  margin-top: 16px;
  padding: 12px 0;
}

.current-questions {
  margin-top: 24px;
  padding-top: 20px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
}

.current-questions h4 {
  font-size: 14px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0 0 12px 0;
}

.direct-form {
  margin-bottom: 20px;
}

.direct-form .el-form-item {
  margin-bottom: 18px;
}

.direct-action {
  display: flex;
  justify-content: center;
  margin-top: 20px;
  padding-top: 16px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
}

.choice-editor {
  width: 100%;
}

.choice-row {
  display: flex;
  gap: 10px;
  margin-bottom: 10px;
  align-items: center;
}

.test-cases-section {
  width: 100%;
}

.test-case-item {
  padding: 14px;
  margin-bottom: 14px;
  background: var(--wabi-surface-warm, #faf9f7);
  border-radius: 6px;
  border: 1px solid var(--wabi-border, #e8e4df);
}

.test-case-title {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
  font-size: 13px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
}

.test-case-foot {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-top: 10px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 不换行单元格 */
.nowrap-cell {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
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

  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .homework-item {
    flex-direction: column;
  }

  .homework-actions {
    margin-left: 0;
    margin-top: 12px;
  }
}
</style>
