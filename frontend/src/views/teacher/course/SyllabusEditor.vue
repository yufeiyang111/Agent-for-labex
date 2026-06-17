<template>
  <div class="syllabus-editor wabi-page">
    <!-- 页面头部 -->
    <div class="wabi-header">
      <div class="header-left">
        <el-button :icon="ArrowLeft" @click="$router.back()" text class="wabi-btn-text">返回</el-button>
        <div class="header-info">
          <h1 class="wabi-title">课程大纲</h1>
          <span class="wabi-subtitle">{{ course?.code }} · {{ course?.nameCn }}</span>
        </div>
      </div>
      <div class="header-actions">
        <el-button
          type="primary"
          plain
          @click="onAiGenerateAll"
          :loading="aiLoading.all"
          :icon="MagicStick"
          class="wabi-btn-ghost ai-btn"
        >
          AI 一键生成
        </el-button>
        <span class="wabi-divider-v"></span>
        <el-button @click="onPreview" :icon="View" class="wabi-btn-ghost">预览</el-button>
        <el-button @click="onDownload" :icon="Download" class="wabi-btn-ghost">下载</el-button>
        <el-button type="primary" @click="onSave" :icon="Check" :loading="saving" class="wabi-btn-primary">保存</el-button>
      </div>
    </div>

    <!-- 主体内容 -->
    <div class="editor-body">
      <!-- 左侧导航 -->
      <div class="wabi-side-nav">
        <div
          v-for="section in sections"
          :key="section.key"
          class="wabi-nav-item"
          :class="{ active: activeSection === section.key }"
          @click="activeSection = section.key"
        >
          <span class="wabi-nav-index">{{ section.index }}</span>
          <span class="nav-label">{{ section.label }}</span>
        </div>
      </div>

      <!-- 右侧内容区 -->
      <div class="content-area" v-loading="loading">
        <!-- AI一键生成提示 -->
        <div v-if="!syllabus.courseIntro && chapters.length === 0" class="wabi-alert wabi-alert-info ai-hint">
          <div class="ai-hint-content">
            <span>大纲内容为空，可使用 AI 一键生成完整大纲</span>
            <el-button
              type="primary"
              size="small"
              @click="onAiGenerateFull"
              :loading="aiLoading.full"
              class="wabi-btn-primary"
            >
              一键生成
            </el-button>
          </div>
        </div>

        <!-- 一、基本信息 -->
        <section v-show="activeSection === 'basic'" class="wabi-field-group">
          <h2 class="section-title">一、基本信息</h2>
          <div class="wabi-card">
            <div class="wabi-card-content">
              <div class="info-grid">
                <div class="info-item">
                  <span class="info-label">课程编号</span>
                  <span class="info-value">{{ course?.code || '-' }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">中文名称</span>
                  <span class="info-value">{{ course?.nameCn || '-' }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">英文名称</span>
                  <span class="info-value">{{ course?.nameEn || '-' }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">学分</span>
                  <span class="info-value">{{ course?.credit || '-' }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">总学时</span>
                  <span class="info-value">{{ course?.hours || '-' }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">理论/实验</span>
                  <span class="info-value">{{ course?.theoryHours || 0 }} / {{ course?.labHours || 0 }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">适用专业</span>
                  <span class="info-value">{{ course?.major || '-' }}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">先修课程</span>
                  <span class="info-value">{{ course?.prerequisite || '-' }}</span>
                </div>
                <div class="info-item full-width">
                  <span class="info-label">开课系</span>
                  <span class="info-value">{{ course?.department || '-' }}</span>
                </div>
              </div>
            </div>
          </div>

          <div class="wabi-field-group">
            <div class="wabi-field-header">
              <label class="wabi-field-label">课程简介</label>
              <el-button
                size="small"
                type="primary"
                plain
                @click="onAiGenerate('intro')"
                :loading="aiLoading.intro"
                class="wabi-btn-ghost"
              >
                AI 生成
              </el-button>
            </div>
            <el-input
              v-model="syllabus.courseIntro"
              type="textarea"
              :rows="4"
              placeholder="对课程的总体描述，包含课程性质、主要内容、学习意义等..."
              resize="vertical"
            />
          </div>
        </section>

        <!-- 二、课程目标 -->
        <section v-show="activeSection === 'objectives'" class="wabi-field-group">
          <div class="section-header">
            <h2 class="section-title">二、课程目标</h2>
            <el-button size="small" @click="goObjective" class="wabi-btn-ghost">前往目标管理</el-button>
          </div>

          <div class="wabi-field-group">
            <div class="wabi-field-header">
              <label class="wabi-field-label">主要任务</label>
              <el-button size="small" type="primary" plain @click="onAiGenerate('mainTask')" :loading="aiLoading.mainTask" class="wabi-btn-ghost">
                AI 生成
              </el-button>
            </div>
            <el-input v-model="syllabus.mainTask" type="textarea" :rows="3" placeholder="本课程的主要教学任务..." resize="vertical" />
          </div>

          <div class="wabi-field-group">
            <div class="wabi-field-header">
              <label class="wabi-field-label">知识目标</label>
              <el-button size="small" type="primary" plain @click="onAiGenerateGoals('knowledge')" :loading="aiLoading.knowledgeGoals" class="wabi-btn-ghost">
                AI 生成
              </el-button>
            </div>
            <el-input v-model="syllabus.knowledgeGoals" type="textarea" :rows="3" placeholder="学生应掌握的知识..." resize="vertical" />
          </div>

          <div class="wabi-field-group">
            <div class="wabi-field-header">
              <label class="wabi-field-label">能力目标</label>
              <el-button size="small" type="primary" plain @click="onAiGenerateGoals('ability')" :loading="aiLoading.abilityGoals" class="wabi-btn-ghost">
                AI 生成
              </el-button>
            </div>
            <el-input v-model="syllabus.abilityGoals" type="textarea" :rows="3" placeholder="学生应具备的能力..." resize="vertical" />
          </div>

          <div class="wabi-field-group">
            <div class="wabi-field-header">
              <label class="wabi-field-label">素质目标</label>
              <el-button size="small" type="primary" plain @click="onAiGenerateGoals('quality')" :loading="aiLoading.qualityGoals" class="wabi-btn-ghost">
                AI 生成
              </el-button>
            </div>
            <el-input v-model="syllabus.qualityGoals" type="textarea" :rows="3" placeholder="学生应培养的素质..." resize="vertical" />
          </div>
        </section>

        <!-- 三、教学内容 -->
        <section v-show="activeSection === 'chapters'" class="wabi-field-group">
          <div class="section-header">
            <h2 class="section-title">三、教学内容</h2>
            <div class="header-btns">
              <el-button type="primary" plain size="small" @click="onAiGenerateChapters" :loading="aiLoading.chapters" class="wabi-btn-ghost">
                AI 生成章节
              </el-button>
              <el-button type="primary" size="small" @click="onAddChapter" class="wabi-btn-primary">
                新增章节
              </el-button>
            </div>
          </div>

          <div v-if="chapters.length === 0" class="wabi-empty">
            <div class="wabi-empty-icon">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                <path d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
              </svg>
            </div>
            <p class="wabi-empty-text">暂无章节内容</p>
            <el-button type="primary" @click="onAiGenerateChapters" :loading="aiLoading.chapters" class="wabi-btn-primary">
              AI 一键生成
            </el-button>
          </div>

          <div v-else class="chapter-list-container">
            <div class="chapter-list">
              <div v-for="(chapter, index) in paginatedChapters" :key="chapter.chapterId" class="chapter-card wabi-card">
                <div class="chapter-card-header">
                  <div class="chapter-no-badge">{{ chapter.chapterNo || `第${(chapterPagination.page - 1) * chapterPagination.pageSize + index + 1}章` }}</div>
                  <div class="chapter-card-body">
                    <div class="chapter-main">
                      <h4 class="chapter-topic">{{ chapter.topic }}</h4>
                      <div class="chapter-tags">
                        <span class="wabi-tag">{{ chapter.recommendedHours || 0 }} 学时</span>
                        <span class="wabi-tag">{{ chapter.teachingMethod || '讲授' }}</span>
                        <span v-if="chapter.objectiveRef" class="wabi-tag wabi-tag-accent">{{ chapter.objectiveRef }}</span>
                      </div>
                    </div>
                    <div class="chapter-actions">
                      <el-button size="small" text @click="onEditChapter(chapter)" class="wabi-btn-text">编辑</el-button>
                      <el-button size="small" text type="danger" @click="onDeleteChapter(chapter)" class="wabi-btn-text wabi-btn-danger">删除</el-button>
                    </div>
                  </div>
                </div>
                <div class="chapter-snippets">
                  <div class="snippet-item">
                    <span class="snippet-label">知识能力要求：</span>
                    <span class="snippet-text">{{ chapter.knowledgeRequirements || '暂未填写' }}</span>
                  </div>
                  <div class="snippet-item">
                    <span class="snippet-label">思政元素：</span>
                    <span class="snippet-text">{{ chapter.ideologicalElements || '暂未填写' }}</span>
                  </div>
                </div>
              </div>
            </div>

            <!-- 分页（常驻显示） -->
            <div class="chapter-pagination">
              <el-pagination
                v-model:current-page="chapterPagination.page"
                v-model:page-size="chapterPagination.pageSize"
                :page-sizes="[5, 10, 20]"
                :total="chapters.length"
                layout="total, sizes, prev, pager, next"
                @size-change="handleChapterPageChange"
                @current-change="handleChapterPageChange"
              />
            </div>
          </div>
        </section>

        <!-- 四、实践教学 -->
        <section v-show="activeSection === 'practice'" class="wabi-field-group">
          <h2 class="section-title">四、实践教学</h2>
          <div class="wabi-alert wabi-alert-info">
            实践教学安排关联开课实例下的实验项目，请到「实验管理」页面配置具体实验内容。
          </div>
        </section>

        <!-- 五、教学方法 -->
        <section v-show="activeSection === 'methods'" class="wabi-field-group">
          <h2 class="section-title">五、教学方法与习题</h2>

          <div class="wabi-field-group">
            <div class="wabi-field-header">
              <label class="wabi-field-label">教学方法</label>
              <el-button size="small" type="primary" plain @click="onAiGenerate('methods')" :loading="aiLoading.methods" class="wabi-btn-ghost">
                AI 生成
              </el-button>
            </div>
            <el-input v-model="syllabus.teachingMethods" type="textarea" :rows="4" placeholder="课堂讲授、实验教学、案例分析、小组讨论等..." resize="vertical" />
          </div>

          <div class="wabi-field-group">
            <div class="wabi-field-header">
              <label class="wabi-field-label">习题要求</label>
              <el-button size="small" type="primary" plain @click="onAiGenerate('exerciseRequirements')" :loading="aiLoading.exerciseRequirements" class="wabi-btn-ghost">
                AI 生成
              </el-button>
            </div>
            <el-input v-model="syllabus.exerciseRequirements" type="textarea" :rows="3" placeholder="课后习题、作业要求..." resize="vertical" />
          </div>
        </section>

        <!-- 六、考核方式 -->
        <section v-show="activeSection === 'assessment'" class="wabi-field-group">
          <h2 class="section-title">六、考核方式</h2>

          <div class="wabi-field-group">
            <div class="wabi-field-header">
              <label class="wabi-field-label">考核方式说明</label>
              <el-button size="small" type="primary" plain @click="onAiGenerate('assessmentMethods')" :loading="aiLoading.assessmentMethods" class="wabi-btn-ghost">
                AI 生成
              </el-button>
            </div>
            <el-input v-model="syllabus.assessmentMethods" type="textarea" :rows="4" placeholder="平时作业 + 实验 + 期末考试 ..." resize="vertical" />
          </div>

          <div class="wabi-alert wabi-alert-info">
            具体评分项与权重，请在开课实例下「评分项配置」中设置。
          </div>
        </section>

        <!-- 七、达成度公式 -->
        <section v-show="activeSection === 'formula'" class="wabi-field-group">
          <h2 class="section-title">七、达成度公式</h2>

          <div class="wabi-card formula-card">
            <div class="wabi-card-content">
              <div class="formula-item">
                <span class="formula-label">课程分目标达成度</span>
                <span class="formula-eq">=</span>
                <span class="formula-desc">加权得分 / 加权期望分</span>
              </div>
              <div class="formula-item">
                <span class="formula-label">课程总目标达成度</span>
                <span class="formula-eq">=</span>
                <span class="formula-desc">达到期望分值的学生人数 / 学生总人数</span>
              </div>
            </div>
          </div>

          <div class="wabi-field-group">
            <div class="wabi-field-header">
              <label class="wabi-field-label">自定义说明</label>
              <el-button size="small" type="primary" plain @click="onAiGenerate('achievementFormula')" :loading="aiLoading.achievementFormula" class="wabi-btn-ghost">
                AI 生成
              </el-button>
            </div>
            <el-input v-model="syllabus.achievementFormula" type="textarea" :rows="3" placeholder="达成度计算的补充说明..." resize="vertical" />
          </div>
        </section>

        <!-- 八、教材参考书 -->
        <section v-show="activeSection === 'books'" class="wabi-field-group">
          <h2 class="section-title">八、教材与参考书</h2>

          <div class="wabi-field-group">
            <div class="wabi-field-header">
              <label class="wabi-field-label">推荐教材</label>
              <el-button size="small" type="primary" plain @click="onAiGenerate('textbooks')" :loading="aiLoading.textbooks" class="wabi-btn-ghost">
                AI 生成
              </el-button>
            </div>
            <el-input v-model="syllabus.textbooks" type="textarea" :rows="4" placeholder="教材名称、作者、出版社..." resize="vertical" />
          </div>

          <div class="wabi-field-group">
            <div class="wabi-field-header">
              <label class="wabi-field-label">参考书</label>
              <el-button size="small" type="primary" plain @click="onAiGenerate('referencesList')" :loading="aiLoading.referencesList" class="wabi-btn-ghost">
                AI 生成
              </el-button>
            </div>
            <el-input v-model="syllabus.referencesList" type="textarea" :rows="4" placeholder="参考书目..." resize="vertical" />
          </div>
        </section>

        <!-- 九、学时分配 -->
        <section v-show="activeSection === 'hours'" class="wabi-field-group">
          <h2 class="section-title">九、学时分配</h2>

          <div class="wabi-card">
            <el-table :data="chapters" class="wabi-table">
              <el-table-column prop="chapterNo" label="章节" width="100" />
              <el-table-column prop="topic" label="教学内容" />
              <el-table-column prop="recommendedHours" label="学时" width="100" align="center" />
              <el-table-column prop="teachingMethod" label="教学方式" width="120" align="center" />
            </el-table>
            <div class="hours-total">
              <span class="wabi-muted">合计学时</span>
              <span class="total-value">{{ totalHours }}</span>
            </div>
          </div>
        </section>
      </div>
    </div>

    <!-- PDF预览弹窗 -->
    <PdfPreviewDialog
      v-model="showPreview"
      title="课程大纲预览"
      :url="exportApi.syllabusPreviewUrl(courseId)"
      :downloadName="`课程大纲-${course?.code || courseId}.pdf`"
    />

    <!-- 章节编辑弹窗 -->
    <el-dialog
      v-model="chapterDialogVisible"
      :title="editingChapter.chapterId ? '编辑章节' : '新增章节'"
      width="600"
      class="wabi-dialog"
    >
      <el-form :model="editingChapter" label-width="100" class="wabi-form">
        <el-form-item label="章节号">
          <el-input v-model="editingChapter.chapterNo" placeholder="如：第一章" />
        </el-form-item>
        <el-form-item label="教学内容">
          <el-input v-model="editingChapter.topic" placeholder="章节主题" />
        </el-form-item>
        <el-form-item label="知识能力要求">
          <el-input v-model="editingChapter.knowledgeRequirements" type="textarea" :rows="3" placeholder="学生应掌握的知识和能力..." />
        </el-form-item>
        <el-form-item label="思政元素">
          <el-input v-model="editingChapter.ideologicalElements" type="textarea" :rows="2" placeholder="课程思政融入点..." />
        </el-form-item>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="推荐学时">
              <el-input-number v-model="editingChapter.recommendedHours" :min="0" :max="20" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="教学方式">
              <el-select v-model="editingChapter.teachingMethod">
                <el-option label="讲授" value="讲授" />
                <el-option label="实验" value="实验" />
                <el-option label="上机" value="上机" />
                <el-option label="实践" value="实践" />
                <el-option label="讨论" value="讨论" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="对应目标">
          <el-input v-model="editingChapter.objectiveRef" placeholder="如：课程目标1,课程目标2" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="chapterDialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="onSaveChapter" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, reactive } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { ArrowLeft, View, Download, Check, MagicStick } from '@element-plus/icons-vue'
import { courseApi, syllabusApi, aiAssistApi, exportApi } from '@/api'
import PdfPreviewDialog from '@/components/common/PdfPreviewDialog.vue'

const route = useRoute()
const router = useRouter()
const courseId = computed(() => Number(route.params.id))

// 数据
const course = ref(null)
const syllabus = ref({})
const chapters = ref([])
const activeSection = ref('basic')
const loading = ref(false)
const saving = ref(false)
const chapterDialogVisible = ref(false)
const editingChapter = ref({})
const showPreview = ref(false)

// 章节分页
const chapterPagination = reactive({
  page: 1,
  pageSize: 5
})

// 分页后的章节列表
const paginatedChapters = computed(() => {
  const start = (chapterPagination.page - 1) * chapterPagination.pageSize
  const end = start + chapterPagination.pageSize
  return chapters.value.slice(start, end)
})

// 章节分页变化
const handleChapterPageChange = () => {
  // 分页变化时自动滚动到顶部
  const container = document.querySelector('.chapter-list')
  if (container) {
    container.scrollTop = 0
  }
}

// 截断文本
const truncateText = (text, maxLen) => {
  if (!text) return ''
  if (text.length <= maxLen) return text
  return text.substring(0, maxLen) + '...'
}

// AI加载状态
const aiLoading = reactive({
  all: false,
  full: false,
  intro: false,
  mainTask: false,
  knowledgeGoals: false,
  abilityGoals: false,
  qualityGoals: false,
  chapters: false,
  methods: false,
  exerciseRequirements: false,
  assessmentMethods: false,
  achievementFormula: false,
  textbooks: false,
  referencesList: false
})

// 左侧导航
const sections = [
  { key: 'basic', index: '一', label: '基本信息' },
  { key: 'objectives', index: '二', label: '课程目标' },
  { key: 'chapters', index: '三', label: '教学内容' },
  { key: 'practice', index: '四', label: '实践教学' },
  { key: 'methods', index: '五', label: '教学方法' },
  { key: 'assessment', index: '六', label: '考核方式' },
  { key: 'formula', index: '七', label: '达成度公式' },
  { key: 'books', index: '八', label: '教材参考书' },
  { key: 'hours', index: '九', label: '学时分配' }
]

// 计算总学时
const totalHours = computed(() =>
  chapters.value.reduce((sum, c) => sum + (c.recommendedHours || 0), 0)
)

// 获取数据
const fetchData = async () => {
  loading.value = true
  try {
    const [c, s] = await Promise.all([
      courseApi.detail(courseId.value),
      syllabusApi.get(courseId.value)
    ])
    course.value = c.data
    syllabus.value = s.data?.syllabus || {}
    chapters.value = s.data?.chapters || []
    // 调试：打印第一个章节的数据结构
    if (chapters.value.length > 0) {
      console.log('章节数据结构:', chapters.value[0])
      console.log('knowledgeRequirements:', chapters.value[0].knowledgeRequirements)
      console.log('knowledge_requirements:', chapters.value[0].knowledge_requirements)
      console.log('ideologicalElements:', chapters.value[0].ideologicalElements)
      console.log('ideological_elements:', chapters.value[0].ideological_elements)
    }
  } finally {
    loading.value = false
  }
}

onMounted(fetchData)

// 保存大纲
const onSave = async () => {
  saving.value = true
  try {
    await syllabusApi.save(courseId.value, syllabus.value)
    ElMessage.success('大纲已保存')
  } finally {
    saving.value = false
  }
}

// AI生成：完整大纲
const onAiGenerateFull = async () => {
  aiLoading.full = true
  try {
    const res = await aiAssistApi.syllabusFull(courseId.value)
    if (res.data) {
      // 后端已将数据写入数据库，重新加载即可获取最新内容
      await fetchData()
      ElMessage.success('AI 已生成完整大纲')
    }
  } catch (e) {
    ElMessage.error('AI 生成失败：' + (e.message || '未知错误'))
  } finally {
    aiLoading.full = false
  }
}

// AI一键生成所有内容
const onAiGenerateAll = async () => {
  aiLoading.all = true
  try {
    const res = await aiAssistApi.syllabusFull(courseId.value)
    if (res.data) {
      // 后端已将数据写入数据库，重新加载即可获取最新内容
      await fetchData()
      ElMessage.success('AI 已一键生成所有大纲内容')
    }
  } catch (e) {
    ElMessage.error('AI 生成失败：' + (e.message || '未知错误'))
  } finally {
    aiLoading.all = false
  }
}

// AI生成：单个字段
const onAiGenerate = async (field) => {
  const apiMap = {
    intro: () => aiAssistApi.syllabusIntro(courseId.value),
    mainTask: () => aiAssistApi.syllabusMainTask(courseId.value),
    methods: () => aiAssistApi.syllabusMethods(courseId.value),
    exerciseRequirements: () => aiAssistApi.syllabusExerciseRequirements(courseId.value),
    assessmentMethods: () => aiAssistApi.syllabusAssessmentMethods(courseId.value),
    achievementFormula: () => aiAssistApi.syllabusAchievementFormula(courseId.value),
    textbooks: () => aiAssistApi.syllabusTextbooks(courseId.value),
    referencesList: () => aiAssistApi.syllabusReferencesList(courseId.value)
  }

  const fieldMap = {
    intro: 'courseIntro',
    mainTask: 'mainTask',
    methods: 'teachingMethods',
    exerciseRequirements: 'exerciseRequirements',
    assessmentMethods: 'assessmentMethods',
    achievementFormula: 'achievementFormula',
    textbooks: 'textbooks',
    referencesList: 'referencesList'
  }

  if (!apiMap[field]) return

  aiLoading[field] = true
  try {
    const res = await apiMap[field]()
    if (res.data?.content) {
      syllabus.value[fieldMap[field]] = res.data.content
      ElMessage.success('AI 已生成')
    }
  } catch (e) {
    ElMessage.error('AI 生成失败：' + (e.message || '未知错误'))
  } finally {
    aiLoading[field] = false
  }
}

// AI生成：目标
const onAiGenerateGoals = async (type) => {
  const loadingKey = type + 'Goals'
  aiLoading[loadingKey] = true
  try {
    const res = await aiAssistApi.syllabusGoals(courseId.value, type)
    if (res.data?.content) {
      const fieldMap = {
        knowledge: 'knowledgeGoals',
        ability: 'abilityGoals',
        quality: 'qualityGoals'
      }
      syllabus.value[fieldMap[type]] = res.data.content
      ElMessage.success('AI 已生成')
    }
  } catch (e) {
    ElMessage.error('AI 生成失败：' + (e.message || '未知错误'))
  } finally {
    aiLoading[loadingKey] = false
  }
}

// AI生成：章节
const onAiGenerateChapters = async () => {
  aiLoading.chapters = true
  try {
    const res = await aiAssistApi.syllabusChapters(courseId.value)
    if (res.data) {
      chapters.value = res.data
      ElMessage.success('AI 已生成章节内容')
    }
  } catch (e) {
    ElMessage.error('AI 生成失败：' + (e.message || '未知错误'))
  } finally {
    aiLoading.chapters = false
  }
}

// 章节操作
const onAddChapter = () => {
  editingChapter.value = {
    chapterNo: `第${chapters.value.length + 1}章`,
    topic: '',
    recommendedHours: 2,
    teachingMethod: '讲授',
    sortOrder: chapters.value.length
  }
  chapterDialogVisible.value = true
}

const onEditChapter = (row) => {
  editingChapter.value = { ...row }
  chapterDialogVisible.value = true
}

const onSaveChapter = async () => {
  try {
    if (editingChapter.value.chapterId) {
      await syllabusApi.updateChapter(editingChapter.value.chapterId, editingChapter.value)
    } else {
      await syllabusApi.addChapter(syllabus.value.syllabusId, editingChapter.value)
    }
    chapterDialogVisible.value = false
    ElMessage.success('章节已保存')
    fetchData()
  } catch (e) {
    ElMessage.error('保存失败')
  }
}

const onDeleteChapter = async (row) => {
  await ElMessageBox.confirm(`确定删除「${row.topic}」?`, '确认删除')
  await syllabusApi.deleteChapter(row.chapterId)
  ElMessage.success('已删除')
  fetchData()
}

// 跳转目标管理
const goObjective = () => router.push(`/teacher/objective/${courseId.value}`)

// 预览PDF
const onPreview = () => {
  showPreview.value = true
}

// 下载PDF
const onDownload = async () => {
  try {
    const url = '/api' + exportApi.syllabusDownloadUrl(courseId.value)
    const resp = await fetch(url, {
      headers: { 'Authorization': `Bearer ${localStorage.getItem('token') || ''}` }
    })
    if (!resp.ok) throw new Error('下载失败')
    const blob = await resp.blob()
    const a = document.createElement('a')
    a.href = URL.createObjectURL(blob)
    a.download = `课程大纲-${course.value?.code || courseId.value}.pdf`
    a.click()
    URL.revokeObjectURL(a.href)
    ElMessage.success('下载成功')
  } catch (e) {
    ElMessage.error('下载失败：' + e.message)
  }
}
</script>

<style scoped>
.syllabus-editor {
  display: flex;
  flex-direction: column;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.header-info {
  display: flex;
  flex-direction: column;
}

.header-actions {
  display: flex;
  gap: 8px;
  align-items: center;
}

.ai-btn {
  position: relative;
  overflow: hidden;
}

.ai-btn::after {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: linear-gradient(
    45deg,
    transparent 30%,
    rgba(255, 255, 255, 0.1) 50%,
    transparent 70%
  );
  animation: ai-shimmer 3s infinite;
}

@keyframes ai-shimmer {
  0% { transform: translateX(-100%) rotate(45deg); }
  100% { transform: translateX(100%) rotate(45deg); }
}

/* 主体布局 */
.editor-body {
  flex: 1;
  display: flex;
  overflow: hidden;
}

/* 右侧内容区 */
.content-area {
  flex: 1;
  overflow-y: auto;
  padding: 32px;
  animation: wabi-fade-in 0.4s ease;
}

/* AI提示 */
.ai-hint {
  margin-bottom: 24px;
}

.ai-hint-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

/* 章节标题 */
.section-title {
  font-size: 16px;
  font-weight: 500;
  color: var(--wabi-text);
  margin: 0 0 20px 0;
  letter-spacing: 0.5px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.section-header .section-title {
  margin: 0;
}

.header-btns {
  display: flex;
  gap: 8px;
}

/* 信息网格 */
.info-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.info-item.full-width {
  grid-column: span 2;
}

.info-label {
  font-size: 12px;
  color: var(--wabi-text-muted);
  letter-spacing: 0.5px;
}

.info-value {
  font-size: 14px;
  color: var(--wabi-text);
}

/* 章节卡片 */
.chapter-card {
  padding: 0;
  transition: var(--wabi-transition);
  overflow: visible;
}

.chapter-card:hover {
  box-shadow: var(--wabi-shadow);
  border-color: var(--wabi-accent);
}

.chapter-card :deep(.wabi-card) {
  overflow: visible;
}

.chapter-card-header {
  display: flex;
  gap: 16px;
  padding: 16px;
}

.chapter-no-badge {
  flex-shrink: 0;
  width: 60px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--wabi-accent-light);
  color: var(--wabi-accent);
  font-size: 13px;
  font-weight: 500;
  border-radius: 8px;
  text-align: center;
  line-height: 1.2;
}

.chapter-card-body {
  flex: 1;
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 16px;
}

.chapter-main {
  flex: 1;
  min-width: 0;
}

.chapter-topic {
  font-size: 15px;
  font-weight: 500;
  color: var(--wabi-text);
  margin: 0 0 8px 0;
  line-height: 1.4;
}

.chapter-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.chapter-actions {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  gap: 4px;
}

/* 章节缩略信息 */
.chapter-snippets {
  padding: 0 16px 16px 16px;
  border-top: 1px solid var(--wabi-border-light);
}

.snippet-item {
  display: flex;
  gap: 8px;
  padding: 8px 0;
  font-size: 13px;
  line-height: 1.5;
}

.snippet-item + .snippet-item {
  border-top: 1px dashed var(--wabi-border-light);
}

.snippet-label {
  flex-shrink: 0;
  color: var(--wabi-text-muted);
  font-weight: 500;
}

.snippet-text {
  color: var(--wabi-text-secondary);
}

.snippet-text.text-empty {
  color: var(--wabi-text-muted);
  font-style: italic;
}

/* 章节列表容器 */
.chapter-list-container {
  display: flex;
  flex-direction: column;
  background: var(--wabi-surface);
  border: 1px solid var(--wabi-border);
  border-radius: var(--wabi-radius);
  overflow: hidden;
}

.chapter-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
  padding: 16px;
  overflow-y: auto;
  max-height: calc(100vh - 300px);
}

/* 章节分页 */
.chapter-pagination {
  display: flex;
  justify-content: center;
  padding: 12px 0;
  border-top: 1px solid var(--wabi-border);
}

/* 公式卡片 */
.formula-card {
  margin-bottom: 24px;
  background: var(--wabi-surface-warm);
}

.formula-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 8px 0;
}

.formula-item:first-child {
  padding-top: 0;
}

.formula-item:last-child {
  padding-bottom: 0;
}

.formula-label {
  font-weight: 500;
  color: var(--wabi-text);
  min-width: 140px;
}

.formula-eq {
  color: var(--wabi-text-muted);
}

.formula-desc {
  color: var(--wabi-text-secondary);
}

/* 学时总计 */
.hours-total {
  display: flex;
  justify-content: flex-end;
  align-items: center;
  gap: 12px;
  padding: 16px 24px;
  border-top: 1px solid var(--wabi-border);
}

.total-value {
  font-size: 20px;
  font-weight: 500;
  color: var(--wabi-accent);
  font-family: var(--wabi-font-mono);
}

/* 响应式 */
@media (max-width: 768px) {
  .editor-body {
    flex-direction: column;
  }

  .wabi-side-nav {
    width: 100%;
    border-right: none;
    border-bottom: 1px solid var(--wabi-border);
    display: flex;
    overflow-x: auto;
    padding: 0;
  }

  .wabi-nav-item {
    padding: 12px 16px;
    white-space: nowrap;
    border-right: none;
    border-bottom: 3px solid transparent;
  }

  .wabi-nav-item.active {
    border-bottom-color: var(--wabi-accent);
  }

  .content-area {
    padding: 20px;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }

  .info-item.full-width {
    grid-column: span 1;
  }

  .chapter-header {
    flex-direction: column;
    gap: 8px;
  }

  .chapter-actions {
    align-self: flex-end;
  }
}
</style>
