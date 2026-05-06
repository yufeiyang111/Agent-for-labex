<template>
  <div class="experiment-page">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/teacher' }">教师首页</el-breadcrumb-item>
      <el-breadcrumb-item>实验管理</el-breadcrumb-item>
    </el-breadcrumb>

    <!-- 页面标题和搜索区域 -->
    <div class="page-header">
      <h2 class="page-title">实验管理</h2>
      <div class="search-area">
        <el-input
          v-model="searchQuery"
          placeholder="搜索实验编号或名称"
          clearable
          @clear="handleSearch"
          @keyup.enter="handleSearch"
          class="search-input"
        >
          <template #prefix>
            <el-icon><Search /></el-icon>
          </template>
        </el-input>
        <el-button type="primary" @click="handleSearch" class="search-btn">
          搜索
        </el-button>
      </div>
    </div>

    <!-- 操作按钮区域 -->
    <div class="action-bar">
      <el-button type="success" @click="handleAdd" class="add-btn">
        <el-icon><Plus /></el-icon>
        新增实验
      </el-button>
    </div>

    <!-- 实验列表表格 -->
    <el-card class="table-card" shadow="hover">
      <el-table
        :data="experimentList"
        v-loading="loading"
        stripe
        hover
        style="width: 100%"
      >
        <el-table-column prop="experimentNo" label="实验编号" min-width="120" />
        <el-table-column prop="experimentName" label="实验名称" min-width="180" />
        <el-table-column label="类型" min-width="120">
          <template #default="{ row }">
            <el-tag type="info">{{ getExperimentTypeName(row.experimentType) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="状态" width="90">
          <template #default="{ row }">
            <el-tag :type="row.state === 1 ? 'success' : 'info'">
              {{ row.state === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="300" fixed="right">
          <template #default="{ row }">
            <div class="action-buttons">
              <el-switch
                v-model="row.state"
                :active-value="1"
                :inactive-value="0"
                @change="handleToggleState(row)"
                style="width: 50px;"
              />
              <el-button type="primary" size="small" plain @click="handleEdit(row)" class="action-btn">
                编辑
              </el-button>
              <el-button type="success" size="small" plain @click="handleManageItems(row)" class="action-btn">
                题目管理
              </el-button>
              <el-button type="danger" size="small" plain @click="handleDelete(row)" class="action-btn">
                删除
              </el-button>
            </div>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <el-pagination
        v-model:current-page="pagination.page"
        v-model:page-size="pagination.pageSize"
        :page-sizes="[20, 40, 60, 100]"
        :total="pagination.total"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="loadExperimentList"
        @current-change="loadExperimentList"
        class="pagination"
      />
    </el-card>

    <!-- 新增/编辑实验对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="500px"
      class="experiment-dialog"
    >
      <el-form
        ref="formRef"
        :model="formData"
        :rules="formRules"
        label-width="100px"
      >
        <el-form-item label="实验编号" prop="experimentNo">
          <el-input v-model="formData.experimentNo" placeholder="请输入实验编号" :disabled="isEdit" />
        </el-form-item>
        <el-form-item label="实验名称" prop="experimentName">
          <el-input v-model="formData.experimentName" placeholder="请输入实验名称" />
        </el-form-item>
        <el-form-item label="类型">
          <el-select v-model="formData.experimentType" placeholder="请选择实验类型" style="width: 100%">
            <el-option label="选择题" :value="1" />
            <el-option label="编程题" :value="2" />
            <el-option label="综合题" :value="3" />
            <el-option label="默认" :value="4" />
          </el-select>
        </el-form-item>
        <el-form-item label="指导类型">
          <el-input v-model="formData.instructionType" placeholder="请输入指导类型" />
        </el-form-item>
        <el-form-item label="实验要求">
          <el-input
            v-model="formData.experimentRequirement"
            type="textarea"
            :rows="2"
            placeholder="请输入实验要求"
          />
        </el-form-item>
        <el-form-item label="实验内容">
          <el-input
            v-model="formData.experimentContent"
            type="textarea"
            :rows="3"
            placeholder="请输入实验内容"
          />
        </el-form-item>
        <el-form-item label="状态">
          <el-switch
            v-model="formData.state"
            :active-value="1"
            :inactive-value="0"
            active-text="启用"
            inactive-text="禁用"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit" :loading="submitting">
          确定
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Search, Plus } from '@element-plus/icons-vue'
import { teacherApi } from '@/api/index.js'

const router = useRouter()

// 响应式数据
const loading = ref(false)
const submitting = ref(false)
const experimentList = ref([])
const dialogVisible = ref(false)
const dialogTitle = computed(() => isEdit.value ? '编辑实验' : '新增实验')
const isEdit = ref(false)
const formRef = ref(null)
const searchQuery = ref('')

// 分页
const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

// 表单数据
const formData = reactive({
  experimentNo: '',
  experimentName: '',
  experimentType: 1,
  instructionType: '',
  experimentRequirement: '',
  experimentContent: '',
  state: 1
})

// 表单验证规则
const formRules = {
  experimentNo: [
    { required: true, message: '请输入实验编号', trigger: 'blur' }
  ],
  experimentName: [
    { required: true, message: '请输入实验名称', trigger: 'blur' },
    { max: 50, message: '最多50个字符', trigger: 'blur' }
  ]
}

// 实验类型名称
const getExperimentTypeName = (type) => {
  const typeMap = {
    1: '选择题',
    2: '编程题',
    3: '综合题',
    4: '默认'
  }
  return typeMap[type] || '默认'
}

// 加载实验列表
const loadExperimentList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize
    }
    if (searchQuery.value) {
      params.keyword = searchQuery.value
    }
    const response = await teacherApi.experiment.list(params)
    experimentList.value = response.data?.list || []
    pagination.total = response.data?.total || 0
  } catch (error) {
    ElMessage.error('加载实验列表失败')
    console.error(error)
  } finally {
    loading.value = false
  }
}

// 搜索
const handleSearch = () => {
  pagination.page = 1
  loadExperimentList()
}

// 重置表单
const resetForm = () => {
  Object.assign(formData, {
    experimentNo: '',
    experimentName: '',
    experimentType: 1,
    instructionType: '',
    experimentRequirement: '',
    experimentContent: '',
    state: 1
  })
}

// 新增实验
const handleAdd = () => {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
}

// 编辑实验
const handleEdit = (row) => {
  Object.assign(formData, {
    experimentNo: row.experimentNo,
    experimentName: row.experimentName,
    experimentType: row.experimentType || 1,
    instructionType: row.instructionType || '',
    experimentRequirement: row.experimentRequirement || '',
    experimentContent: row.experimentContent || '',
    state: row.state
  })
  isEdit.value = true
  dialogVisible.value = true
}

// 提交表单
const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    submitting.value = true

    if (isEdit.value) {
      await teacherApi.experiment.update(formData.experimentNo, formData)
      ElMessage.success('更新成功')
    } else {
      await teacherApi.experiment.add(formData)
      ElMessage.success('添加成功')
    }

    dialogVisible.value = false
    loadExperimentList()
  } catch (error) {
    if (error !== false) {
      ElMessage.error('操作失败')
      console.error(error)
    }
  } finally {
    submitting.value = false
  }
}

// 切换状态
const handleToggleState = async (row) => {
  const newState = row.state === 1 ? 1 : 0
  try {
    await teacherApi.experiment.updateState(row.experimentId, newState)
    ElMessage.success(newState === 1 ? '已启用' : '已禁用')
    loadExperimentList()
  } catch (error) {
    row.state = row.state === 1 ? 0 : 1
    ElMessage.error('状态更新失败')
    console.error(error)
  }
}

// 删除实验
const handleDelete = (row) => {
  ElMessageBox.confirm(
    `确认删除实验 "${row.experimentName}" 吗？此操作不可恢复！`,
    '警告',
    { type: 'warning' }
  ).then(async () => {
    try {
      await teacherApi.experiment.delete(row.experimentId)
      ElMessage.success('删除成功')
      loadExperimentList()
    } catch (error) {
      ElMessage.error('删除失败')
      console.error(error)
    }
  }).catch(() => {})
}

// 跳转到题目管理页面
const handleManageItems = (row) => {
  router.push(`/teacher/experiment-item/${row.experimentId}`)
}

// 页面初始化
onMounted(() => {
  loadExperimentList()
})
</script>

<style scoped>
.experiment-page {
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
  flex-wrap: wrap;
  gap: 15px;
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
  width: 280px;
}

.action-bar {
  margin-bottom: 20px;
}

.add-btn {
  background: #5cb85c;
  border: none;
  transition: all 0.3s ease;
}

.add-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(92, 184, 92, 0.4);
}

.table-card {
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  border: 1px solid #e8f5e9;
}

.table-card :deep(.el-card__body) {
  padding: 20px;
}

.pagination {
  margin-top: 20px;
  justify-content: flex-end;
}

.experiment-dialog :deep(.el-dialog__header) {
  background: #e8f5e9;
  border-radius: 8px 8px 0 0;
}

.experiment-dialog :deep(.el-dialog__title) {
  color: #2d8a4e;
  font-weight: 600;
}

/* 操作按钮样式 */
.action-buttons {
  display: flex;
  align-items: center;
  gap: 6px;
  flex-wrap: nowrap;
}

.action-btn {
  padding: 6px 12px;
  height: 28px;
  font-size: 12px;
  border-radius: 4px;
  transition: all 0.2s ease;
}

.action-btn:hover {
  transform: translateY(-1px);
}
</style>
