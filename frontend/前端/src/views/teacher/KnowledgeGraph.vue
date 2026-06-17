<template>
  <div class="kg-page wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-hero wabi-card">
        <div class="wabi-card-content">
          <div class="hero-content">
            <h2 class="hero-title">知识图谱管理</h2>
            <p class="hero-desc">管理讲义知识点、题目关联，构建课程知识体系</p>
          </div>
          <div class="hero-actions">
            <el-button @click="showExtractDialog = true" type="primary" :icon="MagicStick" class="wabi-btn-primary">
              从讲义提取
            </el-button>
            <el-button @click="linkQuestionsFast" :icon="Connection" :loading="linkingQuestionsFast" class="wabi-btn-ghost">
              快速关联
            </el-button>
            <el-button @click="linkQuestions" :icon="Connection" :loading="linkingQuestions" class="wabi-btn-ghost">
              精确关联
            </el-button>
          </div>
        </div>
      </div>

      <!-- 统计卡片 -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-value">{{ stats.totalKPs }}</div>
          <div class="stat-label">知识节点</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">{{ stats.linkedQuestions }}</div>
          <div class="stat-label">已关联题目</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">{{ topics.length }}</div>
          <div class="stat-label">知识主题</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">{{ stats.totalQuestions || 0 }}</div>
          <div class="stat-label">题库总量</div>
        </div>
      </div>

      <!-- 标签页 -->
      <div class="wabi-card">
        <div class="wabi-card-header">
          <div class="tab-nav">
            <span
              v-for="tab in tabs"
              :key="tab.key"
              class="tab-item"
              :class="{ active: activeTab === tab.key }"
              @click="activeTab = tab.key"
            >
              {{ tab.label }}
            </span>
          </div>
        </div>
        <div class="wabi-card-content">
          <!-- 知识点列表 -->
          <div v-if="activeTab === 'points'">
            <div class="toolbar">
              <el-input
                v-model="searchKeyword"
                placeholder="搜索知识点..."
                clearable
                @clear="loadPoints"
                @keyup.enter="loadPoints"
                size="small"
                class="wabi-search"
              >
                <template #prefix><el-icon><Search /></el-icon></template>
              </el-input>
              <el-select
                v-model="filterTopicId"
                placeholder="按主题筛选"
                clearable
                @change="loadPoints"
                size="small"
                class="topic-select"
              >
                <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.id" />
              </el-select>
              <el-button type="primary" size="small" @click="showAddPointDialog" class="wabi-btn-primary">
                新增知识点
              </el-button>
            </div>
            <div v-loading="loadingPoints">
              <div v-if="!points.length" class="wabi-empty">
                <p class="wabi-empty-text">暂无知识点</p>
              </div>
              <div v-else class="point-list">
                <div v-for="p in points" :key="p.id" class="point-item">
                  <div class="point-info">
                    <span class="point-name">{{ p.name }}</span>
                    <span v-if="p.topicName" class="wabi-tag">{{ p.topicName }}</span>
                    <span v-if="p.description" class="point-desc">{{ p.description }}</span>
                  </div>
                  <div class="point-actions">
                    <el-button size="small" text @click="showEditPointDialog(p)" class="wabi-btn-text">编辑</el-button>
                    <el-button size="small" text type="danger" @click="handleDeletePoint(p)" class="wabi-btn-text wabi-btn-danger">删除</el-button>
                  </div>
                </div>
              </div>
              <!-- 分页 -->
              <div v-if="pointsTotal > pointsPageSize" class="pagination-wrapper">
                <el-pagination
                  v-model:current-page="pointsPage"
                  v-model:page-size="pointsPageSize"
                  :page-sizes="[10, 20, 50, 100]"
                  :total="pointsTotal"
                  layout="total, sizes, prev, pager, next"
                  @size-change="loadPoints"
                  @current-change="loadPoints"
                  small
                />
              </div>
            </div>
          </div>

          <!-- 主题列表 -->
          <div v-if="activeTab === 'topics'">
            <div class="toolbar">
              <el-button type="primary" size="small" @click="showAddTopicDialog" class="wabi-btn-primary">
                新增主题
              </el-button>
            </div>
            <div v-loading="loadingTopics">
              <div v-if="!topics.length" class="wabi-empty">
                <p class="wabi-empty-text">暂无主题</p>
              </div>
              <div v-else class="topic-list">
                <div v-for="t in topics" :key="t.id" class="topic-item">
                  <div class="topic-info">
                    <span class="topic-name">{{ t.name }}</span>
                    <span class="topic-desc">{{ t.description || '暂无描述' }}</span>
                    <span class="topic-count">{{ t.pointCount || 0 }} 个知识点</span>
                  </div>
                  <div class="topic-actions">
                    <el-button size="small" text @click="showEditTopicDialog(t)" class="wabi-btn-text">编辑</el-button>
                    <el-button size="small" text type="danger" @click="handleDeleteTopic(t)" class="wabi-btn-text wabi-btn-danger">删除</el-button>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 图谱可视化 -->
          <div v-if="activeTab === 'graph'" class="graph-tab">
            <KnowledgeGraphVisualization :topic-id="graphTopicId" @node-click="handleNodeClick" />
          </div>
        </div>
      </div>
    </div>

    <!-- 知识点编辑弹窗 -->
    <el-dialog v-model="pointDialogVisible" :title="pointDialogTitle" width="500" class="wabi-dialog">
      <el-form ref="pointFormRef" :model="pointForm" :rules="pointRules" label-width="80" class="wabi-form">
        <el-form-item label="名称" prop="name">
          <el-input v-model="pointForm.name" placeholder="知识点名称" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="pointForm.description" type="textarea" :rows="3" placeholder="知识点描述" />
        </el-form-item>
        <el-form-item label="主题">
          <el-select v-model="pointForm.topicId" placeholder="选择主题" clearable style="width: 100%">
            <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.id" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="pointDialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleSavePoint" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>

    <!-- 主题编辑弹窗 -->
    <el-dialog v-model="topicDialogVisible" :title="topicDialogTitle" width="400" class="wabi-dialog">
      <el-form ref="topicFormRef" :model="topicForm" :rules="topicRules" label-width="80" class="wabi-form">
        <el-form-item label="名称" prop="name">
          <el-input v-model="topicForm.name" placeholder="主题名称" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="topicForm.description" type="textarea" :rows="3" placeholder="主题描述" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="topicDialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleSaveTopic" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>

    <!-- 从讲义提取弹窗 -->
    <el-dialog v-model="showExtractDialog" title="从讲义提取知识点" width="500" class="wabi-dialog">
      <el-form :model="extractForm" label-width="80" class="wabi-form">
        <el-form-item label="选择讲义">
          <div class="lecture-select-wrapper">
            <el-select
              v-model="extractForm.lectureIds"
              multiple
              placeholder="选择讲义"
              style="width: 100%"
              collapse-tags
              collapse-tags-tooltip
            >
              <el-option
                v-for="l in lectures"
                :key="l.lectureId || l.id"
                :label="l.lectureName || l.name"
                :value="l.lectureId || l.id"
              />
            </el-select>
            <div class="lecture-select-actions">
              <el-button size="small" text @click="selectAllLectures" class="wabi-btn-text">
                全选
              </el-button>
              <el-button size="small" text @click="extractForm.lectureIds = []" class="wabi-btn-text">
                清空
              </el-button>
              <span class="lecture-count">共 {{ lectures.length }} 个讲义</span>
            </div>
          </div>
        </el-form-item>
        <el-form-item label="主题">
          <el-select v-model="extractForm.topicId" placeholder="选择主题（可选）" clearable style="width: 100%">
            <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.id" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showExtractDialog = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleExtract" :loading="extracting" class="wabi-btn-primary">
          开始提取
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, onBeforeUnmount, watch, nextTick } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Search, MagicStick, Connection } from '@element-plus/icons-vue'
import { kgApi, teacherApi } from '@/api'
import KnowledgeGraphVisualization from '@/components/kg/KnowledgeGraphVisualization.vue'

const loading = ref(false)
const loadingPoints = ref(false)
const loadingTopics = ref(false)
const linkingQuestions = ref(false)
const linkingQuestionsFast = ref(false)
const extracting = ref(false)
const showExtractDialog = ref(false)
const activeTab = ref('points')
const searchKeyword = ref('')
const filterTopicId = ref('')
const points = ref([])
const topics = ref([])
const lectures = ref([])

// 分页
const pointsPage = ref(1)
const pointsPageSize = ref(20)
const pointsTotal = ref(0)

// 图谱
const graphTopicId = ref('')

// 知识点编辑
const pointDialogVisible = ref(false)
const pointDialogTitle = ref('新增知识点')
const pointFormRef = ref()
const pointForm = ref({ id: null, name: '', description: '', topicId: '' })
const pointRules = {
  name: [{ required: true, message: '请输入名称', trigger: 'blur' }]
}

// 主题编辑
const topicDialogVisible = ref(false)
const topicDialogTitle = ref('新增主题')
const topicFormRef = ref()
const topicForm = ref({ id: null, name: '', description: '' })
const topicRules = {
  name: [{ required: true, message: '请输入名称', trigger: 'blur' }]
}

// 讲义提取
const extractForm = ref({ lectureIds: [], topicId: '' })

const stats = reactive({
  totalKPs: 0,
  linkedQuestions: 0,
  totalQuestions: 0
})

const tabs = [
  { key: 'points', label: '知识点' },
  { key: 'topics', label: '主题' },
  { key: 'graph', label: '图谱' }
]

// 加载知识点
const loadPoints = async () => {
  loadingPoints.value = true
  try {
    const params = {
      keyword: searchKeyword.value || undefined,
      topicId: filterTopicId.value || undefined,
      page: pointsPage.value,
      size: pointsPageSize.value
    }
    const res = await kgApi.getPoints(params)
    points.value = res.data?.list || []
    pointsTotal.value = res.data?.total || 0
  } catch (error) {
    console.error('加载知识点失败:', error)
  } finally {
    loadingPoints.value = false
  }
}

// 加载主题
const loadTopics = async () => {
  loadingTopics.value = true
  try {
    const res = await kgApi.getTopics()
    topics.value = res.data || []
  } catch (error) {
    console.error('加载主题失败:', error)
  } finally {
    loadingTopics.value = false
  }
}

// 加载统计
const loadStats = async () => {
  try {
    const res = await kgApi.getStats()
    Object.assign(stats, res.data || {})
  } catch (error) {
    console.error('加载统计失败:', error)
  }
}

// 加载讲义列表
const loadLectures = async () => {
  try {
    const res = await teacherApi.lecture.getAll()
    lectures.value = res.data || []
  } catch (error) {
    console.error('加载讲义失败:', error)
  }
}

// 知识点操作
const showAddPointDialog = () => {
  pointForm.value = { id: null, name: '', description: '', topicId: '' }
  pointDialogTitle.value = '新增知识点'
  pointDialogVisible.value = true
}

const showEditPointDialog = (point) => {
  pointForm.value = { ...point }
  pointDialogTitle.value = '编辑知识点'
  pointDialogVisible.value = true
}

const handleSavePoint = async () => {
  await pointFormRef.value.validate()
  try {
    if (pointForm.value.id) {
      await kgApi.updatePoint(pointForm.value.id, pointForm.value)
      ElMessage.success('更新成功')
    } else {
      await kgApi.createPoint(pointForm.value)
      ElMessage.success('创建成功')
    }
    pointDialogVisible.value = false
    loadPoints()
    loadStats()
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

const handleDeletePoint = async (point) => {
  await ElMessageBox.confirm('确定删除该知识点?', '提示', { type: 'warning' })
  try {
    await kgApi.deletePoint(point.id)
    ElMessage.success('已删除')
    loadPoints()
    loadStats()
  } catch (error) {
    ElMessage.error('删除失败')
  }
}

// 主题操作
const showAddTopicDialog = () => {
  topicForm.value = { id: null, name: '', description: '' }
  topicDialogTitle.value = '新增主题'
  topicDialogVisible.value = true
}

const showEditTopicDialog = (topic) => {
  topicForm.value = { ...topic }
  topicDialogTitle.value = '编辑主题'
  topicDialogVisible.value = true
}

const handleSaveTopic = async () => {
  await topicFormRef.value.validate()
  try {
    if (topicForm.value.id) {
      await kgApi.updateTopic(topicForm.value.id, topicForm.value)
      ElMessage.success('更新成功')
    } else {
      await kgApi.createTopic(topicForm.value)
      ElMessage.success('创建成功')
    }
    topicDialogVisible.value = false
    loadTopics()
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

const handleDeleteTopic = async (topic) => {
  await ElMessageBox.confirm('确定删除该主题?', '提示', { type: 'warning' })
  try {
    await kgApi.deleteTopic(topic.id)
    ElMessage.success('已删除')
    loadTopics()
  } catch (error) {
    ElMessage.error('删除失败')
  }
}

// 图谱节点点击
const handleNodeClick = (data) => {
  console.log('节点点击:', data)
}

// 全选讲义
const selectAllLectures = () => {
  extractForm.value.lectureIds = lectures.value.map(l => l.lectureId || l.id)
}

// 关联题目
const linkQuestions = async () => {
  try {
    await ElMessageBox.confirm(
      '精确关联将使用 LLM 分析每道题目与知识点的关系，耗时较长。是否继续？',
      '确认关联',
      { confirmButtonText: '开始关联', cancelButtonText: '取消', type: 'info' }
    )
  } catch {
    return // 用户取消
  }

  linkingQuestions.value = true
  try {
    const res = await kgApi.linkQuestions({})
    ElMessage.success(res.data?.message || '精确关联完成')
    loadStats()
  } catch (error) {
    ElMessage.error('关联失败')
  } finally {
    linkingQuestions.value = false
  }
}

const linkQuestionsFast = async () => {
  try {
    await ElMessageBox.confirm(
      '快速关联将使用 Embedding 相似度匹配题目与知识点，速度较快。是否继续？',
      '确认关联',
      { confirmButtonText: '开始关联', cancelButtonText: '取消', type: 'info' }
    )
  } catch {
    return // 用户取消
  }

  linkingQuestionsFast.value = true
  try {
    const res = await kgApi.linkQuestionsFast({})
    ElMessage.success(res.data?.message || '快速关联完成')
    loadStats()
  } catch (error) {
    ElMessage.error('关联失败')
  } finally {
    linkingQuestionsFast.value = false
  }
}

// 提取知识点定时器引用
let extractTimer = null

const handleExtract = async () => {
  if (!extractForm.value.lectureIds?.length) {
    ElMessage.warning('请选择讲义')
    return
  }
  extracting.value = true
  try {
    await kgApi.extract(extractForm.value)
    ElMessage.success('提取任务已启动')
    showExtractDialog.value = false
    // 保存定时器引用以便清理
    extractTimer = setTimeout(() => {
      loadPoints()
      loadStats()
      extractTimer = null
    }, 2000)
  } catch (error) {
    ElMessage.error('提取失败')
  } finally {
    extracting.value = false
  }
}

// 切换标签时加载数据
watch(activeTab, (tab) => {
  if (tab === 'points') loadPoints()
  else if (tab === 'topics') loadTopics()
})

onMounted(() => {
  loadPoints()
  loadTopics()
  loadStats()
  loadLectures()
})

// 清理定时器，防止内存泄漏
onBeforeUnmount(() => {
  if (extractTimer) {
    clearTimeout(extractTimer)
    extractTimer = null
  }
})
</script>

<style scoped>
.kg-page {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-body {
  padding: 24px;
  max-width: 1400px;
  margin: 0 auto;
  animation: wabi-fade-in 0.4s ease;
}

@keyframes wabi-fade-in {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 页面头部 */
.page-hero .wabi-card-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.hero-title {
  font-size: 20px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0 0 4px 0;
}

.hero-desc {
  font-size: 14px;
  color: var(--wabi-text-secondary, #8a8580);
  margin: 0;
}

.hero-actions {
  display: flex;
  gap: 8px;
}

/* 统计卡片 */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
  margin: 16px 0;
}

.stat-card {
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  padding: 16px 20px;
  text-align: center;
}

.stat-value {
  font-size: 24px;
  font-weight: 600;
  color: var(--wabi-text, #2c2c2c);
  font-family: 'Georgia', serif;
}

.stat-label {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-top: 4px;
}

/* 标签导航 */
.tab-nav {
  display: flex;
  gap: 4px;
}

.tab-item {
  padding: 8px 16px;
  font-size: 14px;
  color: var(--wabi-text-secondary, #8a8580);
  cursor: pointer;
  border-bottom: 2px solid transparent;
  transition: all 0.2s ease;
}

.tab-item:hover {
  color: var(--wabi-text, #2c2c2c);
}

.tab-item.active {
  color: var(--wabi-accent, #7a8b6f);
  border-bottom-color: var(--wabi-accent, #7a8b6f);
}

/* 工具栏 */
.toolbar {
  display: flex;
  gap: 8px;
  margin-bottom: 16px;
  flex-wrap: wrap;
}

.graph-toolbar {
  display: flex;
  gap: 8px;
  margin-bottom: 16px;
  align-items: center;
}

.graph-hint {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.wabi-search {
  width: 240px;
}

.topic-select {
  width: 180px;
}

/* 知识点列表 */
.point-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.point-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 4px;
}

.point-info {
  display: flex;
  align-items: center;
  gap: 8px;
  flex: 1;
}

.point-name {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
  font-weight: 500;
}

.point-desc {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  max-width: 300px;
}

.point-actions {
  display: flex;
  gap: 4px;
}

/* 主题列表 */
.topic-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.topic-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 4px;
}

.topic-info {
  display: flex;
  align-items: center;
  gap: 12px;
  flex: 1;
}

.topic-name {
  font-size: 14px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
}

.topic-desc {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.topic-count {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  padding: 2px 8px;
  background: var(--wabi-border-light, #f0ece8);
  border-radius: 2px;
}

.topic-actions {
  display: flex;
  gap: 4px;
}

/* 图谱标签页 */
.graph-tab {
  min-height: 600px;
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

/* 讲义选择 */
.lecture-select-wrapper {
  width: 100%;
}

.lecture-select-actions {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-top: 8px;
}

.lecture-count {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-left: auto;
}

/* 响应式 */
@media (max-width: 768px) {
  .wabi-body {
    padding: 16px;
  }

  .page-hero .wabi-card-content {
    flex-direction: column;
    gap: 12px;
  }

  .hero-actions {
    width: 100%;
    flex-wrap: wrap;
  }

  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .toolbar {
    flex-direction: column;
  }

  .wabi-search,
  .topic-select {
    width: 100%;
  }

  .point-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }

  .point-actions {
    width: 100%;
    justify-content: flex-end;
  }

  .topic-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }

  .topic-actions {
    width: 100%;
    justify-content: flex-end;
  }
}
</style>
