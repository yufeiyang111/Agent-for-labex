<template>
  <div class="objective-editor-page">
    <el-page-header @back="$router.back()" :content="`课程目标管理 - 课程ID ${courseId}`" />

    <el-card class="mt-4">
      <template #header>
        <div class="card-header">
          <span class="title">课程目标列表</span>
          <el-button type="primary" :icon="Plus" @click="onAddObjective">新增目标</el-button>
        </div>
      </template>
      <el-table :data="objectives" stripe v-loading="loading">
        <el-table-column prop="code" label="编号" width="120" />
        <el-table-column prop="category" label="类别" width="100" align="center">
          <template #default="{ row }">
            <el-tag size="small">{{ categoryText(row.category) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="description" label="描述" />
        <el-table-column prop="sortOrder" label="顺序" width="80" align="center" />
        <el-table-column label="操作" width="180">
          <template #default="{ row }">
            <el-button size="small" @click="onEditObjective(row)">编辑</el-button>
            <el-popconfirm :title="`确定删除「${row.code}」?`" @confirm="onDeleteObjective(row)">
              <template #reference><el-button size="small" type="danger">删除</el-button></template>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!loading && !objectives.length" description="还没有课程目标" />
    </el-card>

    <!-- 支撑矩阵 -->
    <el-card class="mt-4">
      <template #header>
        <div class="card-header">
          <span class="title">课程目标 ↔ 毕业要求指标点 支撑矩阵</span>
          <el-button type="primary" @click="onSaveMatrix">保存支撑关系</el-button>
        </div>
      </template>
      <el-table :data="objectives" border>
        <el-table-column label="课程目标" width="180" fixed>
          <template #default="{ row }">
            <div><strong>{{ row.code }}</strong></div>
            <div class="muted">{{ row.description }}</div>
          </template>
        </el-table-column>
        <el-table-column v-for="ind in allIndicators" :key="ind.indicatorId" :label="ind.code" width="100" align="center">
          <template #header>
            <el-tooltip :content="ind.description" placement="top">
              <span>{{ ind.code }}</span>
            </el-tooltip>
          </template>
          <template #default="{ row }">
            <el-select v-model="matrixMap[row.objectiveId][ind.indicatorId]" placeholder="-" clearable size="small">
              <el-option label="H 高" :value="3" />
              <el-option label="M 中" :value="2" />
              <el-option label="L 低" :value="1" />
            </el-select>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!objectives.length || !allIndicators.length" description="需要先有课程目标和毕业要求指标点" />
    </el-card>

    <!-- 编辑目标弹窗 -->
    <el-dialog v-model="objDialogVisible" :title="form.objectiveId ? '编辑课程目标' : '新增课程目标'" width="600">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100">
        <el-form-item label="编号" prop="code"><el-input v-model="form.code" placeholder="如：课程目标1" /></el-form-item>
        <el-form-item label="类别"><el-select v-model="form.category" placeholder="选择">
          <el-option label="知识目标" value="knowledge" />
          <el-option label="能力目标" value="ability" />
          <el-option label="素质目标" value="quality" />
        </el-select></el-form-item>
        <el-form-item label="描述" prop="description"><el-input v-model="form.description" type="textarea" :rows="4" /></el-form-item>
        <el-form-item label="排序"><el-input-number v-model="form.sortOrder" :min="0" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="objDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="onSaveObjective">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, watch, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { objectiveApi, graduationApi } from '@/api'

const route = useRoute()
const courseId = computed(() => Number(route.params.courseId))

const objectives = ref([])
const allIndicators = ref([])
const supports = ref([])
const matrixMap = reactive({})
const loading = ref(false)
const objDialogVisible = ref(false)
const formRef = ref()
const form = ref({ code: '', category: 'knowledge', description: '', sortOrder: 0 })
const rules = {
  code: [{ required: true, message: '请输入编号' }],
  description: [{ required: true, message: '请输入描述' }]
}

const categoryText = (c) => ({ knowledge: '知识', ability: '能力', quality: '素质' }[c] || c || '-')

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
  form.value = { courseId: courseId.value, code: '课程目标' + (objectives.value.length + 1), category: 'knowledge', description: '', sortOrder: objectives.value.length }
  objDialogVisible.value = true
}
const onEditObjective = (row) => { form.value = { ...row }; objDialogVisible.value = true }
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

const onSaveMatrix = async () => {
  for (const obj of objectives.value) {
    const supports = []
    const row = matrixMap[obj.objectiveId] || {}
    for (const [indId, strength] of Object.entries(row)) {
      if (strength) {
        supports.push({ objectiveId: obj.objectiveId, indicatorId: Number(indId), supportStrength: strength })
      }
    }
    await objectiveApi.setSupports(obj.objectiveId, supports)
  }
  ElMessage.success('支撑关系已保存')
  fetch()
}
</script>

<style scoped>
.objective-editor-page { padding: 20px; }
.card-header { display: flex; justify-content: space-between; align-items: center; }
.title { font-weight: 600; font-size: 16px; }
.muted { color: #909399; font-size: 12px; }
.mt-4 { margin-top: 16px; }
</style>
