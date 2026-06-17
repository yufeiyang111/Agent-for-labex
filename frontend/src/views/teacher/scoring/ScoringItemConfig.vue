<template>
  <div class="scoring-item-config wabi-page">
    <!-- 页面头部 -->
    <div class="wabi-header">
      <div class="header-left">
        <el-button :icon="ArrowLeft" @click="$router.back()" text class="wabi-back-btn">返回</el-button>
        <div class="header-info">
          <h1 class="wabi-title">评分项配置</h1>
          <span class="wabi-subtitle">开课ID: {{ offeringId }}</span>
        </div>
      </div>
      <div class="header-actions">
        <el-tag :type="weightValid ? 'success' : 'danger'" class="weight-tag" effect="plain">
          权重和: {{ weightSum.toFixed(4) }} / 1.0000
        </el-tag>
      </div>
    </div>

    <!-- 主体内容 -->
    <div class="wabi-body">
      <div class="wabi-card">
        <div class="wabi-card-header">
          <span class="wabi-card-title">评分项列表</span>
          <div class="wabi-card-actions">
            <el-button :icon="MagicStick" @click="onSuggest" :loading="suggesting" class="wabi-btn-ghost">
              一键导入
            </el-button>
            <el-button type="primary" :icon="Plus" @click="onAdd" class="wabi-btn-primary">
              新增评分项
            </el-button>
          </div>
        </div>

        <div class="wabi-table-wrapper">
          <el-table :data="items" v-loading="loading" class="wabi-table">
            <el-table-column prop="sortOrder" label="序" width="60" align="center" />
            <el-table-column prop="name" label="名称" min-width="140" />
            <el-table-column prop="type" label="类型" width="100" align="center">
              <template #default="{ row }">
                <span class="wabi-tag">{{ typeText(row.type) }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="maxScore" label="满分" width="80" align="center" />
            <el-table-column prop="passingScore" label="期望分" width="90" align="center" />
            <el-table-column prop="weight" label="权重" width="100" align="center">
              <template #default="{ row }">
                <span class="wabi-tag wabi-tag-accent">{{ row.weight }}</span>
              </template>
            </el-table-column>
            <el-table-column label="对应目标" min-width="160">
              <template #default="{ row }">
                <span v-for="o in objectiveLinkMap[row.itemId] || []" :key="o" class="wabi-tag wabi-tag-outline">
                  {{ objectiveMap[o]?.code || o }}
                </span>
                <span v-if="!(objectiveLinkMap[row.itemId]?.length)" class="wabi-muted">未关联</span>
              </template>
            </el-table-column>
            <el-table-column prop="sourceTable" label="来源" width="120">
              <template #default="{ row }">
                <span v-if="row.sourceTable" class="wabi-muted">{{ row.sourceTable }}#{{ row.sourceId }}</span>
                <span v-else class="wabi-muted">手动</span>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="140" fixed="right" align="center">
              <template #default="{ row }">
                <div class="wabi-action-group">
                  <el-button size="small" text @click="onEdit(row)" class="wabi-btn-text">编辑</el-button>
                  <span class="wabi-divider-v"></span>
                  <el-popconfirm title="确定删除?" @confirm="onDelete(row)">
                    <template #reference>
                      <el-button size="small" text type="danger" class="wabi-btn-text wabi-btn-danger">删除</el-button>
                    </template>
                  </el-popconfirm>
                </div>
              </template>
            </el-table-column>
          </el-table>
        </div>

        <div v-if="!loading && !items.length" class="wabi-empty">
          <div class="wabi-empty-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
              <path d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
          </div>
          <p class="wabi-empty-text">暂无评分项</p>
        </div>
      </div>
    </div>

    <!-- 编辑评分项 -->
    <el-dialog v-model="dialogVisible" :title="form.itemId ? '编辑评分项' : '新增评分项'" width="600" class="wabi-dialog">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100" class="wabi-form">
        <el-form-item label="名称" prop="name">
          <el-input v-model="form.name" placeholder="评分项名称" />
        </el-form-item>
        <el-form-item label="类型" prop="type">
          <el-select v-model="form.type" placeholder="选择类型" style="width: 100%">
            <el-option label="作业" value="homework" />
            <el-option label="实验" value="experiment" />
            <el-option label="考试" value="exam" />
            <el-option label="大作业/项目" value="project" />
            <el-option label="其他" value="other" />
          </el-select>
        </el-form-item>
        <el-row :gutter="16">
          <el-col :span="8">
            <el-form-item label="满分">
              <el-input-number v-model="form.maxScore" :min="1" :max="1000" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="期望分">
              <el-input-number v-model="form.passingScore" :min="0" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="排序">
              <el-input-number v-model="form.sortOrder" :min="0" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="权重" prop="weight">
          <el-input-number v-model="form.weight" :min="0" :max="1" :step="0.01" :precision="4" />
          <span class="wabi-hint">权重和应 = 1.0000</span>
        </el-form-item>
        <el-form-item label="对应目标">
          <div class="wabi-checkbox-group">
            <label v-for="o in objectives" :key="o.objectiveId" class="wabi-checkbox-item">
              <input type="checkbox" v-model="selectedObjectives" :value="o.objectiveId" />
              <span class="wabi-checkbox-label">{{ o.code }}</span>
            </label>
          </div>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="onSave" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>

    <!-- 建议导入 -->
    <el-dialog v-model="suggestDialogVisible" title="一键导入建议" width="800" class="wabi-dialog">
      <div class="wabi-alert wabi-alert-info">
        <span>以下评分项基于现有作业/实验/考试自动生成，权重默认为 0，请勾选并修改权重。</span>
      </div>
      <el-table :data="suggestions" ref="suggestTableRef" @selection-change="onSelectionChange" class="wabi-table">
        <el-table-column type="selection" width="50" />
        <el-table-column prop="name" label="名称" />
        <el-table-column prop="type" label="类型" width="100">
          <template #default="{ row }">
            <span class="wabi-tag">{{ typeText(row.type) }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="maxScore" label="满分" width="80" align="center" />
        <el-table-column label="设置权重" width="140">
          <template #default="{ row }">
            <el-input-number v-model="row.weight" :min="0" :max="1" :step="0.01" :precision="4" size="small" />
          </template>
        </el-table-column>
      </el-table>
      <template #footer>
        <el-button @click="suggestDialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="onImportSelected" :disabled="!selectedSuggestions.length" class="wabi-btn-primary">
          导入选中 ({{ selectedSuggestions.length }})
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Plus, MagicStick, ArrowLeft } from '@element-plus/icons-vue'
import { scoringItemApi, objectiveApi, offeringApi } from '@/api'

const route = useRoute()
const offeringId = computed(() => Number(route.params.offeringId))

const items = ref([])
const objectives = ref([])
const objectiveMap = computed(() => Object.fromEntries(objectives.value.map(o => [o.objectiveId, o])))
const objectiveLinkMap = ref({})
const loading = ref(false)
const suggesting = ref(false)
const dialogVisible = ref(false)
const suggestDialogVisible = ref(false)
const suggestTableRef = ref()
const formRef = ref()
const form = ref({})
const selectedObjectives = ref([])
const suggestions = ref([])
const selectedSuggestions = ref([])

const rules = {
  name: [{ required: true, message: '请输入名称' }],
  type: [{ required: true, message: '请选择类型' }],
  weight: [{ required: true, message: '请输入权重' }]
}

const typeText = (t) => ({
  homework: '作业',
  experiment: '实验',
  exam: '考试',
  project: '项目',
  other: '其他'
}[t] || t)

const weightSum = computed(() =>
  items.value.reduce((sum, i) => sum + Number(i.weight || 0), 0)
)
const weightValid = computed(() => Math.abs(weightSum.value - 1) < 0.0001)

const fetch = async () => {
  loading.value = true
  try {
    const [iRes, oRes] = await Promise.all([
      scoringItemApi.list(offeringId.value),
      offeringApi.detail(offeringId.value)
    ])
    items.value = iRes.data || []
    const courseId = oRes.data?.courseId
    if (courseId) {
      const objRes = await objectiveApi.list(courseId)
      objectives.value = objRes.data || []
    }
    const linkMap = {}
    for (const item of items.value) {
      const r = await scoringItemApi.objectives(item.itemId)
      linkMap[item.itemId] = (r.data || []).map(l => l.objectiveId)
    }
    objectiveLinkMap.value = linkMap
  } finally {
    loading.value = false
  }
}
onMounted(fetch)

const onAdd = () => {
  form.value = {
    offeringId: offeringId.value,
    name: '',
    type: 'homework',
    maxScore: 100,
    passingScore: 70,
    weight: 0.05,
    sortOrder: items.value.length
  }
  selectedObjectives.value = []
  dialogVisible.value = true
}

const onEdit = (row) => {
  form.value = { ...row }
  selectedObjectives.value = [...(objectiveLinkMap.value[row.itemId] || [])]
  dialogVisible.value = true
}

const onSave = async () => {
  await formRef.value.validate()
  const req = {
    item: form.value,
    objectiveLinks: selectedObjectives.value.map(oid => ({ objectiveId: oid }))
  }
  if (form.value.itemId) {
    await scoringItemApi.update(form.value.itemId, req)
  } else {
    await scoringItemApi.create(req)
  }
  ElMessage.success('已保存')
  dialogVisible.value = false
  fetch()
}

const onDelete = async (row) => {
  await scoringItemApi.remove(row.itemId)
  ElMessage.success('已删除')
  fetch()
}

const onSuggest = async () => {
  suggesting.value = true
  try {
    const res = await scoringItemApi.suggest(offeringId.value)
    suggestions.value = (res.data || []).map(i => ({ ...i }))
    suggestDialogVisible.value = true
  } finally {
    suggesting.value = false
  }
}

const onSelectionChange = (rows) => {
  selectedSuggestions.value = rows
}

const onImportSelected = async () => {
  const reqs = selectedSuggestions.value.map(item => ({ item, objectiveLinks: [] }))
  await scoringItemApi.batchSave(reqs)
  ElMessage.success(`已导入 ${reqs.length} 个评分项，请配置权重和对应目标`)
  suggestDialogVisible.value = false
  fetch()
}
</script>

<style scoped>
/* 侘寂风格基础变量 */
.wabi-page {
  --wabi-bg: #f8f6f3;
  --wabi-surface: #ffffff;
  --wabi-border: #e8e4df;
  --wabi-text: #2c2c2c;
  --wabi-text-secondary: #8a8580;
  --wabi-accent: #7a8b6f;
  --wabi-accent-light: #e8ede5;
  --wabi-danger: #c47c7c;
  --wabi-tag-bg: #f0ece8;
  --wabi-transition: all 0.25s ease;

  min-height: 100vh;
  background: var(--wabi-bg);
  color: var(--wabi-text);
  font-family: 'Noto Serif SC', 'Source Han Serif CN', Georgia, serif;
}

/* 页面头部 */
.wabi-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 32px;
  background: var(--wabi-surface);
  border-bottom: 1px solid var(--wabi-border);
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.header-info {
  display: flex;
  flex-direction: column;
}

.wabi-title {
  font-size: 18px;
  font-weight: 500;
  color: var(--wabi-text);
  margin: 0;
  letter-spacing: 0.5px;
}

.wabi-subtitle {
  font-size: 13px;
  color: var(--wabi-text-secondary);
  margin-top: 2px;
}

.wabi-back-btn {
  color: var(--wabi-text-secondary);
  transition: var(--wabi-transition);
}

.wabi-back-btn:hover {
  color: var(--wabi-text);
}

.weight-tag {
  border-radius: 2px;
  font-family: 'SF Mono', 'Consolas', monospace;
  font-size: 13px;
}

/* 主体内容 */
.wabi-body {
  padding: 32px;
  max-width: 1200px;
  margin: 0 auto;
}

/* 卡片 */
.wabi-card {
  background: var(--wabi-surface);
  border: 1px solid var(--wabi-border);
  border-radius: 4px;
  overflow: hidden;
}

.wabi-card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 24px;
  border-bottom: 1px solid var(--wabi-border);
  background: linear-gradient(to bottom, #faf9f7, var(--wabi-surface));
}

.wabi-card-title {
  font-size: 15px;
  font-weight: 500;
  color: var(--wabi-text);
  letter-spacing: 0.3px;
}

.wabi-card-actions {
  display: flex;
  gap: 8px;
}

/* 表格 */
.wabi-table-wrapper {
  overflow-x: auto;
}

.wabi-table {
  width: 100%;
}

.wabi-table :deep(.el-table__header th) {
  background: var(--wabi-tag-bg);
  color: var(--wabi-text-secondary);
  font-weight: 500;
  font-size: 13px;
  letter-spacing: 0.5px;
  border-bottom: 1px solid var(--wabi-border);
}

.wabi-table :deep(.el-table__body td) {
  border-bottom: 1px solid var(--wabi-border);
  transition: var(--wabi-transition);
}

.wabi-table :deep(.el-table__body tr:hover td) {
  background: rgba(122, 139, 111, 0.04);
}

.wabi-table :deep(.el-table__empty-block) {
  display: none;
}

/* 操作按钮组 */
.wabi-action-group {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.wabi-divider-v {
  width: 1px;
  height: 14px;
  background: var(--wabi-border);
}

.wabi-btn-text {
  padding: 4px 8px;
  font-size: 13px;
  color: var(--wabi-text-secondary);
  transition: var(--wabi-transition);
}

.wabi-btn-text:hover {
  color: var(--wabi-accent);
  background: var(--wabi-accent-light);
}

.wabi-btn-danger:hover {
  color: var(--wabi-danger);
  background: rgba(196, 124, 124, 0.08);
}

/* 标签 */
.wabi-tag {
  display: inline-block;
  padding: 2px 8px;
  background: var(--wabi-tag-bg);
  color: var(--wabi-text-secondary);
  font-size: 12px;
  border-radius: 2px;
  letter-spacing: 0.3px;
}

.wabi-tag-accent {
  background: var(--wabi-accent-light);
  color: var(--wabi-accent);
  font-family: 'SF Mono', 'Consolas', monospace;
}

.wabi-tag-outline {
  background: transparent;
  border: 1px solid var(--wabi-border);
  margin-right: 4px;
}

/* 按钮 */
.wabi-btn-primary {
  background: var(--wabi-accent);
  border-color: var(--wabi-accent);
  border-radius: 3px;
  letter-spacing: 0.5px;
  transition: var(--wabi-transition);
}

.wabi-btn-primary:hover {
  background: #6b7d60;
  border-color: #6b7d60;
}

.wabi-btn-ghost {
  border-color: var(--wabi-border);
  color: var(--wabi-text-secondary);
  border-radius: 3px;
  transition: var(--wabi-transition);
}

.wabi-btn-ghost:hover {
  border-color: var(--wabi-accent);
  color: var(--wabi-accent);
}

/* 空状态 */
.wabi-empty {
  padding: 60px 0;
  text-align: center;
}

.wabi-empty-icon {
  width: 48px;
  height: 48px;
  margin: 0 auto 16px;
  color: var(--wabi-border);
}

.wabi-empty-icon svg {
  width: 100%;
  height: 100%;
}

.wabi-empty-text {
  color: var(--wabi-text-secondary);
  font-size: 14px;
  margin: 0;
}

/* 提示文字 */
.wabi-muted {
  color: var(--wabi-text-secondary);
  font-size: 12px;
}

.wabi-hint {
  color: var(--wabi-text-secondary);
  font-size: 12px;
  margin-left: 8px;
}

/* 弹窗 */
.wabi-dialog :deep(.el-dialog) {
  border-radius: 4px;
  border: 1px solid var(--wabi-border);
}

.wabi-dialog :deep(.el-dialog__header) {
  border-bottom: 1px solid var(--wabi-border);
  padding: 16px 24px;
}

.wabi-dialog :deep(.el-dialog__title) {
  font-weight: 500;
  letter-spacing: 0.3px;
}

.wabi-dialog :deep(.el-dialog__body) {
  padding: 24px;
}

.wabi-dialog :deep(.el-dialog__footer) {
  border-top: 1px solid var(--wabi-border);
  padding: 16px 24px;
}

/* 表单 */
.wabi-form :deep(.el-form-item__label) {
  color: var(--wabi-text-secondary);
  font-weight: 400;
}

.wabi-form :deep(.el-input__wrapper) {
  border-radius: 3px;
  box-shadow: 0 0 0 1px var(--wabi-border);
}

.wabi-form :deep(.el-input__wrapper:hover) {
  box-shadow: 0 0 0 1px var(--wabi-accent);
}

.wabi-form :deep(.el-input__wrapper.is-focus) {
  box-shadow: 0 0 0 1px var(--wabi-accent);
}

/* 复选框组 */
.wabi-checkbox-group {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.wabi-checkbox-item {
  display: flex;
  align-items: center;
  gap: 6px;
  cursor: pointer;
  padding: 4px 8px;
  border: 1px solid var(--wabi-border);
  border-radius: 3px;
  transition: var(--wabi-transition);
}

.wabi-checkbox-item:hover {
  border-color: var(--wabi-accent);
}

.wabi-checkbox-item input:checked + .wabi-checkbox-label {
  color: var(--wabi-accent);
}

.wabi-checkbox-label {
  font-size: 13px;
  color: var(--wabi-text-secondary);
}

/* 提示框 */
.wabi-alert {
  padding: 12px 16px;
  border-radius: 3px;
  font-size: 13px;
  line-height: 1.6;
  margin-bottom: 16px;
}

.wabi-alert-info {
  background: var(--wabi-accent-light);
  color: var(--wabi-accent);
  border: 1px solid rgba(122, 139, 111, 0.2);
}

/* 响应式 */
@media (max-width: 768px) {
  .wabi-header {
    flex-direction: column;
    gap: 12px;
    align-items: flex-start;
    padding: 16px 20px;
  }

  .wabi-body {
    padding: 20px;
  }

  .wabi-card-header {
    flex-direction: column;
    gap: 12px;
    align-items: flex-start;
  }

  .wabi-card-actions {
    width: 100%;
  }

  .wabi-action-group {
    flex-direction: column;
    gap: 4px;
  }

  .wabi-divider-v {
    display: none;
  }
}
</style>
