<template>
  <div class="kg-page">
    <!-- Header -->
    <div class="page-header">
      <div class="header-left">
        <h2 class="page-title">知识图谱管理</h2>
        <p class="page-subtitle">管理讲义知识点、题目关联，构建课程知识体系</p>
      </div>
      <div class="header-actions">
        <el-button @click="showExtractDialog = true" type="primary" :icon="MagicStick">
          从讲义提取知识点
        </el-button>
        <el-button @click="linkQuestionsFast" type="warning" :icon="Connection" :loading="linkingQuestionsFast">
          快速关联 (Embedding)
        </el-button>
        <el-button @click="linkQuestions" type="success" :icon="Connection" :loading="linkingQuestions">
          精确关联 (LLM)
        </el-button>
      </div>
    </div>

    <!-- Stats -->
    <el-row :gutter="16" class="stats-row">
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-value">{{ stats.totalKPs }}</div>
          <div class="stat-label">知识节点</div>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-value">{{ stats.linkedQuestions }}</div>
          <div class="stat-label">已关联题目</div>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-value">{{ topics.length }}</div>
          <div class="stat-label">知识主题</div>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-value">{{ stats.totalQuestions || 0 }}</div>
          <div class="stat-label">题库总量</div>
        </div>
      </el-col>
    </el-row>

    <!-- Tabs: Knowledge Points | Topics -->
    <el-tabs v-model="activeTab" class="kg-tabs">
      <el-tab-pane label="知识点" name="points">
        <div class="tab-toolbar">
          <el-input v-model="searchKeyword" placeholder="搜索知识点..."
            clearable style="width: 240px" @clear="loadPoints" @keyup.enter="loadPoints">
            <template #prefix><el-icon><Search /></el-icon></template>
          </el-input>
          <el-select v-model="filterTopicId" placeholder="按主题筛选" clearable
            style="width: 180px; margin-left: 10px" @change="loadPoints">
            <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.id" />
          </el-select>
          <el-button type="primary" plain @click="loadPoints" style="margin-left: 10px">查询</el-button>
          <el-button @click="showCreateKpDialog = true" style="margin-left: auto">手动添加</el-button>
        </div>

        <el-table :data="points" v-loading="loadingPoints" stripe class="points-table">
          <el-table-column prop="name" label="知识点名称" min-width="180">
            <template #default="{ row }">
              <span class="kp-name">{{ row.name }}</span>
              <el-tag v-if="row.source === 'LLM_EXTRACTED'" size="small" type="info" effect="plain">AI提取</el-tag>
              <el-tag v-else size="small" type="success" effect="plain">手动</el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="description" label="描述" min-width="220" show-overflow-tooltip />
          <el-table-column prop="topic" label="所属主题" width="120">
            <template #default="{ row }">{{ row.topic?.name || '-' }}</template>
          </el-table-column>
          <el-table-column prop="confidence" label="置信度" width="100" align="center">
            <template #default="{ row }">
              <el-progress v-if="row.confidence" :percentage="Math.round(row.confidence * 100)"
                :stroke-width="6" :show-text="false"
                :color="row.confidence >= 0.8 ? '#67c23a' : '#e6a23c'" />
              <span v-else>-</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="120" fixed="right">
            <template #default="{ row }">
              <el-button type="danger" link size="small" @click="deletePoint(row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>

        <el-pagination v-if="pointsTotal > pageSize" class="pagination"
          :current-page="currentPage" :page-size="pageSize" :total="pointsTotal"
          layout="total, prev, pager, next" @current-change="loadPoints" />
      </el-tab-pane>

      <el-tab-pane label="主题管理" name="topics">
        <div class="tab-toolbar">
          <el-button type="primary" @click="showCreateTopicDialog = true">新建主题</el-button>
        </div>
        <el-table :data="topics" v-loading="loadingTopics" stripe>
          <el-table-column prop="name" label="主题名称" min-width="160" />
          <el-table-column prop="description" label="描述" min-width="200" show-overflow-tooltip />
          <el-table-column prop="kpCount" label="知识点数" width="100" align="center" />
          <el-table-column label="操作" width="140" fixed="right">
            <template #default="{ row }">
              <el-button type="primary" link size="small" @click="openEditTopic(row)">编辑</el-button>
              <el-button type="danger" link size="small" @click="deleteTopic(row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>
    </el-tabs>

    <!-- Extract Dialog -->
    <el-dialog v-model="showExtractDialog" title="从讲义提取知识点" width="600px">
      <p class="dialog-hint">选择要提取知识点的讲义，AI 将自动分析内容并构建知识图谱。</p>
      <el-select v-model="selectedLectureIds" multiple placeholder="选择讲义..."
        style="width: 100%" filterable>
        <el-option v-for="l in lectures" :key="l.lectureId"
          :label="l.lectureName" :value="l.lectureId" />
      </el-select>
      <el-select v-model="extractTopicId" placeholder="归属主题（可选）" clearable
        style="width: 100%; margin-top: 12px">
        <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.id" />
      </el-select>
      <template #footer>
        <el-button @click="showExtractDialog = false">取消</el-button>
        <el-button type="primary" :loading="extracting" @click="extractPoints">
          开始提取
        </el-button>
      </template>
    </el-dialog>

    <!-- Create Knowledge Point Dialog -->
    <el-dialog v-model="showCreateKpDialog" title="手动添加知识点" width="500px">
      <el-form :model="createKpForm" label-width="80px">
        <el-form-item label="名称">
          <el-input v-model="createKpForm.name" placeholder="知识点名称" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="createKpForm.description" type="textarea" :rows="3" placeholder="简要描述" />
        </el-form-item>
        <el-form-item label="所属主题">
          <el-select v-model="createKpForm.topicId" placeholder="选择主题" clearable style="width: 100%">
            <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.id" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showCreateKpDialog = false">取消</el-button>
        <el-button type="primary" :loading="creatingKp" @click="createPoint">确定</el-button>
      </template>
    </el-dialog>

    <!-- Create Topic Dialog -->
    <el-dialog v-model="showCreateTopicDialog" title="新建主题" width="450px">
      <el-form :model="createTopicForm" label-width="80px">
        <el-form-item label="名称">
          <el-input v-model="createTopicForm.name" placeholder="主题名称，如：数据结构" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="createTopicForm.description" type="textarea" :rows="2" placeholder="简要描述" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showCreateTopicDialog = false">取消</el-button>
        <el-button type="primary" :loading="creatingTopic" @click="createTopic">确定</el-button>
      </template>
    </el-dialog>

    <!-- Edit Topic Dialog -->
    <el-dialog v-model="showEditTopicDialog" title="编辑主题" width="450px">
      <el-form :model="editTopicForm" label-width="80px">
        <el-form-item label="名称">
          <el-input v-model="editTopicForm.name" placeholder="主题名称，如：数据结构" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="editTopicForm.description" type="textarea" :rows="2" placeholder="简要描述" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showEditTopicDialog = false">取消</el-button>
        <el-button type="primary" :loading="updatingTopic" @click="updateTopic">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Search, MagicStick, Connection } from '@element-plus/icons-vue'
import { kgApi, studentApi, teacherApi } from '@/api'

const activeTab = ref('points')

// Knowledge points
const points = ref([])
const pointsTotal = ref(0)
const loadingPoints = ref(false)
const currentPage = ref(1)
const pageSize = ref(15)
const searchKeyword = ref('')
const filterTopicId = ref('')

// Topics
const topics = ref([])
const loadingTopics = ref(false)

// Lectures (for extraction)
const lectures = ref([])

// Stats
const stats = reactive({ totalKPs: 0, linkedQuestions: 0, totalQuestions: 0 })

// Dialogs
const showExtractDialog = ref(false)
const extracting = ref(false)
const selectedLectureIds = ref([])
const extractTopicId = ref('')

const showCreateKpDialog = ref(false)
const creatingKp = ref(false)
const createKpForm = reactive({ name: '', description: '', topicId: '' })

const showCreateTopicDialog = ref(false)
const creatingTopic = ref(false)
const createTopicForm = reactive({ name: '', description: '' })

const showEditTopicDialog = ref(false)
const updatingTopic = ref(false)
const editTopicForm = reactive({ id: '', name: '', description: '' })

// Question linking
const linkingQuestions = ref(false)
const linkingQuestionsFast = ref(false)

// Load
const loadPoints = async (page = 1) => {
  currentPage.value = page
  loadingPoints.value = true
  try {
    const res = await kgApi.getPoints({
      topicId: filterTopicId.value || undefined,
      keyword: searchKeyword.value || undefined,
      page,
      size: pageSize.value
    })
    if (res.code === 0) {
      points.value = res.data?.list || []
      pointsTotal.value = res.data?.total || 0
      stats.totalKPs = res.data?.total || 0
    }
  } catch (e) {
    ElMessage.error('加载知识点失败')
  } finally {
    loadingPoints.value = false
  }
}

const loadTopics = async () => {
  loadingTopics.value = true
  try {
    const res = await kgApi.getTopics()
    if (res.code === 0) {
      topics.value = res.data || []
    }
  } catch (e) {
    ElMessage.error('加载主题失败')
  } finally {
    loadingTopics.value = false
  }
}

const loadLectures = async () => {
  try {
    const res = await teacherApi.lecture.getAll()
    if (res.code === 0) {
      lectures.value = res.data || []
    }
  } catch (e) {
    console.error('Failed to load lectures:', e)
  }
}

// Extract knowledge points
const extractPoints = async () => {
  if (selectedLectureIds.value.length === 0) {
    ElMessage.warning('请至少选择一份讲义')
    return
  }
  extracting.value = true
  try {
    const res = await kgApi.extract({
      lectureIds: selectedLectureIds.value,
      topicId: extractTopicId.value || undefined
    })
    if (res.code === 0) {
      ElMessage.success(`知识提取已启动，正在处理 ${selectedLectureIds.value.length} 份讲义`)
      showExtractDialog.value = false
      selectedLectureIds.value = []
      extractTopicId.value = ''
    } else {
      ElMessage.error(res.message || '提取失败')
    }
  } catch (e) {
    ElMessage.error('提取请求失败')
  } finally {
    extracting.value = false
  }
}

// Link questions (LLM - slow)
const linkQuestions = async () => {
  linkingQuestions.value = true
  try {
    const res = await kgApi.linkQuestions({ forceReprocess: false })
    if (res.code === 0) {
      ElMessage.success('LLM关联已启动，正在后台处理（速度较慢）')
    } else {
      ElMessage.error(res.message || '关联失败')
    }
  } catch (e) {
    ElMessage.error('关联请求失败')
  } finally {
    linkingQuestions.value = false
  }
}

// Link questions fast (Embedding - fast)
const linkQuestionsFast = async () => {
  linkingQuestionsFast.value = true
  try {
    const res = await kgApi.linkQuestionsFast({ forceReprocess: false })
    if (res.code === 0) {
      ElMessage.success('快速关联已启动，基于向量相似度匹配（速度快）')
    } else {
      ElMessage.error(res.message || '关联失败')
    }
  } catch (e) {
    ElMessage.error('关联请求失败')
  } finally {
    linkingQuestionsFast.value = false
  }
}

// Create knowledge point
const createPoint = async () => {
  if (!createKpForm.name.trim()) {
    ElMessage.warning('请输入知识点名称')
    return
  }
  creatingKp.value = true
  try {
    const res = await kgApi.createPoint({
      name: createKpForm.name,
      description: createKpForm.description,
      topicId: createKpForm.topicId || undefined
    })
    if (res.code === 0) {
      ElMessage.success('知识点创建成功')
      showCreateKpDialog.value = false
      Object.assign(createKpForm, { name: '', description: '', topicId: '' })
      loadPoints()
    } else {
      ElMessage.error(res.message || '创建失败')
    }
  } catch (e) {
    ElMessage.error('创建请求失败')
  } finally {
    creatingKp.value = false
  }
}

// Create topic
const createTopic = async () => {
  if (!createTopicForm.name.trim()) {
    ElMessage.warning('请输入主题名称')
    return
  }
  creatingTopic.value = true
  try {
    const res = await kgApi.createTopic({
      name: createTopicForm.name,
      description: createTopicForm.description
    })
    if (res.code === 0) {
      ElMessage.success('主题创建成功')
      showCreateTopicDialog.value = false
      Object.assign(createTopicForm, { name: '', description: '' })
      loadTopics()
    } else {
      ElMessage.error(res.message || '创建失败')
    }
  } catch (e) {
    ElMessage.error('创建请求失败')
  } finally {
    creatingTopic.value = false
  }
}

// Edit topic
const openEditTopic = (row) => {
  editTopicForm.id = row.id
  editTopicForm.name = row.name
  editTopicForm.description = row.description || ''
  showEditTopicDialog.value = true
}

const updateTopic = async () => {
  if (!editTopicForm.name.trim()) {
    ElMessage.warning('请输入主题名称')
    return
  }
  updatingTopic.value = true
  try {
    const res = await kgApi.updateTopic(editTopicForm.id, {
      name: editTopicForm.name,
      description: editTopicForm.description
    })
    if (res.code === 0) {
      ElMessage.success('主题更新成功')
      showEditTopicDialog.value = false
      loadTopics()
    } else {
      ElMessage.error(res.message || '更新失败')
    }
  } catch (e) {
    ElMessage.error('更新请求失败')
  } finally {
    updatingTopic.value = false
  }
}

// Delete topic
const deleteTopic = (row) => {
  ElMessageBox.confirm(`确定要删除主题 "${row.name}" 吗？其下的知识点将解除关联。`, '确认删除', {
    confirmButtonText: '确定', cancelButtonText: '取消', type: 'warning'
  }).then(async () => {
    try {
      const res = await kgApi.deleteTopic(row.id)
      if (res.code === 0) {
        ElMessage.success('已删除')
        loadTopics()
        loadPoints()
      } else {
        ElMessage.error(res.message || '删除失败')
      }
    } catch (e) {
      ElMessage.error('删除请求失败')
    }
  }).catch(() => {})
}

// Delete knowledge point
const deletePoint = (row) => {
  ElMessageBox.confirm(`确定要删除知识点 "${row.name}" 吗？`, '确认删除', {
    confirmButtonText: '确定', cancelButtonText: '取消', type: 'warning'
  }).then(async () => {
    try {
      const res = await kgApi.deletePoint(row.id)
      if (res.code === 0) {
        ElMessage.success('已删除')
        loadPoints()
      } else {
        ElMessage.error(res.message || '删除失败')
      }
    } catch (e) {
      ElMessage.error('删除请求失败')
    }
  }).catch(() => {})
}

onMounted(() => {
  loadPoints()
  loadTopics()
  loadLectures()
})
</script>

<style scoped>
.kg-page {
  max-width: 1400px;
  margin: 0 auto;
  padding: 24px;
}
.page-header {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  margin-bottom: 20px;
  flex-wrap: wrap;
  gap: 12px;
}
.page-title { font-size: 22px; font-weight: 600; color: #1f2328; margin: 0 0 4px; }
.page-subtitle { font-size: 13px; color: #8b949e; margin: 0; }
.header-actions { display: flex; gap: 10px; flex-shrink: 0; }
.stats-row { margin-bottom: 20px; }
.stat-card {
  background: #fff; border-radius: 10px; padding: 18px 20px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.04); text-align: center;
}
.stat-value { font-size: 28px; font-weight: 700; color: #409eff; }
.stat-label { font-size: 13px; color: #909399; margin-top: 4px; }
.kg-tabs { background: #fff; border-radius: 10px; padding: 16px 20px; box-shadow: 0 1px 4px rgba(0,0,0,0.04); }
.tab-toolbar { display: flex; align-items: center; margin-bottom: 14px; }
.points-table { margin-top: 8px; }
.kp-name { margin-right: 8px; font-weight: 500; }
.pagination { margin-top: 16px; justify-content: flex-end; }
.dialog-hint { font-size: 13px; color: #909399; margin: 0 0 16px; }
</style>
