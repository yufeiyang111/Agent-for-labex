<template>
  <div class="syllabus-editor-page">
    <el-page-header @back="$router.back()" :content="`课程大纲：${course?.nameCn || ''} (${course?.code || ''})`" />

    <el-tabs v-model="activeTab" class="mt-4" type="border-card" v-loading="loading">
      <!-- 一、基本信息 -->
      <el-tab-pane label="一、基本信息" name="basic">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="课程编号">{{ course?.code }}</el-descriptions-item>
          <el-descriptions-item label="中文名">{{ course?.nameCn }}</el-descriptions-item>
          <el-descriptions-item label="英文名">{{ course?.nameEn }}</el-descriptions-item>
          <el-descriptions-item label="学分">{{ course?.credit }}</el-descriptions-item>
          <el-descriptions-item label="总学时">{{ course?.hours }}</el-descriptions-item>
          <el-descriptions-item label="理论/实验学时">{{ course?.theoryHours }} / {{ course?.labHours }}</el-descriptions-item>
          <el-descriptions-item label="适用专业">{{ course?.major }}</el-descriptions-item>
          <el-descriptions-item label="先修课程">{{ course?.prerequisite }}</el-descriptions-item>
          <el-descriptions-item label="开课系" :span="2">{{ course?.department }}</el-descriptions-item>
        </el-descriptions>
        <el-form label-width="120" class="mt-4">
          <el-form-item label="课程简介">
            <el-input v-model="syllabus.courseIntro" type="textarea" :rows="3" placeholder="对课程的总体描述..." />
          </el-form-item>
        </el-form>
      </el-tab-pane>

      <!-- 二、课程目标 -->
      <el-tab-pane label="二、课程目标" name="objectives">
        <el-alert type="info" :closable="false" class="mb-3">
          完整的目标和支撑关系矩阵请前往
          <el-link type="primary" @click="goObjective">课程目标管理</el-link>
          页面配置。本节用于大纲文本展示。
        </el-alert>
        <el-form label-width="120">
          <el-form-item label="主要任务">
            <el-input v-model="syllabus.mainTask" type="textarea" :rows="2" />
          </el-form-item>
          <el-form-item label="知识目标">
            <el-input v-model="syllabus.knowledgeGoals" type="textarea" :rows="3" />
          </el-form-item>
          <el-form-item label="能力目标">
            <el-input v-model="syllabus.abilityGoals" type="textarea" :rows="3" />
          </el-form-item>
          <el-form-item label="素质目标">
            <el-input v-model="syllabus.qualityGoals" type="textarea" :rows="3" />
          </el-form-item>
        </el-form>
      </el-tab-pane>

      <!-- 三、教学内容（章节） -->
      <el-tab-pane label="三、教学内容" name="chapters">
        <div class="mb-2"><el-button type="primary" @click="onAddChapter">新增章节</el-button></div>
        <el-table :data="chapters" stripe>
          <el-table-column prop="chapterNo" label="章节号" width="100" />
          <el-table-column prop="topic" label="教学内容" min-width="180" />
          <el-table-column prop="knowledgeRequirements" label="知识/能力要求" min-width="200" show-overflow-tooltip />
          <el-table-column prop="recommendedHours" label="学时" width="80" align="center" />
          <el-table-column prop="teachingMethod" label="教学方式" width="100" align="center" />
          <el-table-column prop="objectiveRef" label="对应目标" width="140" />
          <el-table-column label="操作" width="140" fixed="right">
            <template #default="{ row }">
              <el-button size="small" @click="onEditChapter(row)">编辑</el-button>
              <el-button size="small" type="danger" @click="onDeleteChapter(row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>

      <!-- 四、实践教学 -->
      <el-tab-pane label="四、实践教学" name="practice">
        <el-alert type="info" :closable="false">
          实践教学安排关联开课实例下的实验项目（t_experiment），请到「实验管理」配置。
        </el-alert>
      </el-tab-pane>

      <!-- 五、教学方法与习题 -->
      <el-tab-pane label="五、教学方法" name="methods">
        <el-form label-width="120">
          <el-form-item label="教学方法"><el-input v-model="syllabus.teachingMethods" type="textarea" :rows="4" placeholder="课堂讲授 + 实验教学 + 习题..." /></el-form-item>
          <el-form-item label="习题要求"><el-input v-model="syllabus.exerciseRequirements" type="textarea" :rows="3" /></el-form-item>
        </el-form>
      </el-tab-pane>

      <!-- 六、考核方式 -->
      <el-tab-pane label="六、考核方式" name="assessment">
        <el-form label-width="120">
          <el-form-item label="考核方式说明"><el-input v-model="syllabus.assessmentMethods" type="textarea" :rows="4" placeholder="平时作业 + 实验 + 期末考试 ..." /></el-form-item>
        </el-form>
        <el-alert type="info" :closable="false">具体评分项与权重，请在开课实例下「评分项配置」中设置。</el-alert>
      </el-tab-pane>

      <!-- 七、达成度公式 -->
      <el-tab-pane label="七、达成度公式" name="formula">
        <el-alert type="success" :closable="false">
          <strong>课程分目标达成度</strong> = 加权得分 / 加权期望分（参考 Excel 行 154）<br/>
          <strong>课程总目标达成度</strong> = 达到期望分值的学生人数 / 学生总人数（班级层）
        </el-alert>
        <el-form-item label="自定义说明" label-width="120" class="mt-4">
          <el-input v-model="syllabus.achievementFormula" type="textarea" :rows="3" />
        </el-form-item>
      </el-tab-pane>

      <!-- 八、教材参考书 -->
      <el-tab-pane label="八、教材参考书" name="books">
        <el-form label-width="120">
          <el-form-item label="推荐教材"><el-input v-model="syllabus.textbooks" type="textarea" :rows="4" /></el-form-item>
          <el-form-item label="参考书"><el-input v-model="syllabus.referencesList" type="textarea" :rows="4" /></el-form-item>
        </el-form>
      </el-tab-pane>

      <!-- 九、学时分配 -->
      <el-tab-pane label="九、学时分配" name="hours">
        <el-table :data="chapters">
          <el-table-column prop="chapterNo" label="章节号" width="100" />
          <el-table-column prop="topic" label="教学内容" />
          <el-table-column prop="recommendedHours" label="推荐学时" width="120" align="center" />
          <el-table-column prop="teachingMethod" label="教学方式" width="120" align="center" />
        </el-table>
        <div class="hours-summary mt-2">
          <el-tag>合计：{{ totalHours }} 学时</el-tag>
        </div>
      </el-tab-pane>
    </el-tabs>

    <div class="footer mt-4">
      <el-button type="primary" size="large" @click="onSave">保存大纲</el-button>
    </div>

    <!-- 章节编辑弹窗 -->
    <el-dialog v-model="chapterDialogVisible" :title="editingChapter.chapterId ? '编辑章节' : '新增章节'" width="700">
      <el-form :model="editingChapter" label-width="120">
        <el-form-item label="章节号"><el-input v-model="editingChapter.chapterNo" placeholder="如：第一章" /></el-form-item>
        <el-form-item label="教学内容"><el-input v-model="editingChapter.topic" /></el-form-item>
        <el-form-item label="知识/能力要求"><el-input v-model="editingChapter.knowledgeRequirements" type="textarea" :rows="3" /></el-form-item>
        <el-form-item label="思政元素"><el-input v-model="editingChapter.ideologicalElements" type="textarea" :rows="2" /></el-form-item>
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="推荐学时"><el-input-number v-model="editingChapter.recommendedHours" :min="0" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="教学方式">
            <el-select v-model="editingChapter.teachingMethod" placeholder="选择">
              <el-option label="讲授" value="讲授" />
              <el-option label="实验" value="实验" />
              <el-option label="上机" value="上机" />
              <el-option label="实践" value="实践" />
            </el-select>
          </el-form-item></el-col>
        </el-row>
        <el-form-item label="对应课程目标"><el-input v-model="editingChapter.objectiveRef" placeholder="如：课程目标1,课程目标2" /></el-form-item>
        <el-form-item label="排序"><el-input-number v-model="editingChapter.sortOrder" :min="0" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="chapterDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="onSaveChapter">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { courseApi, syllabusApi } from '@/api'

const route = useRoute()
const router = useRouter()
const courseId = computed(() => Number(route.params.id))

const course = ref(null)
const syllabus = ref({})
const chapters = ref([])
const activeTab = ref('basic')
const loading = ref(false)
const chapterDialogVisible = ref(false)
const editingChapter = ref({})

const totalHours = computed(() =>
  chapters.value.reduce((sum, c) => sum + (c.recommendedHours || 0), 0)
)

const fetch = async () => {
  loading.value = true
  try {
    const [c, s] = await Promise.all([
      courseApi.detail(courseId.value),
      syllabusApi.get(courseId.value)
    ])
    course.value = c.data
    syllabus.value = s.data?.syllabus || {}
    chapters.value = s.data?.chapters || []
  } finally {
    loading.value = false
  }
}
onMounted(fetch)

const onSave = async () => {
  await syllabusApi.save(courseId.value, syllabus.value)
  ElMessage.success('大纲已保存')
}

const onAddChapter = () => {
  editingChapter.value = { chapterNo: '', topic: '', recommendedHours: 2, teachingMethod: '讲授', sortOrder: chapters.value.length }
  chapterDialogVisible.value = true
}
const onEditChapter = (row) => { editingChapter.value = { ...row }; chapterDialogVisible.value = true }
const onSaveChapter = async () => {
  if (editingChapter.value.chapterId) {
    await syllabusApi.updateChapter(editingChapter.value.chapterId, editingChapter.value)
  } else {
    await syllabusApi.addChapter(syllabus.value.syllabusId, editingChapter.value)
  }
  chapterDialogVisible.value = false
  ElMessage.success('章节已保存')
  fetch()
}
const onDeleteChapter = async (row) => {
  await ElMessageBox.confirm(`确定删除「${row.topic}」?`, '确认')
  await syllabusApi.deleteChapter(row.chapterId)
  ElMessage.success('已删除')
  fetch()
}
const goObjective = () => router.push(`/teacher/objective/${courseId.value}`)
</script>

<style scoped>
.syllabus-editor-page { padding: 20px; }
.mt-4 { margin-top: 16px; }
.mt-2 { margin-top: 8px; }
.mb-3 { margin-bottom: 12px; }
.mb-2 { margin-bottom: 8px; }
.hours-summary { text-align: right; }
.footer { text-align: center; }
</style>
