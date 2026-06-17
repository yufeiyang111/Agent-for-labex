<template>
  <div class="clazz-page wabi-page">
    <div class="wabi-body">
      <div class="wabi-card">
        <div class="wabi-card-header">
          <div class="header-left">
            <span class="wabi-card-title">班级管理</span>
            <div class="search-wrapper">
              <el-input
                v-model="searchQuery"
                placeholder="搜索班级编号或描述"
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
          <el-button type="primary" :icon="Plus" @click="handleAdd" class="wabi-btn-primary">
            新增班级
          </el-button>
        </div>
        <div class="wabi-card-content">
          <div v-if="!loading && !clazzList.length" class="wabi-empty">
            <p class="wabi-empty-text">暂无班级数据</p>
          </div>
          <div v-else class="clazz-list">
            <div v-for="clazz in clazzList" :key="clazz.clazzId" class="clazz-item">
              <div class="clazz-info">
                <div class="clazz-header">
                  <span class="clazz-no">{{ clazz.no }}</span>
                  <span class="wabi-tag" :class="clazz.state === 1 ? 'wabi-tag-accent' : ''">
                    {{ clazz.state === 1 ? '启用' : '禁用' }}
                  </span>
                </div>
                <div class="clazz-memo">{{ clazz.memo || '暂无描述' }}</div>
              </div>
              <div class="clazz-actions">
                <el-button size="small" text @click="handleToggleState(clazz)" class="wabi-btn-text">
                  {{ clazz.state === 1 ? '禁用' : '启用' }}
                </el-button>
                <el-button size="small" text @click="handleEdit(clazz)" class="wabi-btn-text">
                  编辑
                </el-button>
                <el-button size="small" text type="danger" @click="handleDelete(clazz)" class="wabi-btn-text wabi-btn-danger">
                  删除
                </el-button>
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
              @size-change="loadClazzList"
              @current-change="loadClazzList"
              small
            />
          </div>
        </div>
      </div>
    </div>

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="500" class="wabi-dialog">
      <el-form ref="formRef" :model="form" :rules="formRules" label-width="80" class="wabi-form">
        <el-form-item label="班级编号" prop="no">
          <el-input v-model="form.no" placeholder="如 23-SE-1" />
        </el-form-item>
        <el-form-item label="描述" prop="memo">
          <el-input v-model="form.memo" type="textarea" :rows="3" placeholder="班级描述信息" />
        </el-form-item>
        <el-form-item label="状态">
          <el-switch v-model="form.state" :active-value="1" :inactive-value="0" active-text="启用" inactive-text="禁用" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleSubmit" :loading="submitting" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search } from '@element-plus/icons-vue'
import { teacherApi } from '@/api'

const clazzApi = teacherApi.clazz

const loading = ref(false)
const submitting = ref(false)
const clazzList = ref([])
const searchQuery = ref('')
const dialogVisible = ref(false)
const dialogTitle = ref('新增班级')
const formRef = ref()

const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const form = ref({
  clazzId: null,
  no: '',
  memo: '',
  state: 1
})

const formRules = {
  no: [{ required: true, message: '请输入班级编号', trigger: 'blur' }]
}

const loadClazzList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize,
      keyword: searchQuery.value || undefined
    }
    const res = await clazzApi.list(params)
    clazzList.value = res.data?.list || res.data || []
    pagination.total = res.data?.total || clazzList.value.length
  } catch (error) {
    console.error('加载班级列表失败:', error)
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadClazzList()
}

const handleAdd = () => {
  form.value = { clazzId: null, no: '', memo: '', state: 1 }
  dialogTitle.value = '新增班级'
  dialogVisible.value = true
}

const handleEdit = (row) => {
  form.value = { ...row }
  dialogTitle.value = '编辑班级'
  dialogVisible.value = true
}

const handleSubmit = async () => {
  await formRef.value.validate()
  submitting.value = true
  try {
    if (form.value.no) {
      await clazzApi.update(form.value.no, form.value)
      ElMessage.success('更新成功')
    } else {
      await clazzApi.add(form.value)
      ElMessage.success('创建成功')
    }
    dialogVisible.value = false
    loadClazzList()
  } catch (error) {
    ElMessage.error('操作失败')
  } finally {
    submitting.value = false
  }
}

const handleToggleState = async (row) => {
  const newState = row.state === 1 ? 0 : 1
  await clazzApi.updateState(row.no, newState)
  ElMessage.success(newState === 1 ? '已启用' : '已禁用')
  loadClazzList()
}

const handleDelete = async (row) => {
  await ElMessageBox.confirm('确定删除该班级?', '提示', { type: 'warning' })
  await clazzApi.delete(row.no)
  ElMessage.success('已删除')
  loadClazzList()
}

onMounted(loadClazzList)
</script>

<style scoped>
.clazz-page {
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
}

.search-wrapper {
  width: 240px;
}

.wabi-search :deep(.el-input__wrapper) {
  border-radius: 4px;
  box-shadow: 0 0 0 1px var(--wabi-border, #e8e4df);
}

/* 班级列表 */
.clazz-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.clazz-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  transition: all 0.2s ease;
}

.clazz-item:hover {
  border-color: var(--wabi-accent, #7a8b6f);
}

.clazz-info {
  flex: 1;
}

.clazz-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.clazz-no {
  font-size: 15px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
}

.clazz-memo {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.clazz-actions {
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

.wabi-btn-text {
  color: var(--wabi-text-secondary, #8a8580);
}

.wabi-btn-text:hover {
  color: var(--wabi-accent, #7a8b6f);
}

.wabi-btn-danger:hover {
  color: #c47c7c;
}

/* 响应式 */
@media (max-width: 768px) {
  .wabi-body {
    padding: 16px;
  }

  .header-left {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }

  .search-wrapper {
    width: 100%;
  }

  .clazz-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }

  .clazz-actions {
    width: 100%;
    justify-content: flex-end;
  }
}
</style>
