<template>
  <div class="experiment-page wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-left">
          <h2 class="page-title">实验管理</h2>
          <el-input
            v-model="searchQuery"
            placeholder="搜索实验编号或名称"
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
          新增实验
        </el-button>
      </div>

      <!-- 列表容器 -->
      <div class="list-container">
        <div class="list-content" v-loading="loading">
          <div v-if="!loading && !experimentList.length" class="list-empty">
            <el-empty description="暂无实验数据">
              <el-button type="primary" @click="handleAdd">新增实验</el-button>
            </el-empty>
          </div>
          <div v-else class="experiment-list">
            <div v-for="exp in experimentList" :key="exp.experimentId" class="experiment-item">
              <div class="experiment-info">
                <div class="experiment-header">
                  <span class="experiment-no">{{ exp.experimentNo }}</span>
                  <span class="wabi-tag">{{ getExperimentTypeName(exp.experimentType) }}</span>
                  <span class="wabi-tag" :class="exp.state === 1 ? 'wabi-tag-accent' : ''">
                    {{ exp.state === 1 ? '启用' : '禁用' }}
                  </span>
                </div>
                <h3 class="experiment-name">{{ exp.experimentName }}</h3>
              </div>
              <div class="experiment-actions">
                <el-switch
                  v-model="exp.state"
                  :active-value="1"
                  :inactive-value="0"
                  @change="handleToggleState(exp)"
                  size="small"
                />
                <el-button size="small" text @click="handleEdit(exp)" class="wabi-btn-text">编辑</el-button>
                <el-button size="small" text @click="handleManageItems(exp)" class="wabi-btn-text">题目</el-button>
                <el-button size="small" text type="danger" @click="handleDelete(exp)" class="wabi-btn-text wabi-btn-danger">删除</el-button>
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
            @size-change="loadExperimentList"
            @current-change="loadExperimentList"
          />
        </div>
      </div>
    </div>

    <!-- 新增/编辑实验对话框 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="600" class="wabi-dialog">
      <el-form ref="formRef" :model="form" :rules="formRules" label-width="100" class="wabi-form">
        <el-form-item label="实验编号" prop="experimentNo">
          <el-input v-model="form.experimentNo" placeholder="如 EXP001" />
        </el-form-item>
        <el-form-item label="实验名称" prop="experimentName">
          <el-input v-model="form.experimentName" placeholder="请输入实验名称" />
        </el-form-item>
        <el-form-item label="实验类型">
          <el-select v-model="form.experimentType" placeholder="选择类型" style="width: 100%">
            <el-option label="验证型" :value="1" />
            <el-option label="设计型" :value="2" />
            <el-option label="综合型" :value="3" />
          </el-select>
        </el-form-item>
        <el-form-item label="实验描述">
          <el-input v-model="form.description" type="textarea" :rows="3" placeholder="请输入实验描述" />
        </el-form-item>
        <el-form-item label="状态">
          <el-switch v-model="form.state" :active-value="1" :inactive-value="0" active-text="启用" inactive-text="禁用" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleSubmit" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search } from '@element-plus/icons-vue'
import { teacherApi } from '@/api'

const router = useRouter()
const experimentApi = teacherApi.experiment

const loading = ref(false)
const experimentList = ref([])
const searchQuery = ref('')
const dialogVisible = ref(false)
const dialogTitle = ref('')
const formRef = ref()

const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const form = ref({
  experimentId: null,
  experimentNo: '',
  experimentName: '',
  experimentType: 1,
  description: '',
  state: 1
})

const formRules = {
  experimentNo: [{ required: true, message: '请输入实验编号', trigger: 'blur' }],
  experimentName: [{ required: true, message: '请输入实验名称', trigger: 'blur' }]
}

const getExperimentTypeName = (type) => ({
  1: '验证型',
  2: '设计型',
  3: '综合型'
}[type] || '未知')

const loadExperimentList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize,
      keyword: searchQuery.value || undefined
    }
    const res = await experimentApi.list(params)
    experimentList.value = res.data?.list || res.data || []
    pagination.total = res.data?.total || experimentList.value.length
  } catch (error) {
    console.error('加载实验列表失败:', error)
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadExperimentList()
}

const handleAdd = () => {
  form.value = {
    experimentId: null,
    experimentNo: '',
    experimentName: '',
    experimentType: 1,
    description: '',
    state: 1
  }
  dialogTitle.value = '新增实验'
  dialogVisible.value = true
}

const handleEdit = (row) => {
  form.value = { ...row }
  dialogTitle.value = '编辑实验'
  dialogVisible.value = true
}

const handleSubmit = async () => {
  await formRef.value.validate()
  try {
    if (form.value.experimentId) {
      await experimentApi.update(form.value.experimentId, form.value)
      ElMessage.success('更新成功')
    } else {
      await experimentApi.add(form.value)
      ElMessage.success('创建成功')
    }
    dialogVisible.value = false
    loadExperimentList()
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

const handleToggleState = async (row) => {
  await experimentApi.updateState(row.experimentId, row.state)
  ElMessage.success(row.state === 1 ? '已启用' : '已禁用')
}

const handleDelete = async (row) => {
  await ElMessageBox.confirm('确定删除该实验?', '提示', { type: 'warning' })
  await experimentApi.delete(row.experimentId)
  ElMessage.success('已删除')
  loadExperimentList()
}

const handleManageItems = (row) => {
  router.push(`/teacher/experiment-item/${row.experimentId}`)
}

onMounted(loadExperimentList)
</script>

<style scoped>
.experiment-page {
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

/* 实验列表 */
.experiment-list {
  display: flex;
  flex-direction: column;
}

.experiment-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
  transition: background 0.2s ease;
}

.experiment-item:hover {
  background: var(--wabi-accent-light, #e8ede5);
}

.experiment-item:last-child {
  border-bottom: none;
}

.experiment-info {
  flex: 1;
  min-width: 0;
}

.experiment-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.experiment-no {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  font-family: monospace;
}

.experiment-name {
  font-size: 15px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
}

.experiment-actions {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  gap: 8px;
  margin-left: 16px;
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

  .experiment-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }

  .experiment-actions {
    margin-left: 0;
    width: 100%;
    justify-content: flex-end;
  }
}
</style>
