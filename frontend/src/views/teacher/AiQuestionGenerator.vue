<template>
  <div class="ai-question-generator">
    <!-- 顶部导航栏 -->
    <header class="top-nav">
      <div class="nav-left">
        <div class="nav-brand">
          <el-icon :size="24"><MagicStick /></el-icon>
          <span class="brand-text">AI 题目生成器</span>
        </div>
        <span class="nav-desc">智能生成 · 多题型支持 · 相似度查重</span>
      </div>
      <div class="nav-right">
        <el-button @click="showHistory = true" text class="nav-btn">
          <el-icon><Clock /></el-icon>
          <span>生成历史</span>
        </el-button>
        <el-button @click="startNewGeneration" text class="nav-btn" v-if="currentBatch">
          <el-icon><Plus /></el-icon>
          <span>新建生成</span>
        </el-button>
      </div>
    </header>

    <!-- 主内容区 -->
    <main class="main-content">
      <!-- 配置区域 - 无批次时显示 -->
      <section v-if="!currentBatch" class="config-section">
        <div class="config-container">
          <div class="config-header">
            <h2>配置生成参数</h2>
            <p>选择题型、设置参数，AI 将根据知识库智能生成题目</p>
          </div>

          <el-form :model="generateForm" :rules="formRules" ref="formRef" class="config-form" label-position="top">
            <!-- 题型选择 -->
            <div class="form-section">
              <div class="section-title">
                <el-icon><Grid /></el-icon>
                <span>题目类型</span>
              </div>
              <div class="type-grid">
                <div v-for="type in questionTypes" :key="type.value"
                     class="type-card"
                     :class="{ active: generateForm.questionTypes.includes(type.value) }"
                     @click="toggleQuestionType(type.value)">
                  <div class="type-icon">
                    <el-icon :size="28"><component :is="type.icon" /></el-icon>
                  </div>
                  <div class="type-info">
                    <div class="type-name">{{ type.label }}</div>
                    <div class="type-desc">{{ type.desc }}</div>
                  </div>
                  <div class="type-check" v-if="generateForm.questionTypes.includes(type.value)">
                    <el-icon><Check /></el-icon>
                  </div>
                </div>
              </div>
            </div>

            <!-- 知识库检索 -->
            <div class="form-section">
              <div class="section-title">
                <el-icon><Search /></el-icon>
                <span>知识库检索</span>
              </div>
              <el-input
                v-model="generateForm.knowledgeKeywords"
                placeholder="输入关键词，如：数据结构 栈 队列"
                :rows="2"
                type="textarea"
                class="keyword-input"
              />
              <div class="form-hint">
                <el-icon><InfoFilled /></el-icon>
                <span>系统会从知识库中检索相关文档作为题目生成依据</span>
              </div>
            </div>

            <!-- 讲义选择 -->
            <div class="form-section">
              <div class="section-title">
                <el-icon><Document /></el-icon>
                <span>指定讲义</span>
                <span class="optional-tag">可选</span>
              </div>
              <el-select
                ref="lectureSelectRef"
                v-model="generateForm.lectureIds"
                multiple
                filterable
                remote
                :remote-method="searchLectures"
                :loading="lectureLoading"
                placeholder="搜索讲义..."
                style="width: 100%"
                popper-class="lecture-select-popper"
                @visible-change="onLectureDropdownVisible"
                class="lecture-select"
              >
                <el-option
                  v-for="lecture in lectures"
                  :key="lecture.lectureId"
                  :label="lecture.lectureName"
                  :value="lecture.lectureId"
                />
                <el-option
                  v-if="lectureLoadingMore"
                  :value="'__loading__'"
                  :label="'加载中...'"
                  disabled
                  class="loading-option"
                >
                  <div class="loading-more-tip">加载中...</div>
                </el-option>
              </el-select>
            </div>

            <!-- 参数配置 -->
            <div class="form-section">
              <div class="section-title">
                <el-icon><Setting /></el-icon>
                <span>生成参数</span>
              </div>
              <div class="params-grid">
                <div class="param-item">
                  <label>每种题型数量</label>
                  <el-input-number
                    v-model="generateForm.countPerType"
                    :min="1"
                    :max="20"
                    :step="1"
                    size="large"
                  />
                </div>
                <div class="param-item">
                  <label>难度要求</label>
                  <div class="difficulty-selector">
                    <div v-for="diff in difficulties" :key="diff.value"
                         class="diff-option"
                         :class="{ active: generateForm.difficulty === diff.value }"
                         @click="generateForm.difficulty = diff.value">
                      {{ diff.label }}
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- 提交按钮 -->
            <div class="form-actions">
              <el-button @click="resetForm" :disabled="generating" size="large" class="reset-btn">
                重置
              </el-button>
              <el-button type="primary" @click="handleGenerate" :loading="generating" size="large" class="submit-btn">
                <el-icon><MagicStick /></el-icon>
                {{ generating ? '正在启动...' : '开始生成' }}
              </el-button>
            </div>
          </el-form>
        </div>
      </section>

      <!-- 生成中状态 -->
      <section v-if="currentBatch && (currentBatch.status === 'generating' || generating)" class="generating-section">
        <div class="generating-container">
          <!-- 页面标题 -->
          <div class="generating-header">
            <el-icon class="spin-icon"><Loading /></el-icon>
            <h2>正在生成题目</h2>
            <el-tag type="warning" effect="dark" size="small">生成中</el-tag>
          </div>

          <!-- 双面板布局 -->
          <div class="generating-panels">
            <!-- 左侧进度面板 -->
            <div class="progress-panel">
              <div class="progress-content">
                <div class="progress-ring-wrapper">
                  <el-progress
                    type="circle"
                    :percentage="progressPercentage"
                    :status="progressStatus"
                    :width="180"
                    :stroke-width="10"
                    class="circle-progress"
                  />
                </div>
                <p class="progress-text">{{ progressText }}</p>

                <div class="progress-stats">
                  <div class="stat-box">
                    <span class="stat-num">{{ currentBatch.questions?.length || 0 }}</span>
                    <span class="stat-label">已生成</span>
                  </div>
                  <div class="stat-divider"></div>
                  <div class="stat-box">
                    <span class="stat-num">{{ currentBatch.totalCount || currentBatch.request?.countPerType * currentBatch.request?.questionTypes?.length || 5 }}</span>
                    <span class="stat-label">目标数量</span>
                  </div>
                </div>

                <div class="progress-detail">
                  <div class="detail-item">
                    <el-icon><Clock /></el-icon>
                    <span>开始时间：{{ formatTime(currentBatch.startedAt) }}</span>
                  </div>
                </div>
              </div>
            </div>

            <!-- 右侧实时预览面板 -->
            <div class="preview-panel">
              <div class="preview-header">
                <div class="preview-title">
                  <el-icon><List /></el-icon>
                  <span>实时预览</span>
                </div>
                <span class="preview-count">{{ currentBatch.questions?.length || 0 }} / {{ currentBatch.totalCount || currentBatch.request?.countPerType * currentBatch.request?.questionTypes?.length || 5 }} 道</span>
              </div>

              <div class="preview-list" v-if="currentBatch.questions && currentBatch.questions.length > 0">
                <transition-group name="preview-item">
                  <div v-for="(q, index) in currentBatch.questions" :key="q.tempId || index" class="preview-card">
                    <div class="preview-index">#{{ index + 1 }}</div>
                    <div class="preview-body">
                      <div class="preview-top">
                        <span class="preview-type">{{ getTypeName(q.type) }}</span>
                      </div>
                      <div class="preview-content" v-html="formatQuestionText(q.question)"></div>
                    </div>
                  </div>
                </transition-group>
              </div>

              <div class="preview-empty" v-else>
                <el-icon :size="48"><Document /></el-icon>
                <p>等待题目生成...</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- 生成失败 -->
      <section v-if="currentBatch && currentBatch.status === 'failed'" class="error-section">
        <div class="error-container">
          <div class="error-icon">
            <el-icon :size="64"><CircleClose /></el-icon>
          </div>
          <h2>生成失败</h2>
          <p class="error-message">{{ currentBatch.errorMessage || '生成过程中发生错误' }}</p>
          <el-button type="primary" @click="startNewGeneration" size="large">
            <el-icon><Refresh /></el-icon>
            重新尝试
          </el-button>
        </div>
      </section>

      <!-- 生成结果审核 -->
      <section v-if="currentBatch && currentBatch.status === 'completed'" class="result-section">
        <!-- 顶部操作栏 -->
        <div class="result-toolbar">
          <div class="toolbar-left">
            <h2>生成结果审核</h2>
            <el-tag type="success" effect="dark" size="small">已完成</el-tag>
          </div>
          <div class="toolbar-right">
            <el-button type="primary" @click="handleBatchPersist" :loading="persisting">
              <el-icon><Upload /></el-icon>
              批量入库
            </el-button>
            <el-button @click="startNewGeneration">
              <el-icon><Back /></el-icon>
              返回
            </el-button>
          </div>
        </div>

        <!-- 统计卡片 -->
        <div class="stats-row">
          <div class="stat-card" v-for="item in statCards" :key="item.key">
            <div class="stat-icon-wrap" :class="item.key">
              <el-icon><component :is="item.icon" /></el-icon>
            </div>
            <div class="stat-content">
              <div class="stat-value" :class="{ 'text-sm': item.small }">{{ item.value }}</div>
              <div class="stat-label">{{ item.label }}</div>
            </div>
          </div>
        </div>

        <!-- 筛选栏 -->
        <div class="filter-row">
          <div class="filter-tabs">
            <div v-for="tab in filterTabs" :key="tab.value"
                 class="filter-tab"
                 :class="{ active: filterStatus === tab.value }"
                 @click="filterStatus = tab.value; filterQuestions()">
              {{ tab.label }}
            </div>
          </div>
          <el-select v-model="filterType" placeholder="题型" clearable @change="filterQuestions" size="small" class="type-select">
            <el-option label="填空题" :value="1" />
            <el-option label="单选题" :value="2" />
            <el-option label="多选题" :value="3" />
            <el-option label="判断题" :value="4" />
            <el-option label="简答题" :value="5" />
            <el-option label="编程题" :value="6" />
          </el-select>
        </div>

        <!-- 题目列表 -->
        <div class="questions-grid">
          <div v-for="question in filteredQuestions" :key="question.tempId"
               class="question-item"
               :class="question.status">
            <!-- 题目头部 -->
            <div class="item-header">
              <div class="item-tags">
                <span class="tag type-tag" :class="'type-' + question.type">{{ question.typeName }}</span>
                <span class="tag diff-tag" :class="'diff-' + question.difficulty">{{ getDifficultyText(question.difficulty) }}</span>
                <span class="tag status-tag" :class="'status-' + question.status">{{ getStatusText(question.status) }}</span>
                <span class="tag warn-tag" v-if="question.similarityScore > 0.5">
                  <el-icon><Warning /></el-icon>
                  {{ (question.similarityScore * 100).toFixed(0) }}%
                </span>
              </div>
              <span class="item-score">{{ question.score }}分</span>
            </div>

            <!-- 题目内容 -->
            <div class="item-body">
              <div class="content-section" v-if="editingQuestion !== question.tempId">
                <div class="content-label">题目</div>
                <div class="content-text" v-html="formatQuestionText(question.modifiedQuestion || question.question)"></div>
              </div>
              <div v-else class="edit-section">
                <div class="content-label">题目</div>
                <el-input v-model="editForm.question" type="textarea" :rows="3" />
              </div>

              <div class="content-section" v-if="editingQuestion !== question.tempId">
                <div class="content-label">答案</div>
                <div class="content-text answer-text">{{ question.modifiedAnswer || question.answer }}</div>
              </div>
              <div v-else class="edit-section">
                <div class="content-label">答案</div>
                <el-input v-model="editForm.answer" type="textarea" :rows="2" />
              </div>

              <div class="content-section" v-if="editingQuestion !== question.tempId">
                <div class="content-label">解析</div>
                <div class="content-text analysis-text">{{ question.modifiedAnalysis || question.analysis }}</div>
              </div>
              <div v-else class="edit-section">
                <div class="content-label">解析</div>
                <el-input v-model="editForm.analysis" type="textarea" :rows="2" />
              </div>

              <div class="item-meta" v-if="question.knowledgePoint || question.similarQuestionText">
                <div class="meta-item" v-if="question.knowledgePoint">
                  <el-icon><Collection /></el-icon>
                  <span>知识点：{{ question.knowledgePoint }}</span>
                </div>
                <div class="meta-item warn" v-if="question.similarQuestionText">
                  <el-icon><Warning /></el-icon>
                  <span>相似：{{ question.similarQuestionText }}</span>
                </div>
              </div>
            </div>

            <!-- 操作按钮 -->
            <div class="item-actions">
              <template v-if="editingQuestion !== question.tempId">
                <el-button type="success" @click="handleApprove(question)" :disabled="question.status === 'persisted'" size="small" text>
                  <el-icon><Check /></el-icon> 批准
                </el-button>
                <el-button type="danger" @click="handleReject(question)" :disabled="question.status === 'persisted'" size="small" text>
                  <el-icon><Close /></el-icon> 拒绝
                </el-button>
                <el-button type="primary" @click="startEdit(question)" :disabled="question.status === 'persisted'" size="small" text>
                  <el-icon><Edit /></el-icon> 修改
                </el-button>
                <el-button type="warning" @click="handleRegenerate(question)" :disabled="question.status === 'persisted'" size="small" text>
                  <el-icon><Refresh /></el-icon> 重新生成
                </el-button>
                <el-button type="info" @click="handlePersist(question)" :disabled="question.status === 'persisted'" size="small" text>
                  <el-icon><Download /></el-icon> 入库
                </el-button>
              </template>
              <template v-else>
                <el-button type="success" @click="saveEdit(question)" size="small">
                  <el-icon><Check /></el-icon> 保存
                </el-button>
                <el-button @click="cancelEdit" size="small">取消</el-button>
              </template>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- 生成历史对话框 -->
    <el-dialog v-model="showHistory" title="生成历史" width="720px" class="history-dialog">
      <div class="history-list">
        <div v-for="batch in batches" :key="batch.batchId" class="history-item"
             :class="{ 'active': currentBatch?.batchId === batch.batchId }" @click="loadBatch(batch.batchId)">
          <div class="history-top">
            <div class="history-time">
              <el-icon><Clock /></el-icon>
              <span>{{ formatTime(batch.startedAt) }}</span>
            </div>
            <span class="history-status" :class="batch.status">{{ getStatusText(batch.status) }}</span>
          </div>
          <div class="history-detail">
            <span>{{ getTypeNames(batch.request?.questionTypes) }}</span>
            <span>{{ batch.totalCount }}题</span>
            <span>已批准{{ batch.approvedCount || 0 }}</span>
            <span>已入库{{ batch.persistedCount || 0 }}</span>
          </div>
        </div>
        <el-empty v-if="batches.length === 0" description="暂无生成历史" />
      </div>
    </el-dialog>

    <!-- 重新生成对话框 -->
    <el-dialog v-model="showRegenerateDialog" title="重新生成题目" width="480px">
      <el-form :model="regenerateForm">
        <el-form-item label="生成要求">
          <el-input
            v-model="regenerateForm.requirements"
            type="textarea"
            :rows="4"
            placeholder="请输入对新题目的要求，例如：从不同角度考察、增加难度、改变问法等"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showRegenerateDialog = false">取消</el-button>
        <el-button type="primary" @click="confirmRegenerate" :loading="regenerating">
          <el-icon><MagicStick /></el-icon>
          确认生成
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, onUnmounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { aiQuestionApi, teacherApi } from '@/api'

// 表单引用
const formRef = ref(null)

// 生成表单
const generateForm = reactive({
  questionTypes: [],
  knowledgeKeywords: '',
  lectureIds: [],
  countPerType: 5,
  difficulty: 'mixed'
})

// 表单验证规则
const formRules = {
  questionTypes: [
    { type: 'array', required: true, message: '请选择至少一种题型', trigger: 'change' }
  ],
  countPerType: [
    { required: true, message: '请输入每种题型数量', trigger: 'blur' }
  ]
}

// 状态变量
const generating = ref(false)
const currentBatch = ref(null)
const batches = ref([])
const lectures = ref([])
const showHistory = ref(false)
const showRegenerateDialog = ref(false)
const persisting = ref(false)
const regenerating = ref(false)
const editingQuestion = ref(null)
const filterStatus = ref('all')
const filterType = ref(null)
const progressPercentage = ref(0)
const progressStatus = ref('')
const progressText = ref('')

// 讲义分页相关
const lectureSelectRef = ref(null)
const lectureLoading = ref(false)
const lectureLoadingMore = ref(false)
const lecturePage = ref(1)
const lectureTotal = ref(0)
const lectureSearchKeyword = ref('')
const lecturePageSize = 20
let scrollListenerAttached = false

const hasMoreLectures = computed(() => {
  return lectures.value.length < lectureTotal.value
})

// 编辑表单
const editForm = reactive({
  question: '',
  answer: '',
  analysis: ''
})

// 重新生成表单
const regenerateForm = reactive({
  requirements: '',
  tempId: ''
})

// 轮询定时器
let pollingTimer = null

// 题型配置
const questionTypes = [
  { value: 1, label: '填空题', icon: 'Edit', desc: '考察基础概念' },
  { value: 2, label: '单选题', icon: 'CircleCheck', desc: '考察理解判断' },
  { value: 3, label: '多选题', icon: 'Finished', desc: '考察综合分析' },
  { value: 4, label: '判断题', icon: 'Switch', desc: '考察是非辨别' },
  { value: 5, label: '简答题', icon: 'Document', desc: '考察表达能力' },
  { value: 6, label: '编程题', icon: 'Monitor', desc: '考察实践能力' }
]

// 难度配置
const difficulties = [
  { value: 'easy', label: '简单' },
  { value: 'medium', label: '中等' },
  { value: 'hard', label: '困难' },
  { value: 'mixed', label: '混合' }
]

// 筛选标签
const filterTabs = [
  { value: 'all', label: '全部' },
  { value: 'pending', label: '待审核' },
  { value: 'approved', label: '已批准' },
  { value: 'rejected', label: '已拒绝' },
  { value: 'modified', label: '已修改' },
  { value: 'persisted', label: '已入库' }
]

// 计算属性：过滤后的题目
const filteredQuestions = computed(() => {
  if (!currentBatch.value?.questions) return []

  return currentBatch.value.questions.filter(q => {
    if (filterStatus.value !== 'all' && q.status !== filterStatus.value) return false
    if (filterType.value && q.type !== filterType.value) return false
    return true
  })
})

// 计算属性：统计卡片数据
const statCards = computed(() => {
  if (!currentBatch.value) return []
  return [
    {
      key: 'total',
      icon: 'Document',
      value: currentBatch.value.totalCount || 0,
      label: '总题数',
      small: false
    },
    {
      key: 'approved',
      icon: 'CircleCheck',
      value: currentBatch.value.approvedCount || 0,
      label: '已批准',
      small: false
    },
    {
      key: 'rejected',
      icon: 'CircleClose',
      value: currentBatch.value.rejectedCount || 0,
      label: '已拒绝',
      small: false
    },
    {
      key: 'persisted',
      icon: 'Upload',
      value: currentBatch.value.persistedCount || 0,
      label: '已入库',
      small: false
    },
    {
      key: 'types',
      icon: 'Grid',
      value: getTypeDistributionText(),
      label: '题型分布',
      small: true
    },
    {
      key: 'time',
      icon: 'Clock',
      value: getRemainingTime(),
      label: '剩余时间',
      small: true
    }
  ]
})

// 生命周期
onMounted(() => {
  loadBatches()
})

onUnmounted(() => {
  if (pollingTimer) {
    clearInterval(pollingTimer)
  }
  removeScrollListener()
})

// 切换题型选择
const toggleQuestionType = (type) => {
  const index = generateForm.questionTypes.indexOf(type)
  if (index === -1) {
    generateForm.questionTypes.push(type)
  } else {
    generateForm.questionTypes.splice(index, 1)
  }
}

// 加载讲义列表（分页）
const loadLectures = async (reset = true) => {
  if (reset) {
    lecturePage.value = 1
    lectures.value = []
  }
  lectureLoading.value = true
  try {
    const res = await teacherApi.lecture.list({
      page: lecturePage.value,
      pageSize: lecturePageSize,
      keyword: lectureSearchKeyword.value || undefined
    })
    if (res.code === 0) {
      const pageData = res.data
      if (reset) {
        lectures.value = pageData.list || []
      } else {
        lectures.value = [...lectures.value, ...(pageData.list || [])]
      }
      lectureTotal.value = pageData.total || 0
    }
  } catch (e) {
    console.error('加载讲义列表失败:', e)
  } finally {
    lectureLoading.value = false
  }
}

// 搜索讲义
const searchLectures = async (keyword) => {
  lectureSearchKeyword.value = keyword
  await loadLectures(true)
}

// 加载更多讲义
const loadMoreLectures = async () => {
  if (lectureLoadingMore.value || !hasMoreLectures.value) return
  lectureLoadingMore.value = true
  lecturePage.value++
  try {
    const res = await teacherApi.lecture.list({
      page: lecturePage.value,
      pageSize: lecturePageSize,
      keyword: lectureSearchKeyword.value || undefined
    })
    if (res.code === 0) {
      const pageData = res.data
      lectures.value = [...lectures.value, ...(pageData.list || [])]
      lectureTotal.value = pageData.total || 0
    }
  } catch (e) {
    console.error('加载更多讲义失败:', e)
    lecturePage.value--
  } finally {
    lectureLoadingMore.value = false
  }
}

// 下拉框可见性变化时，首次加载并设置滚动监听
const onLectureDropdownVisible = (visible) => {
  if (visible) {
    if (lectures.value.length === 0) {
      loadLectures(true)
    }
    setTimeout(setupScrollListener, 100)
  } else {
    removeScrollListener()
  }
}

// 设置下拉框滚动监听
const setupScrollListener = () => {
  if (scrollListenerAttached) return
  const popperEl = document.querySelector('.lecture-select-popper .el-select-dropdown__wrap')
  if (popperEl) {
    popperEl.addEventListener('scroll', handleScroll)
    scrollListenerAttached = true
  }
}

// 移除滚动监听
const removeScrollListener = () => {
  const popperEl = document.querySelector('.lecture-select-popper .el-select-dropdown__wrap')
  if (popperEl) {
    popperEl.removeEventListener('scroll', handleScroll)
    scrollListenerAttached = false
  }
}

// 滚动事件处理
const handleScroll = (e) => {
  const { scrollTop, scrollHeight, clientHeight } = e.target
  if (scrollHeight - scrollTop - clientHeight < 50) {
    loadMoreLectures()
  }
}

// 加载生成历史
const loadBatches = async () => {
  try {
    const res = await aiQuestionApi.getBatches()
    if (res.code === 0) {
      batches.value = res.data || []
    }
  } catch (e) {
    console.error('加载生成历史失败:', e)
  }
}

// 加载指定批次
const loadBatch = async (batchId) => {
  try {
    const res = await aiQuestionApi.getBatch(batchId)
    if (res.code === 0) {
      currentBatch.value = res.data
      showHistory.value = false
    }
  } catch (e) {
    console.error('加载批次失败:', e)
  }
}

// 开始生成
const handleGenerate = async () => {
  if (!formRef.value) return

  // 检查是否已经有正在进行的生成任务
  if (generating.value) {
    ElMessage.warning('正在启动生成任务，请稍候...')
    return
  }

  if (currentBatch.value && (currentBatch.value.status === 'generating' || currentBatch.value.status === 'completed')) {
    ElMessage.warning('已有生成任务，请先完成当前任务或点击"新建生成"')
    return
  }

  await formRef.value.validate(async (valid) => {
    if (!valid) return

    // 先清除之前的轮询定时器
    if (pollingTimer) {
      clearInterval(pollingTimer)
      pollingTimer = null
    }

    generating.value = true
    currentBatch.value = {
      status: 'generating',
      questions: []
    }
    progressPercentage.value = 10
    progressText.value = '正在启动生成任务...'
    progressStatus.value = ''

    try {
      const res = await aiQuestionApi.generate(generateForm)
      if (res.code === 0) {
        const batchId = res.data.batchId
        ElMessage.success('题目生成已启动')
        startPolling(batchId)
      } else {
        ElMessage.error(res.message || '启动生成失败')
        currentBatch.value = null
      }
    } catch (e) {
      ElMessage.error('启动生成失败: ' + e.message)
      currentBatch.value = null
    } finally {
      generating.value = false
    }
  })
}

// 开始新的生成
const startNewGeneration = () => {
  // 先清除轮询定时器
  if (pollingTimer) {
    clearInterval(pollingTimer)
    pollingTimer = null
  }
  // 清除当前批次
  currentBatch.value = null
}

// 开始轮询状态
const startPolling = (batchId) => {
  // 先清除之前的轮询定时器
  if (pollingTimer) {
    clearInterval(pollingTimer)
    pollingTimer = null
  }

  loadBatchStatus(batchId)
  pollingTimer = setInterval(async () => {
    const shouldStop = await loadBatchStatus(batchId)
    if (shouldStop && pollingTimer) {
      clearInterval(pollingTimer)
      pollingTimer = null
    }
  }, 3000)
}

// 加载批次状态
const loadBatchStatus = async (batchId) => {
  try {
    const res = await aiQuestionApi.getBatch(batchId)
    if (res.code === 0) {
      currentBatch.value = res.data

      if (res.data.status === 'generating') {
        const questionCount = res.data.questions?.length || 0
        const totalCount = res.data.totalCount || res.data.request?.countPerType * res.data.request?.questionTypes?.length || 5
        progressPercentage.value = Math.min(Math.round((questionCount / totalCount) * 100), 90)
        progressText.value = `正在生成题目... 已生成 ${questionCount} 道`
        progressStatus.value = ''
      } else if (res.data.status === 'completed') {
        progressPercentage.value = 100
        progressStatus.value = 'success'
        progressText.value = `生成完成！共 ${res.data.questions?.length || 0} 道题目`
        loadBatches()
        return true
      } else if (res.data.status === 'failed') {
        progressPercentage.value = 100
        progressStatus.value = 'exception'
        progressText.value = '生成失败: ' + res.data.errorMessage
        return true
      }
    }
    return false
  } catch (e) {
    if (e.message && e.message.includes('批次不存在')) {
      progressText.value = '正在准备生成任务...'
      return false
    }
    console.error('加载批次状态失败:', e)
    return false
  }
}

// 重置表单
const resetForm = () => {
  if (formRef.value) {
    formRef.value.resetFields()
  }
  generateForm.questionTypes = []
  generateForm.knowledgeKeywords = ''
  generateForm.lectureIds = []
  generateForm.countPerType = 5
  generateForm.difficulty = 'mixed'
}

// 批准题目
const handleApprove = async (question) => {
  try {
    const res = await aiQuestionApi.approveQuestion(question.tempId)
    if (res.code === 0) {
      question.status = 'approved'
      ElMessage.success('已批准')
      updateBatchStats()
    }
  } catch (e) {
    ElMessage.error('批准失败: ' + e.message)
  }
}

// 拒绝题目
const handleReject = async (question) => {
  try {
    const res = await aiQuestionApi.rejectQuestion(question.tempId)
    if (res.code === 0) {
      question.status = 'rejected'
      ElMessage.success('已拒绝')
      updateBatchStats()
    }
  } catch (e) {
    ElMessage.error('拒绝失败: ' + e.message)
  }
}

// 开始编辑
const startEdit = (question) => {
  editingQuestion.value = question.tempId
  editForm.question = question.modifiedQuestion || question.question
  editForm.answer = question.modifiedAnswer || question.answer
  editForm.analysis = question.modifiedAnalysis || question.analysis
}

// 取消编辑
const cancelEdit = () => {
  editingQuestion.value = null
  editForm.question = ''
  editForm.answer = ''
  editForm.analysis = ''
}

// 保存编辑
const saveEdit = async (question) => {
  try {
    const res = await aiQuestionApi.updateQuestion(question.tempId, {
      question: editForm.question,
      answer: editForm.answer,
      analysis: editForm.analysis
    })
    if (res.code === 0) {
      question.modifiedQuestion = editForm.question
      question.modifiedAnswer = editForm.answer
      question.modifiedAnalysis = editForm.analysis
      question.status = 'modified'
      editingQuestion.value = null
      ElMessage.success('保存成功')
      updateBatchStats()
    }
  } catch (e) {
    ElMessage.error('保存失败: ' + e.message)
  }
}

// 打开重新生成对话框
const handleRegenerate = (question) => {
  regenerateForm.tempId = question.tempId
  regenerateForm.requirements = ''
  showRegenerateDialog.value = true
}

// 确认重新生成
const confirmRegenerate = async () => {
  regenerating.value = true
  try {
    const res = await aiQuestionApi.regenerateQuestion(regenerateForm.tempId, regenerateForm.requirements)
    if (res.code === 0) {
      const index = currentBatch.value.questions.findIndex(q => q.tempId === regenerateForm.tempId)
      if (index !== -1) {
        currentBatch.value.questions[index] = { ...currentBatch.value.questions[index], ...res.data }
      }
      showRegenerateDialog.value = false
      ElMessage.success('重新生成成功')
    }
  } catch (e) {
    ElMessage.error('重新生成失败: ' + e.message)
  } finally {
    regenerating.value = false
  }
}

// 持久化单个题目
const handlePersist = async (question) => {
  try {
    await ElMessageBox.confirm('确定要将此题目入库吗？入库后将永久保存到题库。', '确认入库', {
      type: 'warning'
    })

    const res = await aiQuestionApi.persistQuestion(question.tempId)
    if (res.code === 0) {
      question.status = 'persisted'
      question.persisted = true
      question.questionId = res.data.id
      ElMessage.success('入库成功')
      updateBatchStats()
    }
  } catch (e) {
    if (e !== 'cancel') {
      ElMessage.error('入库失败: ' + e.message)
    }
  }
}

// 批量持久化
const handleBatchPersist = async () => {
  const approvedQuestions = currentBatch.value.questions.filter(q =>
    q.status === 'approved' || q.status === 'modified'
  )

  if (approvedQuestions.length === 0) {
    ElMessage.warning('没有已批准的题目可以入库')
    return
  }

  try {
    await ElMessageBox.confirm(
      `确定要将 ${approvedQuestions.length} 道题目入库吗？入库后将永久保存到题库。`,
      '批量入库',
      { type: 'warning' }
    )

    persisting.value = true
    const tempIds = approvedQuestions.map(q => q.tempId)
    const res = await aiQuestionApi.batchPersistQuestions(currentBatch.value.batchId, tempIds)

    if (res.code === 0) {
      const persistedCount = res.data.length

      approvedQuestions.forEach(q => {
        q.status = 'persisted'
        q.persisted = true
      })

      ElMessage.success(`成功入库 ${persistedCount} 道题目`)
      updateBatchStats()
    }
  } catch (e) {
    if (e !== 'cancel') {
      ElMessage.error('批量入库失败: ' + e.message)
    }
  } finally {
    persisting.value = false
  }
}

// 更新批次统计
const updateBatchStats = async () => {
  if (!currentBatch.value) return

  try {
    const res = await aiQuestionApi.getBatchStatistics(currentBatch.value.batchId)
    if (res.code === 0) {
      Object.assign(currentBatch.value, res.data)
    }
  } catch (e) {
    console.error('更新批次统计失败:', e)
  }
}

// 筛选题目
const filterQuestions = () => {
  // 由computed属性自动处理
}

// 获取题型标签类型
const getTypeTag = (type) => {
  const types = { 1: '', 2: 'success', 3: 'warning', 4: 'info', 5: 'danger', 6: '' }
  return types[type] || ''
}

// 获取难度标签类型
const getDifficultyTag = (difficulty) => {
  const tags = { easy: 'success', medium: 'warning', hard: 'danger' }
  return tags[difficulty] || 'info'
}

// 获取状态标签类型
const getStatusTag = (status) => {
  const tags = {
    pending: 'info',
    approved: 'success',
    rejected: 'danger',
    modified: 'warning',
    persisted: '',
    generating: 'warning',
    completed: 'success',
    failed: 'danger'
  }
  return tags[status] || 'info'
}

// 获取状态文本
const getStatusText = (status) => {
  const texts = {
    pending: '待审核',
    approved: '已批准',
    rejected: '已拒绝',
    modified: '已修改',
    persisted: '已入库',
    generating: '生成中',
    completed: '已完成',
    failed: '失败'
  }
  return texts[status] || status
}

// 获取题型名称
const getTypeName = (type) => {
  const names = { 1: '填空题', 2: '单选题', 3: '多选题', 4: '判断题', 5: '简答题', 6: '编程题' }
  return names[type] || '未知'
}

// 获取题型分布文本
const getTypeDistributionText = () => {
  if (!currentBatch.value?.typeDistribution) return '-'
  const dist = currentBatch.value.typeDistribution
  return Object.entries(dist).map(([type, count]) => `${getTypeName(parseInt(type))}:${count}`).join(', ')
}

// 获取剩余时间
const getRemainingTime = () => {
  if (!currentBatch.value?.expiresAt) return '-'
  const now = new Date()
  const expires = new Date(currentBatch.value.expiresAt)
  const diff = expires - now
  if (diff <= 0) return '已过期'
  const hours = Math.floor(diff / 3600000)
  const minutes = Math.floor((diff % 3600000) / 60000)
  return `${hours}小时${minutes}分钟`
}

// 格式化时间
const formatTime = (time) => {
  if (!time) return '-'
  const date = new Date(time)
  return date.toLocaleString('zh-CN')
}

// 格式化题目文本
const formatQuestionText = (text) => {
  if (!text) return ''
  return text.replace(/\n/g, '<br>')
}

// 获取题型名称列表
const getTypeNames = (types) => {
  if (!types || types.length === 0) return '-'
  return types.map(t => getTypeName(t)).join(', ')
}

// 获取难度文本
const getDifficultyText = (difficulty) => {
  const texts = { easy: '简单', medium: '中等', hard: '困难', mixed: '混合' }
  return texts[difficulty] || difficulty
}

// 获取题型标签类型（用于生成中显示）
const getTypeTagType = (type) => {
  const types = { 1: '', 2: 'success', 3: 'warning', 4: 'info', 5: 'danger', 6: '' }
  return types[type] || ''
}
</script>

<style scoped>
/* 基础变量 */
.ai-question-generator {
  --primary: #4f46e5;
  --primary-light: #818cf8;
  --primary-bg: #eef2ff;
  --success: #10b981;
  --success-bg: #ecfdf5;
  --warning: #f59e0b;
  --warning-bg: #fffbeb;
  --danger: #ef4444;
  --danger-bg: #fef2f2;
  --info: #6b7280;
  --info-bg: #f9fafb;

  --bg: #f8fafc;
  --surface: #ffffff;
  --border: #e2e8f0;
  --text: #1e293b;
  --text-secondary: #64748b;
  --text-muted: #94a3b8;

  --radius-sm: 6px;
  --radius: 10px;
  --radius-lg: 14px;
  --radius-xl: 20px;

  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
  --shadow: 0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.06);
  --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);

  min-height: 100vh;
  background: var(--bg);
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  color: var(--text);
}

/* 顶部导航 */
.top-nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 32px;
  background: var(--surface);
  border-bottom: 1px solid var(--border);
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.nav-brand {
  display: flex;
  align-items: center;
  gap: 10px;
  color: var(--primary);
}

.brand-text {
  font-size: 18px;
  font-weight: 600;
}

.nav-desc {
  font-size: 13px;
  color: var(--text-muted);
  padding-left: 16px;
  border-left: 1px solid var(--border);
}

.nav-right {
  display: flex;
  align-items: center;
  gap: 8px;
}

.nav-btn {
  color: var(--text-secondary) !important;
  font-size: 14px;
}

.nav-btn:hover {
  color: var(--primary) !important;
  background: var(--primary-bg) !important;
}

/* 主内容区 */
.main-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 32px;
}

/* 配置区域 */
.config-section {
  animation: fadeIn 0.5s ease;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

.config-container {
  background: var(--surface);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow);
  overflow: hidden;
}

.config-header {
  padding: 32px 40px 24px;
  border-bottom: 1px solid var(--border);
}

.config-header h2 {
  margin: 0 0 8px;
  font-size: 24px;
  font-weight: 700;
  color: var(--text);
}

.config-header p {
  margin: 0;
  font-size: 14px;
  color: var(--text-secondary);
}

.config-form {
  padding: 32px 40px 40px;
}

/* 表单区块 */
.form-section {
  margin-bottom: 32px;
}

.section-title {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 16px;
  font-size: 15px;
  font-weight: 600;
  color: var(--text);
}

.section-title .el-icon {
  color: var(--primary);
}

.optional-tag {
  font-size: 12px;
  font-weight: 400;
  color: var(--text-muted);
  background: var(--info-bg);
  padding: 2px 8px;
  border-radius: var(--radius-sm);
}

/* 题型选择网格 */
.type-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}

.type-card {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 16px 20px;
  background: var(--bg);
  border: 2px solid var(--border);
  border-radius: var(--radius);
  cursor: pointer;
  transition: all 0.2s ease;
  position: relative;
}

.type-card:hover {
  border-color: var(--primary-light);
  background: var(--primary-bg);
}

.type-card.active {
  border-color: var(--primary);
  background: var(--primary-bg);
}

.type-icon {
  width: 48px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--surface);
  border-radius: var(--radius);
  color: var(--text-secondary);
  box-shadow: var(--shadow-sm);
}

.type-card.active .type-icon {
  color: var(--primary);
  background: var(--primary-bg);
}

.type-info {
  flex: 1;
}

.type-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--text);
  margin-bottom: 2px;
}

.type-desc {
  font-size: 12px;
  color: var(--text-muted);
}

.type-check {
  position: absolute;
  top: 8px;
  right: 8px;
  width: 20px;
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--primary);
  color: white;
  border-radius: 50%;
  font-size: 12px;
}

/* 关键词输入 */
.keyword-input :deep(.el-textarea__inner) {
  border-radius: var(--radius);
  border-color: var(--border);
  font-size: 14px;
}

.keyword-input :deep(.el-textarea__inner:focus) {
  border-color: var(--primary);
  box-shadow: 0 0 0 3px var(--primary-bg);
}

.form-hint {
  display: flex;
  align-items: center;
  gap: 6px;
  margin-top: 8px;
  font-size: 13px;
  color: var(--text-muted);
}

.form-hint .el-icon {
  color: var(--text-muted);
}

/* 讲义选择 */
.lecture-select :deep(.el-input__wrapper) {
  border-radius: var(--radius);
}

/* 参数配置 */
.params-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
}

.param-item {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.param-item label {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-secondary);
}

.difficulty-selector {
  display: flex;
  gap: 8px;
}

.diff-option {
  flex: 1;
  padding: 10px 16px;
  text-align: center;
  font-size: 14px;
  font-weight: 500;
  background: var(--bg);
  border: 2px solid var(--border);
  border-radius: var(--radius);
  cursor: pointer;
  transition: all 0.2s ease;
  color: var(--text-secondary);
}

.diff-option:hover {
  border-color: var(--primary-light);
  color: var(--primary);
}

.diff-option.active {
  background: var(--primary);
  border-color: var(--primary);
  color: white;
}

/* 表单操作 */
.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  margin-top: 40px;
  padding-top: 24px;
  border-top: 1px solid var(--border);
}

.reset-btn {
  min-width: 100px;
}

.submit-btn {
  min-width: 160px;
  background: var(--primary) !important;
  border-color: var(--primary) !important;
}

.submit-btn:hover {
  background: var(--primary-light) !important;
  border-color: var(--primary-light) !important;
}

/* 生成中状态 */
.generating-section {
  animation: fadeIn 0.5s ease;
}

.generating-container {
  height: calc(100vh - 120px);
  display: flex;
  flex-direction: column;
}

.generating-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 24px;
  flex-shrink: 0;
}

.generating-header h2 {
  margin: 0;
  font-size: 22px;
  font-weight: 700;
  color: var(--text);
}

.generating-header .el-icon {
  color: var(--primary);
  font-size: 24px;
}

/* 双面板布局 - 填满整个空间 */
.generating-panels {
  display: grid;
  grid-template-columns: 400px 1fr;
  gap: 24px;
  flex: 1;
  min-height: 0;
}

/* 左侧进度面板 */
.progress-panel {
  display: flex;
  flex-direction: column;
}

.progress-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.progress-ring-wrapper {
  margin-bottom: 32px;
}

.circle-progress :deep(.el-progress-circle__track) {
  stroke: var(--primary-bg);
}

.progress-text {
  margin: 0 0 40px;
  font-size: 15px;
  color: var(--text-secondary);
  font-weight: 500;
}

.progress-stats {
  display: flex;
  align-items: center;
  gap: 40px;
  margin-bottom: 40px;
}

.stat-box {
  display: flex;
  flex-direction: column;
  align-items: center;
  min-width: 80px;
}

.stat-num {
  font-size: 32px;
  font-weight: 700;
  color: var(--text);
  line-height: 1.2;
}

.stat-label {
  font-size: 13px;
  color: var(--text-muted);
  margin-top: 8px;
}

.stat-divider {
  width: 1px;
  height: 48px;
  background: var(--border);
}

.progress-detail {
  width: 100%;
  max-width: 300px;
}

.detail-item {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  padding: 14px 0;
  font-size: 14px;
  color: var(--text-secondary);
}

.detail-item .el-icon {
  color: var(--primary);
}

/* 右侧预览面板 */
.preview-panel {
  display: flex;
  flex-direction: column;
  background: var(--surface);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow);
  overflow: hidden;
}

.preview-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 18px 24px;
  border-bottom: 1px solid var(--border);
  flex-shrink: 0;
}

.preview-title {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 15px;
  font-weight: 600;
  color: var(--text);
}

.preview-title .el-icon {
  color: var(--primary);
}

.preview-count {
  font-size: 13px;
  color: var(--text-muted);
  font-weight: 500;
}

.preview-list {
  flex: 1;
  overflow-y: auto;
  padding: 16px;
}

.preview-card {
  display: flex;
  gap: 14px;
  padding: 16px;
  background: var(--bg);
  border-radius: var(--radius);
  margin-bottom: 12px;
  animation: slideIn 0.3s ease;
  transition: all 0.2s ease;
}

.preview-card:hover {
  background: var(--primary-bg);
}

.preview-index {
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--primary);
  color: white;
  border-radius: 50%;
  font-size: 13px;
  font-weight: 600;
  flex-shrink: 0;
}

.preview-body {
  flex: 1;
  min-width: 0;
}

.preview-top {
  margin-bottom: 8px;
}

.preview-type {
  display: inline-block;
  padding: 3px 10px;
  background: var(--primary-bg);
  color: var(--primary);
  border-radius: var(--radius-sm);
  font-size: 12px;
  font-weight: 600;
}

.preview-content {
  font-size: 14px;
  color: var(--text);
  line-height: 1.6;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.preview-empty {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: var(--text-muted);
  padding: 60px 20px;
}

.preview-empty .el-icon {
  margin-bottom: 16px;
  opacity: 0.5;
}

.preview-empty p {
  margin: 0;
  font-size: 14px;
}

.preview-item-enter-active,
.preview-item-leave-active {
  transition: all 0.3s ease;
}

.preview-item-enter-from {
  opacity: 0;
  transform: translateY(-10px);
}

.preview-item-leave-to {
  opacity: 0;
  transform: translateX(20px);
}

.panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  border-bottom: 1px solid var(--border);
}

.panel-title {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 15px;
  font-weight: 600;
  color: var(--text);
}

.panel-title .el-icon {
  color: var(--primary);
}

.spin-icon {
  animation: spin 1.5s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.preview-count {
  font-size: 13px;
  color: var(--text-muted);
}

.progress-body {
  padding: 32px 20px;
  text-align: center;
}

.progress-ring {
  margin-bottom: 20px;
}

.circle-progress :deep(.el-progress-circle__track) {
  stroke: var(--primary-bg);
}

.progress-text {
  margin: 0 0 24px;
  font-size: 14px;
  color: var(--text-secondary);
}

.progress-stats {
  display: flex;
  justify-content: center;
  gap: 32px;
}

.stat-item {
  text-align: center;
}

.stat-num {
  display: block;
  font-size: 20px;
  font-weight: 700;
  color: var(--text);
  margin-bottom: 4px;
}

.stat-label {
  font-size: 12px;
  color: var(--text-muted);
}

/* 预览列表 */
.preview-list {
  max-height: 500px;
  overflow-y: auto;
  padding: 16px;
}

.preview-card {
  padding: 14px 16px;
  background: var(--bg);
  border-radius: var(--radius);
  margin-bottom: 10px;
  border-left: 3px solid var(--primary);
  animation: slideIn 0.3s ease;
}

@keyframes slideIn {
  from { opacity: 0; transform: translateX(-10px); }
  to { opacity: 1; transform: translateX(0); }
}

.preview-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.preview-type {
  font-size: 12px;
  font-weight: 600;
  color: var(--primary);
  background: var(--primary-bg);
  padding: 2px 8px;
  border-radius: var(--radius-sm);
}

.preview-index {
  font-size: 12px;
  color: var(--text-muted);
}

.preview-content {
  font-size: 13px;
  color: var(--text);
  line-height: 1.6;
}

.preview-item-enter-active,
.preview-item-leave-active {
  transition: all 0.3s ease;
}

.preview-item-enter-from {
  opacity: 0;
  transform: translateX(-20px);
}

.preview-item-leave-to {
  opacity: 0;
  transform: translateX(20px);
}

/* 错误状态 */
.error-section {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 400px;
  animation: fadeIn 0.5s ease;
}

.error-container {
  text-align: center;
  padding: 48px;
  background: var(--surface);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow);
  max-width: 480px;
}

.error-icon {
  color: var(--danger);
  margin-bottom: 20px;
}

.error-container h2 {
  margin: 0 0 12px;
  font-size: 24px;
  font-weight: 700;
  color: var(--text);
}

.error-message {
  margin: 0 0 32px;
  font-size: 14px;
  color: var(--text-secondary);
}

/* 结果区域 */
.result-section {
  animation: fadeIn 0.5s ease;
}

.result-toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.toolbar-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.toolbar-left h2 {
  margin: 0;
  font-size: 22px;
  font-weight: 700;
}

.toolbar-right {
  display: flex;
  gap: 12px;
}

/* 统计卡片 */
.stats-row {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 16px;
  margin-bottom: 24px;
}

.stat-card {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 18px 16px;
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow-sm);
  transition: all 0.2s ease;
}

.stat-card:hover {
  box-shadow: var(--shadow-md);
  transform: translateY(-2px);
}

.stat-icon-wrap {
  width: 44px;
  height: 44px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: var(--radius);
  font-size: 20px;
}

.stat-icon-wrap.total { background: var(--primary-bg); color: var(--primary); }
.stat-icon-wrap.approved { background: var(--success-bg); color: var(--success); }
.stat-icon-wrap.rejected { background: var(--danger-bg); color: var(--danger); }
.stat-icon-wrap.persisted { background: #eff6ff; color: #3b82f6; }
.stat-icon-wrap.types { background: var(--warning-bg); color: var(--warning); }
.stat-icon-wrap.time { background: var(--info-bg); color: var(--info); }

.stat-content {
  flex: 1;
  min-width: 0;
}

.stat-value {
  font-size: 22px;
  font-weight: 700;
  color: var(--text);
  line-height: 1.2;
}

.stat-value.text-sm {
  font-size: 13px;
  font-weight: 600;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.stat-label {
  font-size: 12px;
  color: var(--text-muted);
  margin-top: 2px;
}

/* 筛选栏 */
.filter-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding: 12px 16px;
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow-sm);
}

.filter-tabs {
  display: flex;
  gap: 4px;
}

.filter-tab {
  padding: 6px 14px;
  font-size: 13px;
  font-weight: 500;
  color: var(--text-secondary);
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition: all 0.2s ease;
}

.filter-tab:hover {
  background: var(--bg);
  color: var(--text);
}

.filter-tab.active {
  background: var(--primary);
  color: white;
}

.type-select {
  width: 120px;
}

/* 题目列表 */
.questions-grid {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.question-item {
  background: var(--surface);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  overflow: hidden;
  transition: all 0.2s ease;
  border: 2px solid transparent;
}

.question-item:hover {
  box-shadow: var(--shadow-md);
}

.question-item.approved {
  border-color: var(--success);
}

.question-item.rejected {
  border-color: var(--danger);
}

.item-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 14px 20px;
  background: var(--bg);
  border-bottom: 1px solid var(--border);
}

.item-tags {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.tag {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 4px 10px;
  font-size: 12px;
  font-weight: 600;
  border-radius: var(--radius-sm);
}

.type-tag { background: var(--primary-bg); color: var(--primary); }
.diff-tag.diff-easy { background: var(--success-bg); color: var(--success); }
.diff-tag.diff-medium { background: var(--warning-bg); color: var(--warning); }
.diff-tag.diff-hard { background: var(--danger-bg); color: var(--danger); }
.diff-tag.diff-mixed { background: var(--info-bg); color: var(--info); }
.status-tag.status-pending { background: var(--info-bg); color: var(--info); }
.status-tag.status-approved { background: var(--success-bg); color: var(--success); }
.status-tag.status-rejected { background: var(--danger-bg); color: var(--danger); }
.status-tag.status-modified { background: var(--warning-bg); color: var(--warning); }
.status-tag.status-persisted { background: #eff6ff; color: #3b82f6; }
.warn-tag { background: var(--warning-bg); color: var(--warning); }

.item-score {
  font-size: 18px;
  font-weight: 700;
  color: var(--primary);
}

.item-body {
  padding: 20px;
}

.content-section {
  margin-bottom: 16px;
}

.content-label {
  font-size: 12px;
  font-weight: 600;
  color: var(--text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 8px;
}

.content-text {
  font-size: 14px;
  line-height: 1.7;
  color: var(--text);
  padding: 12px 16px;
  background: var(--bg);
  border-radius: var(--radius);
}

.answer-text {
  background: var(--success-bg);
  border-left: 3px solid var(--success);
}

.analysis-text {
  background: #eff6ff;
  border-left: 3px solid #3b82f6;
}

.edit-section {
  margin-bottom: 16px;
}

.item-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
  padding-top: 16px;
  border-top: 1px solid var(--border);
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 13px;
  color: var(--text-secondary);
}

.meta-item .el-icon {
  color: var(--text-muted);
}

.meta-item.warn {
  color: var(--warning);
}

.meta-item.warn .el-icon {
  color: var(--warning);
}

.item-actions {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px 20px;
  background: var(--bg);
  border-top: 1px solid var(--border);
  flex-wrap: wrap;
}

/* 历史对话框 */
.history-list {
  max-height: 500px;
  overflow-y: auto;
}

.history-item {
  padding: 16px;
  border: 1px solid var(--border);
  border-radius: var(--radius);
  margin-bottom: 12px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.history-item:hover {
  border-color: var(--primary);
  background: var(--primary-bg);
}

.history-item.active {
  border-color: var(--primary);
  background: var(--primary-bg);
}

.history-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.history-time {
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 600;
  font-size: 14px;
  color: var(--text);
}

.history-time .el-icon {
  color: var(--primary);
}

.history-status {
  font-size: 12px;
  font-weight: 600;
  padding: 4px 10px;
  border-radius: var(--radius-sm);
}

.history-status.completed { background: var(--success-bg); color: var(--success); }
.history-status.generating { background: var(--warning-bg); color: var(--warning); }
.history-status.failed { background: var(--danger-bg); color: var(--danger); }

.history-detail {
  display: flex;
  gap: 16px;
  font-size: 13px;
  color: var(--text-secondary);
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .stats-row {
    grid-template-columns: repeat(3, 1fr);
  }

  .generating-panels {
    grid-template-columns: 1fr;
  }

  .progress-panel,
  .preview-panel {
    width: 100%;
  }

  .generating-container {
    height: auto;
  }

  .progress-panel {
    min-height: 400px;
  }

  .preview-panel {
    min-height: 400px;
  }
}

@media (max-width: 768px) {
  .top-nav {
    flex-direction: column;
    gap: 12px;
    padding: 12px 16px;
  }

  .nav-left {
    flex-direction: column;
    gap: 8px;
  }

  .nav-desc {
    border-left: none;
    padding-left: 0;
  }

  .main-content {
    padding: 16px;
  }

  .config-header {
    padding: 24px 20px 20px;
  }

  .config-form {
    padding: 24px 20px;
  }

  .type-grid {
    grid-template-columns: 1fr;
  }

  .params-grid {
    grid-template-columns: 1fr;
  }

  .stats-row {
    grid-template-columns: repeat(2, 1fr);
  }

  .filter-row {
    flex-direction: column;
    gap: 12px;
  }

  .filter-tabs {
    flex-wrap: wrap;
  }

  .result-toolbar {
    flex-direction: column;
    gap: 16px;
    align-items: flex-start;
  }

  .item-actions {
    flex-direction: column;
    align-items: stretch;
  }
}

@media (max-width: 480px) {
  .stats-row {
    grid-template-columns: 1fr;
  }

  .difficulty-selector {
    flex-direction: column;
  }
}

/* 尊重用户动画偏好 */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
</style>

<style>
.lecture-select-popper .loading-option {
  text-align: center;
  cursor: default !important;
}

.lecture-select-popper .loading-more-tip {
  padding: 8px 0;
  font-size: 13px;
  color: #909399;
}
</style>
