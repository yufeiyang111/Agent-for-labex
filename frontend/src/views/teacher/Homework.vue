<template>
  <div class="homework-page">
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/teacher' }">教师首页</el-breadcrumb-item>
      <el-breadcrumb-item>作业管理</el-breadcrumb-item>
    </el-breadcrumb>

    <section class="hero">
      <div>
        <h2>作业工作台</h2>
        <p>作业发布、题目配置、提交批改一体化处理。</p>
      </div>
      <div class="hero-actions">
        <el-input v-model="searchQuery" placeholder="搜索作业名称" clearable class="search-input" @clear="handleSearch" @keyup.enter="handleSearch">
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
        <el-button type="primary" @click="handleSearch">搜索</el-button>
        <el-button type="success" @click="handleAdd">
          <el-icon><Plus /></el-icon> 新增作业
        </el-button>
      </div>
    </section>

    <section class="stats-grid">
      <el-card shadow="never" class="stat-card"><div class="stat-title">作业总数</div><div class="stat-value">{{ pagination.total }}</div></el-card>
      <el-card shadow="never" class="stat-card"><div class="stat-title">已启用</div><div class="stat-value">{{ activeCount }}</div></el-card>
      <el-card shadow="never" class="stat-card"><div class="stat-title">已过期</div><div class="stat-value">{{ overdueCount }}</div></el-card>
      <el-card shadow="never" class="stat-card"><div class="stat-title">平均总分</div><div class="stat-value">{{ avgScore }}</div></el-card>
    </section>

    <section v-loading="loading">
      <div class="list-header" v-if="displayedHomework.length">
        <span class="list-count">共 {{ displayedHomework.length }} / {{ pagination.total }} 个作业</span>
      </div>
      <el-empty v-if="displayedHomework.length === 0" description="暂无作业" />
      <div v-else class="homework-grid" ref="homeworkGridRef" @scroll="handleHomeworkScroll">
        <el-card v-for="row in displayedHomework" :key="row.homeworkId" class="homework-card" shadow="hover">
          <div class="card-top">
            <div class="title">{{ row.homeworkName }}</div>
            <el-tag :type="row.state === 1 ? 'success' : 'info'" effect="plain">{{ row.state === 1 ? '启用' : '禁用' }}</el-tag>
          </div>
          <div class="desc">{{ row.content || '暂无作业内容' }}</div>
          <div class="meta-list">
            <div>截止：<span :class="{ overdue: isOverdue(row.deadline) }">{{ formatDate(row.deadline) }}</span></div>
            <div>总分：{{ row.totalScore || 100 }}</div>
            <div>附件：{{ row.filePath ? '有' : '无' }}</div>
          </div>
          <div class="actions">
            <el-button type="primary" plain size="small" @click="handleEdit(row)">编辑</el-button>
            <el-button type="warning" plain size="small" @click="handleQuestions(row)">题目</el-button>
            <el-button type="success" plain size="small" @click="handleSubmissions(row)">批改</el-button>
            <el-button type="danger" plain size="small" @click="handleDelete(row)">删除</el-button>
          </div>
        </el-card>
        <div v-if="loadingMore" class="loading-more">
          <el-icon class="is-loading"><Loading /></el-icon>
          <span>加载中...</span>
        </div>
        <div v-if="!pagination.hasMore && displayedHomework.length > 0" class="no-more-data">
          已加载全部 {{ displayedHomework.length }} 个作业
        </div>
      </div>
    </section>

    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="620px">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="92px">
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
          <el-input-number v-model="formData.totalScore" :min="1" :max="1000" />
        </el-form-item>
        <el-form-item label="上传附件">
          <el-upload :auto-upload="false" :limit="1" :on-change="handleFileChange" :on-remove="handleFileRemove" accept=".pdf,.doc,.docx,.zip">
            <template #trigger><el-button type="primary">选择文件</el-button></template>
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
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="submitting" @click="handleSubmit">保存</el-button>
      </template>
    </el-dialog>

    <el-dialog v-model="submissionDialogVisible" title="提交批改" width="1160px">
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
            <el-form label-width="86px" class="score-form">
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
              <el-button type="success" @click="saveScore(activeSubmission)">保存评分</el-button>
            </div>
          </template>
          <el-empty v-else description="请选择一条提交" />
        </div>
      </div>
    </el-dialog>

    <el-dialog v-model="gradingDialogVisible" title="按题批改" width="1080px" destroy-on-close>
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
            <el-button type="primary" :loading="savingQuestionId === row.questionId" @click="saveQuestionGrade(row)">保存该题</el-button>
          </div>
          <div class="g-action" v-else>
            <el-tag type="info">自动判分题</el-tag>
          </div>
        </el-card>
      </el-scrollbar>
    </el-dialog>

    <el-dialog v-model="questionDialogVisible" title="作业题目管理" width="1080px" destroy-on-close>
      <div class="question-mode">
        <el-radio-group v-model="questionAddMode">
          <el-radio-button label="bank">从题库添加</el-radio-button>
          <el-radio-button label="direct">直接添加</el-radio-button>
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
          <el-button type="primary" @click="loadAvailableQuestions">筛选</el-button>
          <el-button type="success" :disabled="selectedQuestions.length === 0" @click="confirmAddQuestions">
            添加选中（{{ selectedQuestions.length }}）
          </el-button>
        </div>
        <el-table :data="availableQuestions" @selection-change="handleQuestionSelectionChange" stripe height="360">
          <el-table-column type="selection" width="55" />
          <el-table-column prop="id" label="ID" width="80" />
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
        <el-form :model="directForm" label-width="90px" class="direct-form">
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
            <el-form-item :value="directForm.type === 1 ? '标准答案' : '参考答案'">
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
          <el-button type="success" :loading="creatingQuestion" @click="createAndAddQuestion">创建并加入作业</el-button>
        </div>
      </template>

      <div class="current-questions" v-if="currentHomeworkQuestions.length > 0">
        <h4>当前作业题目</h4>
        <el-table :data="currentHomeworkQuestions" stripe size="small" height="220">
          <el-table-column prop="id" label="ID" width="80" />
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
import { computed, onMounted, reactive, ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Search, Plus, Loading } from '@element-plus/icons-vue'
import { teacherApi } from '@/api/index.js'

const loading = ref(false)
const loadingMore = ref(false)
const submitting = ref(false)
const creatingQuestion = ref(false)
const homeworkList = ref([])
const displayedHomework = ref([])
const dialogVisible = ref(false)
const submissionDialogVisible = ref(false)
const isEdit = ref(false)
const formRef = ref(null)
const searchQuery = ref('')
const currentFile = ref(null)
const currentHomeworkId = ref(null)
const submissionList = ref([])
const activeSubmissionId = ref(null)
const homeworkGridRef = ref(null)

const gradingDialogVisible = ref(false)
const gradingLoading = ref(false)
const savingQuestionId = ref(null)
const onlyManualPending = ref(true)
const gradingItems = ref([])
const gradingStudent = reactive({ studentId: null, studentName: '' })

const questionDialogVisible = ref(false)
const questionAddMode = ref('bank')
const questionType = ref(null)
const availableQuestions = ref([])
const selectedQuestions = ref([])
const currentHomeworkQuestions = ref([])

// 分页相关
const questionPagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const INITIAL_HOMEWORK_COUNT = 12
const LOAD_MORE_HOMEWORK_COUNT = 8
const pagination = reactive({ page: 1, pageSize: INITIAL_HOMEWORK_COUNT, total: 0, hasMore: true })
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

const dialogTitle = computed(() => (isEdit.value ? '编辑作业' : '新增作业'))
const validChoiceOptions = computed(() => choiceOptions.value.filter((item) => item.key && item.content && String(item.key).trim()))
const activeSubmission = computed(() => submissionList.value.find((x) => x.id === activeSubmissionId.value) || null)
const activeCount = computed(() => homeworkList.value.filter((h) => h.state === 1).length)
const overdueCount = computed(() => homeworkList.value.filter((h) => isOverdue(h.deadline)).length)
const avgScore = computed(() => {
  if (!homeworkList.value.length) return 0
  const total = homeworkList.value.reduce((sum, h) => sum + (h.totalScore || 100), 0)
  return Math.round(total / homeworkList.value.length)
})

const objectiveTypes = new Set([1, 2])
const manualTypes = new Set([5, 7])
const typeMap = { 1: '填空题', 2: '选择题', 5: '解答题', 6: '编程题' }

const displayGradingItems = computed(() => {
  if (!onlyManualPending.value) return gradingItems.value
  return gradingItems.value.filter((item) => isManualType(item.type) && !item.graded)
})

const formatDate = (date) => (date ? new Date(date).toLocaleString('zh-CN') : '-')
const isOverdue = (deadline) => !!deadline && new Date(deadline) < new Date()
const shortText = (text, length = 100) => (!text ? '-' : (text.length > length ? `${text.slice(0, length)}...` : text))
const getTypeName = (type) => typeMap[type] || `类型${type || '-'}`
const isManualType = (type) => manualTypes.has(type)

const loadHomeworkList = async () => {
  loading.value = true
  try {
    const params = { page: pagination.page, pageSize: pagination.pageSize }
    if (searchQuery.value) params.name = searchQuery.value
    const response = await teacherApi.homework.list(params)
    homeworkList.value = response.data?.list || []
    pagination.total = response.data?.total || 0
    displayedHomework.value = homeworkList.value.slice(0, INITIAL_HOMEWORK_COUNT)
    pagination.hasMore = displayedHomework.value.length < homeworkList.value.length
  } catch {
    ElMessage.error('加载作业列表失败')
  } finally {
    loading.value = false
  }
}

const loadMoreHomework = () => {
  if (loadingMore.value || !pagination.hasMore) return
  loadingMore.value = true
  setTimeout(() => {
    const start = displayedHomework.value.length
    const end = start + LOAD_MORE_HOMEWORK_COUNT
    displayedHomework.value.push(...homeworkList.value.slice(start, end))
    pagination.hasMore = displayedHomework.value.length < homeworkList.value.length
    loadingMore.value = false
  }, 300)
}

const handleHomeworkScroll = (e) => {
  const { scrollTop, scrollHeight, clientHeight } = e.target
  if (scrollHeight - scrollTop - clientHeight < 80) {
    loadMoreHomework()
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadHomeworkList()
}

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
      const uploadRes = await teacherApi.homework.upload(currentFile.value)
      if (uploadRes.data) {
        filePath = uploadRes.data
        formData.fileSize = currentFile.value.size
      }
    }
    const data = { ...formData, filePath }
    if (isEdit.value) {
      await teacherApi.homework.update(formData.homeworkId, data)
      ElMessage.success('更新成功')
    } else {
      await teacherApi.homework.add(data)
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

const handleDelete = (row) => {
  ElMessageBox.confirm(`确认删除作业 "${row.homeworkName}" 吗？`, '提示', { type: 'warning' })
    .then(async () => {
      try {
        await teacherApi.homework.delete(row.homeworkId)
        ElMessage.success('删除成功')
        loadHomeworkList()
      } catch {
        ElMessage.error('删除失败')
      }
    })
    .catch(() => {})
}

const handleSubmissions = async (row) => {
  currentHomeworkId.value = row.homeworkId
  submissionDialogVisible.value = true
  try {
    const res = await teacherApi.homework.getSubmissions(row.homeworkId)
    submissionList.value = res.data || []
    activeSubmissionId.value = submissionList.value[0]?.id || null
  } catch {
    ElMessage.error('加载提交列表失败')
  }
}

const selectSubmission = (id) => { activeSubmissionId.value = id }

const loadStudentQuestionAnswers = async (homeworkId, studentId) => {
  const res = await teacherApi.homework.getStudentAnswers(homeworkId, studentId)
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
    await teacherApi.homework.scoreStudentQuestion(currentHomeworkId.value, gradingStudent.studentId, row.questionId, score)
    ElMessage.success('该题评分已保存')
    await loadStudentQuestionAnswers(currentHomeworkId.value, gradingStudent.studentId)
    const subRes = await teacherApi.homework.getSubmissions(currentHomeworkId.value)
    submissionList.value = subRes.data || []
  } catch {
    ElMessage.error('保存失败')
  } finally {
    savingQuestionId.value = null
  }
}

const saveScore = async (row) => {
  try {
    await teacherApi.homework.scoreSubmission(row.id, { score: row.score, remark: row.remark })
    ElMessage.success('评分成功')
  } catch {
    ElMessage.error('评分失败')
  }
}

const handleDownload = (row) => {
  window.open(`/teacher/homework/submission/download/${row.id}`, '_blank')
}

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
    const res = await teacherApi.homework.getQuestions(currentHomeworkId.value)
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
    const res = await teacherApi.homework.getAvailableQuestions(params)
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
    await teacherApi.homework.addQuestions(currentHomeworkId.value, questionIds)
    ElMessage.success('添加成功')
    selectedQuestions.value = []
    await loadCurrentQuestions()
  } catch {
    ElMessage.error('添加失败')
  }
}

const removeQuestion = async (questionId) => {
  try {
    await teacherApi.homework.removeQuestion(currentHomeworkId.value, questionId)
    ElMessage.success('移除成功')
    await loadCurrentQuestions()
  } catch {
    ElMessage.error('移除失败')
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
  if (objectiveTypes.has(directForm.type) && directForm.type === 1 && (!directForm.answer || !directForm.answer.trim())) {
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
      await teacherApi.homework.addQuestions(currentHomeworkId.value, [questionId])
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
    await teacherApi.homework.addQuestions(currentHomeworkId.value, [questionId])
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

onMounted(loadHomeworkList)
</script>

<style scoped>
.homework-page { padding: 20px; }
.breadcrumb { margin-bottom: 16px; }
.hero { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 12px; gap: 10px; }
.hero h2 { margin: 0; font-size: 26px; color: #111827; }
.hero p { margin: 6px 0 0; color: #6b7280; font-size: 13px; }
.hero-actions { display: flex; gap: 8px; align-items: center; }
.search-input { width: 260px; }

.stats-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 10px; margin-bottom: 14px; }
.stat-card { border: 1px solid #e5e7eb; border-radius: 10px; }
.stat-title { font-size: 12px; color: #6b7280; }
.stat-value { margin-top: 4px; font-size: 24px; font-weight: 700; color: #111827; }

.homework-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 14px;
  max-height: calc(100vh - 380px);
  overflow-y: auto;
  scrollbar-width: thin;
}
.homework-card {
  border-radius: 14px;
  border: 1px solid #e5e7eb;
  transition: all 0.25s cubic-bezier(0.25, 0.1, 0.25, 1);
}
.homework-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 28px rgba(0, 0, 0, 0.1);
}
.card-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
.title { font-size: 15px; font-weight: 700; color: #111827; }
.desc { min-height: 40px; color: #4b5563; font-size: 13px; margin-bottom: 10px; line-height: 1.5; }
.meta-list { display: flex; flex-direction: column; gap: 4px; margin-bottom: 10px; color: #374151; font-size: 13px; }
.overdue { color: #dc2626; font-weight: 700; }
.actions { display: flex; gap: 8px; flex-wrap: wrap; }

.list-header {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 12px;
}
.list-count {
  font-size: 13px;
  color: #9ca3af;
}

.loading-more,
.no-more-data {
  grid-column: 1 / -1;
  padding: 16px;
  text-align: center;
  color: #9ca3af;
  font-size: 13px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}
.loading-more .el-icon { font-size: 18px; }

@media (max-width: 1200px) {
  .homework-grid { grid-template-columns: repeat(3, 1fr); }
}
@media (max-width: 900px) {
  .homework-grid { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 600px) {
  .homework-grid { grid-template-columns: 1fr; }
}

.submission-layout { display: grid; grid-template-columns: 320px 1fr; gap: 12px; }
.submission-left, .submission-right {
  border: 1px solid #e5e7eb;
  border-radius: 10px;
  padding: 10px;
}
.submission-left h4, .submission-right h4, .current-questions h4 { margin: 0 0 8px; color: #111827; }
.submission-item {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 8px;
  margin-bottom: 8px;
  background: #f9fafb;
  cursor: pointer;
}
.submission-item.active { border-color: #3b82f6; background: #eff6ff; }
.line-1 { display: flex; justify-content: space-between; align-items: center; margin-bottom: 4px; }
.line-2, .line-3 { color: #6b7280; font-size: 12px; }
.detail-head { display: flex; gap: 12px; color: #374151; margin-bottom: 10px; }
.detail-actions { display: flex; gap: 8px; }
.empty-hint { color: #9ca3af; padding: 14px 6px; }

.grading-toolbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
.grading-card { border: 1px solid #e5e7eb; margin-bottom: 10px; }
.g-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
.g-index { margin-left: 8px; color: #374151; }
.g-score { color: #6b7280; font-size: 13px; }
.g-question { background: #f9fafb; border-radius: 6px; padding: 8px; margin-bottom: 8px; color: #111827; line-height: 1.6; white-space: pre-wrap; }
.g-answer { border: 1px dashed #d1d5db; border-radius: 6px; padding: 8px; margin-bottom: 8px; }
.g-answer .label { color: #6b7280; font-size: 12px; margin-bottom: 4px; }
.g-answer .value { color: #111827; white-space: pre-wrap; word-break: break-word; }
.g-action { display: flex; align-items: center; gap: 8px; }

.question-mode { margin-bottom: 10px; }
.question-toolbar { display: flex; align-items: center; gap: 8px; margin-bottom: 10px; }
.pagination-wrapper { display: flex; justify-content: flex-end; margin-top: 12px; }
.direct-form { border: 1px solid #e5e7eb; border-radius: 10px; padding: 12px; }
.direct-action { margin-top: 10px; }
.choice-editor { display: flex; flex-direction: column; gap: 8px; width: 100%; }
.choice-row { display: flex; align-items: center; gap: 8px; }
.test-cases-section { display: flex; flex-direction: column; gap: 10px; width: 100%; }
.test-case-item { border: 1px solid #e5e7eb; border-radius: 8px; padding: 10px; }
.test-case-title { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; color: #374151; }
.test-case-foot { margin-top: 8px; display: flex; align-items: center; gap: 8px; color: #4b5563; }
.current-questions { margin-top: 12px; }

@media (max-width: 1200px) {
  .stats-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  .submission-layout { grid-template-columns: 1fr; }
}
</style>
