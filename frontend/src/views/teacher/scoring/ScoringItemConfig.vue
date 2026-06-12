<template>
  <div class="scoring-item-config-page">
    <el-page-header @back="$router.back()" :content="`评分项配置 - 开课ID ${offeringId}`" />

    <el-card class="mt-4">
      <template #header>
        <div class="card-header">
          <div>
            <span class="title">评分项列表</span>
            <el-tag :type="weightValid ? 'success' : 'danger'" class="ml-2">
              权重和：{{ weightSum.toFixed(4) }} / 1.0000
              <el-icon v-if="weightValid" class="ml-1"><CircleCheckFilled /></el-icon>
              <el-icon v-else class="ml-1"><WarningFilled /></el-icon>
            </el-tag>
          </div>
          <div>
            <el-button :icon="MagicStick" @click="onSuggest" :loading="suggesting">从作业/实验/考试一键导入</el-button>
            <el-button type="primary" :icon="Plus" @click="onAdd">新增评分项</el-button>
          </div>
        </div>
      </template>

      <el-table :data="items" stripe v-loading="loading">
        <el-table-column prop="sortOrder" label="序" width="60" align="center" />
        <el-table-column prop="name" label="名称" min-width="140" />
        <el-table-column prop="type" label="类型" width="100" align="center">
          <template #default="{ row }">
            <el-tag size="small">{{ typeText(row.type) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="maxScore" label="满分" width="80" align="center" />
        <el-table-column prop="passingScore" label="期望分" width="90" align="center" />
        <el-table-column prop="weight" label="权重" width="100" align="center">
          <template #default="{ row }">
            <el-tag>{{ row.weight }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="对应目标" min-width="160">
          <template #default="{ row }">
            <el-tag v-for="o in objectiveLinkMap[row.itemId] || []" :key="o" size="small" class="mr-1">
              {{ objectiveMap[o]?.code || o }}
            </el-tag>
            <span v-if="!(objectiveLinkMap[row.itemId]?.length)" class="muted">未关联</span>
          </template>
        </el-table-column>
        <el-table-column prop="sourceTable" label="来源" width="120">
          <template #default="{ row }">
            <span v-if="row.sourceTable">{{ row.sourceTable }}#{{ row.sourceId }}</span>
            <span v-else class="muted">手动</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="160" fixed="right">
          <template #default="{ row }">
            <el-button size="small" @click="onEdit(row)">编辑</el-button>
            <el-popconfirm title="确定删除?" @confirm="onDelete(row)">
              <template #reference><el-button size="small" type="danger">删除</el-button></template>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!loading && !items.length" description="还没有评分项" />
    </el-card>

    <!-- 编辑评分项 -->
    <el-dialog v-model="dialogVisible" :title="form.itemId ? '编辑评分项' : '新增评分项'" width="700">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100">
        <el-row :gutter="20">
          <el-col :span="14"><el-form-item label="名称" prop="name"><el-input v-model="form.name" /></el-form-item></el-col>
          <el-col :span="10"><el-form-item label="类型" prop="type">
            <el-select v-model="form.type" placeholder="选择">
              <el-option label="作业" value="homework" />
              <el-option label="实验" value="experiment" />
              <el-option label="考试" value="exam" />
              <el-option label="大作业/项目" value="project" />
              <el-option label="其他" value="other" />
            </el-select>
          </el-form-item></el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="8"><el-form-item label="满分"><el-input-number v-model="form.maxScore" :min="1" :max="1000" /></el-form-item></el-col>
          <el-col :span="8"><el-form-item label="期望及格分"><el-input-number v-model="form.passingScore" :min="0" /></el-form-item></el-col>
          <el-col :span="8"><el-form-item label="排序"><el-input-number v-model="form.sortOrder" :min="0" /></el-form-item></el-col>
        </el-row>
        <el-form-item label="权重" prop="weight">
          <el-input-number v-model="form.weight" :min="0" :max="1" :step="0.01" :precision="4" />
          <span class="ml-2 muted">所有评分项权重和应=1.0000</span>
        </el-form-item>
        <el-form-item label="对应课程目标">
          <el-checkbox-group v-model="selectedObjectives">
            <el-checkbox v-for="o in objectives" :key="o.objectiveId" :label="o.objectiveId">
              {{ o.code }}
            </el-checkbox>
          </el-checkbox-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="onSave">保存</el-button>
      </template>
    </el-dialog>

    <!-- 建议导入 -->
    <el-dialog v-model="suggestDialogVisible" title="一键导入建议" width="900">
      <el-alert type="info" :closable="false" class="mb-2">
        以下评分项基于您的现有作业/实验/考试自动生成，权重默认 0，请勾选需要导入的项并修改权重。
      </el-alert>
      <el-table :data="suggestions" stripe ref="suggestTableRef" @selection-change="onSelectionChange">
        <el-table-column type="selection" width="55" />
        <el-table-column prop="name" label="名称" />
        <el-table-column prop="type" label="类型" width="120">
          <template #default="{ row }"><el-tag size="small">{{ typeText(row.type) }}</el-tag></template>
        </el-table-column>
        <el-table-column prop="maxScore" label="满分" width="80" align="center" />
        <el-table-column label="设置权重" width="160">
          <template #default="{ row }">
            <el-input-number v-model="row.weight" :min="0" :max="1" :step="0.01" :precision="4" size="small" />
          </template>
        </el-table-column>
      </el-table>
      <template #footer>
        <el-button @click="suggestDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="onImportSelected" :disabled="!selectedSuggestions.length">导入选中</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Plus, MagicStick, CircleCheckFilled, WarningFilled } from '@element-plus/icons-vue'
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

const typeText = (t) => ({ homework: '作业', experiment: '实验', exam: '考试', project: '项目', other: '其他' }[t] || t)

const weightSum = computed(() =>
  items.value.reduce((sum, i) => sum + Number(i.weight || 0), 0)
)
const weightValid = computed(() => Math.abs(weightSum.value - 1) < 0.0001)

const fetch = async () => {
  loading.value = true
  try {
    const [iRes, oRes, oferRes] = await Promise.all([
      scoringItemApi.list(offeringId.value),
      offeringApi.detail(offeringId.value),
      Promise.resolve()
    ])
    items.value = iRes.data || []
    // 取课程ID再取目标
    const courseId = oRes.data?.courseId
    if (courseId) {
      const objRes = await objectiveApi.list(courseId)
      objectives.value = objRes.data || []
    }
    // 取每个 item 的目标关联
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
  form.value = { offeringId: offeringId.value, name: '', type: 'homework', maxScore: 100, passingScore: 70, weight: 0.05, sortOrder: items.value.length }
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
const onDelete = async (row) => { await scoringItemApi.remove(row.itemId); ElMessage.success('已删除'); fetch() }

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
const onSelectionChange = (rows) => { selectedSuggestions.value = rows }
const onImportSelected = async () => {
  const reqs = selectedSuggestions.value.map(item => ({ item, objectiveLinks: [] }))
  await scoringItemApi.batchSave(reqs)
  ElMessage.success(`已导入 ${reqs.length} 个评分项，请配置权重和对应目标`)
  suggestDialogVisible.value = false
  fetch()
}
</script>

<style scoped>
.scoring-item-config-page { padding: 20px; }
.card-header { display: flex; justify-content: space-between; align-items: center; }
.title { font-weight: 600; font-size: 16px; }
.muted { color: #909399; font-size: 12px; }
.mt-4 { margin-top: 16px; }
.ml-1 { margin-left: 4px; }
.ml-2 { margin-left: 8px; }
.mr-1 { margin-right: 4px; }
.mb-2 { margin-bottom: 8px; }
</style>
