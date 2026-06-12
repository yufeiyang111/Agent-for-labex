<template>
  <div class="course-edit-page">
    <el-page-header @back="$router.back()" content="编辑课程" />
    <el-card class="mt-4">
      <el-form ref="formRef" :model="form" label-width="120" v-loading="loading">
        <el-form-item label="课程编号"><el-input v-model="form.code" /></el-form-item>
        <el-form-item label="中文名"><el-input v-model="form.nameCn" /></el-form-item>
        <el-form-item label="英文名"><el-input v-model="form.nameEn" /></el-form-item>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="学分">
              <el-input-number v-model="form.credit" :min="0.5" :max="10" :step="0.5" style="width:100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="总学时">
              <el-input-number v-model="form.hours" :min="1" :max="300" style="width:100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="理论学时">
              <el-input-number v-model="form.theoryHours" :min="0" :max="300" style="width:100%" @change="onSubHoursChange" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="实验学时">
              <el-input-number v-model="form.labHours" :min="0" :max="300" style="width:100%" @change="onSubHoursChange" />
            </el-form-item>
          </el-col>
        </el-row>
        <div class="hours-hint">
          <el-text size="small" type="info">
            提示：「总学时」为整门课课时（含讲授/实验/上机/实践等）；「理论」=讲授，「实验」=动手操作；总学时可大于或等于理论+实验之和。
          </el-text>
        </div>
        <el-form-item label="适用专业"><el-input v-model="form.major" /></el-form-item>
        <el-form-item label="先修课程"><el-input v-model="form.prerequisite" /></el-form-item>
        <el-form-item label="开课系"><el-input v-model="form.department" /></el-form-item>
        <el-form-item label="课程简介"><el-input v-model="form.intro" type="textarea" :rows="6" /></el-form-item>
        <el-form-item>
          <el-button type="primary" @click="onSave">保存</el-button>
          <el-button @click="$router.back()">取消</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
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

const onSave = async () => {
  await courseApi.update(courseId.value, form.value)
  ElMessage.success('保存成功')
  router.push('/teacher/course')
}

const onSubHoursChange = () => {
  const sum = Number(form.value.theoryHours || 0) + Number(form.value.labHours || 0)
  if (!form.value.hours || form.value.hours < sum) {
    form.value.hours = sum
  }
}
</script>

<style scoped>
.course-edit-page { padding: 20px; }
.mt-4 { margin-top: 16px; }
.hours-hint { padding-left: 120px; margin-bottom: 16px; line-height: 1.5; }
</style>
