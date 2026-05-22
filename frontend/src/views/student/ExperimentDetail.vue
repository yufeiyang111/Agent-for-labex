<template>
  <div class="experiment-detail-page">
    <!-- 顶部进度条 -->
    <div class="progress-header">
      <div class="experiment-title">
        <el-button text @click="$router.back()">
          <el-icon><ArrowLeft /></el-icon>
          返回
        </el-button>
        <h2>{{ experimentName || '加载中...' }}</h2>
      </div>
      <div class="progress-info">
        <span class="progress-text">已完成 {{ completedCount }} / {{ totalCount }} 题</span>
        <el-progress
          :percentage="progressPercentage"
          :stroke-width="8"
          :show-text="false"
          color="#4caf50"
        />
      </div>
    </div>

    <!-- 主内容区 -->
    <div class="main-container">
      <!-- 左侧题目导航 -->
      <aside class="question-nav" :class="{ collapsed: navCollapsed }">
        <div class="nav-header">
          <span v-if="!navCollapsed">题目列表</span>
          <el-button
            :icon="navCollapsed ? ArrowRight : ArrowLeft"
            @click="navCollapsed = !navCollapsed"
            text
            circle
          />
        </div>

        <div v-if="!navCollapsed" class="question-list">
          <div
            v-for="(item, index) in questionItems"
            :key="item.experimentItemId"
            class="question-item"
            :class="{
              active: currentIndex === index,
              answered: answers[item.experimentItemId]
            }"
            @click="goToQuestion(index)"
          >
            <span class="question-no">{{ index + 1 }}</span>
            <span class="question-name">{{ item.experimentItemName }}</span>
            <el-icon v-if="answers[item.experimentItemId]" class="answered-icon"><Check /></el-icon>
            <el-icon v-else class="unanswered-icon"><Minus /></el-icon>
          </div>
        </div>

        <div v-else class="collapsed-nav">
          <div
            v-for="(item, index) in questionItems"
            :key="item.experimentItemId"
            class="collapsed-item"
            :class="{
              active: currentIndex === index,
              answered: answers[item.experimentItemId]
            }"
            @click="goToQuestion(index); navCollapsed = false"
            :title="item.experimentItemName"
          >
            {{ index + 1 }}
          </div>
        </div>
      </aside>

      <!-- 右侧题目内容 -->
      <main class="question-content">
        <el-card v-if="currentQuestion" shadow="never" class="question-card">
          <!-- 题目头部 -->
          <div class="question-header">
            <div class="question-meta">
              <el-tag type="info" size="small">第 {{ currentIndex + 1 }} 题</el-tag>
              <el-tag :type="getQuestionTypeTag(currentQuestion.experimentItemType)" size="small">
                {{ getQuestionTypeName(currentQuestion.experimentItemType) }}
              </el-tag>
              <el-tag type="warning" size="small">{{ currentQuestion.experimentItemScore }}分</el-tag>
            </div>
            <div class="answer-status">
              <el-tag v-if="answers[currentQuestion.experimentItemId]" type="success" size="small">
                已作答
              </el-tag>
              <el-tag v-else type="warning" size="small">未作答</el-tag>
            </div>
          </div>

          <!-- 题目内容 -->
          <div class="question-body">
            <h3 class="question-title">{{ currentQuestion.experimentItemName }}</h3>
            <div class="question-description">{{ currentQuestion.experimentItemContent }}</div>
          </div>

          <!-- 答题区域 -->
          <div class="answer-section">
            <div class="section-label">你的答案</div>

            <!-- 根据题型显示不同输入组件 -->
            <template v-if="currentQuestion.experimentItemType === 1">
              <!-- 选择题 -->
              <el-radio-group v-model="currentAnswer" @change="handleAnswerChange">
                <el-radio
                  v-for="(option, idx) in parseOptions(currentQuestion.experimentItemAnswer)"
                  :key="idx"
                  :value="String.fromCharCode(65 + idx)"
                >
                  {{ option }}
                </el-radio>
              </el-radio-group>
            </template>
            <template v-else-if="currentQuestion.experimentItemType === 2">
              <!-- 判断题 -->
              <el-radio-group v-model="currentAnswer" @change="handleAnswerChange">
                <el-radio value="A">正确</el-radio>
                <el-radio value="B">错误</el-radio>
              </el-radio-group>
            </template>
            <template v-else-if="currentQuestion.experimentItemType === 3">
              <!-- 填空题/简答题/编程题/综合题 -->
              <el-input
                v-model="currentAnswer"
                type="textarea"
                :rows="6"
                :placeholder="getPlaceholder(currentQuestion.experimentItemType)"
                @input="handleAnswerChange"
                class="answer-input"
              />
            </template>
            <template v-else>
              <el-input
                v-model="currentAnswer"
                type="textarea"
                :rows="6"
                placeholder="请输入答案..."
                @input="handleAnswerChange"
                class="answer-input"
              />
            </template>

            <div class="save-hint">
              <el-icon v-if="saveStatus === 'saving'"><Loading /></el-icon>
              <el-icon v-else-if="saveStatus === 'saved'"><Check /></el-icon>
              <span>{{ saveHintText }}</span>
            </div>
          </div>

          <!-- 底部操作按钮 -->
          <div class="question-footer">
            <div class="footer-left">
              <el-button @click="prevQuestion" :disabled="currentIndex === 0">
                <el-icon><ArrowLeft /></el-icon>
                上一题
              </el-button>
              <el-button @click="nextQuestion" :disabled="currentIndex === totalCount - 1">
                下一题
                <el-icon><ArrowRight /></el-icon>
              </el-button>
            </div>
            <div class="footer-right">
              <el-button @click="handleSaveAnswer" :loading="saveStatus === 'saving'">
                保存答案
              </el-button>
              <el-button type="success" @click="handleSubmitExperiment" :loading="submitting">
                提交实验
              </el-button>
            </div>
          </div>
        </el-card>

        <!-- 加载状态 -->
        <div v-else-if="loading" class="loading-state">
          <el-skeleton :rows="8" animated />
        </div>

        <!-- 空状态 -->
        <el-empty v-else-if="questionItems.length === 0" description="暂无题目" />
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import {
  ArrowLeft,
  ArrowRight,
  Check,
  Minus,
  Loading
} from '@element-plus/icons-vue'
import { studentApi, teacherApi } from '@/api'

const route = useRoute()
const router = useRouter()

const experimentId = computed(() => route.params.experimentId)

// 状态
const loading = ref(false)
const submitting = ref(false)
const experimentName = ref('')
const questionItems = ref([])
const answers = ref({})
const currentIndex = ref(0)
const navCollapsed = ref(false)
const saveStatus = ref('idle')
const currentAnswer = ref('')

// 防抖定时器
let saveDebounceTimer = null

// 计算属性
const totalCount = computed(() => questionItems.value.length)
const completedCount = computed(() => Object.keys(answers.value).filter(id => answers.value[id]).length)
const progressPercentage = computed(() => {
  if (totalCount.value === 0) return 0
  return Math.round((completedCount.value / totalCount.value) * 100)
})
const currentQuestion = computed(() => questionItems.value[currentIndex.value])

const saveHintText = computed(() => {
  if (saveStatus.value === 'saving') return '保存中...'
  if (saveStatus.value === 'saved') return '已保存'
  return ''
})

// 题目类型标签
const getQuestionTypeTag = (type) => {
  const types = { 1: 'success', 2: 'warning', 3: 'primary', 4: 'danger', 5: 'info' }
  return types[type] || 'info'
}

// 题目类型名称
const getQuestionTypeName = (type) => {
  const types = { 1: '选择题', 2: '判断题', 3: '填空题', 4: '简答题', 5: '编程题' }
  return types[type] || '其他'
}

// 占位符文本
const getPlaceholder = (type) => {
  const placeholders = {
    3: '请输入填空答案...',
    4: '请输入简答题答案...',
    5: '请输入编程题答案...'
  }
  return placeholders[type] || '请输入答案...'
}

// 解析选项（选择题答案格式为 A,正确答案）
const parseOptions = (answerStr) => {
  if (!answerStr) return []
  // 假设答案是 "A,B,C" 格式，每项是一个选项
  return answerStr.split(',').filter(s => s.trim())
}

// 监听当前题目变化，更新答案
watch(currentQuestion, (newQuestion) => {
  if (newQuestion) {
    const savedAnswer = answers.value[newQuestion.experimentItemId]
    currentAnswer.value = savedAnswer || ''
  }
})

// 获取实验详情和题目
const fetchExperimentData = async () => {
  loading.value = true
  try {
    // 获取实验信息
    const expRes = await teacherApi.experiment.get(experimentId.value)
    if (expRes.data) {
      experimentName.value = expRes.data.experimentName
    }

    // 获取题目列表
    const itemsRes = await teacherApi.experimentItem.listByExperiment(experimentId.value)
    questionItems.value = itemsRes.data || []

    // 获取已保存的答题记录
    const progressRes = await studentApi.getProgress(experimentId.value)
    if (progressRes.data && Array.isArray(progressRes.data)) {
      // 将答题记录转换为 {itemId: content} 格式
      progressRes.data.forEach(item => {
        if (item.itemId && item.content) {
          answers.value[item.itemId] = item.content
        }
      })
    }

    // 加载本地缓存
    loadLocalCache()

    // 如果有题目，加载第一题的答案
    if (questionItems.value.length > 0) {
      const firstQuestion = questionItems.value[0]
      currentAnswer.value = answers.value[firstQuestion.experimentItemId] || ''
    }
  } catch (error) {
    ElMessage.error('获取实验数据失败')
    console.error(error)
  } finally {
    loading.value = false
  }
}

// 本地缓存key
const getLocalCacheKey = () => `experiment_${experimentId.value}_answers`
const getLocalCacheTimeKey = () => `experiment_${experimentId.value}_cache_time`

// 保存到本地
const saveToLocal = () => {
  try {
    localStorage.setItem(getLocalCacheKey(), JSON.stringify(answers.value))
    localStorage.setItem(getLocalCacheTimeKey(), new Date().toISOString())
  } catch (e) {
    console.error('保存到本地失败', e)
  }
}

// 加载本地缓存
const loadLocalCache = () => {
  try {
    const cached = localStorage.getItem(getLocalCacheKey())
    if (cached) {
      const cachedAnswers = JSON.parse(cached)
      // 合并本地缓存和服务器数据，本地优先
      answers.value = { ...answers.value, ...cachedAnswers }
    }
  } catch (e) {
    console.error('加载本地缓存失败', e)
  }
}

// 清除本地缓存
const clearLocalCache = () => {
  try {
    localStorage.removeItem(getLocalCacheKey())
    localStorage.removeItem(getLocalCacheTimeKey())
  } catch (e) {
    console.error('清除本地缓存失败', e)
  }
}

// 答案变化处理（防抖自动保存）
const handleAnswerChange = () => {
  saveStatus.value = 'idle'

  if (saveDebounceTimer) {
    clearTimeout(saveDebounceTimer)
  }

  saveDebounceTimer = setTimeout(() => {
    handleAutoSave()
  }, 1000)
}

// 自动保存
const handleAutoSave = async () => {
  if (!currentQuestion.value) return

  const answer = currentAnswer.value
  if (!answer) return

  saveStatus.value = 'saving'
  answers.value[currentQuestion.value.experimentItemId] = answer

  // 保存到本地
  saveToLocal()

  try {
    await studentApi.saveAnswer(
      experimentId.value,
      currentQuestion.value.experimentItemId,
      answer
    )
    saveStatus.value = 'saved'
    setTimeout(() => {
      saveStatus.value = 'idle'
    }, 2000)
  } catch (error) {
    console.error('保存答案失败', error)
  }
}

// 保存当前答案
const handleSaveAnswer = async () => {
  if (!currentQuestion.value) return

  saveStatus.value = 'saving'
  answers.value[currentQuestion.value.experimentItemId] = currentAnswer.value

  // 保存到本地
  saveToLocal()

  try {
    await studentApi.saveAnswer(
      experimentId.value,
      currentQuestion.value.experimentItemId,
      currentAnswer.value
    )
    saveStatus.value = 'saved'
    ElMessage.success('保存成功')
    setTimeout(() => {
      saveStatus.value = 'idle'
    }, 2000)
  } catch (error) {
    ElMessage.error('保存失败')
    console.error(error)
  }
}

// 跳转到指定题目
const goToQuestion = (index) => {
  // 先保存当前答案
  if (currentAnswer.value && currentQuestion.value) {
    answers.value[currentQuestion.value.experimentItemId] = currentAnswer.value
    saveToLocal()
  }
  currentIndex.value = index
}

// 上一题
const prevQuestion = () => {
  if (currentIndex.value > 0) {
    goToQuestion(currentIndex.value - 1)
  }
}

// 下一题
const nextQuestion = () => {
  if (currentIndex.value < totalCount.value - 1) {
    goToQuestion(currentIndex.value + 1)
  }
}

// 提交实验
const handleSubmitExperiment = async () => {
  try {
    await ElMessageBox.confirm(
      `确定要提交实验吗？提交后将无法修改答案。\n\n已完成 ${completedCount.value} / ${totalCount.value} 题`,
      '提交确认',
      {
        confirmButtonText: '确定提交',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )

    submitting.value = true

    try {
      // 先保存所有答案
      for (const item of questionItems.value) {
        const answer = answers.value[item.experimentItemId]
        if (answer) {
          await studentApi.saveAnswer(experimentId.value, item.experimentItemId, answer)
        }
      }

      // 提交实验
      const submitData = questionItems.value.map(item => ({
        itemId: item.experimentItemId,
        content: answers.value[item.experimentItemId] || ''
      }))
      await studentApi.submitAnswer(experimentId.value, submitData)

      // 清除本地缓存
      clearLocalCache()

      ElMessage.success('提交成功')
      router.push('/student/experiment')
    } catch (error) {
      if (error !== 'cancel') {
        ElMessage.error('提交失败，请重试')
        console.error(error)
      }
    }
  } catch {
    // 用户取消
  } finally {
    submitting.value = false
  }
}

onMounted(() => {
  fetchExperimentData()
})
</script>

<style lang="scss" scoped>
.experiment-detail-page {
  height: calc(100vh - 100px);
  display: flex;
  flex-direction: column;
  padding: 20px;
  overflow: hidden;
}

.progress-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding: 16px 24px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(76, 175, 80, 0.08);

  .experiment-title {
    display: flex;
    align-items: center;
    gap: 16px;

    h2 {
      margin: 0;
      font-size: 20px;
      color: #2c3e50;
    }
  }

  .progress-info {
    display: flex;
    align-items: center;
    gap: 16px;
    min-width: 200px;

    .progress-text {
      font-size: 14px;
      color: #606266;
      white-space: nowrap;
    }

    .el-progress {
      flex: 1;
    }
  }
}

.main-container {
  flex: 1;
  display: flex;
  gap: 20px;
  overflow: hidden;
}

.question-nav {
  width: 260px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(76, 175, 80, 0.08);
  display: flex;
  flex-direction: column;
  transition: width 0.3s ease;
  overflow: hidden;

  &.collapsed {
    width: 56px;
  }

  .nav-header {
    padding: 16px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #f0f0f0;
    font-size: 14px;
    font-weight: 600;
    color: #2c3e50;
  }

  .question-list {
    flex: 1;
    overflow-y: auto;
    padding: 8px;

    .question-item {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 10px 12px;
      margin-bottom: 4px;
      border-radius: 8px;
      cursor: pointer;
      transition: all 0.2s ease;
      font-size: 13px;

      &:hover {
        background: #e8f5e9;
      }

      &.active {
        background: #4caf50;
        color: #fff;

        .answered-icon, .unanswered-icon {
          color: #fff;
        }
      }

      &.answered {
        .answered-icon {
          color: #4caf50;
        }
      }

      .question-no {
        width: 24px;
        height: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #f5f5f5;
        border-radius: 50%;
        font-size: 12px;
        font-weight: 600;
      }

      &.active .question-no {
        background: rgba(255, 255, 255, 0.2);
      }

      .question-name {
        flex: 1;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }

      .answered-icon {
        color: #4caf50;
      }

      .unanswered-icon {
        color: #c0c4cc;
      }
    }
  }

  .collapsed-nav {
    flex: 1;
    overflow-y: auto;
    padding: 8px;
    display: flex;
    flex-direction: column;
    gap: 4px;

    .collapsed-item {
      width: 32px;
      height: 32px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
      cursor: pointer;
      font-size: 12px;
      font-weight: 600;
      background: #f5f5f5;
      color: #606266;
      transition: all 0.2s ease;

      &:hover {
        background: #e8f5e9;
      }

      &.active {
        background: #4caf50;
        color: #fff;
      }

      &.answered {
        background: #e8f5e9;
        color: #4caf50;
      }
    }
  }
}

.question-content {
  flex: 1;
  overflow-y: auto;
}

.question-card {
  border-radius: 12px;
  border: none;
  box-shadow: 0 2px 12px rgba(76, 175, 80, 0.08);

  .question-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 16px;
    border-bottom: 1px solid #f0f0f0;
    margin-bottom: 20px;

    .question-meta {
      display: flex;
      gap: 8px;
    }
  }

  .question-body {
    margin-bottom: 24px;

    .question-title {
      font-size: 18px;
      color: #2c3e50;
      margin: 0 0 16px 0;
      font-weight: 600;
      line-height: 1.6;
    }

    .question-description {
      font-size: 15px;
      color: #606266;
      line-height: 1.8;
      white-space: pre-wrap;
    }
  }

  .answer-section {
    margin-top: 24px;
    padding: 20px;
    background: #f9fafb;
    border-radius: 8px;

    .section-label {
      font-size: 14px;
      font-weight: 600;
      color: #2c3e50;
      margin-bottom: 12px;
    }

    .answer-input {
      :deep(.el-textarea__inner) {
        border-radius: 8px;
        border-color: #dcdfe6;
        transition: all 0.3s ease;

        &:focus {
          border-color: #4caf50;
          box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.1);
        }
      }
    }

    .el-radio-group {
      display: flex;
      flex-direction: column;
      gap: 12px;

      :deep(.el-radio) {
        padding: 12px 16px;
        background: #fff;
        border-radius: 8px;
        border: 1px solid #dcdfe6;
        transition: all 0.2s ease;

        &:hover {
          border-color: #4caf50;
        }
      }
    }

    .save-hint {
      display: flex;
      align-items: center;
      gap: 6px;
      margin-top: 12px;
      font-size: 12px;
      color: #909399;
      height: 20px;

      .el-icon {
        animation: spin 1s linear infinite;
      }
    }
  }

  .question-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 24px;
    padding-top: 20px;
    border-top: 1px solid #f0f0f0;

    .footer-left, .footer-right {
      display: flex;
      gap: 12px;
    }
  }
}

.loading-state {
  padding: 40px;
  background: #fff;
  border-radius: 12px;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
</style>
