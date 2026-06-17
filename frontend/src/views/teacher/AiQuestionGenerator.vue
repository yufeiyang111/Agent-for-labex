<template>
  <div class="ai-question-generator wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-hero wabi-card">
        <div class="wabi-card-content">
          <div class="hero-content">
            <div class="hero-title-wrapper">
              <el-icon :size="24" class="hero-icon"><MagicStick /></el-icon>
              <h2 class="hero-title">AI 题目生成器</h2>
            </div>
            <p class="hero-desc">智能生成 · 多题型支持 · 相似度查重</p>
          </div>
          <div class="hero-actions">
            <el-button @click="loadBatches" class="wabi-btn-ghost">
              生成历史
            </el-button>
            <el-button @click="startNewGeneration" v-if="currentBatch" class="wabi-btn-ghost">
              新建生成
            </el-button>
          </div>
        </div>
      </div>

      <!-- 配置区域 -->
      <div v-if="!currentBatch" class="config-section wabi-card">
        <div class="wabi-card-header">
          <span class="wabi-card-title">配置生成参数</span>
        </div>
        <div class="wabi-card-content">
          <el-form :model="generateForm" :rules="formRules" ref="formRef" class="wabi-form" label-position="top">
            <!-- 题型选择 -->
            <div class="form-section">
              <div class="section-label">题目类型 <span class="required">*</span></div>
              <div class="type-grid">
                <div
                  v-for="type in questionTypes"
                  :key="type.value"
                  class="type-card"
                  :class="{ active: generateForm.questionTypes.includes(type.value) }"
                  @click="toggleQuestionType(type.value)"
                >
                  <div class="type-icon">{{ type.icon }}</div>
                  <div class="type-name">{{ type.label }}</div>
                  <div class="type-desc">{{ type.desc }}</div>
                </div>
              </div>
            </div>

            <!-- 生成参数 -->
            <div class="form-section">
              <div class="section-label">生成参数</div>
              <el-row :gutter="16">
                <el-col :span="8">
                  <el-form-item label="每种题型数量">
                    <el-input-number v-model="generateForm.countPerType" :min="1" :max="20" style="width: 100%" />
                  </el-form-item>
                </el-col>
                <el-col :span="8">
                  <el-form-item label="难度">
                    <el-select v-model="generateForm.difficulty" style="width: 100%">
                      <el-option label="简单" value="easy" />
                      <el-option label="中等" value="medium" />
                      <el-option label="困难" value="hard" />
                      <el-option label="混合" value="mixed" />
                    </el-select>
                  </el-form-item>
                </el-col>
                <el-col :span="8">
                  <el-form-item label="指定讲义（可选）">
                    <el-select
                      v-model="generateForm.lectureIds"
                      multiple
                      placeholder="选择讲义"
                      clearable
                      style="width: 100%"
                      collapse-tags
                    >
                      <el-option
                        v-for="l in lectures"
                        :key="l.lectureId || l.id"
                        :label="l.lectureName || l.name"
                        :value="l.lectureId || l.id"
                      />
                    </el-select>
                  </el-form-item>
                </el-col>
              </el-row>
            </div>

            <!-- 知识点选择 -->
            <div class="form-section">
              <div class="section-label">知识点关键词（可选）</div>
              <el-input
                v-model="generateForm.knowledgeKeywords"
                type="textarea"
                :rows="3"
                placeholder="输入相关知识点关键词，用逗号分隔，用于从知识库检索相关内容..."
              />
            </div>

            <!-- 生成按钮 -->
            <div class="form-actions">
              <el-button
                type="primary"
                @click="handleGenerate"
                :loading="generating"
                :disabled="!generateForm.questionTypes.length"
                class="wabi-btn-primary generate-btn"
              >
                <el-icon><MagicStick /></el-icon>
                开始生成
              </el-button>
              <span class="generate-hint">
                已选择 {{ generateForm.questionTypes.length }} 种题型，每种 {{ generateForm.countPerType }} 题
              </span>
            </div>
          </el-form>
        </div>
      </div>

      <!-- 生成结果 -->
      <div v-if="currentBatch" class="result-section wabi-card">
        <div class="wabi-card-header">
          <span class="wabi-card-title">生成结果</span>
          <div class="result-actions">
            <span class="wabi-tag wabi-tag-accent">
              {{ currentBatch.questions?.length || 0 }} 道题目
            </span>
            <el-button
              type="primary"
              size="small"
              @click="handlePersistAll"
              :loading="persisting"
              :disabled="!currentBatch.questions?.length"
              class="wabi-btn-primary"
            >
              批量入库
            </el-button>
            <el-button @click="startNewGeneration" class="wabi-btn-ghost" size="small">
              新建生成
            </el-button>
          </div>
        </div>
        <div class="wabi-card-content">
          <div v-if="generating" class="generating-status">
            <el-icon class="is-loading" :size="32"><Loading /></el-icon>
            <p>正在生成题目，请稍候...</p>
            <p class="generating-hint">AI 正在分析知识库并生成题目，这可能需要一些时间</p>
          </div>
          <div v-else-if="!currentBatch.questions?.length" class="wabi-empty">
            <p class="wabi-empty-text">暂无生成结果</p>
          </div>
          <div v-else class="question-result-list">
            <div v-for="(q, index) in currentBatch.questions" :key="q.tempId || index" class="result-item">
              <div class="result-header">
                <div class="result-info">
                  <span class="result-index">#{{ index + 1 }}</span>
                  <span class="wabi-tag" :class="getTypeClass(q.type)">{{ getTypeName(q.type) }}</span>
                </div>
                <div class="result-actions">
                  <el-button size="small" text @click="handleEditQuestion(q)" class="wabi-btn-text">
                    编辑
                  </el-button>
                  <el-button size="small" text @click="handlePersistQuestion(q)" class="wabi-btn-text">
                    入库
                  </el-button>
                  <el-button size="small" text @click="handleRegenerate(q)" :loading="q._regenerating" class="wabi-btn-text">
                    重新生成
                  </el-button>
                </div>
              </div>
              <div class="result-content">{{ q.question }}</div>
              <div v-if="parseOptions(q.options).length" class="result-options">
                <div v-for="(opt, i) in parseOptions(q.options)" :key="i" class="option-item">
                  <span class="option-label">{{ String.fromCharCode(65 + i) }}.</span>
                  <span class="option-text">{{ opt }}</span>
                </div>
              </div>
              <div v-if="q.answer" class="result-answer">
                <span class="answer-label">参考答案：</span>
                {{ q.answer }}
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 生成历史 -->
      <el-dialog v-model="showHistory" title="生成历史" width="800" class="wabi-dialog">
        <div v-loading="loadingHistory">
          <div v-if="!batches.length" class="wabi-empty">
            <p class="wabi-empty-text">暂无生成历史</p>
          </div>
          <div v-else class="batch-list">
            <div v-for="batch in batches" :key="batch.batchId" class="batch-item">
              <div class="batch-info">
                <div class="batch-header">
                  <span class="batch-id">{{ batch.batchId?.substring(0, 8) }}...</span>
                  <span class="wabi-tag" :class="batch.status === 'completed' ? 'wabi-tag-accent' : ''">
                    {{ batch.status === 'completed' ? '已完成' : '生成中' }}
                  </span>
                </div>
                <div class="batch-meta">
                  <span>{{ batch.questions?.length || 0 }} 道题目</span>
                  <span>{{ formatDate(batch.createTime) }}</span>
                </div>
              </div>
              <div class="batch-actions">
                <el-button size="small" text @click="viewBatch(batch)" class="wabi-btn-text">查看</el-button>
                <el-button size="small" text type="danger" @click="deleteBatch(batch)" class="wabi-btn-text wabi-btn-danger">删除</el-button>
              </div>
            </div>
          </div>
        </div>
      </el-dialog>

      <!-- 编辑题目弹窗 -->
      <el-dialog v-model="editDialogVisible" title="编辑题目" width="600" class="wabi-dialog">
        <el-form :model="editForm" label-width="80" class="wabi-form">
          <el-form-item label="题目">
            <el-input v-model="editForm.question" type="textarea" :rows="4" />
          </el-form-item>
          <el-form-item label="选项" v-if="editForm.options?.length">
            <div v-for="(opt, i) in editForm.options" :key="i" class="edit-option">
              <span class="option-label">{{ String.fromCharCode(65 + i) }}.</span>
              <el-input v-model="editForm.options[i]" />
            </div>
          </el-form-item>
          <el-form-item label="答案">
            <el-input v-model="editForm.answer" type="textarea" :rows="2" />
          </el-form-item>
        </el-form>
        <template #footer>
          <el-button @click="editDialogVisible = false" class="wabi-btn-ghost">取消</el-button>
          <el-button type="primary" @click="handleSaveQuestion" class="wabi-btn-primary">保存</el-button>
        </template>
      </el-dialog>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { MagicStick, Loading } from '@element-plus/icons-vue'
import { aiQuestionApi, teacherApi } from '@/api'

const generating = ref(false)
const persisting = ref(false)
const loadingHistory = ref(false)
const showHistory = ref(false)
const editDialogVisible = ref(false)
const currentBatch = ref(null)
const formRef = ref()
const batches = ref([])
const lectures = ref([])

const generateForm = ref({
  questionTypes: [],
  countPerType: 5,
  difficulty: 'mixed',
  knowledgeKeywords: '',
  lectureIds: []
})

const editForm = ref({
  tempId: '',
  question: '',
  options: [],
  answer: ''
})

const formRules = {
  questionTypes: [{ required: true, message: '请选择题型', trigger: 'change' }]
}

const questionTypes = [
  { value: 1, label: '填空题', desc: '考察基础概念', icon: '___' },
  { value: 2, label: '单选题', desc: '考察理解判断', icon: '○' },
  { value: 3, label: '多选题', desc: '考察综合理解', icon: '☐' },
  { value: 4, label: '判断题', desc: '考察是非判断', icon: '✓✗' },
  { value: 5, label: '简答题', desc: '考察分析能力', icon: '✎' },
  { value: 6, label: '编程题', desc: '考察实践能力', icon: '<>' }
]

const getTypeName = (type) => ({
  1: '填空题', 2: '单选题', 3: '多选题', 4: '判断题', 5: '简答题', 6: '编程题'
}[type] || '未知')

const getTypeClass = (type) => ({
  1: '', 2: 'wabi-tag-accent', 3: 'wabi-tag-accent', 4: '', 5: 'wabi-tag-warning', 6: 'wabi-tag-info'
}[type] || '')

const formatDate = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleString('zh-CN')
}

// 解析选项（后端可能返回 JSON 字符串或数组）
const parseOptions = (options) => {
  if (!options) return []
  if (Array.isArray(options)) return options
  if (typeof options === 'string') {
    try {
      const parsed = JSON.parse(options)
      return Array.isArray(parsed) ? parsed : []
    } catch {
      return []
    }
  }
  return []
}

const toggleQuestionType = (type) => {
  const index = generateForm.value.questionTypes.indexOf(type)
  if (index === -1) {
    generateForm.value.questionTypes.push(type)
  } else {
    generateForm.value.questionTypes.splice(index, 1)
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

// 加载生成历史
const loadBatches = async () => {
  showHistory.value = true
  loadingHistory.value = true
  try {
    const res = await aiQuestionApi.getBatches()
    batches.value = res.data || []
  } catch (error) {
    console.error('加载历史失败:', error)
  } finally {
    loadingHistory.value = false
  }
}

// 生成题目
const handleGenerate = async () => {
  if (!formRef.value) return
  await formRef.value.validate()

  generating.value = true
  currentBatch.value = { status: 'processing', questions: [] }

  try {
    const params = {
      questionTypes: generateForm.value.questionTypes,
      countPerType: generateForm.value.countPerType,
      difficulty: generateForm.value.difficulty,
      knowledgeKeywords: generateForm.value.knowledgeKeywords || undefined,
      lectureIds: generateForm.value.lectureIds?.length ? generateForm.value.lectureIds : undefined
    }

    const res = await aiQuestionApi.generateSync(params)
    currentBatch.value = {
      ...res.data,
      status: 'completed'
    }
    ElMessage.success(`成功生成 ${res.data?.questions?.length || 0} 道题目`)
  } catch (error) {
    ElMessage.error('生成失败：' + (error.message || '未知错误'))
    currentBatch.value = null
  } finally {
    generating.value = false
  }
}

// 开始新生成
const startNewGeneration = () => {
  currentBatch.value = null
}

// 查看批次
const viewBatch = (batch) => {
  currentBatch.value = batch
  showHistory.value = false
}

// 删除批次
const deleteBatch = async (batch) => {
  await ElMessageBox.confirm('确定删除该批次?', '提示', { type: 'warning' })
  try {
    await aiQuestionApi.deleteBatch(batch.batchId)
    ElMessage.success('已删除')
    loadBatches()
  } catch (error) {
    ElMessage.error('删除失败')
  }
}

// 编辑题目
const handleEditQuestion = (q) => {
  editForm.value = {
    ...q,
    options: parseOptions(q.options)
  }
  editDialogVisible.value = true
}

// 保存题目
const handleSaveQuestion = async () => {
  try {
    // 确保 options 是 JSON 字符串格式
    const submitData = {
      ...editForm.value,
      options: Array.isArray(editForm.value.options) ? JSON.stringify(editForm.value.options) : editForm.value.options
    }
    await aiQuestionApi.updateQuestion(editForm.value.tempId, submitData)
    ElMessage.success('保存成功')
    editDialogVisible.value = false
    // 更新本地数据
    const index = currentBatch.value.questions.findIndex(q => q.tempId === editForm.value.tempId)
    if (index !== -1) {
      currentBatch.value.questions[index] = { ...editForm.value }
    }
  } catch (error) {
    ElMessage.error('保存失败')
  }
}

// 入库单个题目
const handlePersistQuestion = async (q) => {
  try {
    await aiQuestionApi.persistQuestion(q.tempId)
    ElMessage.success('入库成功')
  } catch (error) {
    ElMessage.error('入库失败')
  }
}

// 批量入库
const handlePersistAll = async () => {
  if (!currentBatch.value?.questions?.length) return

  persisting.value = true
  try {
    const tempIds = currentBatch.value.questions.map(q => q.tempId)
    await aiQuestionApi.batchPersistQuestions(currentBatch.value.batchId, tempIds)
    ElMessage.success(`成功入库 ${tempIds.length} 道题目`)
  } catch (error) {
    ElMessage.error('批量入库失败')
  } finally {
    persisting.value = false
  }
}

// 重新生成题目
const handleRegenerate = async (q) => {
  q._regenerating = true
  try {
    const res = await aiQuestionApi.regenerateQuestion(q.tempId, '请重新生成一道类似的题目')
    // 更新本地数据
    const index = currentBatch.value.questions.findIndex(item => item.tempId === q.tempId)
    if (index !== -1 && res.data) {
      currentBatch.value.questions[index] = { ...res.data, _regenerating: false }
    }
    ElMessage.success('重新生成成功')
  } catch (error) {
    ElMessage.error('重新生成失败')
  } finally {
    q._regenerating = false
  }
}

onMounted(() => {
  loadLectures()
})
</script>

<style scoped>
.ai-question-generator {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-body {
  padding: 24px;
  max-width: 1000px;
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

.hero-title-wrapper {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.hero-icon {
  color: var(--wabi-accent, #7a8b6f);
}

.hero-title {
  font-size: 20px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
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

/* 表单区域 */
.config-section {
  margin-top: 16px;
}

.form-section {
  margin-bottom: 24px;
}

.section-label {
  font-size: 14px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin-bottom: 12px;
}

.required {
  color: #c47c7c;
}

/* 题型网格 */
.type-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}

.type-card {
  padding: 16px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s ease;
  text-align: center;
}

.type-card:hover {
  border-color: var(--wabi-accent, #7a8b6f);
}

.type-card.active {
  border-color: var(--wabi-accent, #7a8b6f);
  background: var(--wabi-accent-light, #e8ede5);
}

.type-icon {
  font-size: 20px;
  margin-bottom: 8px;
  color: var(--wabi-text-secondary, #8a8580);
}

.type-card.active .type-icon {
  color: var(--wabi-accent, #7a8b6f);
}

.type-name {
  font-size: 14px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin-bottom: 4px;
}

.type-desc {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 表单操作 */
.form-actions {
  display: flex;
  align-items: center;
  gap: 16px;
  padding-top: 16px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
}

.generate-btn {
  display: flex;
  align-items: center;
  gap: 8px;
}

.generate-hint {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 生成中状态 */
.generating-status {
  text-align: center;
  padding: 60px 0;
  color: var(--wabi-text-secondary, #8a8580);
}

.generating-status p {
  margin: 12px 0 0;
}

.generating-hint {
  font-size: 13px;
  color: var(--wabi-text-muted, #b5b0ab);
}

/* 结果区域 */
.result-section {
  margin-top: 16px;
}

.result-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}

.question-result-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.result-item {
  padding: 16px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
}

.result-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.result-info {
  display: flex;
  align-items: center;
  gap: 8px;
}

.result-actions {
  display: flex;
  gap: 4px;
}

.result-index {
  font-family: monospace;
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.result-content {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
  line-height: 1.6;
  margin-bottom: 12px;
}

.result-options {
  margin-bottom: 12px;
  padding-left: 16px;
}

.option-item {
  display: flex;
  gap: 8px;
  margin-bottom: 4px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.option-label {
  font-weight: 500;
  min-width: 20px;
}

.result-answer {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  padding: 12px;
  background: var(--wabi-surface-warm, #faf9f7);
  border-radius: 4px;
}

.answer-label {
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
}

/* 批次历史 */
.batch-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.batch-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 4px;
}

.batch-info {
  flex: 1;
}

.batch-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.batch-id {
  font-family: monospace;
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.batch-meta {
  display: flex;
  gap: 16px;
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.batch-actions {
  display: flex;
  gap: 4px;
}

/* 编辑选项 */
.edit-option {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 8px;
}

.edit-option .option-label {
  font-weight: 500;
  min-width: 20px;
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

.wabi-tag-warning {
  background: #f5efe4;
  color: #a0937d;
}

.wabi-tag-info {
  background: #e8ede5;
  color: #6b8a9a;
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

  .page-hero .wabi-card-content {
    flex-direction: column;
    gap: 12px;
  }

  .type-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .form-actions {
    flex-direction: column;
    align-items: stretch;
  }

  .result-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }

  .result-actions {
    width: 100%;
    justify-content: flex-end;
  }
}
</style>
