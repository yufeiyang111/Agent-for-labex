<template>
  <div class="experiment-item-page wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-left">
          <el-button :icon="ArrowLeft" @click="$router.back()" text class="wabi-btn-text">返回</el-button>
          <div>
            <h2 class="page-title">{{ experimentInfo.experimentName || '实验题目管理' }}</h2>
            <span class="page-subtitle">实验编号: {{ experimentNo }}</span>
          </div>
        </div>
        <el-button type="primary" :icon="Plus" @click="handleAdd" class="wabi-btn-primary">
          新增题目
        </el-button>
      </div>

      <!-- 题目列表 -->
      <div class="list-container">
        <div class="list-content" v-loading="loading">
          <div v-if="!loading && !itemList.length" class="list-empty">
            <el-empty description="暂无题目数据">
              <el-button type="primary" @click="handleAdd">新增题目</el-button>
            </el-empty>
          </div>
          <div v-else class="item-list">
            <div v-for="item in itemList" :key="item.experimentItemId" class="item-card">
              <div class="item-header">
                <div class="item-info">
                  <span class="item-no">{{ item.experimentItemNo }}</span>
                  <span class="wabi-tag" :class="getTypeClass(item.experimentItemType)">
                    {{ getTypeName(item.experimentItemType) }}
                  </span>
                  <span class="wabi-tag" :class="item.state === 1 ? 'wabi-tag-accent' : ''">
                    {{ item.state === 1 ? '启用' : '禁用' }}
                  </span>
                </div>
                <span class="item-score">{{ item.experimentItemScore }} 分</span>
              </div>
              <div class="item-name">{{ item.experimentItemName }}</div>
              <div v-if="item.experimentItemAnswer" class="item-answer">
                <span class="answer-label">参考答案：</span>
                {{ item.experimentItemAnswer }}
              </div>
              <div class="item-actions">
                <el-button size="small" text @click="handleEdit(item)" class="wabi-btn-text">编辑</el-button>
                <el-button size="small" text type="danger" @click="handleDelete(item)" class="wabi-btn-text wabi-btn-danger">删除</el-button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 新增/编辑题目对话框 -->
    <el-dialog v-model="dialogVisible" :title="isEdit ? '编辑题目' : '新增题目'" width="700" class="wabi-dialog">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="100" class="wabi-form">
        <el-form-item label="题号" prop="experimentItemNo">
          <el-input v-model="formData.experimentItemNo" placeholder="如 1.1" />
        </el-form-item>
        <el-form-item label="题目名称" prop="experimentItemName">
          <el-input v-model="formData.experimentItemName" placeholder="请输入题目名称" />
        </el-form-item>
        <el-form-item label="题目内容">
          <el-input v-model="formData.experimentItemContent" type="textarea" :rows="4" placeholder="请输入题目内容" />
        </el-form-item>
        <el-form-item label="标准答案">
          <el-input v-model="formData.experimentItemAnswer" type="textarea" :rows="3" placeholder="请输入标准答案" />
        </el-form-item>
        <el-row :gutter="16">
          <el-col :span="8">
            <el-form-item label="分值" prop="experimentItemScore">
              <el-input-number v-model="formData.experimentItemScore" :min="1" :max="100" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="题型">
              <el-select v-model="formData.experimentItemType" placeholder="选择题型" style="width: 100%">
                <el-option label="填空题" :value="1" />
                <el-option label="单选题" :value="2" />
                <el-option label="多选题" :value="3" />
                <el-option label="判断题" :value="4" />
                <el-option label="简答题" :value="5" />
                <el-option label="编程题" :value="6" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="状态">
              <el-switch v-model="formData.state" :active-value="1" :inactive-value="0" active-text="启用" inactive-text="禁用" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleSubmit" :loading="saving" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { ArrowLeft, Plus } from '@element-plus/icons-vue'
import { teacherApi } from '@/api'

const route = useRoute()
const experimentId = computed(() => Number(route.params.experimentId))
const experimentItemApi = teacherApi.experimentItem
const experimentApi = teacherApi.experiment

const loading = ref(false)
const saving = ref(false)
const itemList = ref([])
const experimentInfo = ref({})
const dialogVisible = ref(false)
const formRef = ref()
const isEdit = ref(false)

const experimentNo = computed(() => experimentInfo.value?.experimentNo || '')

const formData = reactive({
  experimentItemId: null,
  experimentId: null,
  experimentItemNo: '',
  experimentItemName: '',
  experimentItemContent: '',
  experimentItemAnswer: '',
  experimentItemScore: 10,
  experimentItemType: 1,
  state: 1
})

const formRules = {
  experimentItemNo: [{ required: true, message: '请输入题号', trigger: 'blur' }],
  experimentItemName: [{ required: true, message: '请输入题目名称', trigger: 'blur' }],
  experimentItemScore: [{ required: true, message: '请输入分值', trigger: 'change' }]
}

const getTypeName = (type) => ({
  1: '填空题',
  2: '单选题',
  3: '多选题',
  4: '判断题',
  5: '简答题',
  6: '编程题'
}[type] || '未知')

const getTypeClass = (type) => ({
  1: '',
  2: 'wabi-tag-accent',
  3: 'wabi-tag-accent',
  4: '',
  5: 'wabi-tag-warning',
  6: 'wabi-tag-info'
}[type] || '')

const loadItemList = async () => {
  if (!experimentId.value) return
  loading.value = true
  try {
    const res = await experimentItemApi.listByExperiment(experimentId.value)
    itemList.value = res.data || []
    // 获取实验信息
    const expRes = await experimentApi.get(experimentId.value)
    experimentInfo.value = expRes.data || {}
  } catch (error) {
    console.error('加载题目列表失败:', error)
  } finally {
    loading.value = false
  }
}

const resetForm = () => {
  Object.assign(formData, {
    experimentItemId: null,
    experimentId: experimentId.value,
    experimentItemNo: '',
    experimentItemName: '',
    experimentItemContent: '',
    experimentItemAnswer: '',
    experimentItemScore: 10,
    experimentItemType: 1,
    state: 1
  })
}

const handleAdd = () => {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
}

const handleEdit = (row) => {
  Object.assign(formData, {
    experimentItemId: row.experimentItemId,
    experimentId: row.experimentId,
    experimentItemNo: row.experimentItemNo || '',
    experimentItemName: row.experimentItemName || '',
    experimentItemContent: row.experimentItemContent || '',
    experimentItemAnswer: row.experimentItemAnswer || '',
    experimentItemScore: row.experimentItemScore || 10,
    experimentItemType: row.experimentItemType || 1,
    state: row.state
  })
  isEdit.value = true
  dialogVisible.value = true
}

const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    saving.value = true
    if (isEdit.value) {
      await experimentItemApi.update(formData.experimentItemId, formData)
      ElMessage.success('更新成功')
    } else {
      await experimentItemApi.add(formData)
      ElMessage.success('创建成功')
    }
    dialogVisible.value = false
    loadItemList()
  } catch (error) {
    console.error('保存失败:', error)
  } finally {
    saving.value = false
  }
}

const handleDelete = async (row) => {
  await ElMessageBox.confirm('确定删除该题目?', '提示', { type: 'warning' })
  await experimentItemApi.delete(row.experimentItemId)
  ElMessage.success('已删除')
  loadItemList()
}

onMounted(loadItemList)
</script>

<style scoped>
.experiment-item-page {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-body {
  padding: 24px;
  max-width: 1200px;
  margin: 0 auto;
  height: calc(100vh - 48px);
  display: flex;
  flex-direction: column;
  animation: wabi-fade-in 0.4s ease;
}

@keyframes wabi-fade-in {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 页面头部 */
.page-header {
  flex-shrink: 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.page-title {
  font-size: 18px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
}

.page-subtitle {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 列表容器 */
.list-container {
  flex: 1;
  min-height: 0;
  display: flex;
  flex-direction: column;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: var(--wabi-radius, 3px);
  overflow: hidden;
}

.list-content {
  flex: 1;
  min-height: 0;
  overflow-y: auto;
  padding: 20px;
}

.list-empty {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  min-height: 200px;
}

/* 题目列表 */
.item-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.item-card {
  padding: 16px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  transition: all 0.2s ease;
}

.item-card:hover {
  border-color: var(--wabi-accent, #7a8b6f);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.item-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.item-info {
  display: flex;
  align-items: center;
  gap: 8px;
}

.item-no {
  font-family: monospace;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.item-score {
  font-size: 14px;
  font-weight: 600;
  color: var(--wabi-accent, #7a8b6f);
  font-family: 'Georgia', serif;
}

.item-name {
  font-size: 15px;
  color: var(--wabi-text, #2c2c2c);
  margin-bottom: 8px;
  line-height: 1.5;
}

.item-answer {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  padding: 8px 12px;
  background: var(--wabi-surface-warm, #faf9f7);
  border-radius: 4px;
  margin-bottom: 12px;
}

.answer-label {
  font-weight: 500;
}

.item-actions {
  display: flex;
  gap: 4px;
  justify-content: flex-end;
  border-top: 1px solid var(--wabi-border, #e8e4df);
  padding-top: 12px;
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
  background: #e8f0f5;
  color: #6b8a9a;
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

  .page-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }
}
</style>
