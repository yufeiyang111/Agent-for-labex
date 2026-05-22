<template>
  <div class="student-page">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/teacher' }">教师首页</el-breadcrumb-item>
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
      <el-button type="success" @click="handleAdd" class="add-btn">
        <el-icon><Plus /></el-icon>
        新增学生
      </el-button>
      <el-button type="info" @click="showImportDialog" class="import-btn">
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
        <el-table-column label="操作" width="320" fixed="right">
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
              <el-button
                type="primary"
                size="small"
                plain
                @click="handleEdit(row)"
                class="action-btn"
              >
                编辑
              </el-button>
              <el-button
                type="danger"
                size="small"
                plain
                @click="handleDelete(row)"
                class="action-btn"
              >
                删除
              </el-button>
              <el-dropdown trigger="click" @command="(cmd) => handleMoreCommand(cmd, row)" placement="bottom-end">
                <el-button type="info" size="small" class="more-btn">
                  <el-icon><MoreFilled /></el-icon>
                </el-button>
                <template #dropdown>
                  <el-dropdown-menu>
                    <el-dropdown-item command="resetPassword">
                      <el-icon><Key /></el-icon>
                      重置密码
                    </el-dropdown-item>
                    <el-dropdown-item command="resetIp">
                      <el-icon><RefreshRight /></el-icon>
                      重置IP
                    </el-dropdown-item>
                  </el-dropdown-menu>
                </template>
              </el-dropdown>
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

    <!-- 新增/编辑学生对话框 -->
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
          <el-input v-model="formData.studentNo" placeholder="请输入学号" :disabled="isEdit" />
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
        <el-form-item label="初始密码">
          <el-input v-model="formData.password" type="password" placeholder="留空则使用默认密码" />
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
          <li>如果学号已存在，系统将自动将其移动到当前班级</li>
          <li>示例：</li>
        </ol>
        <pre>2023001,张三
2023002,李四</pre>
      </div>
      <el-form label-width="80px">
        <el-form-item label="目标班级">
          <el-select v-model="importClazzNo" placeholder="请选择班级" style="width: 100%">
            <el-option
              v-for="item in clazzOptions"
              :key="item.no"
              :label="item.no + ' - ' + item.memo"
              :value="item.no"
            />
          </el-select>
        </el-form-item>
      </el-form>
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
import { Search, Plus, Upload, MoreFilled, Key, RefreshRight } from '@element-plus/icons-vue'
import { teacherApi } from '@/api/index.js'

// 响应式数据
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

// 分页
const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

// 表单数据
const formData = reactive({
  studentId: null,
  studentNo: '',
  studentName: '',
  clazzNo: '',
  password: '',
  state: 1
})

// 表单验证规则
const formRules = {
  studentNo: [
    { required: true, message: '请输入学号', trigger: 'blur' },
    { min: 2, max: 30, message: '长度在 2 到 30 个字符', trigger: 'blur' }
  ],
  studentName: [
    { required: true, message: '请输入姓名', trigger: 'blur' },
    { max: 20, message: '最多20个字符', trigger: 'blur' }
  ],
  clazzNo: [
    { required: true, message: '请选择班级', trigger: 'change' }
  ]
}

// 加载班级列表（用于下拉框）
const loadClazzList = async () => {
  try {
    const response = await teacherApi.clazz.all()
    clazzOptions.value = response.data || []
  } catch (error) {
    console.error('加载班级列表失败', error)
  }
}

// 加载学生列表
const loadStudentList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize
    }
    if (searchQuery.value) {
      params.keyword = searchQuery.value
    }
    if (filterClazzNo.value) {
      params.clazzNo = filterClazzNo.value
    }
    const response = await teacherApi.student.list(params)
    studentList.value = response.data?.list || []
    pagination.total = response.data?.total || 0
  } catch (error) {
    ElMessage.error('加载学生列表失败')
    console.error(error)
  } finally {
    loading.value = false
  }
}

// 搜索
const handleSearch = () => {
  pagination.page = 1
  loadStudentList()
}

// 重置表单
const resetForm = () => {
  Object.assign(formData, {
    studentId: null,
    studentNo: '',
    studentName: '',
    clazzNo: '',
    password: '',
    state: 1
  })
}

// 新增学生
const handleAdd = () => {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
}

// 编辑学生
const handleEdit = (row) => {
  Object.assign(formData, {
    studentId: row.studentId,
    studentNo: row.studentNo,
    studentName: row.studentName,
    clazzNo: row.clazzNo,
    password: '',
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
      studentNo: formData.studentNo,
      studentName: formData.studentName,
      clazzNo: formData.clazzNo,
      state: formData.state,
      studentPassword: formData.password || formData.studentNo
    }

    if (isEdit.value) {
      await teacherApi.student.update(formData.studentId, submitData)
      ElMessage.success('更新成功')
    } else {
      await teacherApi.student.add(submitData)
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

// 切换状态
const handleToggleState = async (row) => {
  const newState = row.state === 1 ? 0 : 1
  const action = newState === 1 ? '启用' : '禁用'

  try {
    await ElMessageBox.confirm(
      `确认${action}学生 "${row.studentName}" 吗？`,
      '提示',
      { type: 'warning' }
    )
    await teacherApi.student.updateState(row.studentId, newState)
    ElMessage.success(`${action}成功`)
    loadStudentList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(`${action}失败`)
      console.error(error)
    }
  }
}

// 删除学生
const handleDelete = (row) => {
  ElMessageBox.confirm(
    `确认删除学生 "${row.studentName}" 吗？此操作不可恢复！`,
    '警告',
    { type: 'warning' }
  ).then(async () => {
    try {
      await teacherApi.student.delete(row.studentId)
      ElMessage.success('删除成功')
      loadStudentList()
    } catch (error) {
      ElMessage.error('删除失败')
      console.error(error)
    }
  }).catch(() => {})
}

// 重置密码
const handleResetPassword = async (row) => {
  try {
    await ElMessageBox.confirm(
      `确认重置学生 "${row.studentName}" 的密码吗？`,
      '提示',
      { type: 'warning' }
    )
    await teacherApi.student.resetPassword(row.studentId)
    ElMessage.success('密码重置成功')
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('重置失败')
      console.error(error)
    }
  }
}

// 重置IP
const handleResetIp = async (row) => {
  try {
    await ElMessageBox.confirm(
      `确认重置学生 "${row.studentName}" 的IP限制吗？`,
      '提示',
      { type: 'warning' }
    )
    await teacherApi.student.resetIp(row.studentId)
    ElMessage.success('IP重置成功')
    loadStudentList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('重置失败')
      console.error(error)
    }
  }
}

// 更多操作命令处理
const handleMoreCommand = (command, row) => {
  if (command === 'resetPassword') {
    handleResetPassword(row)
  } else if (command === 'resetIp') {
    handleResetIp(row)
  }
}

// 显示导入对话框
const showImportDialog = () => {
  importDialogVisible.value = true
}

// 处理批量导入
const handleImport = async () => {
  const fileList = uploadRef.value?.uploadFiles || []
  if (fileList.length === 0) {
    ElMessage.warning('请选择CSV文件')
    return
  }

  if (!importClazzNo.value) {
    ElMessage.warning('请选择目标班级')
    return
  }

  try {
    importing.value = true
    const file = fileList[0].raw
    const res = await teacherApi.student.import(file, importClazzNo.value)
    ElMessage.success(res.message || '导入成功')
    importDialogVisible.value = false
    uploadRef.value?.clearFiles()
    importClazzNo.value = ''
    loadStudentList()
  } catch (error) {
    ElMessage.error('导入失败')
    console.error(error)
  } finally {
    importing.value = false
  }
}

// 页面初始化
onMounted(() => {
  loadClazzList()
  loadStudentList()
})
</script>

<style scoped>
.student-page {
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
  align-items: center;
}

.clazz-filter {
  width: 220px;
}

.search-input {
  width: 240px;
}

.action-bar {
  margin-bottom: 20px;
  display: flex;
  gap: 10px;
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

.import-btn {
  background: #909399;
  border: none;
  transition: all 0.3s ease;
}

.import-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(144, 147, 153, 0.4);
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

.more-btn {
  padding: 6px 8px;
  height: 28px;
  width: 28px;
  border-radius: 4px;
  transition: all 0.2s ease;
}

.more-btn:hover {
  transform: translateY(-1px);
}

/* 表格内下拉菜单样式 */
:deep(.el-dropdown-menu__item) {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 16px;
  font-size: 13px;

  .el-icon {
    font-size: 14px;
  }
}

.student-dialog :deep(.el-dialog__header) {
  background: #e8f5e9;
  border-radius: 8px 8px 0 0;
}

.student-dialog :deep(.el-dialog__title) {
  color: #2d8a4e;
  font-weight: 600;
}

.import-dialog .import-tips {
  background: #f0f9f0;
  padding: 15px;
  border-radius: 8px;
  margin-bottom: 20px;
  border-left: 4px solid #2d8a4e;
}

.import-tips ol {
  margin: 10px 0;
  padding-left: 20px;
}

.import-tips pre {
  background: #fff;
  padding: 10px;
  border-radius: 4px;
  font-family: monospace;
  margin-top: 10px;
}

.upload-area {
  margin-top: 10px;
}

.upload-hint {
  font-size: 12px;
  color: #909399;
  margin-top: 8px;
}
</style>
