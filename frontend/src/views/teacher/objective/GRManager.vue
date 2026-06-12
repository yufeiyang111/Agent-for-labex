<template>
  <div class="gr-manager-page">
    <el-card>
      <template #header>
        <div class="card-header">
          <span class="title">毕业要求与指标点管理</span>
          <el-button type="primary" :icon="Plus" @click="onCreateGr">新建毕业要求</el-button>
        </div>
      </template>

      <el-tree
        :data="treeData"
        node-key="id"
        :props="{ children: 'children', label: 'display' }"
        default-expand-all
        v-loading="loading"
      >
        <template #default="{ node, data }">
          <div class="tree-row">
            <span>
              <el-tag :type="data.type === 'gr' ? 'success' : 'info'" size="small">
                {{ data.type === 'gr' ? '毕业要求' : '指标点' }}
              </el-tag>
              <span class="ml-2"><strong>{{ data.code }}</strong> {{ data.title || data.description }}</span>
            </span>
            <span class="actions">
              <el-button v-if="data.type === 'gr'" size="small" type="primary" link @click.stop="onAddIndicator(data)">
                + 指标点
              </el-button>
              <el-button size="small" type="danger" link @click.stop="onDelete(data)">删除</el-button>
            </span>
          </div>
        </template>
      </el-tree>
      <el-empty v-if="!loading && !treeData.length" description="还没有毕业要求" />
    </el-card>

    <!-- 新建毕业要求 -->
    <el-dialog v-model="grDialogVisible" title="新建毕业要求" width="700">
      <el-form ref="grFormRef" :model="grForm" :rules="grRules" label-width="100">
        <el-form-item label="编号" prop="code"><el-input v-model="grForm.code" placeholder="如：5" /></el-form-item>
        <el-form-item label="名称" prop="title"><el-input v-model="grForm.title" placeholder="如：使用现代工具" /></el-form-item>
        <el-form-item label="描述"><el-input v-model="grForm.description" type="textarea" :rows="3" /></el-form-item>
        <el-form-item label="适用专业"><el-input v-model="grForm.major" placeholder="如：软件工程" /></el-form-item>
        <el-divider>初始指标点（可选）</el-divider>
        <div v-for="(ind, i) in grForm.indicators" :key="i" class="indicator-row">
          <el-input v-model="ind.code" placeholder="如：5.1" style="width:100px; margin-right:8px" />
          <el-input v-model="ind.description" placeholder="指标点描述" style="flex:1" />
          <el-button type="danger" link @click="grForm.indicators.splice(i, 1)">移除</el-button>
        </div>
        <el-button size="small" @click="grForm.indicators.push({ code: '', description: '' })">+ 添加指标点</el-button>
      </el-form>
      <template #footer>
        <el-button @click="grDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="onSaveGr">保存</el-button>
      </template>
    </el-dialog>

    <!-- 新增指标点 -->
    <el-dialog v-model="indDialogVisible" title="新增指标点" width="600">
      <el-form ref="indFormRef" :model="indForm" :rules="indRules" label-width="100">
        <el-form-item label="毕业要求">{{ currentGr?.code }} {{ currentGr?.title }}</el-form-item>
        <el-form-item label="指标点编号" prop="code"><el-input v-model="indForm.code" placeholder="如：5.1" /></el-form-item>
        <el-form-item label="描述" prop="description"><el-input v-model="indForm.description" type="textarea" :rows="3" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="indDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="onSaveInd">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { graduationApi } from '@/api'

const grs = ref([])
const indicators = ref([])
const loading = ref(false)
const grDialogVisible = ref(false)
const indDialogVisible = ref(false)
const grFormRef = ref()
const indFormRef = ref()
const grForm = ref({ code: '', title: '', description: '', major: '', indicators: [] })
const indForm = ref({ code: '', description: '' })
const currentGr = ref(null)

const grRules = {
  code: [{ required: true, message: '请输入编号' }],
  title: [{ required: true, message: '请输入名称' }]
}
const indRules = {
  code: [{ required: true, message: '请输入指标点编号' }],
  description: [{ required: true, message: '请输入描述' }]
}

const treeData = computed(() =>
  grs.value.map(gr => ({
    id: `gr-${gr.requirementId}`,
    type: 'gr',
    code: gr.code,
    title: gr.title,
    raw: gr,
    children: indicators.value
      .filter(i => i.requirementId === gr.requirementId)
      .map(i => ({
        id: `ind-${i.indicatorId}`,
        type: 'ind',
        code: i.code,
        description: i.description,
        raw: i
      }))
  }))
)

const fetch = async () => {
  loading.value = true
  try {
    const [g, i] = await Promise.all([graduationApi.list(), graduationApi.allIndicators()])
    grs.value = g.data || []
    indicators.value = i.data || []
  } finally {
    loading.value = false
  }
}
onMounted(fetch)

const onCreateGr = () => {
  grForm.value = { code: '', title: '', description: '', major: '软件工程', indicators: [] }
  grDialogVisible.value = true
}
const onSaveGr = async () => {
  await grFormRef.value.validate()
  await graduationApi.create(grForm.value)
  ElMessage.success('已创建')
  grDialogVisible.value = false
  fetch()
}
const onAddIndicator = (data) => {
  currentGr.value = data.raw
  indForm.value = { code: '', description: '' }
  indDialogVisible.value = true
}
const onSaveInd = async () => {
  await indFormRef.value.validate()
  await graduationApi.addIndicator(currentGr.value.requirementId, indForm.value)
  ElMessage.success('已添加指标点')
  indDialogVisible.value = false
  fetch()
}
const onDelete = async (data) => {
  await ElMessageBox.confirm(`确定删除「${data.code}」?`, '确认')
  if (data.type === 'gr') {
    await graduationApi.remove(data.raw.requirementId)
  } else {
    await graduationApi.removeIndicator(data.raw.indicatorId)
  }
  ElMessage.success('已删除')
  fetch()
}
</script>

<style scoped>
.gr-manager-page { padding: 20px; }
.card-header { display: flex; justify-content: space-between; align-items: center; }
.title { font-weight: 600; font-size: 16px; }
.tree-row { display: flex; justify-content: space-between; align-items: center; width: 100%; padding-right: 16px; }
.actions { display: flex; gap: 6px; }
.ml-2 { margin-left: 8px; }
.indicator-row { display: flex; align-items: center; margin-bottom: 8px; gap: 4px; }
</style>
