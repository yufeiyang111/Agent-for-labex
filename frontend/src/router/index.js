import { createRouter, createWebHistory } from 'vue-router'
import { ElMessage } from 'element-plus'
import { useUserStore } from '@/stores/user'

// 登录页
const Login = () => import('@/views/Login.vue')

// 教师模块
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

// 管理员模块
const AdminLayout = () => import('@/views/admin/Layout.vue')
const AdminDashboard = () => import('@/views/admin/Dashboard.vue')
const AdminTeacher = () => import('@/views/admin/Teacher.vue')
const AdminStudent = () => import('@/views/admin/Student.vue')
const AdminClazz = () => import('@/views/admin/Clazz.vue')
const AdminProfile = () => import('@/views/admin/Profile.vue')

// 学生模块
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

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: Login,
    meta: { title: '登录', requiresAuth: false }
  },

  // 教师路由
  {
    path: '/teacher',
    component: TeacherLayout,
    meta: { requiresAuth: true, role: 'TEACHER' },
    redirect: '/teacher/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'TeacherDashboard',
        component: TeacherDashboard,
        meta: { title: '工作台', icon: 'Odometer' }
      },
      {
        path: 'clazz',
        name: 'TeacherClazz',
        component: TeacherClazz,
        meta: { title: '班级管理', icon: 'OfficeBuilding' }
      },
      {
        path: 'student',
        name: 'TeacherStudent',
        component: TeacherStudent,
        meta: { title: '学生管理', icon: 'User' }
      },
      {
        path: 'experiment',
        name: 'TeacherExperiment',
        component: TeacherExperiment,
        meta: { title: '实验管理', icon: 'CollectionTag' }
      },
      {
        path: 'experiment-item/:experimentId',
        name: 'TeacherExperimentItem',
        component: TeacherExperimentItem,
        meta: { title: '题目管理', icon: 'List' }
      },
      {
        path: 'lecture',
        name: 'TeacherLecture',
        component: TeacherLecture,
        meta: { title: '讲义管理', icon: 'Document' }
      },
      {
        path: 'score',
        name: 'TeacherScore',
        component: TeacherScore,
        meta: { title: '成绩管理', icon: 'TrendCharts' }
      },
      {
        path: 'question',
        name: 'TeacherQuestion',
        component: TeacherQuestion,
        meta: { title: '题库管理', icon: 'Tickets' }
      },
      {
        path: 'paper',
        name: 'TeacherPaper',
        component: TeacherPaper,
        meta: { title: '试卷管理', icon: 'DocumentCopy' }
      },
      {
        path: 'exam',
        name: 'TeacherExam',
        component: TeacherExam,
        meta: { title: '考试管理', icon: 'Edit' }
      },
      {
        path: 'exam-grading',
        name: 'TeacherExamGrading',
        component: TeacherExamGrading,
        meta: { title: '考试批改', icon: 'EditPen' }
      },
      {
        path: 'homework',
        name: 'TeacherHomework',
        component: TeacherHomework,
        meta: { title: '作业管理', icon: 'Collection' }
      },
      {
        path: 'profile',
        name: 'TeacherProfile',
        component: TeacherProfile,
        meta: { title: '个人中心', icon: 'UserFilled' }
      },
      {
        path: 'knowledge-graph',
        name: 'TeacherKnowledgeGraph',
        component: TeacherKnowledgeGraph,
        meta: { title: '知识图谱', icon: 'Share' }
      },
      {
        path: 'training-set',
        name: 'TeacherTrainingSet',
        component: TeacherTrainingSet,
        meta: { title: '题目训练', icon: 'List' }
      }
    ]
  },

  // 管理员路由
  {
    path: '/admin',
    component: AdminLayout,
    meta: { requiresAuth: true, role: 'ADMIN' },
    redirect: '/admin/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'AdminDashboard',
        component: AdminDashboard,
        meta: { title: '系统概览', icon: 'Odometer' }
      },
      {
        path: 'teacher',
        name: 'AdminTeacher',
        component: AdminTeacher,
        meta: { title: '教师管理', icon: 'User' }
      },
      {
        path: 'student',
        name: 'AdminStudent',
        component: AdminStudent,
        meta: { title: '学生管理', icon: 'UserFilled' }
      },
      {
        path: 'clazz',
        name: 'AdminClazz',
        component: AdminClazz,
        meta: { title: '班级管理', icon: 'OfficeBuilding' }
      },
      {
        path: 'profile',
        name: 'AdminProfile',
        component: AdminProfile,
        meta: { title: '个人中心', icon: 'UserFilled' }
      }
    ]
  },

  // 学生路由
  {
    path: '/student',
    component: StudentLayout,
    meta: { requiresAuth: true, role: 'STUDENT' },
    redirect: '/student/experiment',
    children: [
      {
        path: 'experiment',
        name: 'StudentExperiment',
        component: StudentExperiment,
        meta: { title: '实验列表', icon: 'Reading' }
      },
      {
        path: 'experiment/:experimentId/detail',
        name: 'StudentExperimentDetail',
        component: StudentExperimentDetail,
        meta: { title: '实验答题', icon: 'Edit' }
      },
      {
        path: 'lecture',
        name: 'StudentLecture',
        component: StudentLecture,
        meta: { title: '讲义学习', icon: 'DocumentCopy' }
      },
      {
        path: 'profile',
        name: 'StudentProfile',
        component: StudentProfile,
        meta: { title: '个人中心', icon: 'UserFilled' }
      },
      {
        path: 'exam',
        name: 'StudentExam',
        component: StudentExam,
        meta: { title: '在线考试', icon: 'Edit' }
      },
      {
        path: 'homework',
        name: 'StudentHomework',
        component: StudentHomework,
        meta: { title: '作业提交', icon: 'Collection' }
      },
      {
        path: 'rag-chat',
        name: 'StudentRagChat',
        component: StudentRagChat,
        meta: { title: '知识问答', icon: 'ChatDotRound' }
      },
      {
        path: 'recommendation',
        name: 'StudentRecommendation',
        component: StudentRecommendation,
        meta: { title: '习题推荐', icon: 'Aim' }
      },
      {
        path: 'training',
        name: 'StudentTraining',
        component: StudentTraining,
        meta: { title: '题目训练', icon: 'List' }
      },
      {
        path: 'training/:id/practice',
        name: 'StudentTrainingPractice',
        component: StudentTrainingPractice,
        meta: { title: '答题练习', icon: 'Edit' }
      },
      {
        path: 'training/:id/result/:attemptId',
        name: 'StudentTrainingResult',
        component: StudentTrainingResult,
        meta: { title: '答题结果', icon: 'View' }
      }
    ]
  },

  // 默认重定向
  {
    path: '/',
    redirect: '/login'
  },

  // 404
  {
    path: '/:pathMatch(.*)*',
    redirect: '/login'
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 路由守卫
router.beforeEach((to, from, next) => {
  // 设置页面标题
  document.title = to.meta.title ? `${to.meta.title} - Labex` : 'Labex 实验教学管理系统'

  const userStore = useUserStore()

  // 不需要认证的页面
  if (!to.meta.requiresAuth) {
    next()
    return
  }

  // 检查是否已登录
  if (!userStore.isLoggedIn) {
    next('/login')
    return
  }

  // 检查角色权限
  if (to.meta.role) {
    if (userStore.role !== to.meta.role) {
      ElMessage.error('无权访问该页面')
      next('/')
      return
    }
  }

  next()
})

export default router
