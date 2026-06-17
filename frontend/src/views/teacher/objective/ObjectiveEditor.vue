<template>
  <div class="objective-editor wabi-page">
    <!-- 页面头部 -->
    <div class="wabi-header">
      <div class="header-left">
        <el-button :icon="ArrowLeft" @click="$router.back()" text class="wabi-btn-text">返回</el-button>
        <div class="header-info">
          <h1 class="wabi-title">课程目标管理</h1>
          <span class="wabi-subtitle">课程ID: {{ courseId }}</span>
        </div>
      </div>
      <div class="header-actions">
        <el-button type="primary" @click="onSaveMatrix" :loading="savingMatrix" class="wabi-btn-primary">
          保存支撑关系
        </el-button>
      </div>
    </div>

    <!-- 主体内容 -->
    <div class="wabi-body">
      <!-- 课程目标列表 -->
      <div class="wabi-card section-card">
        <div class="wabi-card-header">
          <span class="wabi-card-title">课程目标列表</span>
          <el-button type="primary" :icon="Plus" @click="onAddObjective" class="wabi-btn-primary">
            新增目标
          </el-button>
        </div>

        <div v-if="objectives.length === 0" class="wabi-empty">
          <div class="wabi-empty-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
              <path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
            </svg>
          </div>
          <p class="wabi-empty-text">暂无课程目标</p>
          <el-button type="primary" @click="onAddObjective" class="wabi-btn-primary">新增目标</el-button>
        </div>

        <div v-else class="wabi-card-content">
          <div class="objective-list">
            <div v-for="obj in objectives" :key="obj.objectiveId" class="objective-card">
              <div class="objective-header">
                <div class="objective-info">
                  <span class="objective-code">{{ obj.code }}</span>
                  <span class="wabi-tag" :class="categoryTagClass(obj.category)">
                    {{ categoryText(obj.category) }}
                  </span>
                </div>
                <div class="objective-actions">
                  <el-button
                    size="small"
                    type="primary"
                    plain
                    @click="onAiGenerateDescription(obj)"
                    :loading="aiLoading[obj.objectiveId]"
                    class="wabi-btn-ghost"
                  >
                    AI 生成
                  </el-button>
                  <span class="wabi-divider-v"></span>
                  <el-button size="small" text @click="onEditObjective(obj)" class="wabi-btn-text">编辑</el-button>
                  <span class="wabi-divider-v"></span>
                  <el-popconfirm :title="`确定删除「${obj.code}」?`" @confirm="onDeleteObjective(obj)">
                    <template #reference>
                      <el-button size="small" text type="danger" class="wabi-btn-text wabi-btn-danger">删除</el-button>
                    </template>
                  </el-popconfirm>
                </div>
              </div>
              <div class="objective-desc">{{ obj.description || '暂无描述' }}</div>
            </div>
          </div>
        </div>
      </div>

      <!-- 支撑矩阵 -->
      <div class="wabi-card section-card">
        <div class="wabi-card-header">
          <span class="wabi-card-title">课程目标 ↔ 毕业要求指标点 支撑矩阵</span>
          <span class="wabi-hint">H=高支撑 M=中支撑 L=低支撑</span>
        </div>

        <div v-if="objectives.length === 0 || allIndicators.length === 0" class="wabi-empty">
          <div class="wabi-empty-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
              <path d="M3 10h18M3 14h18m-9-4v8m-7 0h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
            </svg>
          </div>
          <p class="wabi-empty-text">需要先有课程目标和毕业要求指标点</p>
        </div>

        <div v-else class="matrix-wrapper">
          <el-table :data="objectives" class="wabi-table matrix-table" border>
            <el-table-column label="课程目标" width="200" fixed>
              <template #default="{ row }">
                <div class="matrix-row-header">
                  <strong>{{ row.code }}</strong>
                  <span class="matrix-row-desc">{{ row.description }}</span>
                </div>
              </template>
            </el-table-column>
            <el-table-column
              v-for="ind in allIndicators"
              :key="ind.indicatorId"
              :label="ind.code"
              min-width="100"
              align="center"
            >
              <template #header>
                <el-tooltip :content="ind.description" placement="top">
                  <span class="indicator-header">{{ ind.code }}</span>
                </el-tooltip>
              </template>
              <template #default="{ row }">
                <el-select
                  v-model="matrixMap[row.objectiveId][ind.indicatorId]"
                  placeholder="-"
                  clearable
                  size="small"
                  class="matrix-select"
                >
                  <el-option label="H 高" :value="3" />
                  <el-option label="M 中" :value="2" />
                  <el-option label="L 低" :value="1" />
                </el-select>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </div>
    </div>

    <!-- 编辑目标弹窗 -->
    <el-dialog
      v-model="objDialogVisible"
      :title="form.objectiveId ? '编辑课程目标' : '新增课程目标'"
      width="600"
      class="wabi-dialog"
    >
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100" class="wabi-form">
        <el-form-item label="编号" prop="code">
          <el-input v-model="form.code" placeholder="如：课程目标1" />
        </el-form-item>
        <el-form-item label="类别">
          <el-select v-model="form.category" style="width: 100%">
            <el-option label="知识目标" value="knowledge" />
            <el-option label="能力目标" value="ability" />
            <el-option label="素质目标" value="quality" />
          </el-select>
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input v-model="form.description" type="textarea" :rows="4" placeholder="课程目标的具体描述..." />
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="form.sortOrder" :min="0" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="objDialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="onSaveObjective" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, watch, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowLeft, Plus } from '@element-plus/icons-vue'
import { objectiveApi, graduationApi, aiAssistApi } from '@/api'

const route = useRoute()
const courseId = computed(() => Number(route.params.courseId))

const objectives = ref([])
const allIndicators = ref([])
const supports = ref([])
const matrixMap = reactive({})
const loading = ref(false)
const savingMatrix = ref(false)
const objDialogVisible = ref(false)
const formRef = ref()
const form = ref({ code: '', category: 'knowledge', description: '', sortOrder: 0 })
const aiLoading = reactive({})

const rules = {
  code: [{ required: true, message: '请输入编号' }],
  description: [{ required: true, message: '请输入描述' }]
}

const categoryText = (c) => ({
  knowledge: '知识目标',
  ability: '能力目标',
  quality: '素质目标'
}[c] || c || '-')

const categoryTagClass = (c) => ({
  knowledge: '',
  ability: 'wabi-tag-accent',
  quality: 'wabi-tag-warning'
}[c] || '')

const fetch = async () => {
  loading.value = true
  try {
    const [o, i, s] = await Promise.all([
      objectiveApi.list(courseId.value),
      graduationApi.allIndicators(),
      objectiveApi.supports(courseId.value)
    ])
    objectives.value = o.data || []
    allIndicators.value = i.data || []
    supports.value = s.data || []
    rebuildMatrix()
  } finally {
    loading.value = false
  }
}

onMounted(fetch)
watch(() => courseId.value, fetch)

const rebuildMatrix = () => {
  for (const k of Object.keys(matrixMap)) delete matrixMap[k]
  for (const obj of objectives.value) {
    matrixMap[obj.objectiveId] = {}
    for (const ind of allIndicators.value) {
      matrixMap[obj.objectiveId][ind.indicatorId] = null
    }
  }
  for (const s of supports.value) {
    if (matrixMap[s.objectiveId]) {
      matrixMap[s.objectiveId][s.indicatorId] = s.supportStrength
    }
  }
}

const onAddObjective = () => {
  form.value = {
    courseId: courseId.value,
    code: '课程目标' + (objectives.value.length + 1),
    category: 'knowledge',
    description: '',
    sortOrder: objectives.value.length
  }
  objDialogVisible.value = true
}

const onEditObjective = (row) => {
  form.value = { ...row }
  objDialogVisible.value = true
}

const onSaveObjective = async () => {
  await formRef.value.validate()
  if (form.value.objectiveId) {
    await objectiveApi.update(form.value.objectiveId, form.value)
  } else {
    form.value.courseId = courseId.value
    await objectiveApi.create(form.value)
  }
  ElMessage.success('已保存')
  objDialogVisible.value = false
  fetch()
}

const onDeleteObjective = async (row) => {
  await objectiveApi.remove(row.objectiveId)
  ElMessage.success('已删除')
  fetch()
}

// AI生成目标描述
const onAiGenerateDescription = async (obj) => {
  aiLoading[obj.objectiveId] = true
  try {
    const res = await aiAssistApi.objectiveDescription(obj.objectiveId)
    if (res.data?.content) {
      obj.description = res.data.content
      await objectiveApi.update(obj.objectiveId, { description: res.data.content })
      ElMessage.success('AI 已生成目标描述')
    }
  } catch (e) {
    ElMessage.error('AI 生成失败：' + (e.message || '未知错误'))
  } finally {
    aiLoading[obj.objectiveId] = false
  }
}

const onSaveMatrix = async () => {
  savingMatrix.value = true
  try {
    for (const obj of objectives.value) {
      const supportList = []
      const row = matrixMap[obj.objectiveId] || {}
      for (const [indId, strength] of Object.entries(row)) {
        if (strength) {
          supportList.push({
            objectiveId: obj.objectiveId,
            indicatorId: Number(indId),
            supportStrength: strength
          })
        }
      }
      await objectiveApi.setSupports(obj.objectiveId, supportList)
    }
    ElMessage.success('支撑关系已保存')
    fetch()
  } finally {
    savingMatrix.value = false
  }
}
</script>

<style scoped>
.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.header-info {
  display: flex;
  flex-direction: column;
}

.header-actions {
  display: flex;
  gap: 8px;
}

.section-card {
  margin-bottom: 24px;
}

/* 目标列表 */
.objective-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.objective-card {
  padding: 16px;
  border: 1px solid var(--wabi-border);
  border-radius: var(--wabi-radius);
  transition: var(--wabi-transition);
}

.objective-card:hover {
  border-color: var(--wabi-accent);
  box-shadow: var(--wabi-shadow);
}

.objective-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.objective-info {
  display: flex;
  align-items: center;
  gap: 8px;
}

.objective-code {
  font-weight: 500;
  color: var(--wabi-text);
}

.objective-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}

.objective-desc {
  font-size: 14px;
  color: var(--wabi-text-secondary);
  line-height: 1.6;
  padding-left: 4px;
}

/* 标签变体 */
.wabi-tag-accent {
  background: var(--wabi-green-light);
  color: var(--wabi-green);
}

.wabi-tag-warning {
  background: var(--wabi-warning-light);
  color: var(--wabi-warning);
}

/* 支撑矩阵 */
.matrix-wrapper {
  overflow-x: auto;
  width: 100%;
}

.matrix-table {
  width: 100% !important;
}

.matrix-row-header {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.matrix-row-header strong {
  color: var(--wabi-text);
  font-weight: 500;
}

.matrix-row-desc {
  font-size: 12px;
  color: var(--wabi-text-muted);
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.indicator-header {
  font-weight: 500;
  font-size: 12px;
}

.matrix-select {
  width: 100%;
  min-width: 70px;
}

/* 响应式 */
@media (max-width: 768px) {
  .objective-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }

  .objective-actions {
    align-self: flex-end;
  }
}
</style>
