<template>
  <div class="course-edit-page">
    <el-page-header @back="$router.back()" content="编辑课程" />
    <el-card class="mt-4">
      <el-form ref="formRef" :model="form" label-width="120" v-loading="loading">
        <el-form-item label="课程编号"><el-input v-model="form.code" /></el-form-item>
        <el-form-item label="中文名"><el-input v-model="form.nameCn" /></el-form-item>
        <el-form-item label="英文名"><el-input v-model="form.nameEn" /></el-form-item>
        <el-row :gutter="20">
          <el-col :span="8"><el-form-item label="学分"><el-input-number v-model="form.credit" :min="0.5" :max="10" :step="0.5" /></el-form-item></el-col>
          <el-col :span="8"><el-form-item label="总学时"><el-input-number v-model="form.hours" :min="1" :max="300" /></el-form-item></el-col>
          <el-col :span="8"><el-form-item label="理论/实验">
            <el-input-number v-model="form.theoryHours" :min="0" style="width:90px" />
            <span class="mx-1">/</span>
            <el-input-number v-model="form.labHours" :min="0" style="width:90px" />
          </el-form-item></el-col>
        </el-row>
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
</script>

<style scoped>
.course-edit-page { padding: 20px; }
.mt-4 { margin-top: 16px; }
.mx-1 { margin: 0 4px; }
</style>
