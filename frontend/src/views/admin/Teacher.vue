<template>
  <div class="admin-teacher-page">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/admin' }">管理员首页</el-breadcrumb-item>
      <el-breadcrumb-item>教师管理</el-breadcrumb-item>
    </el-breadcrumb>

    <!-- 页面标题和搜索区域 -->
    <div class="page-header">
      <h2 class="page-title">教师管理</h2>
      <div class="search-area">
        <el-input
          v-model="searchQuery"
          placeholder="搜索账号或姓名"
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
        新增教师
      </el-button>
    </div>

    <!-- 教师列表表格 -->
    <el-card class="table-card" shadow="hover">
      <el-table
        :data="teacherList"
        v-loading="loading"
        stripe
        hover
        style="width: 100%"
      >
        <el-table-column prop="teacherAccount" label="账号" min-width="120" />
        <el-table-column prop="teacherName" label="姓名" min-width="120" />
        <el-table-column label="角色" width="100">
          <template #default="{ row }">
            <el-tag :type="row.role === 'ADMIN' ? 'danger' : 'success'">
              {{ row.role === 'ADMIN' ? '管理员' : '教师' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="状态" width="90">
          <template #default="{ row }">
            <el-tag :type="row.state === 1 ? 'success' : 'info'">
              {{ row.state === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="380" fixed="right">
          <template #default="{ row }">
            <div class="action-buttons">
              <el-button
                :type="row.state === 1 ? 'warning' : 'success'"
                size="small"
                @click="handleToggleState(row)"
                :disabled="row.role === 'ADMIN'"
                class="action-btn"
              >
                {{ row.state === 1 ? '禁用' : '启用' }}
              </el-button>
              <el-button type="primary" size="small" @click="handleEdit(row)" class="action-btn">
                编辑
              </el-button>
              <el-button
                type="info"
                size="small"
                @click="handleResetPassword(row)"
                :disabled="row.role === 'ADMIN'"
                class="action-btn"
              >
                重置密码
              </el-button>
              <el-button
                type="danger"
                size="small"
                @click="handleDelete(row)"
                :disabled="row.role === 'ADMIN'"
                class="action-btn"
              >
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
        @size-change="loadTeacherList"
        @current-change="loadTeacherList"
        class="pagination"
      />
    </el-card>

    <!-- 新增/编辑对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="500px"
      class="teacher-dialog"
    >
      <el-form
        ref="formRef"
        :model="formData"
        :rules="formRules"
        label-width="100px"
      >
        <el-form-item label="账号" prop="teacherAccount">
          <el-input
            v-model="formData.teacherAccount"
            placeholder="请输入账号"
            :disabled="isEdit"
          />
        </el-form-item>
        <el-form-item label="姓名" prop="teacherName">
          <el-input v-model="formData.teacherName" placeholder="请输入姓名" />
        </el-form-item>
        <el-form-item label="角色" prop="role">
          <el-select v-model="formData.role" placeholder="请选择角色" style="width: 100%">
            <el-option label="普通教师" value="TEACHER" />
            <el-option label="管理员" value="ADMIN" />
          </el-select>
        </el-form-item>
        <el-form-item label="初始密码" v-if="!isEdit" prop="teacherPassword">
          <el-input
            v-model="formData.teacherPassword"
            type="password"
            placeholder="留空则使用账号作为密码"
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
const teacherList = ref([])
const dialogVisible = ref(false)
const dialogTitle = computed(() => isEdit.value ? '编辑教师' : '新增教师')
const isEdit = ref(false)
const formRef = ref(null)
const searchQuery = ref('')

const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const formData = reactive({
  teacherId: null,
  teacherAccount: '',
  teacherName: '',
  teacherPassword: '',
  role: 'TEACHER',
  state: 1
})

const formRules = {
  teacherAccount: [
    { required: true, message: '请输入账号', trigger: 'blur' },
    { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
  ],
  teacherName: [
    { required: true, message: '请输入姓名', trigger: 'blur' },
    { max: 20, message: '最多20个字符', trigger: 'blur' }
  ],
  role: [
    { required: true, message: '请选择角色', trigger: 'change' }
  ]
}

const loadTeacherList = async () => {
  loading.value = true
  try {
    const params = {
      pageNum: pagination.page,
      pageSize: pagination.pageSize
    }
    if (searchQuery.value) {
      params.keyword = searchQuery.value
    }
    const response = await adminApi.teacher.list(params)
    teacherList.value = response.data?.list || []
    pagination.total = response.data?.total || 0
  } catch (error) {
    ElMessage.error('加载教师列表失败')
    console.error(error)
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadTeacherList()
}

const resetForm = () => {
  Object.assign(formData, {
    teacherId: null,
    teacherAccount: '',
    teacherName: '',
    teacherPassword: '',
    role: 'TEACHER',
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
    teacherId: row.teacherId,
    teacherAccount: row.teacherAccount,
    teacherName: row.teacherName,
    teacherPassword: '',
    role: row.role || 'TEACHER',
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
      await adminApi.teacher.update(formData.teacherId, {
        teacherName: formData.teacherName,
        role: formData.role,
        state: formData.state
      })
      ElMessage.success('更新成功')
    } else {
      const data = {
        teacherAccount: formData.teacherAccount,
        teacherName: formData.teacherName,
        role: formData.role,
        state: formData.state
      }
      if (formData.teacherPassword) {
        data.teacherPassword = formData.teacherPassword
      }
      await adminApi.teacher.add(data)
      ElMessage.success('添加成功')
    }

    dialogVisible.value = false
    loadTeacherList()
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
      `确认${action}教师 "${row.teacherName}" 吗？`,
      '提示',
      { type: 'warning' }
    )
    await adminApi.teacher.updateState(row.teacherId, newState)
    ElMessage.success(`${action}成功`)
    loadTeacherList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(`${action}失败`)
      console.error(error)
    }
  }
}

const handleResetPassword = async (row) => {
  try {
    await ElMessageBox.confirm(
      `确认重置教师 "${row.teacherName}" 的密码吗？`,
      '提示',
      { type: 'warning' }
    )
    await adminApi.teacher.resetPassword(row.teacherId)
    ElMessage.success('密码已重置为账号')
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('重置失败')
      console.error(error)
    }
  }
}

const handleDelete = (row) => {
  ElMessageBox.confirm(
    `确认删除教师 "${row.teacherName}" 吗？此操作不可恢复！`,
    '警告',
    { type: 'warning' }
  ).then(async () => {
    try {
      await adminApi.teacher.delete(row.teacherId)
      ElMessage.success('删除成功')
      loadTeacherList()
    } catch (error) {
      ElMessage.error('删除失败')
      console.error(error)
    }
  }).catch(() => {})
}

onMounted(() => {
  loadTeacherList()
})
</script>

<style scoped>
.admin-teacher-page {
  padding: 32px;
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
  background: #4caf50;
  border: none;
  padding: 14px 28px;
  border-radius: 14px;
  font-weight: 600;
  transition: all 0.3s cubic-bezier(0.25, 0.1, 0.25, 1);
}

.add-btn:hover {
  background: #2e7d32;
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(76, 175, 80, 0.35);
}

.table-card {
  border-radius: 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  border: none;
  overflow: hidden;
}

:deep(.el-table) {
  font-size: 13px;
}

:deep(.el-table th.el-table__cell) {
  background-color: #fafafa;
  font-weight: 600;
  color: #6e6e73;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 0.8px;
}

:deep(.el-table__row:hover > td.el-table__cell) {
  background-color: #fafafa !important;
}

.pagination {
  margin-top: 24px;
  justify-content: flex-end;
  padding: 20px 0 0 0;
}

.action-buttons {
  display: flex;
  align-items: center;
  gap: 10px;
  flex-wrap: nowrap;
}

.action-btn {
  padding: 8px 14px;
  height: 32px;
  font-size: 12px;
  border-radius: 10px;
  transition: all 0.25s cubic-bezier(0.25, 0.1, 0.25, 1);
  margin: 0;
  font-weight: 600;
}

.action-btn:hover {
  transform: translateY(-2px);
}

.teacher-dialog :deep(.el-dialog__header) {
  background: #ffffff;
  border-bottom: 1px solid #f0f0f0;
  padding: 24px 28px;
}

.teacher-dialog :deep(.el-dialog__body) {
  padding: 28px;
}
</style>
