<template>
  <div class="exam-page">
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/teacher' }">教师首页</el-breadcrumb-item>
      <el-breadcrumb-item>考试管理</el-breadcrumb-item>
    </el-breadcrumb>

    <div class="page-header">
      <h2 class="page-title">考试管理</h2>
      <div class="search-area">
        <el-input v-model="searchQuery" placeholder="搜索考试名称" clearable @clear="handleSearch" @keyup.enter="handleSearch" class="search-input">
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
        <el-button type="primary" @click="handleSearch">搜索</el-button>
      </div>
    </div>

    <div class="action-bar">
      <el-button type="success" @click="handleAdd">
        <el-icon><Plus /></el-icon>
        新增考试
      </el-button>
    </div>

    <el-card class="table-card" shadow="hover">
      <el-table :data="examList" v-loading="loading" stripe>
        <el-table-column prop="id" label="ID" min-width="70" />
        <el-table-column prop="examName" label="考试名称" min-width="170" />
        <el-table-column label="试卷（可复用）" min-width="180">
          <template #default="{ row }">{{ row.paperName || '-' }}</template>
        </el-table-column>
        <el-table-column label="开始时间" min-width="170">
          <template #default="{ row }">{{ formatDate(row.time) }}</template>
        </el-table-column>
        <el-table-column label="截止时间" min-width="170">
          <template #default="{ row }">{{ formatDate(row.endTime) }}</template>
        </el-table-column>
        <el-table-column label="时长" width="95">
          <template #default="{ row }">{{ row.duration || 60 }}分</template>
        </el-table-column>
        <el-table-column label="状态" width="90">
          <template #default="{ row }">
            <el-switch v-model="row.state" :active-value="1" :inactive-value="0" @change="handleStateChange(row)" />
          </template>
        </el-table-column>
        <el-table-column label="操作" width="170" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small" plain @click="handleEdit(row)">编辑</el-button>
            <el-button type="danger" size="small" plain @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination
        v-model:current-page="pagination.page"
        v-model:page-size="pagination.pageSize"
        :page-sizes="[10, 20, 40]"
        :total="pagination.total"
        layout="total, sizes, prev, pager, next"
        @size-change="loadExamList"
        @current-change="loadExamList"
        class="pagination"
      />
    </el-card>

    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="620px">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="100px">
        <el-form-item label="考试名称" prop="examName">
          <el-input v-model="formData.examName" placeholder="请输入考试名称" />
        </el-form-item>
        <el-form-item label="试卷" prop="paperId">
          <el-select v-model="formData.paperId" placeholder="请选择已创建试卷" style="width: 100%">
            <el-option v-for="paper in paperList" :key="paper.id" :label="paper.name" :value="paper.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="开始时间" prop="time">
          <el-date-picker v-model="formData.time" type="datetime" value-format="YYYY-MM-DD HH:mm:ss" placeholder="选择开始时间" style="width: 100%" />
        </el-form-item>
        <el-form-item label="截止时间" prop="endTime">
          <el-date-picker v-model="formData.endTime" type="datetime" value-format="YYYY-MM-DD HH:mm:ss" placeholder="选择截止时间" style="width: 100%" />
        </el-form-item>
        <el-form-item label="时长(分钟)" prop="duration">
          <el-input-number v-model="formData.duration" :min="10" :max="600" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="formData.description" type="textarea" :rows="3" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="formData.state">
            <el-radio :value="1">启用</el-radio>
            <el-radio :value="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit" :loading="submitting">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { computed, onMounted, reactive, ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search } from '@element-plus/icons-vue'
import { teacherApi } from '@/api'

const loading = ref(false)
const submitting = ref(false)
const examList = ref([])
const paperList = ref([])
const dialogVisible = ref(false)
const isEdit = ref(false)
const formRef = ref(null)
const searchQuery = ref('')

const pagination = reactive({ page: 1, pageSize: 20, total: 0 })
const formData = reactive({
  id: null,
  examName: '',
  paperId: null,
  time: null,
  endTime: null,
  duration: 60,
  description: '',
  state: 1
})

const dialogTitle = computed(() => (isEdit.value ? '编辑考试' : '新增考试'))
const formRules = {
  examName: [{ required: true, message: '请输入考试名称', trigger: 'blur' }],
  paperId: [{ required: true, message: '请选择试卷', trigger: 'change' }],
  time: [{ required: true, message: '请选择开始时间', trigger: 'change' }],
  endTime: [{ required: true, message: '请选择截止时间', trigger: 'change' }]
}

const formatDate = (value) => {
  if (!value) return '-'
  return new Date(value).toLocaleString('zh-CN')
}

const resetForm = () => {
  Object.assign(formData, {
    id: null,
    examName: '',
    paperId: null,
    time: null,
    endTime: null,
    duration: 60,
    description: '',
    state: 1
  })
}

const loadExamList = async () => {
  loading.value = true
  try {
    const params = { page: pagination.page, pageSize: pagination.pageSize }
    if (searchQuery.value) params.name = searchQuery.value
    const response = await teacherApi.exam.list(params)
    examList.value = response.data?.list || []
    pagination.total = response.data?.total || 0
  } catch {
    ElMessage.error('加载考试列表失败')
  } finally {
    loading.value = false
  }
}

const loadPapers = async () => {
  try {
    const res = await teacherApi.exam.getPapers()
    paperList.value = res.data || []
  } catch {
    ElMessage.error('加载试卷失败')
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadExamList()
}

const handleAdd = async () => {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
  await loadPapers()
}

const handleEdit = async (row) => {
  Object.assign(formData, {
    id: row.id,
    examName: row.examName,
    paperId: row.paperId,
    time: row.time,
    endTime: row.endTime,
    duration: row.duration || 60,
    description: row.description,
    state: row.state
  })
  isEdit.value = true
  dialogVisible.value = true
  await loadPapers()
}

const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    if (new Date(formData.endTime) <= new Date(formData.time)) {
      ElMessage.error('截止时间必须晚于开始时间')
      return
    }
    submitting.value = true
    if (isEdit.value) {
      await teacherApi.exam.update(formData.id, formData)
      ElMessage.success('更新成功')
    } else {
      await teacherApi.exam.add(formData)
      ElMessage.success('新增成功')
    }
    dialogVisible.value = false
    loadExamList()
  } catch (error) {
    if (error !== false) {
      ElMessage.error('操作失败')
    }
  } finally {
    submitting.value = false
  }
}

const handleStateChange = async (row) => {
  try {
    await teacherApi.exam.update(row.id, { state: row.state })
    ElMessage.success(row.state === 1 ? '已启用' : '已禁用')
  } catch {
    ElMessage.error('状态更新失败')
    row.state = row.state === 1 ? 0 : 1
  }
}

const handleDelete = (row) => {
  ElMessageBox.confirm(`确认删除考试 "${row.examName}" 吗？`, '提示', { type: 'warning' })
    .then(async () => {
      try {
        await teacherApi.exam.delete(row.id)
        ElMessage.success('删除成功')
        loadExamList()
      } catch {
        ElMessage.error('删除失败')
      }
    })
    .catch(() => {})
}

onMounted(loadExamList)
</script>

<style scoped>
.exam-page { padding: 20px; }
.breadcrumb { margin-bottom: 18px; }
.page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px; }
.page-title { margin: 0; font-size: 24px; color: #2d8a4e; }
.search-area { display: flex; gap: 10px; }
.search-input { width: 280px; }
.action-bar { margin-bottom: 14px; }
.table-card { border-radius: 10px; }
.pagination { margin-top: 16px; justify-content: flex-end; }
</style>
