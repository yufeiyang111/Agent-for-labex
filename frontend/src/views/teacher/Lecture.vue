<template>
  <div class="lecture-page">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/teacher' }">教师首页</el-breadcrumb-item>
      <el-breadcrumb-item>讲义管理</el-breadcrumb-item>
    </el-breadcrumb>

    <!-- 页面标题和搜索区域 -->
    <div class="page-header">
      <h2 class="page-title">讲义管理</h2>
      <div class="search-area">
        <el-input
          v-model="searchQuery"
          placeholder="搜索讲义名称"
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

    <!-- 分类导航标签 -->
    <div class="category-nav">
      <span
        class="category-pill"
        :class="{ active: !filterCategory }"
        @click="filterCategory = ''; handleSearch()"
      >全部</span>
      <span
        v-for="c in categories"
        :key="c"
        class="category-pill"
        :class="{ active: filterCategory === c }"
        @click="filterCategory = c; handleSearch()"
      >{{ c }}</span>
    </div>

    <!-- 操作按钮区域 -->
    <div class="action-bar">
      <el-button type="success" @click="handleAdd" class="add-btn">
        <el-icon><Plus /></el-icon>
        新增讲义
      </el-button>
      <el-button type="primary" @click="handleInitKnowledgeBase" class="add-btn" :loading="initLoading">
        <el-icon><Connection /></el-icon>
        初始化知识库
      </el-button>
    </div>

    <!-- 讲义列表表格 -->
    <el-card class="table-card" shadow="hover">
      <el-table
        :data="lectureList"
        v-loading="loading"
        stripe
        hover
        style="width: 100%"
      >
        <el-table-column prop="lectureName" label="讲义名称" min-width="200" />
        <el-table-column label="类型" min-width="120">
          <template #default="{ row }">
            <el-tag type="info">{{ getLectureTypeName(row.lectureType) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="分类" min-width="120">
          <template #default="{ row }">
            <el-tag v-if="row.category" type="success" effect="plain">{{ row.category }}</el-tag>
            <span v-else class="no-category">-</span>
          </template>
        </el-table-column>
        <el-table-column label="文件类型" width="100">
          <template #default="{ row }">
            <el-tag :type="getFileTypeTag(row.lectureFiletype)">
              {{ row.lectureFiletype || '-' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="文件" min-width="150">
          <template #default="{ row }">
            <span v-if="row.filePath">{{ row.filePath }}</span>
            <span v-else>-</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="240" fixed="right">
          <template #default="{ row }">
            <div class="action-buttons">
              <el-button type="primary" size="small" plain @click="handleEdit(row)" class="action-btn">
                编辑
              </el-button>
              <el-button type="success" size="small" plain @click="handleDownload(row)" v-if="row.filePath" class="action-btn">
                下载
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
        @size-change="loadLectureList"
        @current-change="loadLectureList"
        class="pagination"
      />
    </el-card>

    <!-- 新增/编辑讲义对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="500px"
      class="lecture-dialog"
    >
      <el-form
        ref="formRef"
        :model="formData"
        :rules="formRules"
        label-width="100px"
      >
        <el-form-item label="讲义名称" prop="lectureName">
          <el-input v-model="formData.lectureName" placeholder="请输入讲义名称" />
        </el-form-item>
        <el-form-item label="类型">
          <el-select v-model="formData.lectureType" placeholder="请选择讲义类型" style="width: 100%">
            <el-option label="课件" :value="1" />
            <el-option label="教材" :value="2" />
            <el-option label="参考资料" :value="3" />
            <el-option label="默认" :value="4" />
          </el-select>
        </el-form-item>
        <el-form-item label="分类">
          <el-select v-model="formData.category" placeholder="选择分类" clearable allow-create filterable style="width: 100%">
            <el-option v-for="c in categories" :key="c" :label="c" :value="c" />
          </el-select>
        </el-form-item>
        <el-form-item label="上传文件">
          <el-upload
            ref="uploadRef"
            :auto-upload="false"
            :limit="1"
            :on-change="handleFileChange"
            :on-remove="handleFileRemove"
            accept=".pdf,.doc,.docx,.ppt,.pptx,.zip,.rar"
            class="file-upload"
          >
            <template #trigger>
              <el-button type="primary">选择文件</el-button>
            </template>
            <div class="upload-hint">支持 PDF、Word、PPT、ZIP 格式</div>
          </el-upload>
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
import { Search, Plus, Connection } from '@element-plus/icons-vue'
import { teacherApi, ragApi } from '@/api/index.js'

// 响应式数据
const loading = ref(false)
const submitting = ref(false)
const initLoading = ref(false)
const lectureList = ref([])
const dialogVisible = ref(false)
const dialogTitle = computed(() => isEdit.value ? '编辑讲义' : '新增讲义')
const isEdit = ref(false)
const formRef = ref(null)
const uploadRef = ref(null)
const searchQuery = ref('')
const currentFile = ref(null)
const categories = ref([])
const filterCategory = ref('')

// 分页
const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

// 表单数据
const formData = reactive({
  lectureId: null,
  lectureName: '',
  lectureType: 1,
  category: '',
  lectureFiletype: '',
  filePath: '',
  fileSize: null
})

// 表单验证规则
const formRules = {
  lectureName: [
    { required: true, message: '请输入讲义名称', trigger: 'blur' },
    { max: 100, message: '最多100个字符', trigger: 'blur' }
  ]
}

// 文件类型标签
const getFileTypeTag = (fileType) => {
  const tagMap = {
    'pdf': 'danger',
    'doc': 'primary',
    'docx': 'primary',
    'ppt': 'success',
    'pptx': 'success',
    'zip': 'warning',
    'rar': 'warning'
  }
  return tagMap[fileType?.toLowerCase()] || 'info'
}

// 讲义类型名称
const getLectureTypeName = (type) => {
  const typeMap = {
    1: '课件',
    2: '教材',
    3: '参考资料',
    4: '默认'
  }
  return typeMap[type] || '默认'
}

// 加载讲义列表
const loadLectureList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize
    }
    if (searchQuery.value) {
      params.keyword = searchQuery.value
    }
    if (filterCategory.value) {
      params.category = filterCategory.value
    }
    const response = await teacherApi.lecture.list(params)
    lectureList.value = response.data?.list || []
    pagination.total = response.data?.total || 0
  } catch (error) {
    ElMessage.error('加载讲义列表失败')
    console.error(error)
  } finally {
    loading.value = false
  }
}

// 搜索
const handleSearch = () => {
  pagination.page = 1
  loadLectureList()
}

// 加载分类列表
const loadCategories = async () => {
  try {
    const res = await teacherApi.lecture.categories()
    categories.value = res.data || []
  } catch (error) {
    console.error('加载分类失败:', error)
  }
}

// 初始化知识库
const handleInitKnowledgeBase = async () => {
  try {
    initLoading.value = true
    const res = await ragApi.init()
    if (res.code === 0) {
      ElMessage.success(`知识库初始化完成，已处理 ${res.data.vectorizedCount} 个讲义`)
      loadLectureList()
    } else {
      ElMessage.error(res.message || '初始化失败')
    }
  } catch (error) {
    ElMessage.error('初始化知识库失败')
    console.error(error)
  } finally {
    initLoading.value = false
  }
}

// 重置表单
const resetForm = () => {
  Object.assign(formData, {
    lectureId: null,
    lectureName: '',
    lectureType: 1,
    category: '',
    lectureFiletype: '',
    filePath: '',
    fileSize: null
  })
  currentFile.value = null
  if (uploadRef.value) {
    uploadRef.value.clearFiles()
  }
}

// 新增讲义
const handleAdd = () => {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
}

// 编辑讲义
const handleEdit = (row) => {
  Object.assign(formData, {
    lectureId: row.lectureId,
    lectureName: row.lectureName,
    lectureType: row.lectureType || 1,
    category: row.category || '',
    lectureFiletype: row.lectureFiletype || '',
    filePath: row.filePath || '',
    fileSize: row.fileSize || null
  })
  isEdit.value = true
  dialogVisible.value = true
}

// 文件选择变化
const handleFileChange = (file) => {
  currentFile.value = file.raw
}

// 文件移除
const handleFileRemove = () => {
  currentFile.value = null
}

// 提交表单
const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    submitting.value = true

    // 如果有新文件，先上传
    let filePath = formData.filePath
    if (currentFile.value) {
      const uploadRes = await teacherApi.lecture.upload(currentFile.value)
      if (uploadRes.data) {
        filePath = uploadRes.data
        formData.lectureFiletype = currentFile.value.name.split('.').pop()
        formData.fileSize = currentFile.value.size
      }
      currentFile.value = null
      if (uploadRef.value) {
        uploadRef.value.clearFiles()
      }
    }

    const submitData = {
      lectureName: formData.lectureName,
      lectureType: formData.lectureType,
      category: formData.category || null,
      lectureFiletype: formData.lectureFiletype,
      filePath: filePath,
      fileSize: formData.fileSize
    }

    if (isEdit.value) {
      await teacherApi.lecture.update(formData.lectureId, submitData)
      ElMessage.success('更新成功')
    } else {
      await teacherApi.lecture.add(submitData)
      ElMessage.success('添加成功')
    }

    dialogVisible.value = false
    loadLectureList()
  } catch (error) {
    if (error !== false) {
      ElMessage.error('操作失败')
      console.error(error)
    }
  } finally {
    submitting.value = false
  }
}

// 删除讲义
const handleDelete = (row) => {
  ElMessageBox.confirm(
    `确认删除讲义 "${row.lectureName}" 吗？此操作不可恢复！`,
    '警告',
    { type: 'warning' }
  ).then(async () => {
    try {
      await teacherApi.lecture.delete(row.lectureId)
      ElMessage.success('删除成功')
      loadLectureList()
    } catch (error) {
      ElMessage.error('删除失败')
      console.error(error)
    }
  }).catch(() => {})
}

// 下载讲义
const handleDownload = async (row) => {
  try {
    ElMessage.info('正在准备下载...')
    const response = await teacherApi.lecture.get(row.lectureId)
    if (response.data?.filePath) {
      window.open('/uploads/' + response.data.filePath, '_blank')
    } else {
      ElMessage.warning('文件链接不存在')
    }
  } catch (error) {
    ElMessage.error('下载失败')
    console.error(error)
  }
}

// 页面初始化
onMounted(() => {
  loadLectureList()
  loadCategories()
})
</script>

<style scoped>
.lecture-page {
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

.category-nav {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 20px;
  padding: 12px 16px;
  background: #ffffff;
  border: 1px solid #e8f5e9;
  border-radius: 10px;
}

.category-pill {
  display: inline-block;
  padding: 5px 14px;
  font-size: 13px;
  font-weight: 500;
  color: #3d4c5e;
  background: #f5f7fa;
  border-radius: 20px;
  cursor: pointer;
  transition: all 0.15s ease;
  user-select: none;

  &:hover {
    background: #e8f5e9;
    color: #2e7d32;
  }

  &.active {
    background: #4caf50;
    color: #ffffff;
    font-weight: 600;
  }
}

.no-category {
  color: #c0c4cc;
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

.lecture-dialog :deep(.el-dialog__header) {
  background: #e8f5e9;
  border-radius: 8px 8px 0 0;
}

.lecture-dialog :deep(.el-dialog__title) {
  color: #2d8a4e;
  font-weight: 600;
}

.file-upload {
  width: 100%;
}

.upload-hint {
  font-size: 12px;
  color: #909399;
  margin-top: 8px;
}

.generate-hint {
  margin-bottom: 16px;
  color: #475467;
  font-size: 14px;
  line-height: 1.6;
}

.generate-note {
  color: #9a6700;
  font-size: 12px;
  margin-top: 4px;
}

.generate-result {
  .result-stats {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 12px;
    margin-bottom: 16px;

    .stat-item {
      text-align: center;
      padding: 12px;
      background: #f9fafb;
      border-radius: 8px;
      border: 1px solid #e5e7eb;

      .stat-value {
        font-size: 28px;
        font-weight: 700;

        &.success { color: #059669; }
        &.warning { color: #f59e0b; }
        &.danger { color: #ef4444; }
      }

      .stat-label {
        font-size: 12px;
        color: #6b7280;
        margin-top: 4px;
      }
    }
  }
}

.type-badge {
  margin-right: 4px;
  display: inline-block;
  margin-bottom: 4px;
}

.error-list {
  margin-top: 12px;
  padding: 10px;
  background: #fef2f2;
  border-radius: 6px;

  .error-title {
    font-weight: 600;
    color: #dc2626;
    margin-bottom: 4px;
  }

  .error-item {
    color: #dc2626;
    font-size: 12px;
    margin: 2px 0;
  }
}
</style>
