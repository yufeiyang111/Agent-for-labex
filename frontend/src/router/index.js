import { createRouter, createWebHistory } from 'vue-router'
import { ElMessage } from 'element-plus'
import { useUserStore } from '@/stores/user'

const Login = () => import('@/views/Login.vue')

const TeacherLayout = () => import('@/views/teacher/Layout.vue')
const TeacherDashboard = () => import('@/views/teacher/Dashboard.vue')
const TeacherClazz = () => import('@/views/teacher/Clazz.vue')
const TeacherStudent = () => import('@/views/teacher/Student.vue')
const TeacherExperiment = () => import('@/views/teacher/Experiment.vue')
const TeacherExperimentItem = () => import('@/views/teacher/ExperimentItem.vue')
const TeacherLecture = () => import('@/views/teacher/Lecture.vue')
const TeacherScore = () => import('@/views/teacher/Score.vue')
const TeacherQuestion = () => import('@/views/teacher/Question.vue')
const TeacherPaper = () => import('@/views/teacher/Paper.vue')
const TeacherExam = () => import('@/views/teacher/Exam.vue')
const TeacherExamGrading = () => import('@/views/teacher/ExamGrading.vue')
const TeacherHomework = () => import('@/views/teacher/Homework.vue')
const TeacherProfile = () => import('@/views/teacher/Profile.vue')
const TeacherKnowledgeGraph = () => import('@/views/teacher/KnowledgeGraph.vue')
const TeacherTrainingSet = () => import('@/views/teacher/TrainingSet.vue')
const TeacherAiQuestionGenerator = () => import('@/views/teacher/AiQuestionGenerator.vue')

// === CTL 教学闭环模块 ===
const TeacherCourse = () => import('@/views/teacher/course/CourseList.vue')
const TeacherCourseEdit = () => import('@/views/teacher/course/CourseEdit.vue')
const TeacherSyllabus = () => import('@/views/teacher/course/SyllabusEditor.vue')
const TeacherOffering = () => import('@/views/teacher/course/OfferingList.vue')
const TeacherGR = () => import('@/views/teacher/objective/GRManager.vue')
const TeacherObjective = () => import('@/views/teacher/objective/ObjectiveEditor.vue')
const TeacherScoring = () => import('@/views/teacher/scoring/ScoringItemConfig.vue')
const TeacherGradeV2 = () => import('@/views/teacher/grading/GradeEntryV2.vue')
const TeacherAchievement = () => import('@/views/teacher/achievement/AchievementDashboard.vue')
const TeacherQuality = () => import('@/views/teacher/quality/EvaluationForm.vue')
const TeacherReports = () => import('@/views/teacher/quality/ReportViewer.vue')
const StudentAchievement = () => import('@/views/student/achievement/MyAchievementDashboard.vue')

const AdminLayout = () => import('@/views/admin/Layout.vue')
const AdminDashboard = () => import('@/views/admin/Dashboard.vue')
const AdminTeacher = () => import('@/views/admin/Teacher.vue')
const AdminStudent = () => import('@/views/admin/Student.vue')
const AdminClazz = () => import('@/views/admin/Clazz.vue')
const AdminProfile = () => import('@/views/admin/Profile.vue')

const StudentLayout = () => import('@/views/student/Layout.vue')
const StudentExperiment = () => import('@/views/student/Experiment.vue')
const StudentExperimentDetail = () => import('@/views/student/ExperimentDetail.vue')
const StudentLecture = () => import('@/views/student/Lecture.vue')
const StudentProfile = () => import('@/views/student/Profile.vue')
const StudentExam = () => import('@/views/student/Exam.vue')
const StudentHomework = () => import('@/views/student/Homework.vue')
const StudentRagChat = () => import('@/views/student/RagChat.vue')
const StudentRecommendation = () => import('@/views/student/ExerciseRecommendation.vue')
const StudentTraining = () => import('@/views/student/Training.vue')
const StudentTrainingPractice = () => import('@/views/student/TrainingPractice.vue')
const StudentTrainingResult = () => import('@/views/student/TrainingResult.vue')
const StudentCloudSpace = () => import('@/views/student/CloudSpace.vue')

// CloudWorkspace is a standalone full-page route (no sidebar)
const CloudWorkspace = () => import('@/views/student/CloudWorkspace.vue')

const routes = [
  { path: '/login', name: 'Login', component: Login, meta: { title: 'Login', requiresAuth: false } },
  {
    path: '/teacher',
    component: TeacherLayout,
    meta: { requiresAuth: true, role: 'TEACHER' },
    redirect: '/teacher/dashboard',
    children: [
      { path: 'dashboard', name: 'TeacherDashboard', component: TeacherDashboard, meta: { title: 'Dashboard', icon: 'Odometer' } },
      { path: 'clazz', name: 'TeacherClazz', component: TeacherClazz, meta: { title: 'Class Mgmt', icon: 'OfficeBuilding' } },
      { path: 'student', name: 'TeacherStudent', component: TeacherStudent, meta: { title: 'Student Mgmt', icon: 'User' } },
      { path: 'experiment', name: 'TeacherExperiment', component: TeacherExperiment, meta: { title: 'Experiment Mgmt', icon: 'CollectionTag' } },
      { path: 'experiment-item/:experimentId', name: 'TeacherExperimentItem', component: TeacherExperimentItem, meta: { title: 'Item Mgmt', icon: 'List' } },
      { path: 'lecture', name: 'TeacherLecture', component: TeacherLecture, meta: { title: 'Lecture Mgmt', icon: 'Document' } },
      { path: 'score', name: 'TeacherScore', component: TeacherScore, meta: { title: 'Score Mgmt', icon: 'TrendCharts' } },
      { path: 'question', name: 'TeacherQuestion', component: TeacherQuestion, meta: { title: 'Question Bank', icon: 'Tickets' } },
      { path: 'paper', name: 'TeacherPaper', component: TeacherPaper, meta: { title: 'Paper Mgmt', icon: 'DocumentCopy' } },
      { path: 'exam', name: 'TeacherExam', component: TeacherExam, meta: { title: 'Exam Mgmt', icon: 'Edit' } },
      { path: 'exam-grading', name: 'TeacherExamGrading', component: TeacherExamGrading, meta: { title: 'Exam Grading', icon: 'Check' } },
      { path: 'exam-grading/:examId', name: 'TeacherExamGradingById', component: TeacherExamGrading, meta: { title: 'Exam Grading', icon: 'Check' } },
      { path: 'homework', name: 'TeacherHomework', component: TeacherHomework, meta: { title: 'Homework Mgmt', icon: 'Collection' } },
      { path: 'profile', name: 'TeacherProfile', component: TeacherProfile, meta: { title: 'Profile', icon: 'UserFilled' } },
      { path: 'knowledge-graph', name: 'TeacherKnowledgeGraph', component: TeacherKnowledgeGraph, meta: { title: 'Knowledge Graph', icon: 'Share' } },
      { path: 'training-set', name: 'TeacherTrainingSet', component: TeacherTrainingSet, meta: { title: 'Training Set', icon: 'List' } },
      { path: 'ai-question-generator', name: 'TeacherAiQuestionGenerator', component: TeacherAiQuestionGenerator, meta: { title: 'AI Question Generator', icon: 'MagicStick' } },
      // === CTL 教学闭环 ===
      { path: 'course', name: 'TeacherCourse', component: TeacherCourse, meta: { title: '课程管理', icon: 'Notebook' } },
      { path: 'course/:id/edit', name: 'TeacherCourseEdit', component: TeacherCourseEdit, meta: { title: '编辑课程', icon: 'Edit' } },
      { path: 'course/:id/syllabus', name: 'TeacherSyllabus', component: TeacherSyllabus, meta: { title: '课程大纲', icon: 'Document' } },
      { path: 'offering', name: 'TeacherOffering', component: TeacherOffering, meta: { title: '开课管理', icon: 'School' } },
      { path: 'graduation-requirement', name: 'TeacherGR', component: TeacherGR, meta: { title: '毕业要求', icon: 'Medal' } },
      { path: 'objective/:courseId', name: 'TeacherObjective', component: TeacherObjective, meta: { title: '课程目标', icon: 'Aim' } },
      { path: 'scoring/:offeringId', name: 'TeacherScoring', component: TeacherScoring, meta: { title: '评分项配置', icon: 'Promotion' } },
      { path: 'grade-v2/:offeringId', name: 'TeacherGradeV2', component: TeacherGradeV2, meta: { title: '成绩录入V2', icon: 'EditPen' } },
      { path: 'achievement/:offeringId', name: 'TeacherAchievement', component: TeacherAchievement, meta: { title: '达成度分析', icon: 'DataAnalysis' } },
      { path: 'quality/:offeringId', name: 'TeacherQuality', component: TeacherQuality, meta: { title: '质量评价', icon: 'Stamp' } },
      { path: 'reports/:offeringId', name: 'TeacherReports', component: TeacherReports, meta: { title: '评价报告', icon: 'Files' } }
    ]
  },
  {
    path: '/admin',
    component: AdminLayout,
    meta: { requiresAuth: true, role: 'ADMIN' },
    redirect: '/admin/dashboard',
    children: [
      { path: 'dashboard', name: 'AdminDashboard', component: AdminDashboard, meta: { title: 'Overview', icon: 'Odometer' } },
      { path: 'teacher', name: 'AdminTeacher', component: AdminTeacher, meta: { title: 'Teacher Mgmt', icon: 'User' } },
      { path: 'student', name: 'AdminStudent', component: AdminStudent, meta: { title: 'Student Mgmt', icon: 'UserFilled' } },
      { path: 'clazz', name: 'AdminClazz', component: AdminClazz, meta: { title: 'Class Mgmt', icon: 'OfficeBuilding' } },
      { path: 'profile', name: 'AdminProfile', component: AdminProfile, meta: { title: 'Profile', icon: 'UserFilled' } }
    ]
  },
  {
    path: '/student',
    component: StudentLayout,
    meta: { requiresAuth: true, role: 'STUDENT' },
    redirect: '/student/experiment',
    children: [
      { path: 'experiment', name: 'StudentExperiment', component: StudentExperiment, meta: { title: 'Experiments', icon: 'Reading' } },
      { path: 'experiment/:experimentId/detail', name: 'StudentExperimentDetail', component: StudentExperimentDetail, meta: { title: 'Experiment Detail', icon: 'Edit' } },
      { path: 'lecture', name: 'StudentLecture', component: StudentLecture, meta: { title: 'Lectures', icon: 'DocumentCopy' } },
      { path: 'profile', name: 'StudentProfile', component: StudentProfile, meta: { title: 'Profile', icon: 'UserFilled' } },
      { path: 'exam', name: 'StudentExam', component: StudentExam, meta: { title: 'Online Exam', icon: 'Edit' } },
      { path: 'homework', name: 'StudentHomework', component: StudentHomework, meta: { title: 'Homework', icon: 'Collection' } },
      { path: 'rag-chat', name: 'StudentRagChat', component: StudentRagChat, meta: { title: 'Knowledge QA', icon: 'ChatDotRound' } },
      { path: 'recommendation', name: 'StudentRecommendation', component: StudentRecommendation, meta: { title: 'Recommendations', icon: 'Aim' } },
      { path: 'training', name: 'StudentTraining', component: StudentTraining, meta: { title: 'Training', icon: 'List' } },
      { path: 'training/:id/practice', name: 'StudentTrainingPractice', component: StudentTrainingPractice, meta: { title: 'Practice', icon: 'Edit' } },
      { path: 'training/:id/result/:attemptId', name: 'StudentTrainingResult', component: StudentTrainingResult, meta: { title: 'Results', icon: 'View' } },
      { path: 'cloud-space', name: 'StudentCloudSpace', component: StudentCloudSpace, meta: { title: 'Cloud Code Space', icon: 'Cloudy' } },
      // === CTL 学生达成度 ===
      { path: 'achievement', name: 'StudentAchievement', component: StudentAchievement, meta: { title: '我的达成度', icon: 'DataAnalysis' } }
    ]
  },
  // CloudWorkspace as standalone full-page route (no sidebar)
  {
    path: '/workspace/:projectId',
    name: 'CloudWorkspace',
    component: CloudWorkspace,
    meta: { title: 'Workspace', requiresAuth: true, role: 'STUDENT' }
  },
  { path: '/', redirect: '/login' },
  { path: '/:pathMatch(.*)*', redirect: '/login' }
]

const router = createRouter({ history: createWebHistory(), routes })

router.beforeEach((to, from, next) => {
  document.title = to.meta.title ? to.meta.title + ' - Labex' : 'Labex'
  const userStore = useUserStore()
  if (!to.meta.requiresAuth) { next(); return }
  if (!userStore.isLoggedIn) { next('/login'); return }
  if (to.meta.role && userStore.role !== to.meta.role) {
    ElMessage.error('Access denied')
    next('/')
    return
  }
  next()
})

export default router
