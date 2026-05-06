<template>
  <div class="clazz-page">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/teacher' }">教师首页</el-breadcrumb-item>
      <el-breadcrumb-item>班级管理</el-breadcrumb-item>
    </el-breadcrumb>

    <!-- 页面标题和搜索区域 -->
    <div class="page-header">
      <h2 class="page-title">班级管理</h2>
      <div class="search-area">
        <el-input
          v-model="searchQuery"
          placeholder="搜索班级编号或描述"
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
        新增班级
      </el-button>
    </div>

    <!-- 班级列表表格 -->
    <el-card class="table-card" shadow="hover">
      <el-table
        :data="clazzList"
        v-loading="loading"
        stripe
        hover
        style="width: 100%"
      >
        <el-table-column prop="no" label="班级编号" min-width="120" />
        <el-table-column prop="memo" label="描述" min-width="180" />
        <el-table-column label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.state === 1 ? 'success' : 'info'">
              {{ row.state === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="260" fixed="right">
          <template #default="{ row }">
            <div class="action-buttons">
              <el-button
                :type="row.state === 1 ? 'warning' : 'success'"
                size="small"
                plain
                @click="handleToggleState(row)"
                class="action-btn"
              >
                {{ row.state === 1 ? '禁用' : '启用' }}
              </el-button>
              <el-button type="primary" size="small" plain @click="handleEdit(row)" class="action-btn">
                编辑
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
        @size-change="loadClazzList"
        @current-change="loadClazzList"
        class="pagination"
      />
    </el-card>

    <!-- 新增/编��对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="500px"
      class="clazz-dialog"
    >
      <el-form
        ref="formRef"
        :model="formData"
        :rules="formRules"
        label-width="100px"
      >
        <el-form-item label="班级编号" prop="no">
          <el-input v-model="formData.no" placeholder="请输入班级编号" :disabled="isEdit" />
        </el-form-item>
        <el-form-item label="描述" prop="memo">
          <el-input
            v-model="formData.memo"
            type="textarea"
            :rows="3"
            placeholder="请输入班级描述"
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
import { ElMessage, ElMessageBox } from 'element-plus'
import { Search, Plus } from '@element-plus/icons-vue'
import { teacherApi } from '@/api/index.js'

// 响应式数据
const loading = ref(false)
const submitting = ref(false)
const clazzList = ref([])
const dialogVisible = ref(false)
const dialogTitle = computed(() => isEdit.value ? '编辑班级' : '新增班级')
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
  no: '',
  memo: '',
  state: 1
})

// 表单验证规则
const formRules = {
  no: [
    { required: true, message: '请输入班级编号', trigger: 'blur' },
    { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
  ],
  memo: [
    { required: true, message: '请输入班级描述', trigger: 'blur' },
    { max: 200, message: '最多200个字符', trigger: 'blur' }
  ]
}

// 加载班级列表
const loadClazzList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize
    }
    if (searchQuery.value) {
      params.keyword = searchQuery.value
    }
    const response = await teacherApi.clazz.list(params)
    clazzList.value = response.data?.list || []
    pagination.total = response.data?.total || 0
  } catch (error) {
    ElMessage.error('加载班级列表失败')
    console.error(error)
  } finally {
    loading.value = false
  }
}

// 搜索
const handleSearch = () => {
  pagination.page = 1
  loadClazzList()
}

// 重置表单
const resetForm = () => {
  Object.assign(formData, {
    no: '',
    memo: '',
    state: 1
  })
}

// 新增班级
const handleAdd = () => {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
}

// 编辑班级
const handleEdit = (row) => {
  Object.assign(formData, {
    no: row.no,
    memo: row.memo,
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
      await teacherApi.clazz.update(formData.no, formData)
      ElMessage.success('更新成功')
    } else {
      await teacherApi.clazz.add(formData)
      ElMessage.success('添加成功')
    }

    dialogVisible.value = false
    loadClazzList()
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
  const newState = row.state === 1 ? 0 : 1
  const action = newState === 1 ? '启用' : '禁用'

  try {
    await ElMessageBox.confirm(
      `确认${action}班级 "${row.no}" 吗？`,
      '提示',
      { type: 'warning' }
    )
    await teacherApi.clazz.updateState(row.no, newState)
    ElMessage.success(`${action}成功`)
    loadClazzList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(`${action}失败`)
      console.error(error)
    }
  }
}

// 删除班级
const handleDelete = (row) => {
  ElMessageBox.confirm(
    `确认删除班级 "${row.no}" 吗？此操作不可恢复！`,
    '警告',
    { type: 'warning' }
  ).then(async () => {
    try {
      await teacherApi.clazz.delete(row.no)
      ElMessage.success('删除成功')
      loadClazzList()
    } catch (error) {
      ElMessage.error('删除失败')
      console.error(error)
    }
  }).catch(() => {})
}

// 页面初始化
onMounted(() => {
  loadClazzList()
})
</script>

<style scoped>
.clazz-page {
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

.clazz-dialog :deep(.el-dialog__header) {
  background: #e8f5e9;
  border-radius: 8px 8px 0 0;
}

.clazz-dialog :deep(.el-dialog__title) {
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
