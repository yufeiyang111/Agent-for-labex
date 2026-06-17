<template>
  <div class="student-page wabi-page">
    <div class="wabi-body">
      <div class="wabi-card">
        <div class="wabi-card-header">
          <div class="header-left">
            <span class="wabi-card-title">学生管理</span>
            <div class="filter-wrapper">
              <el-select
                v-model="filterClazzNo"
                placeholder="选择班级"
                clearable
                @change="handleSearch"
                size="small"
                class="wabi-select"
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
                size="small"
                class="wabi-search"
              >
                <template #prefix>
                  <el-icon><Search /></el-icon>
                </template>
              </el-input>
            </div>
          </div>
          <div class="header-actions">
            <el-button @click="showImportDialog" class="wabi-btn-ghost">
              <el-icon><Upload /></el-icon>
              批量导入
            </el-button>
            <el-button type="primary" :icon="Plus" @click="handleAdd" class="wabi-btn-primary">
              新增学生
            </el-button>
          </div>
        </div>
        <div class="wabi-card-content">
          <div v-if="!loading && !studentList.length" class="wabi-empty">
            <p class="wabi-empty-text">暂无学生数据</p>
          </div>
          <div v-else class="student-list">
            <div v-for="student in studentList" :key="student.studentId" class="student-item">
              <div class="student-info">
                <div class="student-header">
                  <span class="student-no">{{ student.studentNo }}</span>
                  <span class="student-name">{{ student.studentName }}</span>
                  <span class="wabi-tag" :class="student.state === 1 ? 'wabi-tag-accent' : ''">
                    {{ student.state === 1 ? '启用' : '禁用' }}
                  </span>
                </div>
                <div class="student-meta">
                  <span>{{ student.clazzNo }}</span>
                  <span v-if="student.ip">IP: {{ student.ip }}</span>
                </div>
              </div>
              <div class="student-actions">
                <el-button size="small" text @click="handleToggleState(student)" class="wabi-btn-text">
                  {{ student.state === 1 ? '禁用' : '启用' }}
                </el-button>
                <el-button size="small" text @click="handleEdit(student)" class="wabi-btn-text">
                  编辑
                </el-button>
                <el-dropdown trigger="click" @command="(cmd) => handleMoreCommand(cmd, student)" placement="bottom-end">
                  <el-button size="small" text class="wabi-btn-text">
                    更多
                  </el-button>
                  <template #dropdown>
                    <el-dropdown-menu class="wabi-dropdown-menu">
                      <el-dropdown-item command="resetPassword">重置密码</el-dropdown-item>
                      <el-dropdown-item command="resetIp">重置IP</el-dropdown-item>
                      <el-dropdown-item command="delete" divided>删除</el-dropdown-item>
                    </el-dropdown-menu>
                  </template>
                </el-dropdown>
              </div>
            </div>
          </div>
          <div v-if="pagination.total > pagination.pageSize" class="pagination-wrapper">
            <el-pagination
              v-model:current-page="pagination.page"
              v-model:page-size="pagination.pageSize"
              :page-sizes="[20, 40, 60]"
              :total="pagination.total"
              layout="total, sizes, prev, pager, next"
              @size-change="loadStudentList"
              @current-change="loadStudentList"
              small
            />
          </div>
        </div>
      </div>
    </div>

    <!-- 新增/编辑学生对话框 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="500" class="wabi-dialog">
      <el-form ref="formRef" :model="form" :rules="formRules" label-width="80" class="wabi-form">
        <el-form-item label="学号" prop="studentNo">
          <el-input v-model="form.studentNo" :disabled="isEdit" placeholder="请输入学号" />
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="form.password" type="password" placeholder="留空则使用默认密码" />
        </el-form-item>
        <el-form-item label="姓名" prop="studentName">
          <el-input v-model="form.studentName" placeholder="请输入姓名" />
        </el-form-item>
        <el-form-item label="班级" prop="clazzNo">
          <el-select v-model="form.clazzNo" placeholder="请选择班级" style="width: 100%">
            <el-option
              v-for="item in clazzOptions"
              :key="item.no"
              :label="item.no + ' - ' + item.memo"
              :value="item.no"
            />
          </el-select>
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

    <!-- 批量导入对话框 -->
    <el-dialog v-model="importDialogVisible" title="批量导入学生" width="500" class="wabi-dialog">
      <el-form ref="importFormRef" :model="importForm" :rules="importRules" label-width="80" class="wabi-form">
        <el-form-item label="班级" prop="clazzNo">
          <el-select v-model="importForm.clazzNo" placeholder="请选择班级" style="width: 100%">
            <el-option
              v-for="item in clazzOptions"
              :key="item.no"
              :label="item.no + ' - ' + item.memo"
              :value="item.no"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="文件">
          <el-upload
            ref="uploadRef"
            :auto-upload="false"
            :limit="1"
            accept=".xlsx,.xls"
            :on-change="handleFileChange"
          >
            <el-button class="wabi-btn-ghost">选择文件</el-button>
            <template #tip>
              <div class="wabi-hint">仅支持 .xlsx, .xls 格式</div>
            </template>
          </el-upload>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="importDialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleImport" :loading="importing" class="wabi-btn-primary">导入</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search, Upload } from '@element-plus/icons-vue'
import { teacherApi } from '@/api'

const studentApi = teacherApi.student
const clazzApi = teacherApi.clazz

const loading = ref(false)
const studentList = ref([])
const clazzOptions = ref([])
const searchQuery = ref('')
const filterClazzNo = ref('')
const dialogVisible = ref(false)
const importDialogVisible = ref(false)
const dialogTitle = ref('新增学生')
const formRef = ref()
const importFormRef = ref()
const uploadRef = ref()
const importing = ref(false)
const importFile = ref(null)
const isEdit = ref(false)

const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const form = ref({
  studentId: null,
  studentNo: '',
  studentName: '',
  clazzNo: '',
  state: 1,
  password: ''
})

const importForm = ref({
  clazzNo: ''
})

const formRules = {
  studentNo: [{ required: true, message: '请输入学号', trigger: 'blur' }],
  studentName: [{ required: true, message: '请输入姓名', trigger: 'blur' }],
  clazzNo: [{ required: true, message: '请选择班级', trigger: 'change' }]
}

const importRules = {
  clazzNo: [{ required: true, message: '请选择班级', trigger: 'change' }]
}

const loadClazzOptions = async () => {
  try {
    const res = await clazzApi.all()
    clazzOptions.value = res.data || []
  } catch (error) {
    console.error('加载班级选项失败:', error)
  }
}

const loadStudentList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize,
      keyword: searchQuery.value || undefined,
      clazzNo: filterClazzNo.value || undefined
    }
    const res = await studentApi.list(params)
    studentList.value = res.data?.list || res.data || []
    pagination.total = res.data?.total || studentList.value.length
  } catch (error) {
    console.error('加载学生列表失败:', error)
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadStudentList()
}

const handleAdd = () => {
  form.value = { studentId: null, studentNo: '', studentName: '', clazzNo: '', state: 1, password: '' }
  isEdit.value = false
  dialogTitle.value = '新增学生'
  dialogVisible.value = true
}

const handleEdit = (row) => {
  form.value = { ...row, password: '' }
  isEdit.value = true
  dialogTitle.value = '编辑学生'
  dialogVisible.value = true
}

const handleSubmit = async () => {
  await formRef.value.validate()
  try {
    const submitData = {
      ...form.value,
      studentPassword: form.value.password || form.value.studentNo
    }
    if (form.value.studentId) {
      await studentApi.update(form.value.studentId, submitData)
      ElMessage.success('更新成功')
    } else {
      await studentApi.add(submitData)
      ElMessage.success('创建成功')
    }
    dialogVisible.value = false
    loadStudentList()
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

const handleToggleState = async (row) => {
  const newState = row.state === 1 ? 0 : 1
  await studentApi.updateState(row.studentId, newState)
  ElMessage.success(newState === 1 ? '已启用' : '已禁用')
  loadStudentList()
}

const handleDelete = async (row) => {
  await ElMessageBox.confirm('确定删除该学生?', '提示', { type: 'warning' })
  await studentApi.delete(row.studentId)
  ElMessage.success('已删除')
  loadStudentList()
}

const handleMoreCommand = async (cmd, row) => {
  if (cmd === 'resetPassword') {
    await ElMessageBox.confirm('确定重置该学生密码?', '提示', { type: 'warning' })
    await studentApi.resetPassword(row.studentId)
    ElMessage.success('密码已重置')
  } else if (cmd === 'resetIp') {
    await studentApi.resetIp(row.studentId)
    ElMessage.success('IP已重置')
  } else if (cmd === 'delete') {
    await handleDelete(row)
  }
}

const showImportDialog = () => {
  importForm.value = { clazzNo: '' }
  importFile.value = null
  importDialogVisible.value = true
}

const handleFileChange = (file) => {
  importFile.value = file.raw
}

const handleImport = async () => {
  await importFormRef.value.validate()
  if (!importFile.value) {
    ElMessage.warning('请选择文件')
    return
  }
  importing.value = true
  try {
    await studentApi.import(importFile.value, importForm.value.clazzNo)
    ElMessage.success('导入成功')
    importDialogVisible.value = false
    loadStudentList()
  } catch (error) {
    ElMessage.error('导入失败')
  } finally {
    importing.value = false
  }
}

onMounted(() => {
  loadClazzOptions()
  loadStudentList()
})
</script>

<style scoped>
.student-page {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-body {
  padding: 24px;
  max-width: 1200px;
  margin: 0 auto;
  animation: wabi-fade-in 0.4s ease;
}

@keyframes wabi-fade-in {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;
}

.filter-wrapper {
  display: flex;
  gap: 8px;
}

.wabi-select {
  width: 200px;
}

.wabi-search {
  width: 200px;
}

.wabi-search :deep(.el-input__wrapper) {
  border-radius: 4px;
  box-shadow: 0 0 0 1px var(--wabi-border, #e8e4df);
}

.header-actions {
  display: flex;
  gap: 8px;
}

/* 学生列表 */
.student-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.student-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  transition: all 0.2s ease;
}

.student-item:hover {
  border-color: var(--wabi-accent, #7a8b6f);
}

.student-info {
  flex: 1;
}

.student-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 4px;
}

.student-no {
  font-family: monospace;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.student-name {
  font-size: 15px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
}

.student-meta {
  display: flex;
  gap: 16px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.student-actions {
  display: flex;
  gap: 4px;
}

/* 分页 */
.pagination-wrapper {
  margin-top: 16px;
  display: flex;
  justify-content: center;
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

/* 空状态 */
.wabi-empty {
  padding: 40px 0;
  text-align: center;
}

.wabi-empty-text {
  color: var(--wabi-text-secondary, #8a8580);
  font-size: 14px;
  margin: 0;
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

/* 提示 */
.wabi-hint {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-top: 8px;
}

/* 下拉菜单 */
.wabi-dropdown-menu {
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 4px;
}

/* 响应式 */
@media (max-width: 768px) {
  .wabi-body {
    padding: 16px;
  }

  .header-left {
    flex-direction: column;
    align-items: flex-start;
  }

  .filter-wrapper {
    width: 100%;
    flex-wrap: wrap;
  }

  .wabi-select,
  .wabi-search {
    width: 100%;
  }

  .student-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }

  .student-actions {
    width: 100%;
    justify-content: flex-end;
  }
}
</style>
