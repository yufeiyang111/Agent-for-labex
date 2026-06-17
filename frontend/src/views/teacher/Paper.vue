<template>
  <div class="paper-page wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-left">
          <h2 class="page-title">试卷管理</h2>
          <el-input
            v-model="searchQuery"
            placeholder="搜索试卷名称"
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
          新增试卷
        </el-button>
      </div>

      <!-- 统计卡片 -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-value">{{ pagination.total }}</div>
          <div class="stat-label">试卷总数</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">{{ enabledCount }}</div>
          <div class="stat-label">已启用</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">{{ totalQuestions }}</div>
          <div class="stat-label">题量总计</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">{{ avgScore }}</div>
          <div class="stat-label">总分平均值</div>
        </div>
      </div>

      <!-- 列表容器 -->
      <div class="list-container">
        <div class="list-content" v-loading="loading">
          <div v-if="!loading && !paperList.length" class="list-empty">
            <el-empty description="暂无试卷" />
          </div>
          <div v-else class="paper-list">
            <div v-for="paper in paperList" :key="paper.id" class="paper-item">
              <div class="paper-info">
                <div class="paper-header">
                  <h3 class="paper-name">{{ paper.name || '-' }}</h3>
                  <span class="wabi-tag" :class="paper.state === 1 ? 'wabi-tag-accent' : ''">
                    {{ paper.state === 1 ? '启用' : '禁用' }}
                  </span>
                </div>
                <div class="paper-desc">{{ paper.description || '暂无描述' }}</div>
                <div class="paper-meta">
                  <span>题目数：{{ paper.questionCount || 0 }}</span>
                  <span>总分：{{ paper.totalScore || 0 }}</span>
                  <span>ID：#{{ paper.id }}</span>
                </div>
              </div>
              <div class="paper-actions">
                <el-button size="small" text @click="handleEdit(paper)" class="wabi-btn-text">编辑</el-button>
                <el-button size="small" text @click="handleQuestions(paper)" class="wabi-btn-text">题目</el-button>
                <el-button size="small" text type="danger" @click="handleDelete(paper)" class="wabi-btn-text wabi-btn-danger">删除</el-button>
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
            @size-change="loadPaperList"
            @current-change="loadPaperList"
          />
        </div>
      </div>
    </div>

    <!-- 编辑试卷对话框 -->
    <el-dialog v-model="editDialogVisible" :title="isEdit ? '编辑试卷' : '新增试卷'" width="600" class="wabi-dialog">
      <el-form ref="editFormRef" :model="editForm" :rules="editRules" label-width="100" class="wabi-form">
        <el-form-item label="试卷名称" prop="name">
          <el-input v-model="editForm.name" placeholder="请输入试卷名称" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="editForm.description" type="textarea" :rows="3" placeholder="请输入试卷描述" />
        </el-form-item>
        <el-form-item label="状态">
          <el-switch v-model="editForm.state" :active-value="1" :inactive-value="0" active-text="启用" inactive-text="禁用" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="editDialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleSave" :loading="saving" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>

    <!-- 题目管理对话框 -->
    <el-dialog v-model="questionsDialogVisible" :title="`题目管理 - ${currentPaper?.name || ''}`" width="1000" class="wabi-dialog">
      <div class="questions-header">
        <el-button type="primary" size="small" @click="showAddQuestions = true">添加题目</el-button>
      </div>
      <el-table :data="paperQuestions" v-loading="loadingQuestions" class="wabi-table">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="typeName" label="题型" width="100" />
        <el-table-column prop="question" label="题目内容" min-width="300" show-overflow-tooltip />
        <el-table-column prop="score" label="分值" width="80" align="center" />
        <el-table-column label="操作" width="100" align="center">
          <template #default="{ row }">
            <el-button size="small" text type="danger" @click="removeQuestion(row)">移除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search } from '@element-plus/icons-vue'
import { teacherApi } from '@/api'

const paperApi = teacherApi.paper
const questionApi = teacherApi.question

const loading = ref(false)
const saving = ref(false)
const paperList = ref([])
const searchQuery = ref('')
const editDialogVisible = ref(false)
const questionsDialogVisible = ref(false)
const editFormRef = ref()
const isEdit = ref(false)
const currentPaper = ref(null)
const paperQuestions = ref([])
const loadingQuestions = ref(false)

const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const editForm = reactive({
  id: null,
  name: '',
  description: '',
  state: 1
})

const editRules = {
  name: [{ required: true, message: '请输入试卷名称', trigger: 'blur' }]
}

const enabledCount = computed(() => paperList.value.filter(p => p.state === 1).length)
const totalQuestions = computed(() => paperList.value.reduce((sum, p) => sum + (p.questionCount || 0), 0))
const avgScore = computed(() => {
  if (!paperList.value.length) return 0
  const sum = paperList.value.reduce((acc, p) => acc + (p.totalScore || 0), 0)
  return Math.round(sum / paperList.value.length)
})

const loadPaperList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize,
      keyword: searchQuery.value || undefined
    }
    const res = await paperApi.list(params)
    paperList.value = res.data?.list || res.data || []
    pagination.total = res.data?.total || paperList.value.length
  } catch (error) {
    console.error('加载试卷列表失败:', error)
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadPaperList()
}

const resetForm = () => {
  Object.assign(editForm, {
    id: null,
    name: '',
    description: '',
    state: 1
  })
}

const handleAdd = () => {
  resetForm()
  isEdit.value = false
  editDialogVisible.value = true
}

const handleEdit = (row) => {
  Object.assign(editForm, {
    id: row.id,
    name: row.name || '',
    description: row.description || '',
    state: row.state
  })
  isEdit.value = true
  editDialogVisible.value = true
}

const handleSave = async () => {
  try {
    await editFormRef.value.validate()
    saving.value = true
    if (isEdit.value) {
      await paperApi.update(editForm.id, editForm)
      ElMessage.success('更新成功')
    } else {
      await paperApi.add(editForm)
      ElMessage.success('创建成功')
    }
    editDialogVisible.value = false
    loadPaperList()
  } catch (error) {
    console.error('保存失败:', error)
  } finally {
    saving.value = false
  }
}

const handleQuestions = async (row) => {
  currentPaper.value = row
  questionsDialogVisible.value = true
  loadingQuestions.value = true
  try {
    const res = await paperApi.getQuestions(row.id)
    paperQuestions.value = res.data || []
  } catch (error) {
    console.error('加载题目失败:', error)
  } finally {
    loadingQuestions.value = false
  }
}

const removeQuestion = async (question) => {
  await ElMessageBox.confirm('确定从试卷中移除该题目?', '提示', { type: 'warning' })
  await paperApi.removeQuestion(currentPaper.value.id, question.id)
  ElMessage.success('已移除')
  handleQuestions(currentPaper.value)
}

const handleDelete = async (row) => {
  await ElMessageBox.confirm('确定删除该试卷?', '提示', { type: 'warning' })
  await paperApi.delete(row.id)
  ElMessage.success('已删除')
  loadPaperList()
}

onMounted(() => loadPaperList())
</script>

<style scoped>
.paper-page {
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

/* 试卷列表 */
.paper-list {
  display: flex;
  flex-direction: column;
}

.paper-item {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 16px 20px;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
  transition: background 0.2s ease;
}

.paper-item:hover {
  background: var(--wabi-accent-light, #e8ede5);
}

.paper-item:last-child {
  border-bottom: none;
}

.paper-info {
  flex: 1;
  min-width: 0;
}

.paper-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.paper-name {
  font-size: 15px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
}

.paper-desc {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-bottom: 4px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.paper-meta {
  display: flex;
  gap: 16px;
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.paper-actions {
  flex-shrink: 0;
  display: flex;
  gap: 4px;
  margin-left: 16px;
}

/* 题目管理 */
.questions-header {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 16px;
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

  .paper-item {
    flex-direction: column;
  }

  .paper-actions {
    margin-left: 0;
    margin-top: 12px;
  }
}
</style>
