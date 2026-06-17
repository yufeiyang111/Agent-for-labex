<template>
  <div class="exam-page wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-left">
          <h2 class="page-title">考试管理</h2>
          <el-input
            v-model="searchQuery"
            placeholder="搜索考试名称"
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
          新增考试
        </el-button>
      </div>

      <!-- 列表容器 -->
      <div class="list-container">
        <div class="list-content" v-loading="loading">
          <div v-if="!loading && !examList.length" class="list-empty">
            <el-empty description="暂无考试数据" />
          </div>
          <div v-else class="exam-list">
            <div v-for="exam in examList" :key="exam.id" class="exam-item">
              <div class="exam-info">
                <div class="exam-header">
                  <span class="exam-id">#{{ exam.id }}</span>
                  <h3 class="exam-name">{{ exam.examName }}</h3>
                  <el-switch
                    v-model="exam.state"
                    :active-value="1"
                    :inactive-value="0"
                    @change="handleStateChange(exam)"
                    size="small"
                  />
                </div>
                <div class="exam-meta">
                  <span>试卷：{{ exam.paperName || '-' }}</span>
                  <span>时长：{{ exam.duration || 60 }}分钟</span>
                </div>
                <div class="exam-time">
                  <span>{{ formatDate(exam.time) }} - {{ formatDate(exam.endTime) }}</span>
                </div>
              </div>
              <div class="exam-actions">
                <el-button size="small" text @click="handleEdit(exam)" class="wabi-btn-text">编辑</el-button>
                <el-button size="small" text type="danger" @click="handleDelete(exam)" class="wabi-btn-text wabi-btn-danger">删除</el-button>
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
            @size-change="loadExamList"
            @current-change="loadExamList"
          />
        </div>
      </div>
    </div>

    <!-- 新增/编辑考试对话框 -->
    <el-dialog v-model="dialogVisible" :title="isEdit ? '编辑考试' : '新增考试'" width="700" class="wabi-dialog">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="100" class="wabi-form">
        <el-form-item label="考试名称" prop="examName">
          <el-input v-model="formData.examName" placeholder="请输入考试名称" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="formData.description" type="textarea" :rows="3" placeholder="请输入考试描述" />
        </el-form-item>
        <el-form-item label="选择试卷" prop="paperId">
          <el-select v-model="formData.paperId" placeholder="请选择试卷" style="width: 100%" filterable>
            <el-option v-for="p in paperList" :key="p.id" :label="p.name" :value="p.id" />
          </el-select>
        </el-form-item>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="考试时长" prop="duration">
              <el-input-number v-model="formData.duration" :min="10" :max="300" style="width: 100%" />
              <span class="form-hint">分钟</span>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="总分">
              <el-input-number v-model="formData.totalScore" :min="1" :max="1000" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="开始时间" prop="time">
              <el-date-picker v-model="formData.time" type="datetime" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="结束时间" prop="endTime">
              <el-date-picker v-model="formData.endTime" type="datetime" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="状态">
          <el-switch v-model="formData.state" :active-value="1" :inactive-value="0" active-text="启用" inactive-text="禁用" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleSubmit" :loading="saving" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search } from '@element-plus/icons-vue'
import { teacherApi } from '@/api'

const examApi = teacherApi.exam
const paperApi = teacherApi.paper

const loading = ref(false)
const saving = ref(false)
const examList = ref([])
const paperList = ref([])
const searchQuery = ref('')
const dialogVisible = ref(false)
const formRef = ref()
const isEdit = ref(false)

const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const formData = reactive({
  id: null,
  examName: '',
  description: '',
  paperId: null,
  duration: 60,
  totalScore: 100,
  time: '',
  endTime: '',
  state: 1
})

const formRules = {
  examName: [{ required: true, message: '请输入考试名称', trigger: 'blur' }],
  paperId: [{ required: true, message: '请选择试卷', trigger: 'change' }],
  duration: [{ required: true, message: '请输入考试时长', trigger: 'change' }],
  time: [{ required: true, message: '请选择开始时间', trigger: 'change' }],
  endTime: [{ required: true, message: '请选择结束时间', trigger: 'change' }]
}

const formatDate = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleString('zh-CN')
}

const loadExamList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize,
      keyword: searchQuery.value || undefined
    }
    const res = await examApi.list(params)
    examList.value = res.data?.list || res.data || []
    pagination.total = res.data?.total || examList.value.length
  } catch (error) {
    console.error('加载考试列表失败:', error)
  } finally {
    loading.value = false
  }
}

const loadPaperList = async () => {
  try {
    const res = await paperApi.getAll()
    paperList.value = res.data || []
  } catch (error) {
    console.error('加载试卷列表失败:', error)
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadExamList()
}

const resetForm = () => {
  Object.assign(formData, {
    id: null,
    examName: '',
    description: '',
    paperId: null,
    duration: 60,
    totalScore: 100,
    time: '',
    endTime: '',
    state: 1
  })
}

const handleAdd = () => {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
}

const handleEdit = (row) => {
  Object.assign(formData, {
    id: row.id,
    examName: row.examName || '',
    description: row.description || '',
    paperId: row.paperId,
    duration: row.duration || 60,
    totalScore: row.totalScore || 100,
    time: row.time,
    endTime: row.endTime,
    state: row.state
  })
  isEdit.value = true
  dialogVisible.value = true
}

const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    saving.value = true
    if (isEdit.value) {
      await examApi.update(formData.id, formData)
      ElMessage.success('更新成功')
    } else {
      await examApi.add(formData)
      ElMessage.success('创建成功')
    }
    dialogVisible.value = false
    loadExamList()
  } catch (error) {
    console.error('保存失败:', error)
  } finally {
    saving.value = false
  }
}

const handleStateChange = async (row) => {
  await examApi.update(row.id, { state: row.state })
  ElMessage.success(row.state === 1 ? '已启用' : '已禁用')
}

const handleDelete = async (row) => {
  await ElMessageBox.confirm('确定删除该考试?', '提示', { type: 'warning' })
  await examApi.delete(row.id)
  ElMessage.success('已删除')
  loadExamList()
}

onMounted(() => {
  loadExamList()
  loadPaperList()
})
</script>

<style scoped>
.exam-page {
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

/* 考试列表 */
.exam-list {
  display: flex;
  flex-direction: column;
}

.exam-item {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 16px 20px;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
  transition: background 0.2s ease;
}

.exam-item:hover {
  background: var(--wabi-accent-light, #e8ede5);
}

.exam-item:last-child {
  border-bottom: none;
}

.exam-info {
  flex: 1;
  min-width: 0;
}

.exam-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.exam-id {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  font-family: monospace;
}

.exam-name {
  font-size: 15px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
}

.exam-meta {
  display: flex;
  gap: 16px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-bottom: 4px;
}

.exam-time {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.exam-actions {
  flex-shrink: 0;
  display: flex;
  gap: 4px;
  margin-left: 16px;
}

.form-hint {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-left: 8px;
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

  .exam-item {
    flex-direction: column;
  }

  .exam-actions {
    margin-left: 0;
    margin-top: 12px;
  }
}
</style>
