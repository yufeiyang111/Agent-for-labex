<template>
  <div class="gr-manager-page wabi-page">
    <div class="wabi-body">
      <div class="wabi-card">
        <div class="wabi-card-header">
          <span class="wabi-card-title">毕业要求与指标点管理</span>
          <el-button type="primary" :icon="Plus" @click="onCreateGr" class="wabi-btn-primary">
            新建毕业要求
          </el-button>
        </div>
        <div class="wabi-card-content">
          <div v-if="!loading && !treeData.length" class="wabi-empty">
            <p class="wabi-empty-text">还没有毕业要求</p>
            <el-button type="primary" @click="onCreateGr" class="wabi-btn-primary">新建毕业要求</el-button>
          </div>
          <div v-else class="gr-tree">
            <div v-for="gr in treeData" :key="gr.id" class="gr-item">
              <div class="gr-header">
                <div class="gr-info">
                  <span class="wabi-tag wabi-tag-accent">毕业要求</span>
                  <span class="gr-code">{{ gr.code }}</span>
                  <span class="gr-title">{{ gr.title }}</span>
                  <span v-if="gr.description" class="gr-desc">{{ gr.description }}</span>
                </div>
                <div class="gr-actions">
                  <el-button size="small" text @click="onEditGr(gr)" class="wabi-btn-text">
                    编辑
                  </el-button>
                  <el-button size="small" text @click="onAddIndicator(gr)" class="wabi-btn-text">
                    + 指标点
                  </el-button>
                  <el-button size="small" text type="danger" @click="onDeleteGr(gr)" class="wabi-btn-text wabi-btn-danger">
                    删除
                  </el-button>
                </div>
              </div>
              <div v-if="gr.children?.length" class="indicator-list">
                <div v-for="ind in gr.children" :key="ind.indicatorId" class="indicator-item">
                  <div class="indicator-info">
                    <span class="wabi-tag">指标点</span>
                    <span class="indicator-code">{{ ind.code }}</span>
                    <span class="indicator-desc">{{ ind.description }}</span>
                  </div>
                  <div class="indicator-actions">
                    <el-button size="small" text @click="onEditIndicator(gr, ind)" class="wabi-btn-text">
                      编辑
                    </el-button>
                    <el-button size="small" text type="danger" @click="onDeleteIndicator(gr, ind)" class="wabi-btn-text wabi-btn-danger">
                      删除
                    </el-button>
                  </div>
                </div>
              </div>
              <div v-else class="indicator-empty">
                <span>暂无指标点</span>
                <el-button size="small" text @click="onAddIndicator(gr)" class="wabi-btn-text">
                  + 添加指标点
                </el-button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 新建/编辑毕业要求 -->
    <el-dialog v-model="grDialogVisible" :title="grDialogTitle" width="600" class="wabi-dialog">
      <el-form ref="grFormRef" :model="grForm" :rules="grRules" label-width="100" class="wabi-form">
        <el-form-item label="编号" prop="code">
          <el-input v-model="grForm.code" placeholder="如：5" />
        </el-form-item>
        <el-form-item label="名称" prop="title">
          <el-input v-model="grForm.title" placeholder="如：使用现代工具" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="grForm.description" type="textarea" :rows="3" placeholder="毕业要求描述..." />
        </el-form-item>
        <el-form-item label="适用专业">
          <el-input v-model="grForm.major" placeholder="如：软件工程" />
        </el-form-item>
        <template v-if="!isEditGr">
          <el-divider>初始指标点（可选）</el-divider>
          <div v-for="(ind, i) in grForm.indicators" :key="i" class="indicator-form-row">
            <el-input v-model="ind.code" placeholder="如：5.1" style="width: 100px" />
            <el-input v-model="ind.description" placeholder="指标点描述" style="flex: 1" />
            <el-button type="danger" text @click="grForm.indicators.splice(i, 1)">移除</el-button>
          </div>
          <el-button size="small" @click="grForm.indicators.push({ code: '', description: '' })">
            + 添加指标点
          </el-button>
        </template>
      </el-form>
      <template #footer>
        <el-button @click="grDialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="onSaveGr" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>

    <!-- 新建/编辑指标点 -->
    <el-dialog v-model="indDialogVisible" :title="indDialogTitle" width="500" class="wabi-dialog">
      <el-form ref="indFormRef" :model="indForm" :rules="indRules" label-width="80" class="wabi-form">
        <el-form-item label="编号" prop="code">
          <el-input v-model="indForm.code" placeholder="如：5.1" />
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input v-model="indForm.description" type="textarea" :rows="3" placeholder="指标点描述" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="indDialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="onSaveIndicator" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { graduationApi } from '@/api'

const loading = ref(false)
const treeData = ref([])
const grDialogVisible = ref(false)
const indDialogVisible = ref(false)
const grDialogTitle = ref('新建毕业要求')
const indDialogTitle = ref('新增指标点')
const grFormRef = ref()
const indFormRef = ref()
const isEditGr = ref(false)
const currentGrId = ref(null)
const currentIndId = ref(null)

const grForm = ref({
  code: '',
  title: '',
  description: '',
  major: '',
  indicators: [{ code: '', description: '' }]
})

const indForm = ref({
  code: '',
  description: ''
})

const grRules = {
  code: [{ required: true, message: '请输入编号', trigger: 'blur' }],
  title: [{ required: true, message: '请输入名称', trigger: 'blur' }]
}

const indRules = {
  code: [{ required: true, message: '请输入编号', trigger: 'blur' }],
  description: [{ required: true, message: '请输入描述', trigger: 'blur' }]
}

// 加载树形数据
const loadTree = async () => {
  loading.value = true
  try {
    const res = await graduationApi.list()
    const requirements = res.data || []

    const tree = []
    for (const req of requirements) {
      try {
        const indRes = await graduationApi.listIndicators(req.requirementId)
        tree.push({
          ...req,
          id: req.requirementId,
          children: indRes.data || []
        })
      } catch {
        tree.push({
          ...req,
          id: req.requirementId,
          children: []
        })
      }
    }

    treeData.value = tree
  } catch (error) {
    console.error('加载毕业要求失败:', error)
  } finally {
    loading.value = false
  }
}

// ==================== 毕业要求 CRUD ====================

const onCreateGr = () => {
  isEditGr.value = false
  grDialogTitle.value = '新建毕业要求'
  grForm.value = {
    code: '',
    title: '',
    description: '',
    major: '',
    indicators: [{ code: '', description: '' }]
  }
  grDialogVisible.value = true
}

const onEditGr = (gr) => {
  isEditGr.value = true
  grDialogTitle.value = '编辑毕业要求'
  grForm.value = {
    requirementId: gr.requirementId,
    code: gr.code,
    title: gr.title,
    description: gr.description || '',
    major: gr.major || ''
  }
  grDialogVisible.value = true
}

const onSaveGr = async () => {
  await grFormRef.value.validate()
  try {
    if (isEditGr.value) {
      await graduationApi.update(grForm.value.requirementId, grForm.value)
      ElMessage.success('更新成功')
    } else {
      await graduationApi.create(grForm.value)
      ElMessage.success('创建成功')
    }
    grDialogVisible.value = false
    loadTree()
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

const onDeleteGr = async (gr) => {
  await ElMessageBox.confirm(`确定删除毕业要求「${gr.code} ${gr.title}」? 删除后其下的指标点也会被删除。`, '确认删除', { type: 'warning' })
  try {
    await graduationApi.remove(gr.requirementId || gr.id)
    ElMessage.success('已删除')
    loadTree()
  } catch (error) {
    ElMessage.error('删除失败')
  }
}

// ==================== 指标点 CRUD ====================

const onAddIndicator = (gr) => {
  currentGrId.value = gr.requirementId || gr.id
  currentIndId.value = null
  indDialogTitle.value = '新增指标点'
  indForm.value = { code: '', description: '' }
  indDialogVisible.value = true
}

const onEditIndicator = (gr, ind) => {
  currentGrId.value = gr.requirementId || gr.id
  currentIndId.value = ind.indicatorId
  indDialogTitle.value = '编辑指标点'
  indForm.value = {
    code: ind.code,
    description: ind.description || ''
  }
  indDialogVisible.value = true
}

const onSaveIndicator = async () => {
  await indFormRef.value.validate()
  try {
    if (currentIndId.value) {
      await graduationApi.updateIndicator(currentIndId.value, indForm.value)
      ElMessage.success('更新成功')
    } else {
      await graduationApi.addIndicator(currentGrId.value, indForm.value)
      ElMessage.success('创建成功')
    }
    indDialogVisible.value = false
    loadTree()
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

const onDeleteIndicator = async (gr, ind) => {
  await ElMessageBox.confirm(`确定删除指标点「${ind.code}」?`, '确认删除', { type: 'warning' })
  try {
    await graduationApi.removeIndicator(ind.indicatorId)
    ElMessage.success('已删除')
    loadTree()
  } catch (error) {
    ElMessage.error('删除失败')
  }
}

onMounted(loadTree)
</script>

<style scoped>
.gr-manager-page {
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

/* 毕业要求树 */
.gr-tree {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.gr-item {
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  overflow: hidden;
}

.gr-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 16px 20px;
  background: var(--wabi-surface-warm, #faf9f7);
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
}

.gr-info {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  flex-wrap: wrap;
}

.gr-code {
  font-family: monospace;
  font-size: 14px;
  color: var(--wabi-text-secondary, #8a8580);
  font-weight: 500;
}

.gr-title {
  font-size: 15px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
}

.gr-desc {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-top: 4px;
  width: 100%;
}

.gr-actions {
  display: flex;
  gap: 4px;
  flex-shrink: 0;
}

/* 指标点列表 */
.indicator-list {
  padding: 12px 20px;
}

.indicator-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 0;
  border-bottom: 1px dashed var(--wabi-border, #e8e4df);
}

.indicator-item:last-child {
  border-bottom: none;
}

.indicator-info {
  display: flex;
  align-items: center;
  gap: 12px;
  flex: 1;
  min-width: 0;
}

.indicator-code {
  font-family: monospace;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  min-width: 40px;
}

.indicator-desc {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
  flex: 1;
  min-width: 0;
}

.indicator-actions {
  display: flex;
  gap: 4px;
  flex-shrink: 0;
}

.indicator-empty {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 16px 20px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 表单行 */
.indicator-form-row {
  display: flex;
  gap: 8px;
  margin-bottom: 8px;
  align-items: center;
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

/* 空状态 */
.wabi-empty {
  padding: 40px 0;
  text-align: center;
}

.wabi-empty-text {
  color: var(--wabi-text-secondary, #8a8580);
  font-size: 14px;
  margin: 0 0 16px 0;
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

  .gr-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }

  .gr-actions {
    width: 100%;
    justify-content: flex-end;
  }

  .indicator-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }

  .indicator-actions {
    width: 100%;
    justify-content: flex-end;
  }

  .indicator-form-row {
    flex-direction: column;
  }
}
</style>
