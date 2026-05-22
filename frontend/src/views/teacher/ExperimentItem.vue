<template>
  <div class="experiment-item-page">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/teacher' }">教师首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/teacher/experiment' }">实验管理</el-breadcrumb-item>
      <el-breadcrumb-item>题目管理</el-breadcrumb-item>
    </el-breadcrumb>

    <!-- 页面标题和实验信息 -->
    <div class="page-header">
      <div class="header-left">
        <h2 class="page-title">{{ experimentInfo.experimentName || '实验题目管理' }}</h2>
        <p class="experiment-no">实验编号: {{ experimentNo }}</p>
      </div>
      <el-button type="primary" @click="handleAdd" class="add-btn">
        <el-icon><Plus /></el-icon>
        新增题目
      </el-button>
    </div>

    <!-- 题目列表表格 -->
    <el-card class="table-card" shadow="hover">
      <el-table
        :data="itemList"
        v-loading="loading"
        stripe
        hover
        style="width: 100%"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" />
        <el-table-column prop="experimentItemNo" label="题号" min-width="100" />
        <el-table-column prop="experimentItemName" label="题目名称" min-width="150" />
        <el-table-column label="题型" min-width="100">
          <template #default="{ row }">
            <el-tag :type="getQuestionTypeTag(row.experimentItemType)">
              {{ getQuestionTypeName(row.experimentItemType) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="experimentItemScore" label="分值" width="80" />
        <el-table-column prop="experimentItemAnswer" label="标准答案" min-width="200" show-overflow-tooltip />
        <el-table-column label="状态" width="90">
          <template #default="{ row }">
            <el-tag :type="row.state === 1 ? 'success' : 'info'">
              {{ row.state === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="180" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small" @click="handleEdit(row)">
              编辑
            </el-button>
            <el-button type="danger" size="small" @click="handleDelete(row)">
              删除
            </el-button>
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
        @size-change="loadItemList"
        @current-change="loadItemList"
        class="pagination"
      />

      <!-- 批量操作 -->
      <div class="batch-actions" v-if="selectedRows.length > 0">
        <el-button type="danger" @click="handleBatchDelete" :loading="batchDeleting">
          批量删除 ({{ selectedRows.length }})
        </el-button>
        <el-button @click="clearSelection">取消选择</el-button>
      </div>
    </el-card>

    <!-- 新增/编辑题目对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="600px"
      class="item-dialog"
    >
      <el-form
        ref="formRef"
        :model="formData"
        :rules="formRules"
        label-width="100px"
      >
        <el-form-item label="题号" prop="experimentItemNo">
          <el-input v-model="formData.experimentItemNo" placeholder="请输入题号" :disabled="isEdit" />
        </el-form-item>
        <el-form-item label="题目名称" prop="experimentItemName">
          <el-input v-model="formData.experimentItemName" placeholder="请输入题目名称" />
        </el-form-item>
        <el-form-item label="题目内容" prop="experimentItemContent">
          <el-input
            v-model="formData.experimentItemContent"
            type="textarea"
            :rows="4"
            placeholder="请输入题目内容"
          />
        </el-form-item>
        <el-form-item label="标准答案" prop="experimentItemAnswer">
          <el-input
            v-model="formData.experimentItemAnswer"
            type="textarea"
            :rows="3"
            placeholder="请输入标准答案"
          />
        </el-form-item>
        <el-form-item label="分值" prop="experimentItemScore">
          <el-input-number
            v-model="formData.experimentItemScore"
            :min="0"
            :max="100"
            placeholder="请输入分值"
          />
        </el-form-item>
        <el-form-item label="题型">
          <el-select v-model="formData.experimentItemType" placeholder="请选择题型" style="width: 100%">
            <el-option label="选择题" :value="1" />
            <el-option label="填空题" :value="2" />
            <el-option label="简答题" :value="3" />
            <el-option label="编程题" :value="4" />
            <el-option label="综合题" :value="5" />
          </el-select>
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
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { teacherApi } from '@/api/index.js'

const route = useRoute()
const router = useRouter()

// 响应式数据
const loading = ref(false)
const submitting = ref(false)
const batchDeleting = ref(false)
const itemList = ref([])
const experimentInfo = ref({})
const experimentNo = ref('')
const dialogVisible = ref(false)
const dialogTitle = computed(() => isEdit.value ? '编辑题目' : '新增题目')
const isEdit = ref(false)
const formRef = ref(null)
const selectedRows = ref([])

// 分页
const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

// 表单数据
const formData = reactive({
  experimentItemNo: '',
  experimentItemName: '',
  experimentItemContent: '',
  experimentItemAnswer: '',
  experimentItemScore: 10,
  experimentItemType: 1,
  state: 1,
  experimentId: null
})

// 表单验证规则
const formRules = {
  experimentItemNo: [
    { required: true, message: '请输入题号', trigger: 'blur' }
  ],
  experimentItemName: [
    { required: true, message: '请输入题目名称', trigger: 'blur' }
  ],
  experimentItemContent: [
    { required: true, message: '请输入题目内容', trigger: 'blur' }
  ],
  experimentItemAnswer: [
    { required: true, message: '请输入标准答案', trigger: 'blur' }
  ],
  experimentItemScore: [
    { required: true, message: '请输入分值', trigger: 'blur' }
  ]
}

// 题型标签类型
const getQuestionTypeTag = (type) => {
  const tagMap = {
    1: 'success',
    2: 'warning',
    3: 'danger',
    4: 'primary',
    5: 'info'
  }
  return tagMap[type] || 'info'
}

// 题型名称
const getQuestionTypeName = (type) => {
  const nameMap = {
    1: '选择题',
    2: '填空题',
    3: '简答题',
    4: '编程题',
    5: '综合题'
  }
  return nameMap[type] || '未知'
}

// 加载实验信息
const loadExperimentInfo = async () => {
  try {
    const response = await teacherApi.experiment.get(experimentNo.value)
    experimentInfo.value = response.data || {}
  } catch (error) {
    console.error('加载实验信息失败', error)
  }
}

// 加载题目列表
const loadItemList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize,
      experimentId: parseInt(experimentNo.value)
    }
    const response = await teacherApi.experimentItem.list(params)
    itemList.value = response.data?.list || []
    pagination.total = response.data?.total || 0
  } catch (error) {
    ElMessage.error('加载题目列表失败')
    console.error(error)
  } finally {
    loading.value = false
  }
}

// 选择变化
const handleSelectionChange = (selection) => {
  selectedRows.value = selection
}

// 清空选择
const clearSelection = () => {
  selectedRows.value = []
}

// 重置表单
const resetForm = () => {
  Object.assign(formData, {
    experimentItemNo: '',
    experimentItemName: '',
    experimentItemContent: '',
    experimentItemAnswer: '',
    experimentItemScore: 10,
    experimentItemType: 1,
    state: 1,
    experimentId: experimentNo.value ? parseInt(experimentNo.value) : null
  })
}

// 新增题目
const handleAdd = () => {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
}

// 编辑题目
const handleEdit = (row) => {
  Object.assign(formData, {
    experimentItemId: row.experimentItemId,
    experimentItemNo: row.experimentItemNo,
    experimentItemName: row.experimentItemName,
    experimentItemContent: row.experimentItemContent,
    experimentItemAnswer: row.experimentItemAnswer,
    experimentItemScore: row.experimentItemScore,
    experimentItemType: row.experimentItemType,
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

    const submitData = {
      experimentId: parseInt(experimentNo.value),
      experimentItemNo: formData.experimentItemNo,
      experimentItemName: formData.experimentItemName,
      experimentItemContent: formData.experimentItemContent,
      experimentItemAnswer: formData.experimentItemAnswer,
      experimentItemScore: formData.experimentItemScore,
      experimentItemType: formData.experimentItemType,
      state: formData.state
    }

    if (isEdit.value) {
      await teacherApi.experimentItem.update(formData.experimentItemId, submitData)
      ElMessage.success('更新成功')
    } else {
      await teacherApi.experimentItem.add(submitData)
      ElMessage.success('添加成功')
    }

    dialogVisible.value = false
    loadItemList()
  } catch (error) {
    if (error !== false) {
      ElMessage.error('操作失败')
      console.error(error)
    }
  } finally {
    submitting.value = false
  }
}

// 删除题目
const handleDelete = (row) => {
  ElMessageBox.confirm(
    `确认删除题目 "${row.experimentItemName}" 吗？此操作不可恢复！`,
    '警告',
    { type: 'warning' }
  ).then(async () => {
    try {
      await teacherApi.experimentItem.delete(row.experimentItemId)
      ElMessage.success('删除成功')
      loadItemList()
    } catch (error) {
      ElMessage.error('删除失败')
      console.error(error)
    }
  }).catch(() => {})
}

// 批量删除
const handleBatchDelete = () => {
  ElMessageBox.confirm(
    `确认删除选中的 ${selectedRows.value.length} 道题目吗？此操作不可恢复！`,
    '警告',
    { type: 'warning' }
  ).then(async () => {
    try {
      const ids = selectedRows.value.map(row => row.experimentItemId)
      await teacherApi.experimentItem.batchDelete(ids)
      ElMessage.success('批量删除成功')
      clearSelection()
      loadItemList()
    } catch (error) {
      ElMessage.error('批量删除失败')
      console.error(error)
    }
  }).catch(() => {})
}

// 页面初始化
onMounted(() => {
  experimentNo.value = route.params.experimentId
  loadExperimentInfo()
  loadItemList()
})
</script>

<style scoped>
.experiment-item-page {
  padding: 20px;
}

.breadcrumb {
  margin-bottom: 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 20px;
  flex-wrap: wrap;
  gap: 15px;
}

.header-left {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.page-title {
  font-size: 24px;
  font-weight: 600;
  color: #2d8a4e;
  margin: 0;
}

.experiment-no {
  color: #909399;
  font-size: 14px;
  margin: 0;
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

.batch-actions {
  margin-top: 15px;
  padding: 15px;
  background: #f0f9f0;
  border-radius: 8px;
  display: flex;
  gap: 10px;
}

.item-dialog :deep(.el-dialog__header) {
  background: #e8f5e9;
  border-radius: 8px 8px 0 0;
}

.item-dialog :deep(.el-dialog__title) {
  color: #2d8a4e;
  font-weight: 600;
}
</style>
