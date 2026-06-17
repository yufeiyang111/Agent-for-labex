<template>
  <div class="course-evaluation-page">
    <div class="page-header">
      <h2 class="page-title">课程评价</h2>
      <p class="page-desc">对已完成的课程进行评价，帮助我们改进教学质量</p>
    </div>

    <!-- 选择开课 -->
    <div class="select-section">
      <el-select v-model="selectedOfferingId" placeholder="请选择要评价的课程" style="width: 100%" @change="loadEvaluation">
        <el-option
          v-for="o in offerings"
          :key="o.offeringId"
          :label="`${o.semester} · ${o.clazzNo} · ${courseNameOf(o)}`"
          :value="o.offeringId"
        />
      </el-select>
    </div>

    <!-- 评价表单 -->
    <div v-if="selectedOfferingId" class="evaluation-form">
      <div v-if="existingEval" class="already-evaluated">
        <el-result icon="success" title="您已完成评价" sub-title="感谢您的反馈，我们会认真对待每一条建议">
          <template #extra>
            <el-button type="primary" @click="viewMyEvaluation">查看我的评价</el-button>
          </template>
        </el-result>
      </div>

      <template v-else>
        <!-- 评分维度 -->
        <div class="dimension-section">
          <h3 class="section-title">请对以下维度进行评分</h3>
          <div class="dimension-list">
            <div v-for="dim in dimensions" :key="dim.key" class="dimension-item">
              <div class="dim-header">
                <span class="dim-label">{{ dim.label }}</span>
                <span class="dim-score">{{ form[dim.key] || '-' }} / 5</span>
              </div>
              <el-rate v-model="form[dim.key]" :max="5" show-text :texts="dim.texts" />
              <p class="dim-desc">{{ dim.description }}</p>
            </div>
          </div>
        </div>

        <!-- 文字评价 -->
        <div class="comment-section">
          <h3 class="section-title">文字评价（可选）</h3>
          <el-input
            v-model="form.comment"
            type="textarea"
            :rows="4"
            placeholder="请分享您对这门课程的感受和建议..."
          />
        </div>

        <!-- 改进建议 -->
        <div class="suggestion-section">
          <h3 class="section-title">改进建议（可选）</h3>
          <el-input
            v-model="form.suggestion"
            type="textarea"
            :rows="3"
            placeholder="您希望课程在哪些方面进行改进？"
          />
        </div>

        <!-- 提交按钮 -->
        <div class="submit-section">
          <el-button type="primary" size="large" @click="submitEvaluation" :loading="submitting" :disabled="!isFormValid">
            提交评价
          </el-button>
          <p class="submit-hint">评价提交后不可修改，请确认无误后再提交</p>
        </div>
      </template>
    </div>

    <!-- 空状态 -->
    <div v-else class="empty-state">
      <el-empty description="请选择要评价的课程" />
    </div>

    <!-- 查看评价弹窗 -->
    <el-dialog v-model="showMyEval" title="我的评价" width="600">
      <div v-if="myEvalData" class="my-eval-content">
        <div class="eval-dimensions">
          <div v-for="dim in dimensions" :key="dim.key" class="eval-dim">
            <span class="dim-label">{{ dim.label }}</span>
            <el-rate :model-value="myEvalData[dim.key]" disabled :max="5" />
          </div>
        </div>
        <div v-if="myEvalData.comment" class="eval-comment">
          <h4>文字评价</h4>
          <p>{{ myEvalData.comment }}</p>
        </div>
        <div v-if="myEvalData.suggestion" class="eval-suggestion">
          <h4>改进建议</h4>
          <p>{{ myEvalData.suggestion }}</p>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { studentTeachingApi, studentEvalApi } from '@/api'

const offerings = ref([])
const selectedOfferingId = ref(null)
const existingEval = ref(null)
const myEvalData = ref(null)
const showMyEval = ref(false)
const submitting = ref(false)
const courseMap = ref({})

const form = reactive({
  teachingQuality: 0,
  courseContent: 0,
  learningResources: 0,
  assessmentMethod: 0,
  learningEffect: 0,
  comment: '',
  suggestion: ''
})

const dimensions = [
  { key: 'teachingQuality', label: '教学质量', description: '教师的授课水平、讲解清晰度、答疑及时性', texts: ['很差', '较差', '一般', '较好', '很好'] },
  { key: 'courseContent', label: '课程内容', description: '课程内容的实用性、深度、广度', texts: ['很差', '较差', '一般', '较好', '很好'] },
  { key: 'learningResources', label: '学习资源', description: '教材、讲义、实验环境等学习资源的质量', texts: ['很差', '较差', '一般', '较好', '很好'] },
  { key: 'assessmentMethod', label: '考核方式', description: '作业、考试、实验等考核方式的合理性', texts: ['很差', '较差', '一般', '较好', '很好'] },
  { key: 'learningEffect', label: '学习效果', description: '通过课程学习，您对知识的掌握程度', texts: ['很差', '较差', '一般', '较好', '很好'] }
]

const isFormValid = computed(() => {
  return dimensions.every(d => form[d.key] > 0)
})

const courseNameOf = (o) => courseMap.value[o.courseId]?.nameCn || `课程#${o.courseId}`

const loadOfferings = async () => {
  console.log('[课程评价] 开始加载开课列表...')
  try {
    const res = await studentTeachingApi.myOfferings()
    console.log('[课程评价] 开课列表API响应:', res)
    console.log('[课程评价] 开课数据:', res.data)
    offerings.value = res.data || []
    console.log('[课程评价] 加载到', offerings.value.length, '个开课')
    // 加载课程名称
    courseMap.value = Object.fromEntries(
      offerings.value.filter(o => o.courseName).map(o => [o.courseId, { nameCn: o.courseName }])
    )
  } catch (e) {
    console.error('[课程评价] 加载开课列表失败:', e)
    ElMessage.error('加载开课列表失败')
  }
}

const loadEvaluation = async () => {
  if (!selectedOfferingId.value) return

  try {
    const res = await studentEvalApi.getMyEvaluation(selectedOfferingId.value)
    if (res.data) {
      existingEval.value = res.data
      myEvalData.value = res.data
    } else {
      existingEval.value = null
      myEvalData.value = null
      // 重置表单
      dimensions.forEach(d => form[d.key] = 0)
      form.comment = ''
      form.suggestion = ''
    }
  } catch (e) {
    existingEval.value = null
  }
}

const submitEvaluation = async () => {
  if (!isFormValid.value) {
    ElMessage.warning('请完成所有维度的评分')
    return
  }

  submitting.value = true
  try {
    await studentEvalApi.submitEvaluation({
      offeringId: selectedOfferingId.value,
      ...form
    })
    ElMessage.success('评价提交成功，感谢您的反馈！')
    await loadEvaluation()
  } catch (e) {
    ElMessage.error('提交失败：' + (e.message || '未知错误'))
  } finally {
    submitting.value = false
  }
}

const viewMyEvaluation = () => {
  showMyEval.value = true
}

onMounted(loadOfferings)
</script>

<style scoped>
.course-evaluation-page {
  max-width: 800px;
  margin: 0 auto;
}

.page-header {
  margin-bottom: 24px;
}

.page-title {
  font-size: 20px;
  font-weight: 600;
  color: #1d1d1f;
  margin: 0 0 4px 0;
}

.page-desc {
  font-size: 14px;
  color: #6e6e73;
  margin: 0;
}

.select-section {
  margin-bottom: 24px;
}

.evaluation-form {
  background: #fff;
  border-radius: 12px;
  padding: 24px;
  border: 1px solid #e5e5e5;
}

.section-title {
  font-size: 16px;
  font-weight: 600;
  color: #1d1d1f;
  margin: 0 0 16px 0;
}

.dimension-section {
  margin-bottom: 32px;
}

.dimension-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.dimension-item {
  padding: 16px;
  background: #fafafa;
  border-radius: 8px;
}

.dim-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.dim-label {
  font-size: 14px;
  font-weight: 500;
  color: #1d1d1f;
}

.dim-score {
  font-size: 14px;
  color: #6e6e73;
}

.dim-desc {
  font-size: 12px;
  color: #9ca3af;
  margin: 8px 0 0 0;
}

.comment-section,
.suggestion-section {
  margin-bottom: 24px;
}

.submit-section {
  text-align: center;
  padding-top: 16px;
  border-top: 1px solid #e5e5e5;
}

.submit-hint {
  font-size: 12px;
  color: #9ca3af;
  margin: 8px 0 0 0;
}

.empty-state {
  padding: 60px 0;
}

.already-evaluated {
  padding: 20px 0;
}

/* 我的评价 */
.my-eval-content {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.eval-dimensions {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.eval-dim {
  display: flex;
  align-items: center;
  gap: 12px;
}

.eval-dim .dim-label {
  min-width: 80px;
}

.eval-comment h4,
.eval-suggestion h4 {
  font-size: 14px;
  font-weight: 500;
  margin: 0 0 8px 0;
}

.eval-comment p,
.eval-suggestion p {
  font-size: 14px;
  color: #374151;
  line-height: 1.6;
  margin: 0;
  padding: 12px;
  background: #f9fafb;
  border-radius: 6px;
}
</style>
