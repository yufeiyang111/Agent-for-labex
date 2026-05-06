<template>
  <div class="paper-page">
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/teacher' }">教师首页</el-breadcrumb-item>
      <el-breadcrumb-item>试卷管理</el-breadcrumb-item>
    </el-breadcrumb>

    <section class="hero">
      <div>
        <h2>试卷工作台</h2>
        <p>先建试卷，再复用到多个考试；题目维护和分值总览都在这里。</p>
      </div>
      <div class="hero-actions">
        <el-input v-model="searchQuery" placeholder="搜索试卷名称" clearable class="search-input" @clear="handleSearch" @keyup.enter="handleSearch">
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
        <el-button type="primary" @click="handleSearch">搜索</el-button>
        <el-button type="success" @click="handleAdd">
          <el-icon><Plus /></el-icon> 新增试卷
        </el-button>
      </div>
    </section>

    <section class="stats-grid">
      <el-card shadow="never" class="stat-card">
        <div class="stat-title">试卷总数</div>
        <div class="stat-value">{{ pagination.total }}</div>
      </el-card>
      <el-card shadow="never" class="stat-card">
        <div class="stat-title">已启用</div>
        <div class="stat-value">{{ enabledCount }}</div>
      </el-card>
      <el-card shadow="never" class="stat-card">
        <div class="stat-title">题量总计</div>
        <div class="stat-value">{{ totalQuestions }}</div>
      </el-card>
      <el-card shadow="never" class="stat-card">
        <div class="stat-title">总分平均值</div>
        <div class="stat-value">{{ avgScore }}</div>
      </el-card>
    </section>

    <section v-loading="loading">
      <div class="list-header" v-if="displayedPapers.length">
        <span class="list-count">共 {{ displayedPapers.length }} / {{ pagination.total }} 个试卷</span>
      </div>
      <el-empty v-if="displayedPapers.length === 0" description="暂无试卷" />
      <div v-else class="paper-grid" ref="paperGridRef" @scroll="handlePaperScroll">
        <el-card v-for="row in displayedPapers" :key="row.id" class="paper-card" shadow="hover">
          <div class="paper-top">
            <div class="paper-name">{{ row.name || '-' }}</div>
            <el-tag :type="row.state === 1 ? 'success' : 'info'" effect="plain">{{ row.state === 1 ? '启用' : '禁用' }}</el-tag>
          </div>
          <div class="paper-desc">{{ row.description || '暂无描述' }}</div>
          <div class="paper-kpis">
            <div class="kpi"><span>题目数</span><strong>{{ row.questionCount || 0 }}</strong></div>
            <div class="kpi"><span>总分</span><strong>{{ row.totalScore || 0 }}</strong></div>
            <div class="kpi"><span>ID</span><strong>#{{ row.id }}</strong></div>
          </div>
          <div class="paper-actions">
            <el-button type="primary" plain size="small" @click="handleEdit(row)">编辑</el-button>
            <el-button type="warning" plain size="small" @click="handleQuestions(row)">配置题目</el-button>
            <el-button type="danger" plain size="small" @click="handleDelete(row)">删除</el-button>
          </div>
        </el-card>
        <div v-if="loadingMore" class="loading-more">
          <el-icon class="is-loading"><Loading /></el-icon>
          <span>加载中...</span>
        </div>
        <div v-if="!pagination.hasMore && displayedPapers.length > 0" class="no-more-data">
          已加载全部 {{ displayedPapers.length }} 个试卷
        </div>
      </div>
    </section>

    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="560px">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="90px">
        <el-form-item label="试卷名称" prop="name">
          <el-input v-model="formData.name" placeholder="请输入试卷名称" />
        </el-form-item>
        <el-form-item label="试卷描述">
          <el-input v-model="formData.description" type="textarea" :rows="4" placeholder="请输入试卷描述" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="formData.state">
            <el-radio :label="1">启用</el-radio>
            <el-radio :label="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="submitting" @click="handleSubmit">保存</el-button>
      </template>
    </el-dialog>

    <el-dialog v-model="questionDialogVisible" title="试卷题目配置" width="1080px">
      <div class="question-filter">
        <el-select v-model="questionType" placeholder="题目类型" clearable style="width: 140px">
          <el-option label="填空" :value="1" />
          <el-option label="单选" :value="2" />
          <el-option label="多选" :value="3" />
          <el-option label="判断" :value="4" />
          <el-option label="解答" :value="5" />
          <el-option label="编程" :value="6" />
        </el-select>
        <el-button type="primary" @click="loadQuestions">筛选</el-button>
        <el-button type="success" :disabled="selectedQuestions.length === 0" @click="confirmQuestions">
          保存选中（{{ selectedQuestions.length }}）
        </el-button>
      </div>

      <div class="question-layout">
        <div class="question-pool">
          <h4>题库题目</h4>
          <el-table ref="questionTableRef" :data="allQuestions" @selection-change="handleSelectionChange" height="460" stripe>
            <el-table-column type="selection" width="50" />
            <el-table-column prop="id" label="ID" width="70" />
            <el-table-column label="类型" width="92">
              <template #default="{ row }">
                <el-tag size="small">{{ getTypeName(row.type) }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="题目内容" min-width="240">
              <template #default="{ row }">
                <div class="q-cell">{{ shortText(row.question, 96) }}</div>
              </template>
            </el-table-column>
            <el-table-column label="分值" width="80">
              <template #default="{ row }">{{ row.score || 10 }}</template>
            </el-table-column>
          </el-table>
        </div>
        <div class="question-selected">
          <h4>已选择（预览）</h4>
          <el-scrollbar height="460">
            <div v-if="selectedQuestions.length === 0" class="empty-hint">请从左侧选择题目</div>
            <div v-for="item in selectedQuestions" :key="item.id" class="selected-item">
              <div class="selected-line">
                <el-tag size="small" type="info">{{ getTypeName(item.type) }}</el-tag>
                <span>#{{ item.id }}</span>
                <strong>{{ item.score || 10 }}分</strong>
              </div>
              <div class="selected-content">{{ shortText(item.question, 80) }}</div>
            </div>
          </el-scrollbar>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { computed, onMounted, reactive, ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search, Loading } from '@element-plus/icons-vue'
import { teacherApi } from '@/api/index.js'

const loading = ref(false)
const loadingMore = ref(false)
const submitting = ref(false)
const paperList = ref([])
const displayedPapers = ref([])
const dialogVisible = ref(false)
const questionDialogVisible = ref(false)
const isEdit = ref(false)
const formRef = ref(null)
const searchQuery = ref('')
const currentPaperId = ref(null)
const allQuestions = ref([])
const selectedQuestions = ref([])
const questionType = ref(null)
const questionTableRef = ref(null)
const paperGridRef = ref(null)

const INITIAL_PAGE_SIZE = 12
const LOAD_MORE_SIZE = 8
const pagination = reactive({ page: 1, pageSize: INITIAL_PAGE_SIZE, total: 0, hasMore: true })
const formData = reactive({ id: null, name: '', description: '', state: 1 })

const dialogTitle = computed(() => (isEdit.value ? '编辑试卷' : '新增试卷'))
const formRules = { name: [{ required: true, message: '请输入试卷名称', trigger: 'blur' }] }

const enabledCount = computed(() => paperList.value.filter((p) => p.state === 1).length)
const totalQuestions = computed(() => paperList.value.reduce((sum, p) => sum + (p.questionCount || 0), 0))
const avgScore = computed(() => {
  if (!paperList.value.length) return 0
  const total = paperList.value.reduce((sum, p) => sum + (p.totalScore || 0), 0)
  return Math.round(total / paperList.value.length)
})

const getTypeName = (type) => {
  const map = { 1: '填空', 2: '单选', 3: '多选', 4: '判断', 5: '解答', 6: '编程', 7: '综合' }
  return map[type] || '未知'
}

const shortText = (text, len = 80) => {
  if (!text) return '-'
  return text.length > len ? `${text.slice(0, len)}...` : text
}

const loadPaperList = async () => {
  loading.value = true
  try {
    const params = { page: pagination.page, pageSize: pagination.pageSize }
    if (searchQuery.value) params.name = searchQuery.value
    const res = await teacherApi.paper.list(params)
    paperList.value = res.data?.list || []
    pagination.total = res.data?.total || 0
    // 动态加载模式下，每次搜索重置为第一页，初始显示 INITIAL_PAGE_SIZE 条
    displayedPapers.value = paperList.value.slice(0, INITIAL_PAGE_SIZE)
    pagination.hasMore = displayedPapers.value.length < paperList.value.length
  } catch {
    ElMessage.error('加载试卷列表失败')
  } finally {
    loading.value = false
  }
}

const loadMorePapers = () => {
  if (loadingMore.value || !pagination.hasMore) return
  loadingMore.value = true
  setTimeout(() => {
    const start = displayedPapers.value.length
    const end = start + LOAD_MORE_SIZE
    const newPapers = paperList.value.slice(start, end)
    displayedPapers.value.push(...newPapers)
    pagination.hasMore = displayedPapers.value.length < paperList.value.length
    loadingMore.value = false
  }, 300)
}

const handlePaperScroll = (e) => {
  const { scrollTop, scrollHeight, clientHeight } = e.target
  if (scrollHeight - scrollTop - clientHeight < 80) {
    loadMorePapers()
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadPaperList()
}

const resetForm = () => Object.assign(formData, { id: null, name: '', description: '', state: 1 })

const handleAdd = () => {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
}

const handleEdit = (row) => {
  Object.assign(formData, { id: row.id, name: row.name, description: row.description, state: row.state })
  isEdit.value = true
  dialogVisible.value = true
}

const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    submitting.value = true
    if (isEdit.value) {
      await teacherApi.paper.update(formData.id, formData)
      ElMessage.success('更新成功')
    } else {
      await teacherApi.paper.add(formData)
      ElMessage.success('新增成功')
    }
    dialogVisible.value = false
    loadPaperList()
  } catch (error) {
    if (error !== false) {
      ElMessage.error('保存失败')
    }
  } finally {
    submitting.value = false
  }
}

const handleQuestions = async (row) => {
  currentPaperId.value = row.id
  selectedQuestions.value = []
  questionDialogVisible.value = true
  await loadQuestions()
  try {
    const res = await teacherApi.paper.getQuestions(row.id)
    if (res.data) {
      const ids = res.data.map((q) => q.id)
      allQuestions.value.forEach((q) => {
        if (ids.includes(q.id)) {
          questionTableRef.value.toggleRowSelection(q, true)
        }
      })
    }
  } catch {}
}

const loadQuestions = async () => {
  try {
    const res = await teacherApi.question.getAll()
    allQuestions.value = res.data || []
    if (questionType.value) {
      allQuestions.value = allQuestions.value.filter((q) => q.type === questionType.value)
    }
  } catch {
    ElMessage.error('加载题目失败')
  }
}

const handleSelectionChange = (selection) => {
  selectedQuestions.value = selection
}

const confirmQuestions = async () => {
  try {
    const ids = selectedQuestions.value.map((q) => q.id)
    await teacherApi.paper.addQuestions(currentPaperId.value, ids)
    ElMessage.success('试卷题目已更新')
    questionDialogVisible.value = false
    loadPaperList()
  } catch {
    ElMessage.error('保存题目失败')
  }
}

const handleDelete = (row) => {
  ElMessageBox.confirm(`确认删除试卷 "${row.name}" 吗？`, '提示', { type: 'warning' })
    .then(async () => {
      try {
        await teacherApi.paper.delete(row.id)
        ElMessage.success('删除成功')
        loadPaperList()
      } catch {
        ElMessage.error('删除失败')
      }
    })
    .catch(() => {})
}

onMounted(loadPaperList)
</script>

<style scoped>
.paper-page { padding: 20px; }
.breadcrumb { margin-bottom: 16px; }
.hero {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  gap: 12px;
  margin-bottom: 14px;
}
.hero h2 { margin: 0; font-size: 26px; color: #1f2937; }
.hero p { margin: 6px 0 0; color: #6b7280; font-size: 13px; }
.hero-actions { display: flex; gap: 8px; align-items: center; }
.search-input { width: 240px; }

.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 10px;
  margin-bottom: 14px;
}
.stat-card { border-radius: 10px; border: 1px solid #e5e7eb; }
.stat-title { font-size: 12px; color: #6b7280; }
.stat-value { font-size: 26px; font-weight: 700; color: #111827; margin-top: 6px; }

.paper-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 14px;
  max-height: calc(100vh - 380px);
  overflow-y: auto;
  scrollbar-width: thin;
}
.paper-card { border-radius: 14px; border: 1px solid #e5e7eb; transition: all 0.25s cubic-bezier(0.25, 0.1, 0.25, 1); }
.paper-card:hover { transform: translateY(-3px); box-shadow: 0 12px 28px rgba(0, 0, 0, 0.1); }
.paper-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
.paper-name { font-size: 15px; font-weight: 700; color: #111827; }
.paper-desc { min-height: 40px; color: #4b5563; font-size: 13px; margin-bottom: 10px; line-height: 1.5; }
.paper-kpis { display: flex; gap: 16px; margin-bottom: 10px; }
.kpi { display: flex; flex-direction: column; }
.kpi span { font-size: 12px; color: #6b7280; }
.kpi strong { color: #111827; }
.paper-actions { display: flex; gap: 8px; }

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

.question-filter { display: flex; gap: 8px; align-items: center; margin-bottom: 10px; }
.question-layout {
  display: grid;
  grid-template-columns: 2.1fr 1fr;
  gap: 12px;
}
.question-pool, .question-selected {
  border: 1px solid #e5e7eb;
  border-radius: 10px;
  padding: 10px;
}
.question-pool h4, .question-selected h4 { margin: 0 0 8px; color: #111827; }
.q-cell { color: #374151; line-height: 1.5; }
.empty-hint { color: #9ca3af; padding: 14px 8px; }
.selected-item {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 8px;
  margin-bottom: 8px;
  background: #f9fafb;
}
.selected-line { display: flex; align-items: center; justify-content: space-between; margin-bottom: 4px; }
.selected-content { color: #374151; font-size: 13px; line-height: 1.4; }

@media (max-width: 1100px) {
  .stats-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  .paper-grid { grid-template-columns: repeat(3, 1fr); }
  .question-layout { grid-template-columns: 1fr; }
}

@media (max-width: 900px) {
  .paper-grid { grid-template-columns: repeat(2, 1fr); }
}

@media (max-width: 600px) {
  .paper-grid { grid-template-columns: 1fr; }
}
</style>
