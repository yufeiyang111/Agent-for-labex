<template>
  <div class="evaluation-form-page">
    <el-page-header @back="$router.back()" :content="`课程质量评价 - 开课ID ${offeringId}`" />

    <el-card class="mt-4">
      <template #header>
        <div class="card-header">
          <span class="title">评价表单</span>
          <div>
            <el-button v-if="!eval_ || eval_?.status === 'draft'" type="primary" @click="onSave">保存草稿</el-button>
            <el-button v-if="eval_?.status === 'draft'" type="success" @click="onFinalize">提交终稿</el-button>
            <el-tag v-if="eval_?.status === 'finalized'" type="success" size="large">已终稿</el-tag>
            <el-button type="warning" @click="goReports" class="ml-2">查看 4 张报告</el-button>
          </div>
        </div>
      </template>

      <el-form :model="form" label-width="180" v-loading="loading">
        <el-divider content-position="left">基本信息</el-divider>
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="评价轮次"><el-input v-model="form.evalRound" placeholder="如 2024-2025-1-Round1" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="课程负责人"><el-input v-model="form.courseResponsible" /></el-form-item></el-col>
        </el-row>
        <el-form-item label="课程组成员">
          <el-input v-model="courseMembersText" placeholder="姓名 1, 姓名 2, ..." />
        </el-form-item>
        <el-form-item label="评价小组成员">
          <el-input v-model="evalGroupMembersText" placeholder="姓名 1, 姓名 2, ..." />
        </el-form-item>

        <el-divider content-position="left">评价项目 1：课程目标合理性</el-divider>
        <el-form-item label="课程目标与指标点的对应关系">
          <el-radio-group v-model="form.objectiveIndicatorRationality">
            <el-radio label="reasonable">合理</el-radio>
            <el-radio label="relatively">比较合理</el-radio>
            <el-radio label="unreasonable">不合理</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="是否包含知识/能力/素质">
          <el-radio-group v-model="form.objectiveContainsKaq">
            <el-radio label="contain">包含</el-radio>
            <el-radio label="partial">部分包含</el-radio>
            <el-radio label="none">不包含</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-divider content-position="left">评价项目 2：课程目标达成情况</el-divider>
        <el-form-item label="期望值合理性">
          <el-radio-group v-model="form.expectedRationality">
            <el-radio label="reasonable">合理</el-radio>
            <el-radio label="relatively">比较合理</el-radio>
            <el-radio label="unreasonable">不合理</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="达成情况分析合理性">
          <el-radio-group v-model="form.analysisRationality">
            <el-radio label="reasonable">合理</el-radio>
            <el-radio label="relatively">比较合理</el-radio>
            <el-radio label="unreasonable">不合理</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="改进措施合理性">
          <el-radio-group v-model="form.improvementRationality">
            <el-radio label="reasonable">合理</el-radio>
            <el-radio label="relatively">比较合理</el-radio>
            <el-radio label="unreasonable">不合理</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-divider content-position="left">结论及意见</el-divider>
        <el-form-item label="1、课程存在的问题"><el-input v-model="form.existingIssues" type="textarea" :rows="3" /></el-form-item>
        <el-form-item label="2、达成评价的有效性"><el-input v-model="form.evaluationValidity" type="textarea" :rows="3" /></el-form-item>
        <el-form-item label="3、上一轮问题改进情况"><el-input v-model="form.lastRoundImprovements" type="textarea" :rows="3" /></el-form-item>
        <el-form-item label="4、结论及改进意见"><el-input v-model="form.conclusionAndSuggestions" type="textarea" :rows="4" /></el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { qualityEvalApi } from '@/api'

const route = useRoute()
const router = useRouter()
const offeringId = computed(() => Number(route.params.offeringId))

const eval_ = ref(null)
const form = ref({})
const loading = ref(false)
const courseMembersText = ref('')
const evalGroupMembersText = ref('')

const fetch = async () => {
  loading.value = true
  try {
    const res = await qualityEvalApi.latest(offeringId.value)
    if (res.data) {
      eval_.value = res.data
      form.value = { ...res.data }
      // 反向同步显示文本
      syncDisplayFromForm()
    } else {
      // 自动创建草稿
      const semester = new Date().getFullYear() + '-' + (new Date().getFullYear() + 1)
      const createRes = await qualityEvalApi.create({
        offeringId: offeringId.value,
        evalRound: `${semester}-Round1`
      })
      eval_.value = createRes.data
      form.value = { ...createRes.data }
      syncDisplayFromForm()
    }
  } finally {
    loading.value = false
  }
}

const syncDisplayFromForm = () => {
  try {
    courseMembersText.value = form.value.courseMembers
      ? JSON.parse(form.value.courseMembers).join(', ')
      : ''
  } catch { courseMembersText.value = form.value.courseMembers || '' }
  try {
    evalGroupMembersText.value = form.value.evalGroupMembers
      ? JSON.parse(form.value.evalGroupMembers).join(', ')
      : ''
  } catch { evalGroupMembersText.value = form.value.evalGroupMembers || '' }
}
onMounted(fetch)

watch(courseMembersText, (v) => {
  form.value.courseMembers = JSON.stringify(v.split(',').map(s => s.trim()).filter(Boolean))
})
watch(evalGroupMembersText, (v) => {
  form.value.evalGroupMembers = JSON.stringify(v.split(',').map(s => s.trim()).filter(Boolean))
})

const onSave = async () => {
  await qualityEvalApi.save(eval_.value.evaluationId, form.value)
  ElMessage.success('草稿已保存')
  fetch()
}
const onFinalize = async () => {
  await qualityEvalApi.finalize(eval_.value.evaluationId)
  ElMessage.success('已终稿，自动生成达成度快照')
  fetch()
}
const goReports = () => router.push(`/teacher/reports/${offeringId.value}`)
</script>

<style scoped>
.evaluation-form-page { padding: 20px; }
.card-header { display: flex; justify-content: space-between; align-items: center; }
.title { font-weight: 600; font-size: 16px; }
.mt-4 { margin-top: 16px; }
.ml-2 { margin-left: 8px; }
</style>
