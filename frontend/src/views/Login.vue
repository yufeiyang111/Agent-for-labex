<template>
  <div class="auth-shell" :style="shellStyle" @mousemove="handlePointerMove">
    <div class="ambient-field" aria-hidden="true">
      <span class="ambient-ring ring-one"></span>
      <span class="ambient-ring ring-two"></span>
      <span class="ambient-grid"></span>
    </div>

    <section class="auth-brand">
      <div class="brand-nav">
        <div class="brand-lockup">
          <AppIcon :size="44" />
          <div>
            <strong>Labex</strong>
            <span>AI 实验教学平台</span>
          </div>
        </div>
        <span class="brand-pill">{{ activeCapability.tag }}</span>
      </div>

      <div class="brand-main">
        <div class="brand-hero-grid">
          <div class="brand-copy-block">
            <p class="eyebrow">{{ activeCapability.kicker }}</p>
            <h1>{{ activeCapability.headline }}</h1>
            <p class="brand-copy">
              {{ activeCapability.copy }}
            </p>

            <div class="capability-grid">
              <button
                v-for="(item, index) in capabilities"
                :key="item.title"
                type="button"
                class="capability-card"
                :class="{ active: activeCapabilityIndex === index }"
                @mouseenter="activeCapabilityIndex = index"
                @focus="activeCapabilityIndex = index"
                @click="activeCapabilityIndex = index"
              >
                <span class="capability-icon">
                  <component :is="item.icon" />
                </span>
                <div>
                  <strong>{{ item.title }}</strong>
                  <span>{{ item.desc }}</span>
                </div>
              </button>
            </div>
          </div>

          <div class="mascot-stage" :class="[`mood-${activeCapability.mood}`, `mascot-${activeMascot.value}`]">
            <span class="mascot-halo"></span>
            <span class="mascot-orbit orbit-one"></span>
            <span class="mascot-orbit orbit-two"></span>
            <span class="kawaii-spark spark-one"></span>
            <span class="kawaii-spark spark-two"></span>
            <span class="kawaii-spark spark-three"></span>
            <div class="code-bubble bubble-one">
              <span>{{ activeCapability.bubbles[0].label }}</span>
              <strong>{{ activeCapability.bubbles[0].value }}</strong>
            </div>
            <div class="code-bubble bubble-two">
              <span>{{ activeCapability.bubbles[1].label }}</span>
              <strong>{{ activeCapability.bubbles[1].value }}</strong>
            </div>
            <div class="mascot-stack" aria-hidden="true">
              <img
                v-for="(mascot, index) in mascotOptions"
                :key="mascot.value"
                class="mascot-image"
                :class="{ active: activeMascotIndex === index }"
                :src="mascot.src"
                alt=""
                loading="eager"
                decoding="async"
                fetchpriority="high"
              />
            </div>
            <div class="mascot-shadow"></div>
            <div class="mascot-status">
              <span></span>
              <div>
                <strong>{{ activeMascot.title }}</strong>
                <p>{{ activeCapability.helperText }}</p>
              </div>
            </div>
            <div class="mascot-switch" aria-label="切换学习助手">
              <button
                v-for="(mascot, index) in mascotOptions"
                :key="mascot.value"
                type="button"
                :class="{ active: activeMascotIndex === index }"
                @click="selectMascot(index)"
              >
                {{ mascot.label }}
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="workspace-preview">
        <div class="preview-topbar">
          <span></span>
          <span></span>
          <span></span>
        </div>
        <div class="preview-body">
          <div class="preview-sidebar">
            <button
              v-for="(item, index) in previewTabs"
              :key="item"
              type="button"
              :class="{ active: activeCapabilityIndex === index }"
              @click="activeCapabilityIndex = index"
            >
              {{ item }}
            </button>
          </div>
          <div class="preview-editor">
            <div class="preview-line wide" :style="{ width: activeCapability.widths[0] }"></div>
            <div class="preview-line mid" :style="{ width: activeCapability.widths[1] }"></div>
            <div class="preview-line short" :style="{ width: activeCapability.widths[2] }"></div>
            <div class="preview-metrics">
              <div v-for="metric in activeCapability.metrics" :key="metric.label">
                <strong>{{ metric.value }}</strong>
                <span>{{ metric.label }}</span>
              </div>
            </div>
            <div class="preview-terminal">
              <span>{{ activeCapability.consoleTitle }}</span>
              <strong>{{ activeCapability.consoleText }}</strong>
            </div>
          </div>
          <div class="preview-agent">
            <span>{{ activeCapability.sideTitle }}</span>
            <div class="agent-pulse"></div>
            <p>{{ activeCapability.sideText }}</p>
          </div>
        </div>
      </div>
    </section>

    <section class="auth-panel">
      <div class="auth-card">
        <div class="mobile-lockup">
          <AppIcon :size="40" />
          <div>
            <strong>Labex</strong>
            <span>AI 实验教学平台</span>
          </div>
        </div>

        <div class="mobile-mascot" aria-hidden="true">
          <img :src="activeMascot.src" alt="" />
        </div>

        <div class="mobile-mascot-switch" aria-label="切换学习助手">
          <button
            v-for="(mascot, index) in mascotOptions"
            :key="mascot.value"
            type="button"
            :class="{ active: activeMascotIndex === index }"
            @click="selectMascot(index)"
          >
            {{ mascot.label }}
          </button>
        </div>

        <div class="auth-heading">
          <p>{{ activeMode === 'login' ? '欢迎回来' : '创建学生账号' }}</p>
          <h2>{{ activeMode === 'login' ? '登录工作台' : '注册加入课堂' }}</h2>
        </div>

        <div class="mode-switch" role="tablist" aria-label="登录注册切换">
          <button :class="{ active: activeMode === 'login' }" @click="activeMode = 'login'">登录</button>
          <button :class="{ active: activeMode === 'register' }" @click="activeMode = 'register'">注册</button>
        </div>

        <div class="auth-role-brief">
          <span>
            <component :is="activeRole.icon" />
          </span>
          <div>
            <strong>{{ activeRole.title }}</strong>
            <p>{{ activeRole.description }}</p>
          </div>
        </div>

        <Transition name="form-panel" mode="out-in">
          <el-form
            v-if="activeMode === 'login'"
            key="login"
            ref="loginFormRef"
            :model="loginForm"
            :rules="loginRules"
            class="auth-form"
            label-position="top"
          >
            <div class="role-picker">
              <button
                v-for="role in roles"
                :key="role.value"
                type="button"
                :class="{ active: loginForm.role === role.value }"
                @click="loginForm.role = role.value"
              >
                <component :is="role.icon" />
                <span>{{ role.label }}</span>
              </button>
            </div>

            <el-form-item label="账号" prop="account">
              <el-input v-model.trim="loginForm.account" placeholder="请输入账号或学号" size="large" :prefix-icon="User" />
            </el-form-item>

            <el-form-item label="密码" prop="password">
              <el-input
                v-model="loginForm.password"
                type="password"
                placeholder="请输入密码"
                size="large"
                :prefix-icon="Lock"
                show-password
                @keyup.enter="handleLogin"
              />
            </el-form-item>

            <div class="form-row">
              <el-checkbox v-model="rememberMe">记住账号</el-checkbox>
              <button type="button" class="text-btn" @click="activeMode = 'register'">没有账号？去注册</button>
            </div>

            <el-button type="primary" size="large" class="submit-btn" :loading="loading" @click="handleLogin">
              {{ loading ? '正在登录' : '登录 Labex' }}
            </el-button>
          </el-form>

          <el-form
            v-else
            key="register"
            ref="registerFormRef"
            :model="registerForm"
            :rules="registerRules"
            class="auth-form"
            label-position="top"
          >
            <div class="register-progress">
              <span :class="{ active: registerProgress >= 1 }"></span>
              <span :class="{ active: registerProgress >= 2 }"></span>
              <span :class="{ active: registerProgress >= 3 }"></span>
              <strong>{{ registerProgressText }}</strong>
            </div>

            <el-form-item label="学号" prop="studentNo">
              <el-input v-model.trim="registerForm.studentNo" placeholder="例如 20260001" size="large" :prefix-icon="User" />
            </el-form-item>
            <el-form-item label="姓名" prop="studentName">
              <el-input v-model.trim="registerForm.studentName" placeholder="请输入真实姓名" size="large" :prefix-icon="School" />
            </el-form-item>
            <el-form-item label="班级编号" prop="clazzNo">
              <el-input v-model.trim="registerForm.clazzNo" placeholder="选填，可由教师后续调整" size="large" />
            </el-form-item>
            <el-form-item label="密码" prop="password">
              <el-input v-model="registerForm.password" type="password" placeholder="至少 6 位" size="large" :prefix-icon="Lock" show-password />
            </el-form-item>
            <div class="password-strength">
              <span v-for="i in 4" :key="i" :class="{ active: passwordScore >= i }"></span>
              <strong>{{ passwordStrengthText }}</strong>
            </div>
            <el-form-item label="确认密码" prop="confirmPassword">
              <el-input
                v-model="registerForm.confirmPassword"
                type="password"
                placeholder="请再次输入密码"
                size="large"
                :prefix-icon="Lock"
                show-password
                @keyup.enter="handleRegister"
              />
            </el-form-item>

            <div class="register-note">
              注册仅开放学生账号；教师和管理员账号由系统管理员创建。
            </div>

            <el-button type="primary" size="large" class="submit-btn" :loading="loading" @click="handleRegister">
              {{ loading ? '正在创建' : '创建并登录' }}
            </el-button>
          </el-form>
        </Transition>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { User, Lock, School, Monitor, TrendCharts, Connection, Management } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { useUserStore } from '@/stores/user'
import { authApi } from '@/api'
import AppIcon from '@/components/AppIcon.vue'

const router = useRouter()
const userStore = useUserStore()

const loginFormRef = ref(null)
const registerFormRef = ref(null)
const loading = ref(false)
const rememberMe = ref(false)
const activeMode = ref('login')
const activeCapabilityIndex = ref(0)
const activeMascotIndex = ref(0)
const pointer = reactive({ x: 62, y: 34 })

const roles = [
  { label: '教师', value: 'TEACHER', icon: School, title: '教师工作台', description: '管理班级、讲义、实验、题库与考试批改。' },
  { label: '学生', value: 'STUDENT', icon: User, title: '学生实验室', description: '进入实验、训练、知识问答与云代码空间。' },
  { label: '管理员', value: 'ADMIN', icon: Management, title: '系统控制台', description: '维护教师、学生、班级和平台基础数据。' }
]

const capabilities = [
  {
    title: '云代码空间',
    desc: '文件树、编辑器、终端与代码审查',
    icon: Monitor,
    tag: 'Anime Lab Mode',
    kicker: 'Cute Coding Companion',
    headline: '和 AI 学习助手一起进入云端实验室。',
    copy: '把文件树、编辑器、终端、变更审查和实验任务放进同一个可爱的工作台里，让第一次进入平台的学生也能很快找到方向。',
    mood: 'mint',
    widths: ['78%', '58%', '42%'],
    metrics: [{ value: '3', label: '打开文件' }, { value: '12', label: '测试用例' }, { value: '1', label: '待审变更' }],
    consoleTitle: 'workspace.run',
    consoleText: 'npm run test passed',
    sideTitle: 'Workspace',
    sideText: '文件上下文已同步',
    helperTitle: '小助手在线',
    helperText: '正在整理实验环境',
    bubbles: [{ label: 'LAB', value: 'ready' }, { label: 'CODE', value: 'sync' }]
  },
  {
    title: '智能 Agent',
    desc: '任务规划、上下文记忆和变更追踪',
    icon: Connection,
    tag: 'Agent Rhythm',
    kicker: 'Plan Execute Verify',
    headline: '任务会被拆成清楚的小步骤，再一步步完成。',
    copy: '通过任务规划、工具调用、沙箱约束和变更面板，把 AI 编程过程做成可观察、可审查、可回退的协作流程。',
    mood: 'peach',
    widths: ['64%', '72%', '36%'],
    metrics: [{ value: '4', label: '计划步骤' }, { value: '8', label: '工具调用' }, { value: '2', label: '验证命令' }],
    consoleTitle: 'agent.plan',
    consoleText: 'next step: verify diff',
    sideTitle: 'Agent',
    sideText: '计划与工具输出可见',
    helperTitle: '计划生成中',
    helperText: '先想清楚再动手',
    bubbles: [{ label: 'PLAN', value: '4 steps' }, { label: 'SAFE', value: 'guard' }]
  },
  {
    title: '学习画像',
    desc: '题库、训练和成绩分析联动',
    icon: TrendCharts,
    tag: 'Learning Spark',
    kicker: 'Adaptive Learning',
    headline: '把每次练习都变成可追踪的成长线索。',
    copy: '讲义、题库、考试、作业和训练结果联动，帮助教师看到薄弱点，也让学生知道下一步应该练什么。',
    mood: 'lemon',
    widths: ['46%', '68%', '54%'],
    metrics: [{ value: '86%', label: '掌握度' }, { value: '24', label: '推荐题' }, { value: '5', label: '知识点' }],
    consoleTitle: 'learning.trace',
    consoleText: 'recommendation updated',
    sideTitle: 'Analytics',
    sideText: '学习状态实时沉淀',
    helperTitle: '成长记录中',
    helperText: '推荐下一组练习',
    bubbles: [{ label: 'LEVEL', value: '86%' }, { label: 'NEXT', value: '24 tasks' }]
  }
]

const previewTabs = ['代码', 'Agent', '画像']

const mascotOptions = [
  {
    label: '魔法学院',
    value: 'mage',
    src: '/brand/anime-isekai-mage-idle.webp',
    alt: 'Labex 异世界魔法学院 AI 学习助手',
    title: '魔法助手在线'
  },
  {
    label: '忍者学院',
    value: 'ninja',
    src: '/brand/anime-shonen-ninja-idle.webp',
    alt: 'Labex 少年漫画忍者学院 AI 学习助手',
    title: '忍术助手在线'
  }
]

const loginForm = reactive({
  account: '',
  password: '',
  role: 'TEACHER'
})

const registerForm = reactive({
  studentNo: '',
  studentName: '',
  clazzNo: '',
  password: '',
  confirmPassword: ''
})

const shellStyle = computed(() => ({
  '--spot-x': `${pointer.x}%`,
  '--spot-y': `${pointer.y}%`,
  '--spot-shift-x': `${Math.round((pointer.x - 50) * 0.32)}px`,
  '--spot-shift-y': `${Math.round((pointer.y - 50) * 0.32)}px`,
  '--mascot-shift-x': `${Math.round((pointer.x - 50) * -0.16)}px`,
  '--mascot-shift-y': `${Math.round((pointer.y - 50) * -0.12)}px`
}))

const activeCapability = computed(() => capabilities[activeCapabilityIndex.value] || capabilities[0])
const activeMascot = computed(() => mascotOptions[activeMascotIndex.value] || mascotOptions[0])

const activeRole = computed(() => {
  if (activeMode.value === 'register') return roles.find(role => role.value === 'STUDENT') || roles[1]
  return roles.find(role => role.value === loginForm.role) || roles[0]
})

const passwordScore = computed(() => {
  const value = registerForm.password || ''
  let score = 0
  if (value.length >= 6) score += 1
  if (value.length >= 10) score += 1
  if (/[A-Z]/.test(value) && /[a-z]/.test(value)) score += 1
  if (/\d/.test(value) && /[^A-Za-z0-9]/.test(value)) score += 1
  return Math.min(score, 4)
})

const passwordStrengthText = computed(() => {
  return ['请输入密码', '基础强度', '中等强度', '较强密码', '高强度密码'][passwordScore.value]
})

const registerProgress = computed(() => {
  let progress = 0
  if (registerForm.studentNo && registerForm.studentName) progress += 1
  if (registerForm.password.length >= 6) progress += 1
  if (registerForm.confirmPassword && registerForm.confirmPassword === registerForm.password) progress += 1
  return progress
})

const registerProgressText = computed(() => {
  return ['填写身份信息', '设置登录密码', '确认密码一致', '可以创建账号'][registerProgress.value]
})

const loginRules = {
  account: [{ required: true, message: '请输入账号', trigger: 'blur' }],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 4, message: '密码长度不能少于 4 位', trigger: 'blur' }
  ],
  role: [{ required: true, message: '请选择角色', trigger: 'change' }]
}

const validateConfirmPassword = (_, value, callback) => {
  if (value !== registerForm.password) callback(new Error('两次输入的密码不一致'))
  else callback()
}

const registerRules = {
  studentNo: [
    { required: true, message: '请输入学号', trigger: 'blur' },
    { min: 4, max: 20, message: '学号长度需为 4-20 位', trigger: 'blur' },
    { pattern: /^[A-Za-z0-9_-]+$/, message: '学号只能包含字母、数字、下划线或短横线', trigger: 'blur' }
  ],
  studentName: [
    { required: true, message: '请输入姓名', trigger: 'blur' },
    { min: 2, max: 20, message: '姓名长度需为 2-20 位', trigger: 'blur' }
  ],
  clazzNo: [{ max: 20, message: '班级编号不能超过 20 位', trigger: 'blur' }],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 64, message: '密码长度需为 6-64 位', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认密码', trigger: 'blur' },
    { validator: validateConfirmPassword, trigger: 'blur' }
  ]
}

onMounted(() => {
  const savedAccount = localStorage.getItem('labex-login-account')
  const savedRole = localStorage.getItem('labex-login-role')
  const savedMascot = localStorage.getItem('labex-login-mascot')
  if (savedAccount) {
    loginForm.account = savedAccount
    rememberMe.value = true
  }
  if (savedRole) loginForm.role = savedRole
  if (savedMascot) {
    const index = mascotOptions.findIndex(mascot => mascot.value === savedMascot)
    if (index >= 0) activeMascotIndex.value = index
  }
  mascotOptions.forEach((mascot) => {
    const image = new Image()
    image.decoding = 'async'
    image.src = mascot.src
  })
})

const handlePointerMove = (event) => {
  const rect = event.currentTarget.getBoundingClientRect()
  pointer.x = Math.round(((event.clientX - rect.left) / rect.width) * 100)
  pointer.y = Math.round(((event.clientY - rect.top) / rect.height) * 100)
}

const selectMascot = (index) => {
  if (!mascotOptions[index]) return
  activeMascotIndex.value = index
  localStorage.setItem('labex-login-mascot', mascotOptions[index].value)
}

const routeAfterLogin = () => {
  if (loginForm.role === 'ADMIN') router.push('/admin/dashboard')
  else if (loginForm.role === 'TEACHER') router.push('/teacher/dashboard')
  else router.push('/student/experiment')
}

const persistRememberedAccount = () => {
  if (rememberMe.value) {
    localStorage.setItem('labex-login-account', loginForm.account)
    localStorage.setItem('labex-login-role', loginForm.role)
  } else {
    localStorage.removeItem('labex-login-account')
    localStorage.removeItem('labex-login-role')
  }
}

const handleLogin = async () => {
  const valid = await loginFormRef.value.validate().catch(() => false)
  if (!valid) return

  loading.value = true
  try {
    const result = await userStore.login(loginForm)
    if (result.success) {
      persistRememberedAccount()
      ElMessage.success('登录成功')
      routeAfterLogin()
    } else {
      ElMessage.error(result.message || '登录失败')
    }
  } catch (error) {
    ElMessage.error('登录失败，请检查网络')
  } finally {
    loading.value = false
  }
}

const handleRegister = async () => {
  const valid = await registerFormRef.value.validate().catch(() => false)
  if (!valid) return

  loading.value = true
  try {
    await authApi.register({
      studentNo: registerForm.studentNo,
      studentName: registerForm.studentName,
      clazzNo: registerForm.clazzNo,
      password: registerForm.password
    })
    loginForm.account = registerForm.studentNo
    loginForm.password = registerForm.password
    loginForm.role = 'STUDENT'
    rememberMe.value = true
    ElMessage.success('注册成功，正在进入工作台')
    const result = await userStore.login(loginForm)
    if (result.success) routeAfterLogin()
  } catch (error) {
    ElMessage.error(error.message || '注册失败')
  } finally {
    loading.value = false
  }
}
</script>

<style lang="scss" scoped>
.auth-shell {
  min-height: 100vh;
  display: grid;
  grid-template-columns: minmax(0, 1.08fr) minmax(420px, 0.92fr);
  background:
    linear-gradient(135deg, #f0fdfa 0%, #f8fbff 46%, #fff7ed 100%);
  color: #111827;
  overflow: hidden;
  position: relative;
}

.ambient-field {
  position: absolute;
  inset: 0;
  pointer-events: none;
  overflow: hidden;
  z-index: 0;
}

.ambient-ring {
  position: absolute;
  display: block;
  border-radius: 999px;
  border: 1px solid rgba(15, 118, 110, 0.12);
  filter: blur(0.2px);
}

.ring-one {
  width: 420px;
  height: 420px;
  right: -160px;
  top: 8%;
  animation: driftOne 18s ease-in-out infinite;
}

.ring-two {
  width: 260px;
  height: 260px;
  right: 30%;
  bottom: -120px;
  border-color: rgba(57, 217, 138, 0.14);
  animation: driftTwo 22s ease-in-out infinite;
}

.ambient-grid {
  position: absolute;
  inset: 0;
  background-image:
    linear-gradient(rgba(15, 23, 42, 0.035) 1px, transparent 1px),
    linear-gradient(90deg, rgba(15, 23, 42, 0.035) 1px, transparent 1px);
  background-size: 42px 42px;
  mask-image: radial-gradient(circle at var(--spot-x, 62%) var(--spot-y, 34%), #000 0%, transparent 56%);
}

@keyframes driftOne {
  0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg); }
  50% { transform: translate3d(-22px, 24px, 0) rotate(8deg); }
}

@keyframes driftTwo {
  0%, 100% { transform: translate3d(0, 0, 0) scale(1); }
  50% { transform: translate3d(18px, -20px, 0) scale(1.05); }
}

.auth-brand {
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  padding: 34px 56px 46px;
  background:
    linear-gradient(135deg, rgba(15, 23, 42, 0.98) 0%, rgba(13, 72, 79, 0.94) 56%, rgba(64, 46, 76, 0.92) 100%),
    #0f172a;
  color: #f8fafc;
  overflow: hidden;
  z-index: 1;
  border-right: 1px solid rgba(15, 23, 42, 0.08);
}

.auth-brand::before {
  content: '';
  position: absolute;
  inset: 0;
  background-image:
    linear-gradient(rgba(255,255,255,0.06) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,0.06) 1px, transparent 1px);
  background-size: 34px 34px;
  mask-image: linear-gradient(90deg, #000 0%, transparent 95%);
  pointer-events: none;
}

.auth-brand::after {
  content: '';
  position: absolute;
  width: 430px;
  height: 620px;
  left: 52%;
  top: -90px;
  background: linear-gradient(135deg, transparent 0%, rgba(94, 234, 212, 0.16) 44%, rgba(251, 207, 232, 0.12) 62%, transparent 100%);
  filter: blur(8px);
  transform: translate3d(var(--spot-shift-x, 4px), var(--spot-shift-y, -5px), 0);
  pointer-events: none;
}

.brand-nav,
.brand-main,
.workspace-preview {
  position: relative;
  z-index: 1;
}

.brand-nav {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
}

.brand-lockup,
.mobile-lockup {
  display: flex;
  align-items: center;
  gap: 14px;

  strong {
    display: block;
    font-size: 20px;
    line-height: 1.1;
  }

  span {
    display: block;
    margin-top: 4px;
    color: rgba(248, 250, 252, 0.72);
    font-size: 13px;
  }
}

.brand-pill {
  padding: 8px 12px;
  border: 1px solid rgba(255,255,255,0.14);
  border-radius: 999px;
  color: #d7f9f1;
  font-size: 12px;
  background: rgba(255,255,255,0.08);
}

.brand-main {
  max-width: none;
  margin-top: 34px;
}

.brand-hero-grid {
  display: grid;
  grid-template-columns: minmax(360px, 0.94fr) minmax(300px, 0.82fr);
  gap: 34px;
  align-items: center;
}

.brand-copy-block {
  min-width: 0;
}

.eyebrow {
  color: #5eead4;
  font-size: 13px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  margin-bottom: 18px;
}

.brand-main h1 {
  font-size: 44px;
  line-height: 1.12;
  letter-spacing: 0;
  margin: 0;
  max-width: 760px;
}

.brand-copy {
  margin: 20px 0 0;
  color: rgba(248, 250, 252, 0.74);
  font-size: 16px;
  line-height: 1.8;
  max-width: 620px;
}

.mascot-stage {
  position: relative;
  min-height: 438px;
  display: flex;
  align-items: flex-end;
  justify-content: center;
  transform: translate3d(var(--mascot-shift-x, -2px), var(--mascot-shift-y, 2px), 0);
  transition: transform 0.18s ease-out;
  isolation: isolate;
}

.mascot-halo {
  position: absolute;
  width: 300px;
  height: 300px;
  bottom: 74px;
  left: 50%;
  transform: translateX(-50%);
  border-radius: 50%;
  background:
    conic-gradient(from 140deg, rgba(94, 234, 212, 0), rgba(94, 234, 212, 0.42), rgba(251, 207, 232, 0.34), rgba(253, 224, 71, 0.22), rgba(94, 234, 212, 0));
  filter: blur(0.2px);
  animation: haloSpin 16s linear infinite;
  opacity: 0.88;
  z-index: -2;
}

.mascot-halo::after {
  content: '';
  position: absolute;
  inset: 16px;
  border-radius: inherit;
  background: rgba(15, 23, 42, 0.82);
}

.mascot-orbit {
  position: absolute;
  display: block;
  width: 260px;
  height: 112px;
  left: 50%;
  bottom: 166px;
  border: 1px solid rgba(215, 249, 241, 0.34);
  border-radius: 50%;
  transform: translateX(-50%) rotate(-9deg);
  z-index: -1;
}

.orbit-two {
  width: 312px;
  height: 132px;
  bottom: 145px;
  border-color: rgba(251, 207, 232, 0.26);
  transform: translateX(-50%) rotate(15deg);
  animation: orbitBreath 5.2s ease-in-out infinite;
}

.kawaii-spark {
  position: absolute;
  width: 22px;
  height: 22px;
  color: #fde68a;
  transform: rotate(45deg);
  animation: sparkBlink 2.8s ease-in-out infinite;
}

.kawaii-spark::before,
.kawaii-spark::after {
  content: '';
  position: absolute;
  background: currentColor;
  border-radius: 999px;
}

.kawaii-spark::before {
  width: 4px;
  height: 100%;
  left: 9px;
  top: 0;
}

.kawaii-spark::after {
  width: 100%;
  height: 4px;
  left: 0;
  top: 9px;
}

.spark-one {
  right: 12%;
  top: 15%;
}

.spark-two {
  left: 9%;
  top: 34%;
  color: #99f6e4;
  animation-delay: 0.8s;
}

.spark-three {
  right: 19%;
  bottom: 27%;
  width: 16px;
  height: 16px;
  color: #fbcfe8;
  animation-delay: 1.5s;
}

.code-bubble {
  position: absolute;
  min-width: 112px;
  padding: 12px 14px;
  border: 1px solid rgba(255,255,255,0.22);
  border-radius: 8px;
  background: rgba(15, 23, 42, 0.72);
  box-shadow: 0 18px 40px rgba(0, 0, 0, 0.22);
  backdrop-filter: blur(14px);
  z-index: 2;
  animation: bubbleFloat 4.4s ease-in-out infinite;

  span,
  strong {
    display: block;
    font-family: 'Cascadia Code', 'JetBrains Mono', monospace;
  }

  span {
    color: rgba(215, 249, 241, 0.72);
    font-size: 10px;
    letter-spacing: 0.08em;
  }

  strong {
    margin-top: 5px;
    color: #ffffff;
    font-size: 14px;
  }
}

.bubble-one {
  left: 4%;
  bottom: 148px;
}

.bubble-two {
  right: 1%;
  top: 92px;
  animation-delay: 1.1s;
}

.mascot-stack {
  width: min(330px, 86%);
  height: 430px;
  max-height: 430px;
  filter: drop-shadow(0 28px 28px rgba(0, 0, 0, 0.32));
  animation: mascotFloat 4.8s ease-in-out infinite;
  position: relative;
  z-index: 1;
}

.mascot-ninja .mascot-stack {
  width: min(318px, 84%);
}

.mascot-image {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: contain;
  object-position: center bottom;
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.12s ease;
  will-change: opacity;
}

.mascot-image.active {
  opacity: 1;
}

.mascot-shadow {
  position: absolute;
  width: 220px;
  height: 30px;
  bottom: 4px;
  left: 50%;
  transform: translateX(-50%);
  border-radius: 999px;
  background: rgba(2, 6, 23, 0.28);
  filter: blur(9px);
  animation: shadowPulse 4.8s ease-in-out infinite;
  z-index: -1;
}

.mascot-status {
  position: absolute;
  left: 50%;
  bottom: 22px;
  transform: translateX(-50%);
  min-width: 230px;
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px 14px;
  border-radius: 8px;
  border: 1px solid rgba(255,255,255,0.2);
  background: rgba(248, 250, 252, 0.12);
  box-shadow: 0 18px 40px rgba(0,0,0,0.24);
  backdrop-filter: blur(16px);
  z-index: 3;

  > span {
    width: 10px;
    height: 10px;
    border-radius: 999px;
    background: #5eead4;
    box-shadow: 0 0 0 6px rgba(94, 234, 212, 0.16);
    flex-shrink: 0;
  }

  strong,
  p {
    margin: 0;
    display: block;
  }

  strong {
    color: #ffffff;
    font-size: 13px;
  }

  p {
    margin-top: 3px;
    color: rgba(248, 250, 252, 0.66);
    font-size: 12px;
  }
}

.mascot-switch,
.mobile-mascot-switch {
  display: inline-grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 6px;
  padding: 5px;
  border-radius: 999px;
  border: 1px solid rgba(255,255,255,0.18);
  background: rgba(15, 23, 42, 0.52);
  backdrop-filter: blur(14px);

  button {
    min-width: 58px;
    height: 30px;
    border: 0;
    border-radius: 999px;
    background: transparent;
    color: rgba(248, 250, 252, 0.72);
    font-size: 12px;
    font-weight: 800;
    cursor: pointer;
    transition: background 0.18s ease, color 0.18s ease, transform 0.18s ease;
  }

  button:hover,
  button.active {
    color: #0f172a;
    background: linear-gradient(135deg, #d7f9f1, #fef3c7);
    transform: translateY(-1px);
  }
}

.mascot-switch {
  position: absolute;
  top: 12px;
  right: 12px;
  z-index: 4;
}

@keyframes haloSpin {
  to { transform: translateX(-50%) rotate(360deg); }
}

@keyframes orbitBreath {
  0%, 100% { opacity: 0.55; transform: translateX(-50%) rotate(15deg) scale(1); }
  50% { opacity: 0.92; transform: translateX(-50%) rotate(15deg) scale(1.04); }
}

@keyframes sparkBlink {
  0%, 100% { opacity: 0.28; transform: rotate(45deg) scale(0.78); }
  50% { opacity: 1; transform: rotate(45deg) scale(1.08); }
}

@keyframes bubbleFloat {
  0%, 100% { transform: translate3d(0, 0, 0); }
  50% { transform: translate3d(0, -10px, 0); }
}

@keyframes mascotFloat {
  0%, 100% { transform: translate3d(0, 0, 0) rotate(-0.6deg); }
  50% { transform: translate3d(0, -12px, 0) rotate(0.8deg); }
}

@keyframes shadowPulse {
  0%, 100% { opacity: 0.7; transform: translateX(-50%) scaleX(1); }
  50% { opacity: 0.45; transform: translateX(-50%) scaleX(0.84); }
}

.capability-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 10px;
  margin-top: 28px;
  max-width: 520px;
}

.capability-card {
  display: flex;
  align-items: center;
  gap: 12px;
  min-height: 74px;
  padding: 13px 14px;
  border: 1px solid rgba(255,255,255,0.12);
  border-radius: 8px;
  background: rgba(255,255,255,0.08);
  backdrop-filter: blur(12px);
  text-align: left;
  cursor: pointer;
  font-family: inherit;
  transition: transform 0.22s ease, border-color 0.22s ease, background 0.22s ease, box-shadow 0.22s ease;

  &:hover,
  &:focus-visible,
  &.active {
    transform: translateY(-3px);
    border-color: rgba(94, 234, 212, 0.5);
    background: rgba(255,255,255,0.13);
    box-shadow: 0 16px 34px rgba(0, 0, 0, 0.18);
    outline: none;
  }

  &.active .capability-icon {
    background: linear-gradient(135deg, #d7f9f1, #39d98a);
  }

  strong {
    display: block;
    color: #ffffff;
    font-size: 14px;
    margin-bottom: 5px;
  }

  span {
    color: rgba(248, 250, 252, 0.68);
    font-size: 12px;
    line-height: 1.55;
  }
}

.capability-icon {
  width: 32px;
  height: 32px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 8px;
  color: #0f172a;
  background: #d7f9f1;
  flex-shrink: 0;

  :deep(svg) {
    width: 17px;
    height: 17px;
  }
}

.workspace-preview {
  width: min(720px, 100%);
  margin-top: 26px;
  border: 1px solid rgba(255,255,255,0.12);
  border-radius: 8px;
  overflow: hidden;
  background: rgba(2, 6, 23, 0.68);
  box-shadow: 0 32px 80px rgba(0,0,0,0.32);
}

.preview-topbar {
  display: flex;
  align-items: center;
  gap: 8px;
  height: 38px;
  padding: 0 14px;
  border-bottom: 1px solid rgba(255,255,255,0.1);

  span {
    width: 9px;
    height: 9px;
    border-radius: 50%;
    background: #94a3b8;
  }
}

.preview-body {
  display: grid;
  grid-template-columns: 84px 1fr 168px;
  min-height: 220px;
}

.preview-sidebar {
  padding: 18px 14px;
  border-right: 1px solid rgba(255,255,255,0.08);

  button {
    display: block;
    width: 100%;
    height: 30px;
    margin-bottom: 12px;
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 7px;
    background: rgba(148, 163, 184, 0.12);
    color: rgba(248, 250, 252, 0.64);
    cursor: pointer;
    font-size: 12px;
    font-weight: 700;
    transition: all 0.2s ease;
  }

  button:hover,
  button.active {
    color: #d7f9f1;
    background: rgba(94, 234, 212, 0.14);
    border-color: rgba(94, 234, 212, 0.34);
  }
}

.preview-editor {
  padding: 24px;
}

.preview-line {
  height: 12px;
  border-radius: 999px;
  background: rgba(215, 249, 241, 0.9);
  margin-bottom: 16px;
  transition: width 0.35s ease;

  &.wide { width: 72%; }
  &.mid { width: 52%; background: rgba(94, 234, 212, 0.78); }
  &.short { width: 34%; background: rgba(57, 217, 138, 0.78); }
}

.preview-metrics {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 10px;
  margin-top: 28px;

  div {
    padding: 11px 10px;
    border-radius: 8px;
    background: rgba(255,255,255,0.06);
    border: 1px solid rgba(255,255,255,0.08);
  }

  strong,
  span {
    display: block;
  }

  strong {
    color: #d7f9f1;
    font-size: 20px;
    line-height: 1;
  }

  span {
    margin-top: 6px;
    color: rgba(248, 250, 252, 0.56);
    font-size: 11px;
  }
}

.preview-terminal {
  margin-top: 18px;
  padding: 14px;
  border-radius: 8px;
  background: rgba(15, 23, 42, 0.92);
  border: 1px solid rgba(255,255,255,0.08);

  span,
  strong {
    display: block;
    font-family: 'Cascadia Code', 'JetBrains Mono', monospace;
    font-size: 12px;
  }

  span { color: #5eead4; }
  strong { margin-top: 7px; color: #d7f9f1; }
}

.preview-agent {
  padding: 24px 18px;
  border-left: 1px solid rgba(255,255,255,0.08);
  background: rgba(255,255,255,0.04);

  span {
    display: block;
    color: #d7f9f1;
    font-size: 12px;
    font-weight: 700;
    margin-bottom: 18px;
  }

  p {
    margin: 18px 0 0;
    color: rgba(248, 250, 252, 0.72);
    font-size: 12px;
  }
}

.agent-pulse {
  width: 62px;
  height: 62px;
  border-radius: 18px;
  background:
    linear-gradient(135deg, #39d98a, #5eead4);
  box-shadow: 0 0 0 10px rgba(94, 234, 212, 0.08);
  position: relative;
  animation: pulseSoft 2.8s ease-in-out infinite;
}

.agent-pulse::before,
.agent-pulse::after {
  content: '';
  position: absolute;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: #0f172a;
}

.agent-pulse::before {
  left: 17px;
  top: 19px;
}

.agent-pulse::after {
  right: 17px;
  top: 19px;
}

@keyframes pulseSoft {
  0%, 100% { transform: translateY(0); box-shadow: 0 0 0 10px rgba(94, 234, 212, 0.08); }
  50% { transform: translateY(-4px); box-shadow: 0 0 0 15px rgba(94, 234, 212, 0.04); }
}

.auth-panel {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 42px;
  position: relative;
  z-index: 1;
}

.auth-card {
  width: min(100%, 468px);
  padding: 38px;
  border-radius: 8px;
  background: rgba(255,255,255,0.92);
  border: 1px solid rgba(226, 232, 240, 0.9);
  box-shadow: 0 22px 70px rgba(15, 23, 42, 0.12);
  backdrop-filter: blur(18px);
  position: relative;
  overflow: hidden;
}

.auth-card::before {
  content: '';
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at var(--spot-x, 62%) var(--spot-y, 34%), rgba(57, 217, 138, 0.11), transparent 34%);
  pointer-events: none;
}

.mobile-lockup {
  display: none;
  margin-bottom: 28px;

  span {
    color: #64748b;
  }
}

.mobile-mascot,
.mobile-mascot-switch {
  display: none;
}

.mobile-mascot {
  position: absolute;
  right: 20px;
  top: 18px;
  width: 86px;
  height: 104px;
  pointer-events: none;

  img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    object-position: center bottom;
    filter: drop-shadow(0 12px 16px rgba(15, 23, 42, 0.18));
    animation: mascotFloat 4.8s ease-in-out infinite;
  }
}

.mobile-mascot-switch {
  position: relative;
  z-index: 1;
  width: fit-content;
  margin: -8px 0 18px;
  background: #f8fafc;
  border-color: #d8e0ea;

  button {
    color: #64748b;
  }

  button:hover,
  button.active {
    color: #0f172a;
    background: linear-gradient(135deg, #ccfbf1, #fef3c7);
  }
}

.auth-heading {
  position: relative;
  z-index: 1;
  margin-bottom: 22px;

  p {
    margin: 0 0 8px;
    color: #10b981;
    font-size: 13px;
    font-weight: 700;
  }

  h2 {
    margin: 0;
    font-size: 30px;
    line-height: 1.2;
    color: #0f172a;
    letter-spacing: 0;
  }
}

.mode-switch {
  position: relative;
  z-index: 1;
  display: grid;
  grid-template-columns: 1fr 1fr;
  padding: 4px;
  margin-bottom: 26px;
  border-radius: 8px;
  background: #eef2f7;

  button {
    height: 42px;
    border: 0;
    border-radius: 6px;
    background: transparent;
    color: #64748b;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.2s ease;

    &.active {
      color: #0f172a;
      background: #ffffff;
      box-shadow: 0 10px 24px rgba(15, 23, 42, 0.08);
    }
  }
}

.auth-role-brief {
  position: relative;
  z-index: 1;
  display: flex;
  gap: 12px;
  align-items: flex-start;
  padding: 13px 14px;
  margin-bottom: 18px;
  border: 1px solid #d8e0ea;
  border-radius: 8px;
  background: linear-gradient(135deg, #f8fafc, #ffffff);

  > span {
    width: 34px;
    height: 34px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    border-radius: 8px;
    color: #047857;
    background: #ecfdf5;
  }

  :deep(svg) {
    width: 18px;
    height: 18px;
  }

  strong {
    display: block;
    color: #0f172a;
    font-size: 13px;
    margin-bottom: 4px;
  }

  p {
    margin: 0;
    color: #64748b;
    font-size: 12px;
    line-height: 1.45;
  }
}

.auth-form {
  position: relative;
  z-index: 1;

  :deep(.el-form-item__label) {
    color: #334155;
    font-weight: 700;
    padding-bottom: 8px;
  }

  :deep(.el-input__wrapper) {
    min-height: 46px;
    border-radius: 8px !important;
    box-shadow: 0 0 0 1px #d8e0ea !important;
    transition: box-shadow 0.2s ease, transform 0.2s ease;
  }

  :deep(.el-input__wrapper.is-focus) {
    transform: translateY(-1px);
    box-shadow: 0 0 0 2px rgba(15, 118, 110, 0.35), 0 12px 22px rgba(15, 23, 42, 0.08) !important;
  }
}

.form-panel-enter-active,
.form-panel-leave-active {
  transition: opacity 0.22s ease, transform 0.22s ease;
}

.form-panel-enter-from {
  opacity: 0;
  transform: translateY(10px);
}

.form-panel-leave-to {
  opacity: 0;
  transform: translateY(-8px);
}

.role-picker {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 8px;
  margin-bottom: 18px;

  button {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    min-width: 0;
    height: 42px;
    border: 1px solid #d8e0ea;
    border-radius: 8px;
    background: #ffffff;
    color: #475569;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.2s ease;

    :deep(svg) {
      width: 16px;
      height: 16px;
      flex-shrink: 0;
    }

    &.active {
      border-color: #10b981;
      color: #047857;
      background: #ecfdf5;
      box-shadow: 0 10px 22px rgba(16, 185, 129, 0.12);
    }

    &:hover {
      transform: translateY(-2px);
      border-color: #94d7c9;
    }
  }
}

.form-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  margin: -2px 0 22px;
}

.text-btn {
  border: 0;
  background: transparent;
  color: #047857;
  font-weight: 700;
  cursor: pointer;
}

.register-note {
  margin: -2px 0 18px;
  padding: 12px 14px;
  border-radius: 8px;
  color: #475569;
  background: #f8fafc;
  border: 1px solid #e2e8f0;
  font-size: 13px;
  line-height: 1.6;
}

.register-progress,
.password-strength {
  display: flex;
  align-items: center;
  gap: 7px;
  margin-bottom: 14px;

  > span {
    height: 6px;
    flex: 1;
    border-radius: 999px;
    background: #e2e8f0;
    transition: background 0.22s ease, transform 0.22s ease;
  }

  > span.active {
    background: linear-gradient(90deg, #10b981, #5eead4);
    transform: scaleY(1.2);
  }

  strong {
    width: 92px;
    text-align: right;
    color: #64748b;
    font-size: 11px;
    font-weight: 700;
  }
}

.password-strength {
  margin-top: -8px;
  margin-bottom: 16px;

  strong {
    width: 78px;
  }
}

.submit-btn {
  width: 100%;
  height: 48px;
  border-radius: 8px;
  font-size: 15px;
  font-weight: 800;
  background: #0f766e;
  border-color: #0f766e;
  position: relative;
  overflow: hidden;
  transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;

  &:hover,
  &:focus {
    background: #115e59;
    border-color: #115e59;
    transform: translateY(-2px);
    box-shadow: 0 16px 30px rgba(15, 118, 110, 0.22);
  }

  &::after {
    content: '';
    position: absolute;
    top: 0;
    left: -40%;
    width: 30%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.32), transparent);
    transform: skewX(-18deg);
    transition: left 0.45s ease;
  }

  &:hover::after {
    left: 110%;
  }
}

@media (max-width: 1120px) {
  .auth-shell {
    grid-template-columns: 1fr;
    overflow: auto;
  }

  .auth-brand {
    min-height: 520px;
    padding: 28px;
  }

  .brand-main {
    margin-top: 28px;
  }

  .brand-hero-grid {
    grid-template-columns: minmax(340px, 1fr) minmax(240px, 0.62fr);
    gap: 20px;
  }

  .brand-main h1 {
    font-size: 34px;
  }

  .mascot-stage {
    min-height: 336px;
  }

  .mascot-stack {
    max-height: 322px;
    height: 322px;
    width: min(252px, 86%);
  }

  .mascot-ninja .mascot-stack {
    width: min(238px, 84%);
  }

  .mascot-halo {
    width: 230px;
    height: 230px;
    bottom: 62px;
  }

  .code-bubble {
    min-width: 98px;
    padding: 10px 12px;
  }

  .bubble-one {
    left: 0;
    bottom: 106px;
  }

  .bubble-two {
    right: 0;
    top: 58px;
  }

  .mascot-status {
    display: none;
  }

  .mascot-switch {
    top: 8px;
    right: 8px;
  }

  .workspace-preview {
    display: none;
  }

  .auth-panel {
    padding: 28px;
  }

  .mobile-lockup {
    display: flex;
  }
}

@media (max-width: 720px) {
  .auth-brand {
    display: none;
  }

  .auth-panel {
    min-height: 100vh;
    align-items: flex-start;
    padding: 20px;
  }

  .auth-card {
    padding: 26px 20px;
  }

  .mobile-lockup {
    display: flex;
    padding-right: 96px;
  }

  .mobile-mascot {
    display: block;
  }

  .mobile-mascot-switch {
    display: inline-grid;
  }

  .auth-heading h2 {
    font-size: 26px;
  }

  .role-picker {
    grid-template-columns: 1fr;
  }

  .form-row {
    align-items: flex-start;
    flex-direction: column;
  }
}
</style>
