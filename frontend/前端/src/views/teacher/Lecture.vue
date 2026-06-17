<template>
  <div class="lecture-page wabi-page">
    <div class="wabi-body">
      <div class="wabi-card">
        <div class="wabi-card-header">
          <div class="header-left">
            <span class="wabi-card-title">讲义管理</span>
            <div class="search-wrapper">
              <el-input
                v-model="searchQuery"
                placeholder="搜索讲义名称"
                clearable
                @clear="handleSearch"
                @keyup.enter="handleSearch"
                size="small"
                class="wabi-search"
              >
                <template #prefix><el-icon><Search /></el-icon></template>
              </el-input>
            </div>
          </div>
          <div class="header-actions">
            <el-button @click="handleInitKnowledgeBase" :loading="initLoading" class="wabi-btn-ghost">
              初始化知识库
            </el-button>
            <el-button type="primary" :icon="Plus" @click="handleAdd" class="wabi-btn-primary">
              新增讲义
            </el-button>
          </div>
        </div>
        <div class="wabi-card-content">
          <!-- 分类标签 -->
          <div class="category-nav">
            <span
              class="category-tag"
              :class="{ active: !filterCategory }"
              @click="filterCategory = ''; handleSearch()"
            >
              全部
            </span>
            <span
              v-for="c in categories"
              :key="c"
              class="category-tag"
              :class="{ active: filterCategory === c }"
              @click="filterCategory = c; handleSearch()"
            >
              {{ c }}
            </span>
          </div>

          <!-- 讲义列表 -->
          <div v-if="!loading && !lectureList.length" class="wabi-empty">
            <p class="wabi-empty-text">暂无讲义数据</p>
          </div>
          <div v-else class="lecture-list">
            <div v-for="lecture in lectureList" :key="lecture.lectureId" class="lecture-item">
              <div class="lecture-info">
                <div class="lecture-header">
                  <span class="lecture-no">{{ lecture.lectureId }}</span>
                  <span class="wabi-tag">{{ lecture.category }}</span>
                </div>
                <h3 class="lecture-name">{{ lecture.lectureName }}</h3>
              </div>
              <div class="lecture-actions">
                <el-button size="small" text @click="handleEdit(lecture)" class="wabi-btn-text">编辑</el-button>
                <el-button size="small" text type="danger" @click="handleDelete(lecture)" class="wabi-btn-text wabi-btn-danger">删除</el-button>
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
              @size-change="loadLectureList"
              @current-change="loadLectureList"
              small
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search } from '@element-plus/icons-vue'
import { teacherApi } from '@/api'

const lectureApi = teacherApi.lecture

const loading = ref(false)
const initLoading = ref(false)
const lectureList = ref([])
const categories = ref([])
const searchQuery = ref('')
const filterCategory = ref('')

const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const loadLectureList = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.page,
      pageSize: pagination.pageSize,
      keyword: searchQuery.value || undefined,
      category: filterCategory.value || undefined
    }
    const res = await lectureApi.list(params)
    lectureList.value = res.data?.list || res.data || []
    pagination.total = res.data?.total || lectureList.value.length
  } catch (error) {
    console.error('加载讲义列表失败:', error)
  } finally {
    loading.value = false
  }
}

const loadCategories = async () => {
  try {
    const res = await lectureApi.categories()
    categories.value = res.data || []
  } catch (error) {
    console.error('加载分类失败:', error)
  }
}

const handleSearch = () => {
  pagination.page = 1
  loadLectureList()
}

const handleAdd = () => {
  // TODO: 跳转到新增页面
}

const handleEdit = (row) => {
  // TODO: 跳转到编辑页面
}

const handleDelete = async (row) => {
  await ElMessageBox.confirm('确定删除该讲义?', '提示', { type: 'warning' })
  await lectureApi.delete(row.lectureId)
  ElMessage.success('已删除')
  loadLectureList()
}

const handleInitKnowledgeBase = async () => {
  initLoading.value = true
  try {
    await lectureApi.initKnowledgeBase()
    ElMessage.success('知识库初始化成功')
  } catch (error) {
    ElMessage.error('初始化失败')
  } finally {
    initLoading.value = false
  }
}

onMounted(() => {
  loadCategories()
  loadLectureList()
})
</script>

<style scoped>
.lecture-page {
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

.header-actions {
  display: flex;
  gap: 8px;
}

/* 分类标签 */
.category-nav {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 16px;
}

.category-tag {
  display: inline-block;
  padding: 4px 12px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  color: var(--wabi-text-secondary, #8a8580);
  font-size: 13px;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.category-tag:hover {
  border-color: var(--wabi-accent, #7a8b6f);
  color: var(--wabi-accent, #7a8b6f);
}

.category-tag.active {
  background: var(--wabi-accent-light, #e8ede5);
  border-color: var(--wabi-accent, #7a8b6f);
  color: var(--wabi-accent, #7a8b6f);
}

/* 讲义列表 */
.lecture-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.lecture-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  transition: all 0.2s ease;
}

.lecture-item:hover {
  border-color: var(--wabi-accent, #7a8b6f);
}

.lecture-info {
  flex: 1;
}

.lecture-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.lecture-no {
  font-family: monospace;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.lecture-name {
  font-size: 16px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 4px 0 0 0;
}

.lecture-actions {
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

  .lecture-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }

  .lecture-actions {
    width: 100%;
    justify-content: flex-end;
  }
}
</style>
