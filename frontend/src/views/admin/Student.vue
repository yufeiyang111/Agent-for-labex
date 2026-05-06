<template>
  <div class="admin-student-page">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/admin' }">管理员首页</el-breadcrumb-item>
      <el-breadcrumb-item>学生管理</el-breadcrumb-item>
    </el-breadcrumb>

    <!-- 页面标题和搜索区域 -->
    <div class="page-header">
      <h2 class="page-title">学生管理</h2>
      <div class="search-area">
        <el-select
          v-model="filterClazzNo"
          placeholder="选择班级筛选"
          clearable
          @change="handleSearch"
          class="clazz-filter"
        >
          <el-option
            v-for="item in clazzOptions"
            :key="item.no"
            :label="item.no + ' - ' + item.memo"
            :value="item.no"
          />
        </el-select>
        <el-input
          v-model="searchQuery"
          placeholder="搜索学号或姓名"
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
      <el-button @click="handleAdd" class="add-btn">
        <el-icon><Plus /></el-icon>
        新增学生
      </el-button>
      <el-button @click="showImportDialog" class="import-btn">
        <el-icon><Upload /></el-icon>
        批量导入
      </el-button>
    </div>

    <!-- 学生列表表格 -->
    <el-card class="table-card" shadow="hover">
      <el-table
        :data="studentList"
        v-loading="loading"
        stripe
        hover
        style="width: 100%"
      >
        <el-table-column prop="studentNo" label="学号" min-width="120" />
        <el-table-column prop="studentName" label="姓名" min-width="100" />
        <el-table-column prop="clazzNo" label="班级" min-width="120" />
        <el-table-column label="状态" width="90">
          <template #default="{ row }">
            <el-tag :type="row.state === 1 ? 'success' : 'info'">
              {{ row.state === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="ip" label="IP地址" min-width="140" />
        <el-table-column label="操作" width="420" fixed="right">
          <template #default="{ row }">
            <div class="action-buttons">
              <el-button
                :type="row.state === 1 ? 'warning' : 'success'"
                size="small"
                @click="handleToggleState(row)"
                class="action-btn"
              >
                {{ row.state === 1 ? '禁用' : '启用' }}
              </el-button>
              <el-button type="primary" size="small" @click="handleEdit(row)" class="action-btn">
                编辑
              </el-button>
              <el-button type="info" size="small" @click="handleResetPassword(row)" class="action-btn">
                重置密码
              </el-button>
              <el-button type="info" size="small" @click="handleResetIp(row)" class="action-btn">
                重置IP
              </el-button>
              <el-button type="danger" size="small" @click="handleDelete(row)" class="action-btn">
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
        @size-change="loadStudentList"
        @current-change="loadStudentList"
        class="pagination"
      />
    </el-card>

    <!-- 新增/编辑对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="500px"
      class="student-dialog"
    >
      <el-form
        ref="formRef"
        :model="formData"
        :rules="formRules"
        label-width="100px"
      >
        <el-form-item label="学号" prop="studentNo">
          <el-input
            v-model="formData.studentNo"
            placeholder="请输入学号"
            :disabled="isEdit"
          />
        </el-form-item>
        <el-form-item label="姓名" prop="studentName">
          <el-input v-model="formData.studentName" placeholder="请输入姓名" />
        </el-form-item>
        <el-form-item label="班级" prop="clazzNo">
          <el-select v-model="formData.clazzNo" placeholder="请选择班级" style="width: 100%">
            <el-option
              v-for="item in clazzOptions"
              :key="item.no"
              :label="item.no + ' - ' + item.memo"
              :value="item.no"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="初始密码" v-if="!isEdit" prop="studentPassword">
          <el-input
            v-model="formData.studentPassword"
            type="password"
            placeholder="留空则使用学号作为密码"
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

    <!-- 批量导入对话框 -->
    <el-dialog
      v-model="importDialogVisible"
      title="批量导入学生"
      width="500px"
      class="import-dialog"
    >
      <div class="import-tips">
        <p><strong>导入说明：</strong></p>
        <ol>
          <li>请上传 CSV 格式文件</li>
          <li>CSV 列顺序：学号,姓名</li>
          <li>第一行作为标题行将被跳过</li>
          <li>示例：</li>
        </ol>
        <pre>20230001,张三
20230002,李四</pre>
      </div>
      <el-select
        v-model="importClazzNo"
        placeholder="选择导入班级"
        style="width: 100%; margin-bottom: 15px"
      >
        <el-option
          v-for="item in clazzOptions"
          :key="item.no"
          :label="item.no + ' - ' + item.memo"
          :value="item.no"
        />
      </el-select>
      <el-upload
        ref="uploadRef"
        :auto-upload="false"
        :limit="1"
        accept=".csv"
        class="upload-area"
      >
        <template #trigger>
          <el-button type="primary">选择CSV文件</el-button>
        </template>
        <div class="upload-hint">只能上传csv文件，且不超过1个</div>
      </el-upload>
      <template #footer>
        <el-button @click="importDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleImport" :loading="importing">
          导入
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Search, Plus, Upload } from '@element-plus/icons-vue'
import { adminApi } from '@/api/index.js'

const loading = ref(false)
const submitting = ref(false)
const importing = ref(false)
const studentList = ref([])
const clazzOptions = ref([])
const dialogVisible = ref(false)
const importDialogVisible = ref(false)
const uploadRef = ref(null)
const dialogTitle = computed(() => isEdit.value ? '编辑学生' : '新增学生')
const isEdit = ref(false)
const formRef = ref(null)
const searchQuery = ref('')
const filterClazzNo = ref('')
const importClazzNo = ref('')

const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const formData = reactive({
  studentId: null,
  studentNo: '',
  studentName: '',
  studentPassword: '',
  clazzNo: '',
  state: 1
})

const formRules = {
  studentNo: [
    { required: true, message: '请输入学号', trigger: 'blur' }
  ],
  studentName: [
    { required: true, message: '请输入姓名', trigger: 'blur' },
    { max: 20, message: '最多20个字符', trigger: 'blur' }
  ],
  clazzNo: [
    { required: true, message: '请选择班级', trigger: 'change' }
  ]
}

const loadClazzList = async () => {
  try {
    const response = await adminApi.clazz.all()
    clazzOptions.value = response.data || []
  } catch (error) {
    console.error('加载班级列表失败', error)
  }
}

const loadStudentList = async () => {
  loading.value = true
  try {
    const params = {
      pageNum: pagination.page,
      pageSize: pagination.pageSize
    }
    if (searchQuery.value) {
      params.keyword = searchQuery.value
    }
    if (filterClazzNo.value) {
      params.clazzNo = filterClazzNo.value
    }
    const response = await adminApi.student.list(params)
    studentList.value = response.data?.list || []
    pagination.total = response.data?.total || 0
  } catch (error) {
    ElMessage.error('加载学生列表失败')
    console.error(error)
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadStudentList()
}

const resetForm = () => {
  Object.assign(formData, {
    studentId: null,
    studentNo: '',
    studentName: '',
    studentPassword: '',
    clazzNo: '',
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
    studentId: row.studentId,
    studentNo: row.studentNo,
    studentName: row.studentName,
    studentPassword: '',
    clazzNo: row.clazzNo,
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
      await adminApi.student.update(formData.studentId, {
        studentName: formData.studentName,
        clazzNo: formData.clazzNo,
        state: formData.state
      })
      ElMessage.success('更新成功')
    } else {
      const data = {
        studentNo: formData.studentNo,
        studentName: formData.studentName,
        clazzNo: formData.clazzNo,
        state: formData.state
      }
      if (formData.studentPassword) {
        data.studentPassword = formData.studentPassword
      }
      await adminApi.student.add(data)
      ElMessage.success('添加成功')
    }

    dialogVisible.value = false
    loadStudentList()
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
      `确认${action}学生 "${row.studentName}" 吗？`,
      '提示',
      { type: 'warning' }
    )
    await adminApi.student.updateState(row.studentId, newState)
    ElMessage.success(`${action}成功`)
    loadStudentList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(`${action}失败`)
      console.error(error)
    }
  }
}

const handleDelete = (row) => {
  ElMessageBox.confirm(
    `确认删除学生 "${row.studentName}" 吗？此操作不可恢复！`,
    '警告',
    { type: 'warning' }
  ).then(async () => {
    try {
      await adminApi.student.delete(row.studentId)
      ElMessage.success('删除成功')
      loadStudentList()
    } catch (error) {
      ElMessage.error('删除失败')
      console.error(error)
    }
  }).catch(() => {})
}

const handleResetPassword = async (row) => {
  try {
    await ElMessageBox.confirm(
      `确认重置学生 "${row.studentName}" 的密码吗？`,
      '提示',
      { type: 'warning' }
    )
    await adminApi.student.resetPassword(row.studentId)
    ElMessage.success('密码已重置为学号')
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('重置失败')
      console.error(error)
    }
  }
}

const handleResetIp = async (row) => {
  try {
    await ElMessageBox.confirm(
      `确认重置学生 "${row.studentName}" 的IP限制吗？`,
      '提示',
      { type: 'warning' }
    )
    await adminApi.student.resetIp(row.studentId)
    ElMessage.success('IP已重置')
    loadStudentList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('重置失败')
      console.error(error)
    }
  }
}

const showImportDialog = () => {
  importDialogVisible.value = true
}

const handleImport = async () => {
  const fileList = uploadRef.value?.uploadFiles || []
  if (fileList.length === 0) {
    ElMessage.warning('请选择CSV文件')
    return
  }

  if (!importClazzNo.value) {
    ElMessage.warning('请选择导入班级')
    return
  }

  try {
    importing.value = true
    const file = fileList[0].raw
    await adminApi.student.import(file, importClazzNo.value)
    ElMessage.success('导入成功')
    importDialogVisible.value = false
    uploadRef.value?.clearFiles()
    loadStudentList()
  } catch (error) {
    ElMessage.error('导入失败')
    console.error(error)
  } finally {
    importing.value = false
  }
}

onMounted(() => {
  loadClazzList()
  loadStudentList()
})
</script>

<style scoped>
.admin-student-page {
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
  align-items: center;
}

.clazz-filter {
  width: 200px;
}

.search-input {
  width: 260px;
}

.action-bar {
  margin-bottom: 24px;
  display: flex;
  gap: 14px;
}

.add-btn {
  background: #4caf50;
  border: none;
  color: #fff;
  padding: 14px 28px;
  border-radius: 14px;
  font-weight: 600;
  transition: all 0.3s cubic-bezier(0.25, 0.1, 0.25, 1);
}

.add-btn:hover {
  background: #2e7d32;
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(76, 175, 80, 0.35);
  color: #fff;
}

.import-btn {
  background: #6b7280;
  border: none;
  color: #fff;
  padding: 14px 28px;
  border-radius: 14px;
  font-weight: 600;
  transition: all 0.3s cubic-bezier(0.25, 0.1, 0.25, 1);
}

.import-btn:hover {
  background: #4b5563;
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(107, 114, 128, 0.35);
  color: #fff;
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

.student-dialog :deep(.el-dialog__header) {
  background: #ffffff;
  border-bottom: 1px solid #f0f0f0;
  padding: 24px 28px;
}

.student-dialog :deep(.el-dialog__body) {
  padding: 28px;
}

.import-dialog .import-tips {
  background: #fafafa;
  padding: 18px;
  border-radius: 14px;
  margin-bottom: 22px;
}

.import-tips ol {
  margin: 12px 0;
  padding-left: 22px;
}

.import-tips pre {
  background: #ffffff;
  padding: 14px;
  border-radius: 10px;
  font-family: monospace;
  margin-top: 12px;
  border: 1px solid #f0f0f0;
}

.upload-area {
  margin-top: 12px;
}

.upload-hint {
  font-size: 12px;
  color: #909399;
  margin-top: 8px;
}
</style>