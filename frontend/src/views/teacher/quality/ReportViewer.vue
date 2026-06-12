<template>
  <div class="report-viewer-page">
    <el-page-header @back="$router.back()" :content="`课程评价 4 张报告 - 开课ID ${offeringId}`" />

    <el-tabs v-model="activeTab" type="border-card" class="mt-4">
      <el-tab-pane label="1. 成绩统计表" name="grade-stat">
        <div class="report-toolbar">
          <el-button :icon="Download" @click="onExport('GRADE_STAT')">导出 Excel</el-button>
        </div>
        <el-descriptions :column="2" border v-loading="loadings.gradeStat">
          <el-descriptions-item label="教研室">{{ gradeStat.department || '-' }}</el-descriptions-item>
          <el-descriptions-item label="课程名称">{{ gradeStat.courseName || '-' }}</el-descriptions-item>
          <el-descriptions-item label="授课班级">{{ gradeStat.clazzNo || '-' }}</el-descriptions-item>
          <el-descriptions-item label="任课教师">{{ gradeStat.teacherName || '-' }}</el-descriptions-item>
          <el-descriptions-item label="期望值">{{ gradeStat.expectedValue }}</el-descriptions-item>
          <el-descriptions-item label="及格率">{{ gradeStat.passingRate }} %</el-descriptions-item>
          <el-descriptions-item label="平均分">{{ gradeStat.avgScore }}</el-descriptions-item>
          <el-descriptions-item label="最高/最低">{{ gradeStat.maxScore }} / {{ gradeStat.minScore }}</el-descriptions-item>
          <el-descriptions-item label="是否达到期望">
            <el-tag :type="gradeStat.reachedExpected ? 'success' : 'danger'">{{ gradeStat.reachedExpected ? '是' : '否' }}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="是否正态分布">
            <el-tag :type="gradeStat.normalDistribution ? 'success' : 'warning'">{{ gradeStat.normalDistribution ? '是' : '否' }}</el-tag>
          </el-descriptions-item>
        </el-descriptions>
        <el-table :data="gradeStat.distribution" class="mt-3" stripe>
          <el-table-column prop="range" label="分数段" align="center" />
          <el-table-column prop="count" label="人数" align="center" />
          <el-table-column prop="percent" label="百分比 (%)" align="center" />
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="2. 考核合理性审核表" name="consistency">
        <div class="report-toolbar">
          <el-button :icon="Download" @click="onExport('CONSISTENCY')">导出 Excel</el-button>
        </div>
        <el-descriptions :column="2" border v-loading="loadings.consistency">
          <el-descriptions-item label="课程名称">{{ consistency.courseName }}</el-descriptions-item>
          <el-descriptions-item label="授课学时">{{ consistency.teachingHours }}</el-descriptions-item>
          <el-descriptions-item label="课程学分">{{ consistency.courseCredit }}</el-descriptions-item>
          <el-descriptions-item label="开课学期">{{ consistency.semester }}</el-descriptions-item>
          <el-descriptions-item label="授课对象">{{ consistency.teachingTarget }}</el-descriptions-item>
          <el-descriptions-item label="授课人数">{{ consistency.studentCount }}</el-descriptions-item>
        </el-descriptions>
        <el-table :data="consistency.rows" class="mt-3" stripe>
          <el-table-column prop="objectiveCode" label="课程目标" width="120" />
          <el-table-column prop="objectiveDescription" label="目标描述" />
          <el-table-column prop="assessmentContent" label="考核内容" />
          <el-table-column prop="assessmentMethod" label="考核方式" width="120" />
          <el-table-column prop="assessmentScore" label="考核分值" width="100" align="center" />
          <el-table-column prop="rationalityComment" label="合理性意见" width="120" align="center" />
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="3. 达成情况评价报告" name="attainment">
        <div class="report-toolbar">
          <el-button :icon="Download" @click="onExport('ATTAINMENT')">导出 Excel</el-button>
        </div>
        <h3>一、课程基本信息</h3>
        <el-descriptions :column="2" border v-if="attainment.basicInfo" v-loading="loadings.attainment">
          <el-descriptions-item label="课程名称">{{ attainment.basicInfo.courseName }}</el-descriptions-item>
          <el-descriptions-item label="学期">{{ attainment.basicInfo.semester }}</el-descriptions-item>
          <el-descriptions-item label="理论学时">{{ attainment.basicInfo.theoryHours }}</el-descriptions-item>
          <el-descriptions-item label="实验学时">{{ attainment.basicInfo.labHours }}</el-descriptions-item>
          <el-descriptions-item label="任课教师">{{ attainment.basicInfo.teacherName }}</el-descriptions-item>
          <el-descriptions-item label="授课班级">{{ attainment.basicInfo.clazzNo }}</el-descriptions-item>
          <el-descriptions-item label="学生人数" :span="2">{{ attainment.basicInfo.studentCount }}</el-descriptions-item>
        </el-descriptions>

        <h3 class="mt-3">二、课程目标 ↔ 毕业要求对应关系</h3>
        <el-table :data="attainment.objectiveSupports || []" stripe>
          <el-table-column prop="objectiveCode" label="课程目标" width="120" />
          <el-table-column prop="objectiveDescription" label="描述" />
          <el-table-column prop="supportedRequirements" label="支撑要求" width="120" />
          <el-table-column prop="supportedIndicators" label="支撑指标点" width="160" />
          <el-table-column prop="attainmentMethod" label="达成途径" width="200" />
        </el-table>

        <h3 class="mt-3">五、各课程目标达成情况</h3>
        <el-table :data="attainment.objectiveAttainment || []" stripe border>
          <el-table-column prop="objectiveCode" label="目标" width="120" />
          <el-table-column prop="assessmentLink" label="考核环节" />
          <el-table-column prop="weight" label="权重" width="80" align="center" />
          <el-table-column prop="avgScore" label="平均得分" width="100" align="center">
            <template #default="{ row }">{{ (Number(row.avgScore) * 100).toFixed(2) }}%</template>
          </el-table-column>
          <el-table-column prop="reachedCount" label="达到人数" width="100" align="center" />
          <el-table-column prop="totalCount" label="总人数" width="100" align="center" />
          <el-table-column label="达成度" width="120" align="center">
            <template #default="{ row }">
              <el-tag :type="Number(row.attainmentValue) >= 0.7 ? 'success' : 'warning'">
                {{ (Number(row.attainmentValue) * 100).toFixed(2) }}%
              </el-tag>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="4. 课程质量评价表" name="quality">
        <div class="report-toolbar">
          <el-button :icon="Download" @click="onExport('QUALITY')">导出 Excel</el-button>
        </div>
        <el-empty v-if="!quality.courseName" description="请先在「质量评价」页面填写评价表" />
        <div v-else v-loading="loadings.quality">
          <el-descriptions :column="2" border>
            <el-descriptions-item label="课程名称">{{ quality.courseName }}</el-descriptions-item>
            <el-descriptions-item label="开课学期">{{ quality.semester }}</el-descriptions-item>
            <el-descriptions-item label="授课学时">{{ quality.teachingHours }}</el-descriptions-item>
            <el-descriptions-item label="课程学分">{{ quality.courseCredit }}</el-descriptions-item>
            <el-descriptions-item label="课程负责人">{{ quality.courseResponsible }}</el-descriptions-item>
            <el-descriptions-item label="授课人数">{{ quality.studentCount }}</el-descriptions-item>
            <el-descriptions-item label="课程组成员" :span="2">{{ (quality.courseMembers || []).join(', ') }}</el-descriptions-item>
            <el-descriptions-item label="评价小组成员" :span="2">{{ (quality.evalGroupMembers || []).join(', ') }}</el-descriptions-item>
          </el-descriptions>
          <el-table :data="qualityRows" class="mt-3" stripe>
            <el-table-column prop="category" label="评价项目" width="180" />
            <el-table-column prop="criteria" label="评价依据" />
            <el-table-column prop="result" label="评价结果" width="180" />
          </el-table>
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Download } from '@element-plus/icons-vue'
import { qualityReportApi, qualityEvalApi } from '@/api'

const route = useRoute()
const offeringId = computed(() => Number(route.params.offeringId))

const activeTab = ref('grade-stat')
const gradeStat = reactive({})
const consistency = reactive({ rows: [] })
const attainment = reactive({ objectiveSupports: [], objectiveAttainment: [] })
const quality = reactive({})
const evaluationId = ref(null)
const loadings = reactive({ gradeStat: false, consistency: false, attainment: false, quality: false })

const rationalityText = (v) => ({ reasonable: '合理', relatively: '比较合理', unreasonable: '不合理' }[v] || '未填写')
const containsText = (v) => ({ contain: '包含', partial: '部分包含', none: '不包含' }[v] || '未填写')

const qualityRows = computed(() => [
  { category: '课程目标合理性', criteria: '目标与指标点的对应关系是否合理', result: rationalityText(quality.objectiveIndicatorRationality) },
  { category: '课程目标合理性', criteria: '是否包含知识/能力/素质目标', result: containsText(quality.objectiveContainsKaq) },
  { category: '课程目标达成情况', criteria: '各课程目标达成值', result: JSON.stringify(quality.attainmentValues || {}) },
  { category: '课程目标达成情况', criteria: '期望值合理性', result: rationalityText(quality.expectedRationality) },
  { category: '课程目标达成情况', criteria: '分析合理性', result: rationalityText(quality.analysisRationality) },
  { category: '课程目标达成情况', criteria: '改进措施合理性', result: rationalityText(quality.improvementRationality) }
])

const fetchAll = async () => {
  // 取评价 ID
  const evalRes = await qualityEvalApi.latest(offeringId.value)
  evaluationId.value = evalRes.data?.evaluationId

  loadings.gradeStat = true
  qualityReportApi.gradeStat(offeringId.value).then(r => Object.assign(gradeStat, r.data || {})).finally(() => loadings.gradeStat = false)

  loadings.consistency = true
  qualityReportApi.consistency(offeringId.value).then(r => Object.assign(consistency, r.data || {})).finally(() => loadings.consistency = false)

  loadings.attainment = true
  qualityReportApi.attainment(offeringId.value, evaluationId.value).then(r => Object.assign(attainment, r.data || {})).finally(() => loadings.attainment = false)

  if (evaluationId.value) {
    loadings.quality = true
    qualityReportApi.quality(evaluationId.value).then(r => Object.assign(quality, r.data || {})).finally(() => loadings.quality = false)
  }
}
onMounted(fetchAll)

const onExport = async (type) => {
  try {
    const blob = await qualityReportApi.download(offeringId.value, type, 'excel', evaluationId.value)
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    const names = { GRADE_STAT: '成绩统计表', CONSISTENCY: '考核合理性审核表', ATTAINMENT: '达成情况评价报告', QUALITY: '课程质量评价表' }
    a.href = url
    a.download = `${names[type]}-${offeringId.value}.xlsx`
    a.click()
    URL.revokeObjectURL(url)
    ElMessage.success('已下载')
  } catch (e) {
    ElMessage.error('导出失败：' + e.message)
  }
}
</script>

<style scoped>
.report-viewer-page { padding: 20px; }
.mt-4 { margin-top: 16px; }
.mt-3 { margin-top: 12px; }
.report-toolbar { margin-bottom: 12px; text-align: right; }
</style>
