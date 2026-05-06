<template>
  <div class="admin-clazz-page">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/admin' }">管理员首页</el-breadcrumb-item>
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
        <el-table-column prop="memo" label="描述" min-width="200" />
        <el-table-column label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.state === 1 ? 'success' : 'info'">
              {{ row.state === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="240" fixed="right">
          <template #default="{ row }">
            <el-button
              :type="row.state === 1 ? 'warning' : 'success'"
              size="small"
              @click="handleToggleState(row)"
            >
              {{ row.state === 1 ? '禁用' : '启用' }}
            </el-button>
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
        @size-change="loadClazzList"
        @current-change="loadClazzList"
        class="pagination"
      />
    </el-card>

    <!-- 新增/编辑对话框 -->
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
import { adminApi } from '@/api/index.js'

const loading = ref(false)
const submitting = ref(false)
const clazzList = ref([])
const dialogVisible = ref(false)
const dialogTitle = computed(() => isEdit.value ? '编辑班级' : '新增班级')
const isEdit = ref(false)
const formRef = ref(null)
const searchQuery = ref('')

const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const formData = reactive({
  no: '',
  memo: '',
  state: 1
})

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

const loadClazzList = async () => {
  loading.value = true
  try {
    const params = {
      pageNum: pagination.page,
      pageSize: pagination.pageSize
    }
    if (searchQuery.value) {
      params.keyword = searchQuery.value
    }
    const response = await adminApi.clazz.list(params)
    clazzList.value = response.data?.list || []
    pagination.total = response.data?.total || 0
  } catch (error) {
    ElMessage.error('加载班级列表失败')
    console.error(error)
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadClazzList()
}

const resetForm = () => {
  Object.assign(formData, {
    no: '',
    memo: '',
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
    no: row.no,
    memo: row.memo,
    state: row.state
  })
  isEdit.value = true
  dialogVisible.value = true
}

const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    submitting.value = true

    if (isEdit.value) {
      await adminApi.clazz.update(formData.no, {
        memo: formData.memo,
        state: formData.state
      })
      ElMessage.success('更新成功')
    } else {
      await adminApi.clazz.add(formData)
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

const handleToggleState = async (row) => {
  const newState = row.state === 1 ? 0 : 1
  const action = newState === 1 ? '启用' : '禁用'

  try {
    await ElMessageBox.confirm(
      `确认${action}班级 "${row.no}" 吗？`,
      '提示',
      { type: 'warning' }
    )
    await adminApi.clazz.updateState(row.no, newState)
    ElMessage.success(`${action}成功`)
    loadClazzList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(`${action}失败`)
      console.error(error)
    }
  }
}

const handleDelete = (row) => {
  ElMessageBox.confirm(
    `确认删除班级 "${row.no}" 吗？此操作不可恢复！`,
    '警告',
    { type: 'warning' }
  ).then(async () => {
    try {
      await adminApi.clazz.delete(row.no)
      ElMessage.success('删除成功')
      loadClazzList()
    } catch (error) {
      ElMessage.error('删除失败')
      console.error(error)
    }
  }).catch(() => {})
}

onMounted(() => {
  loadClazzList()
})
</script>

<style scoped>
.admin-clazz-page {
  padding: 20px;
}

.breadcrumb {
  margin-bottom: 28px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 28px;
  flex-wrap: wrap;
  gap: 16px;
  padding: 24px 28px;
  background: #ffffff;
  border-radius: 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.page-title {
  font-size: 22px;
  font-weight: 700;
  color: #1d1d1f;
  margin: 0;
  letter-spacing: -0.5px;
}

.search-area {
  display: flex;
  gap: 14px;
}

.search-input {
  width: 280px;
}

.action-bar {
  margin-bottom: 24px;
}

.add-btn {
  background: #3b82f6;
  border: none;
  padding: 14px 28px;
  border-radius: 14px;
  font-weight: 600;
  transition: all 0.3s cubic-bezier(0.25, 0.1, 0.25, 1);
}

.add-btn:hover {
  background: #2563eb;
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(59, 130, 246, 0.35);
}

.table-card {
  border-radius: 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  border: none;
  overflow: hidden;
}

.pagination {
  margin-top: 24px;
  justify-content: flex-end;
  padding: 20px 0 0 0;
}

.clazz-dialog :deep(.el-dialog__header) {
  background: #ffffff;
  border-bottom: 1px solid #f0f0f0;
  padding: 24px 28px;
}

.clazz-dialog :deep(.el-dialog__body) {
  padding: 28px;
}
</style>