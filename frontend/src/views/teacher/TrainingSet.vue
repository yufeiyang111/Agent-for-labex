<template>
  <div class="training-set-page wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <h2 class="page-title">题目训练</h2>
        <el-button type="primary" :icon="Plus" @click="handleAdd" class="wabi-btn-primary">
          新建训练集
        </el-button>
      </div>

      <!-- 列表容器 -->
      <div class="list-container">
        <div class="list-content" v-loading="loading">
          <div v-if="!loading && !trainingSets.length" class="list-empty">
            <el-empty description="暂无训练集" />
          </div>
          <div v-else class="training-list">
            <div v-for="ts in trainingSets" :key="ts.trainingSetId" class="training-item">
              <div class="training-info">
                <div class="training-header">
                  <h3 class="training-name">{{ ts.name }}</h3>
                  <span class="wabi-tag" :class="ts.state === 1 ? 'wabi-tag-accent' : ''">
                    {{ ts.state === 1 ? '启用' : '禁用' }}
                  </span>
                </div>
                <div class="training-desc">{{ ts.description || '暂无描述' }}</div>
                <div class="training-meta">
                  <span>总分：{{ ts.totalScore || 0 }}</span>
                  <span>创建时间：{{ formatDate(ts.createTime) }}</span>
                </div>
              </div>
              <div class="training-actions">
                <el-button size="small" text @click="handleEdit(ts)" class="wabi-btn-text">编辑</el-button>
                <el-button size="small" text @click="handleQuestions(ts)" class="wabi-btn-text">题目</el-button>
                <el-button size="small" text @click="handleRecords(ts)" class="wabi-btn-text">记录</el-button>
                <el-button size="small" text type="danger" @click="handleDelete(ts)" class="wabi-btn-text wabi-btn-danger">删除</el-button>
              </div>
            </div>
          </div>
        </div>

        <!-- 分页 -->
        <div class="wabi-pagination" v-if="trainingSets.length">
          <el-pagination
            v-model:current-page="pagination.page"
            v-model:page-size="pagination.pageSize"
            :total="pagination.total"
            :page-sizes="[10, 20, 50]"
            layout="total, sizes, prev, pager, next, jumper"
            @size-change="handlePageChange"
            @current-change="handlePageChange"
            background
          />
        </div>
      </div>
    </div>

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="500" class="wabi-dialog">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="80" class="wabi-form">
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
        <el-button @click="dialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleSubmit" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>

    <!-- 题目管理对话框 -->
    <el-dialog v-model="questionsDialogVisible" :title="`题目管理 - ${currentTrainingSet?.name || ''}`" width="1000" class="wabi-dialog">
      <div class="questions-header">
        <el-button type="primary" size="small" @click="showAddQuestions = true; loadAvailableQuestions()">添加题目</el-button>
      </div>
      <el-table :data="trainingQuestions" v-loading="loadingQuestions" class="wabi-table">
        <el-table-column prop="questionId" label="ID" width="80" />
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

    <!-- 添加题目对话框 -->
    <el-dialog v-model="showAddQuestions" title="添加题目" width="900" class="wabi-dialog">
      <div class="add-questions-toolbar">
        <el-select v-model="addQFilter.type" placeholder="题型" clearable style="width:120px" @change="loadAvailableQuestions">
          <el-option label="全部" :value="0" />
          <el-option label="单选" :value="2" />
          <el-option label="多选" :value="3" />
          <el-option label="判断" :value="4" />
          <el-option label="填空" :value="1" />
          <el-option label="简答" :value="5" />
          <el-option label="编程" :value="6" />
        </el-select>
        <el-input v-model="addQFilter.keyword" placeholder="搜索题目" clearable style="width:200px;margin-left:8px" @keyup.enter="loadAvailableQuestions" />
        <el-button type="primary" style="margin-left:8px" @click="loadAvailableQuestions">搜索</el-button>
      </div>
      <el-table :data="availableQuestions" v-loading="loadingAvailable" @selection-change="onQSelectionChange" class="wabi-table" max-height="400">
        <el-table-column type="selection" width="50" />
        <el-table-column prop="id" label="ID" width="70" />
        <el-table-column prop="typeName" label="题型" width="80" />
        <el-table-column prop="question" label="题目内容" min-width="300" show-overflow-tooltip />
      </el-table>
      <div style="margin-top:12px;text-align:right">
        <el-button @click="showAddQuestions = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="confirmAddQuestions" :disabled="!selectedQuestions.length" class="wabi-btn-primary">
          添加 ({{ selectedQuestions.length }})
        </el-button>
      </div>
    </el-dialog>

    <!-- 训练记录对话框 -->
    <el-dialog v-model="recordsDialogVisible" :title="`训练记录 - ${currentTrainingSet?.name || ''}`" width="1000" class="wabi-dialog">
      <el-table :data="trainingRecords" v-loading="loadingRecords" class="wabi-table">
        <el-table-column prop="studentId" label="学生ID" width="100" />
        <el-table-column prop="score" label="得分" width="80" align="center" />
        <el-table-column prop="totalScore" label="总分" width="80" align="center" />
        <el-table-column prop="submitTime" label="提交时间" width="180">
          <template #default="{ row }">
            <span class="nowrap-cell">{{ formatDate(row.submitTime) }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="attemptCount" label="作答次数" width="100" align="center" />
        <el-table-column prop="correctCount" label="正确数" width="80" align="center" />
        <el-table-column prop="totalQuestions" label="总题数" width="80" align="center" />
      </el-table>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { trainingApi } from '@/api'

const loading = ref(false)
const trainingSets = ref([])
const pagination = ref({ page: 1, pageSize: 20, total: 0 })
const dialogVisible = ref(false)
const dialogTitle = ref('新建训练集')
const formRef = ref()
const questionsDialogVisible = ref(false)
const recordsDialogVisible = ref(false)
const showAddQuestions = ref(false)
const currentTrainingSet = ref(null)
const trainingQuestions = ref([])
const trainingRecords = ref([])
const loadingQuestions = ref(false)
const loadingRecords = ref(false)
const availableQuestions = ref([])
const loadingAvailable = ref(false)
const selectedQuestions = ref([])
const addQFilter = ref({ type: 0, keyword: '' })

const formData = ref({
  trainingSetId: null,
  name: '',
  description: '',
  state: 1
})

const formRules = {
  name: [{ required: true, message: '请输入名称', trigger: 'blur' }]
}

const formatDate = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleString('zh-CN')
}

const loadTrainingSets = async () => {
  loading.value = true
  try {
    const params = { page: pagination.value.page, pageSize: pagination.value.pageSize }
    const res = await trainingApi.teacher.list(params)
    const data = res.data
    if (data && data.records) {
      trainingSets.value = data.records
      pagination.value.total = data.total || 0
    } else if (Array.isArray(data)) {
      trainingSets.value = data
      pagination.value.total = data.length
    } else {
      trainingSets.value = []
      pagination.value.total = 0
    }
  } catch (error) {
    console.error('加载训练集失败:', error)
  } finally {
    loading.value = false
  }
}

const handlePageChange = () => {
  loadTrainingSets()
}

const handleAdd = () => {
  formData.value = { trainingSetId: null, name: '', description: '', state: 1 }
  dialogTitle.value = '新建训练集'
  dialogVisible.value = true
}

const handleEdit = (row) => {
  formData.value = { ...row }
  dialogTitle.value = '编辑训练集'
  dialogVisible.value = true
}

const handleSubmit = async () => {
  await formRef.value.validate()
  try {
    if (formData.value.trainingSetId) {
      await trainingApi.teacher.update(formData.value.trainingSetId, formData.value)
      ElMessage.success('更新成功')
    } else {
      await trainingApi.teacher.add(formData.value)
      ElMessage.success('创建成功')
    }
    dialogVisible.value = false
    loadTrainingSets()
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

const handleDelete = async (row) => {
  await ElMessageBox.confirm('确定删除该训练集?', '提示', { type: 'warning' })
  await trainingApi.teacher.delete(row.trainingSetId)
  ElMessage.success('已删除')
  loadTrainingSets()
}

const handleQuestions = async (row) => {
  currentTrainingSet.value = row
  questionsDialogVisible.value = true
  loadingQuestions.value = true
  try {
    const res = await trainingApi.teacher.getQuestions(row.trainingSetId)
    trainingQuestions.value = res.data || []
  } catch (error) {
    console.error('加载题目失败:', error)
  } finally {
    loadingQuestions.value = false
  }
}

const removeQuestion = async (question) => {
  await ElMessageBox.confirm('确定从训练集中移除该题目?', '提示', { type: 'warning' })
  await trainingApi.teacher.removeQuestion(currentTrainingSet.value.trainingSetId, question.questionId || question.id)
  ElMessage.success('已移除')
  handleQuestions(currentTrainingSet.value)
}

const loadAvailableQuestions = async () => {
  loadingAvailable.value = true
  try {
    const params = { page: 1, pageSize: 100 }
    if (addQFilter.value.type > 0) params.type = addQFilter.value.type
    if (addQFilter.value.keyword) params.keyword = addQFilter.value.keyword
    const res = await trainingApi.teacher.getAvailableQuestions(params)
    const data = res.data
    availableQuestions.value = data?.list || data?.records || (Array.isArray(data) ? data : [])
  } catch (error) {
    console.error('加载题目失败:', error)
  } finally {
    loadingAvailable.value = false
  }
}

const onQSelectionChange = (rows) => {
  selectedQuestions.value = rows
}

const confirmAddQuestions = async () => {
  if (!selectedQuestions.value.length) return
  try {
    const ids = selectedQuestions.value.map(q => q.id)
    await trainingApi.teacher.addQuestions(currentTrainingSet.value.trainingSetId, ids)
    ElMessage.success(`已添加 ${ids.length} 道题目`)
    showAddQuestions.value = false
    selectedQuestions.value = []
    handleQuestions(currentTrainingSet.value)
  } catch (error) {
    ElMessage.error('添加失败')
  }
}

const handleRecords = async (row) => {
  currentTrainingSet.value = row
  recordsDialogVisible.value = true
  loadingRecords.value = true
  try {
    const res = await trainingApi.teacher.getStudentRecords(row.trainingSetId)
    trainingRecords.value = res.data || []
  } catch (error) {
    console.error('加载记录失败:', error)
  } finally {
    loadingRecords.value = false
  }
}

onMounted(loadTrainingSets)
</script>

<style scoped>
.training-set-page {
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

.page-title {
  font-size: 18px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
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

/* 训练集列表 */
.training-list {
  display: flex;
  flex-direction: column;
}

.training-item {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 16px 20px;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
  transition: background 0.2s ease;
}

.training-item:hover {
  background: var(--wabi-accent-light, #e8ede5);
}

.training-item:last-child {
  border-bottom: none;
}

.training-info {
  flex: 1;
  min-width: 0;
}

.training-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.training-name {
  font-size: 15px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
}

.training-desc {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-bottom: 4px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.training-meta {
  display: flex;
  gap: 16px;
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.training-actions {
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

.add-questions-toolbar {
  display: flex;
  align-items: center;
  margin-bottom: 12px;
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

  .training-item {
    flex-direction: column;
  }

  .training-actions {
    margin-left: 0;
    margin-top: 12px;
  }
}
</style>
