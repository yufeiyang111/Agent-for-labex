<template>
  <div class="course-edit-page wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-left">
          <el-button :icon="ArrowLeft" @click="$router.back()" text class="wabi-btn-text">返回</el-button>
          <h2 class="page-title">编辑课程</h2>
        </div>
      </div>

      <!-- 表单 -->
      <div class="wabi-card" v-loading="loading">
        <div class="wabi-card-content">
          <el-form ref="formRef" :model="form" label-width="100" class="wabi-form">
            <el-form-item label="课程编号">
              <el-input v-model="form.code" placeholder="如 CS101" />
            </el-form-item>
            <el-form-item label="中文名">
              <el-input v-model="form.nameCn" placeholder="课程中文名称" />
            </el-form-item>
            <el-form-item label="英文名">
              <el-input v-model="form.nameEn" placeholder="Course English Name" />
            </el-form-item>
            <el-row :gutter="16">
              <el-col :span="12">
                <el-form-item label="学分">
                  <el-input-number v-model="form.credit" :min="0.5" :max="10" :step="0.5" style="width: 100%" />
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="总学时">
                  <el-input-number v-model="form.hours" :min="1" :max="300" style="width: 100%" />
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="12">
                <el-form-item label="理论学时">
                  <el-input-number v-model="form.theoryHours" :min="0" :max="300" style="width: 100%" @change="onSubHoursChange" />
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="实验学时">
                  <el-input-number v-model="form.labHours" :min="0" :max="300" style="width: 100%" @change="onSubHoursChange" />
                </el-form-item>
              </el-col>
            </el-row>
            <div class="form-hint">
              提示：「总学时」为整门课课时（含讲授/实验/上机/实践等）；「理论」=讲授，「实验」=动手操作；总学时可大于或等于理论+实验之和。
            </div>
            <el-form-item label="适用专业">
              <el-input v-model="form.major" placeholder="如：软件工程" />
            </el-form-item>
            <el-form-item label="先修课程">
              <el-input v-model="form.prerequisite" placeholder="先修课程名称" />
            </el-form-item>
            <el-form-item label="开课系">
              <el-input v-model="form.department" placeholder="开课院系" />
            </el-form-item>
            <el-form-item label="课程简介">
              <el-input v-model="form.intro" type="textarea" :rows="5" placeholder="对课程的总体描述..." />
            </el-form-item>
            <div class="form-actions">
              <el-button @click="$router.back()" class="wabi-btn-ghost">取消</el-button>
              <el-button type="primary" @click="onSave" class="wabi-btn-primary">保存</el-button>
            </div>
          </el-form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowLeft } from '@element-plus/icons-vue'
import { courseApi } from '@/api'

const route = useRoute()
const router = useRouter()
const courseId = computed(() => Number(route.params.id))
const form = ref({})
const formRef = ref()
const loading = ref(false)

onMounted(async () => {
  loading.value = true
  try {
    const res = await courseApi.detail(courseId.value)
    form.value = res.data || {}
  } finally {
    loading.value = false
  }
})

const onSubHoursChange = () => {
  const sum = Number(form.value.theoryHours || 0) + Number(form.value.labHours || 0)
  if (!form.value.hours || form.value.hours < sum) {
    form.value.hours = sum
  }
}

const onSave = async () => {
  await courseApi.update(courseId.value, form.value)
  ElMessage.success('保存成功')
  router.push('/teacher/course')
}
</script>

<style scoped>
.course-edit-page {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-body {
  padding: 24px;
  max-width: 800px;
  margin: 0 auto;
  animation: wabi-fade-in 0.4s ease;
}

@keyframes wabi-fade-in {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

.page-header {
  margin-bottom: 24px;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.page-title {
  font-size: 20px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
}

.form-hint {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  padding: 8px 12px;
  background: var(--wabi-surface-warm, #faf9f7);
  border-radius: 4px;
  margin-bottom: 16px;
  line-height: 1.6;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  padding-top: 16px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
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

/* 响应式 */
@media (max-width: 768px) {
  .wabi-body {
    padding: 16px;
  }
}
</style>
