<template>
  <div class="profile-page">
    <el-card class="page-header">
      <div class="header-content">
        <div class="header-left">
          <div class="avatar-wrapper">
            <el-upload
              :show-file-list="false"
              :before-upload="beforeAvatarUpload"
              :http-request="handleAvatarUpload"
              accept="image/png,image/jpeg,image/jpg,image/gif,image/webp"
            >
              <el-avatar
                v-if="avatarUrl"
                :src="avatarUrl"
                :size="72"
                class="avatar-img"
              />
              <div v-else class="avatar">
                {{ userInfo?.name?.[0] || userInfo?.account?.[0] || '?' }}
              </div>
              <div class="avatar-hover">
                <el-icon><Camera /></el-icon>
              </div>
            </el-upload>
          </div>
          <div class="user-info">
            <h2>{{ userInfo?.name || userInfo?.account || '未登录' }}</h2>
            <p class="user-meta">
              <el-tag :type="getRoleTagType(userInfo?.role)" size="small">
                {{ roleText }}
              </el-tag>
              <span class="meta-text" v-if="userInfo?.role === 'STUDENT' && userInfo?.clazzName">
                {{ userInfo.clazzName }}
              </span>
            </p>
          </div>
        </div>
        <div class="header-right">
          <el-button type="primary" @click="showPasswordDialog = true">
            <el-icon><Lock /></el-icon>
            修改密码
          </el-button>
        </div>
      </div>
    </el-card>

    <div class="profile-content">
      <el-row :gutter="20">
        <el-col :span="16">
          <el-card class="info-card">
            <template #header>
              <div class="card-header">
                <el-icon><User /></el-icon>
                <span>基本信息</span>
              </div>
            </template>
            <div class="info-grid">
              <div class="info-item">
                <span class="label">用户名</span>
                <span class="value">{{ userInfo?.account || '-' }}</span>
              </div>
              <div class="info-item">
                <span class="label">姓名</span>
                <span class="value">{{ userInfo?.name || '-' }}</span>
              </div>
              <div class="info-item">
                <span class="label">角色</span>
                <span class="value">
                  <el-tag :type="getRoleTagType(userInfo?.role)" size="small">
                    {{ roleText }}
                  </el-tag>
                </span>
              </div>
              <div class="info-item" v-if="userInfo?.role === 'STUDENT'">
                <span class="label">学号</span>
                <span class="value">{{ userInfo?.studentNo || '-' }}</span>
              </div>
              <div class="info-item" v-if="userInfo?.role === 'TEACHER' || userInfo?.role === 'ADMIN'">
                <span class="label">工号</span>
                <span class="value">{{ userInfo?.teacherAccount || userInfo?.account || '-' }}</span>
              </div>
              <div class="info-item" v-if="userInfo?.clazzNo">
                <span class="label">班级编号</span>
                <span class="value">{{ userInfo.clazzNo }}</span>
              </div>
              <div class="info-item" v-if="userInfo?.clazzName">
                <span class="label">班级名称</span>
                <span class="value">{{ userInfo.clazzName }}</span>
              </div>
            </div>
          </el-card>

          <el-card class="info-card">
            <template #header>
              <div class="card-header">
                <el-icon><InfoFilled /></el-icon>
                <span>账户信息</span>
              </div>
            </template>
            <div class="info-grid">
              <div class="info-item">
                <span class="label">账号</span>
                <span class="value">{{ userInfo?.account || '-' }}</span>
              </div>
              <div class="info-item">
                <span class="label">状态</span>
                <span class="value">
                  <el-tag :type="userInfo?.state === 0 ? 'danger' : 'success'" size="small">
                    {{ statusText }}
                  </el-tag>
                </span>
              </div>
              <div class="info-item">
                <span class="label">绑定 IP</span>
                <span class="value">{{ userInfo?.ip || '未绑定' }}</span>
              </div>
              <div class="info-item" v-if="userInfo?.errorCount !== undefined">
                <span class="label">错误次数</span>
                <span class="value">{{ userInfo?.errorCount || 0 }} 次</span>
              </div>
              <div class="info-item full-width" v-if="userInfo?.createTime">
                <span class="label">创建时间</span>
                <span class="value">{{ formatDateTime(userInfo?.createTime) }}</span>
              </div>
            </div>
          </el-card>
        </el-col>

        <el-col :span="8">
          <el-card class="stats-card">
            <template #header>
              <div class="card-header">
                <el-icon><DataLine /></el-icon>
                <span>学习统计</span>
              </div>
            </template>
            <div class="stats-grid">
              <div class="stat-item">
                <div class="stat-icon green">
                  <el-icon><Finished /></el-icon>
                </div>
                <div class="stat-info">
                  <span class="stat-value">{{ stats.experimentCount }}</span>
                  <span class="stat-label">已完成实验</span>
                </div>
              </div>
              <div class="stat-item">
                <div class="stat-icon blue">
                  <el-icon><Document /></el-icon>
                </div>
                <div class="stat-info">
                  <span class="stat-value">{{ stats.examCount }}</span>
                  <span class="stat-label">参加考试</span>
                </div>
              </div>
              <div class="stat-item">
                <div class="stat-icon purple">
                  <el-icon><Edit /></el-icon>
                </div>
                <div class="stat-info">
                  <span class="stat-value">{{ stats.questionCount }}</span>
                  <span class="stat-label">答题数量</span>
                </div>
              </div>
              <div class="stat-item">
                <div class="stat-icon orange">
                  <el-icon><Star /></el-icon>
                </div>
                <div class="stat-info">
                  <span class="stat-value">{{ stats.avgScore }}</span>
                  <span class="stat-label">平均成绩</span>
                </div>
              </div>
            </div>
          </el-card>

          <el-card class="scores-card" v-if="recentScores.length > 0">
            <template #header>
              <div class="card-header">
                <el-icon><TrendCharts /></el-icon>
                <span>最近成绩</span>
              </div>
            </template>
            <div class="scores-list">
              <div v-for="score in recentScores" :key="score.id" class="score-item">
                <div class="score-info">
                  <span class="score-name">{{ score.experimentName || '实验' + score.experimentId }}</span>
                  <span class="score-time">{{ formatDate(score.submitTime || score.createTime) }}</span>
                </div>
                <el-tag :type="getScoreTagType(score.score)" size="small">
                  {{ score.score !== null ? score.score + '分' : '待评分' }}
                </el-tag>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </div>

    <el-dialog
      v-model="showPasswordDialog"
      title="修改密码"
      width="450px"
      :close-on-click-modal="false"
    >
      <el-form :model="passwordForm" label-width="100px" @submit.prevent="handleChangePassword">
        <el-form-item label="当前密码">
          <el-input
            v-model="passwordForm.oldPassword"
            type="password"
            show-password
            placeholder="请输入当前密码"
          />
        </el-form-item>
        <el-form-item label="新密码">
          <el-input
            v-model="passwordForm.newPassword"
            type="password"
            show-password
            placeholder="请输入新密码"
          />
        </el-form-item>
        <el-form-item label="确认密码">
          <el-input
            v-model="passwordForm.confirmPassword"
            type="password"
            show-password
            placeholder="请再次输入新密码"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showPasswordDialog = false">取消</el-button>
        <el-button type="primary" @click="handleChangePassword" :loading="loading">
          确认修改
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useUserStore } from '@/stores/user'
import { authApi, studentApi } from '@/api'
import { ElMessage } from 'element-plus'
import {
  User,
  Lock,
  Camera,
  InfoFilled,
  DataLine,
  Finished,
  Document,
  Edit,
  Star,
  TrendCharts
} from '@element-plus/icons-vue'

const userStore = useUserStore()
const userInfo = computed(() => userStore.userInfo)
const showPasswordDialog = ref(false)
const loading = ref(false)
const avatarUrl = ref('')
const avatarLoading = ref(false)

const passwordForm = ref({
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
})

const stats = ref({
  experimentCount: 0,
  examCount: 0,
  questionCount: 0,
  avgScore: 0
})

const recentScores = ref([])

const roleText = computed(() => {
  const role = userInfo.value?.role
  if (role === 'STUDENT') return '学生'
  if (role === 'TEACHER') return '教师'
  if (role === 'ADMIN') return '管理员'
  return role || '-'
})

const getRoleTagType = (role) => {
  const typeMap = {
    STUDENT: 'success',
    TEACHER: 'primary',
    ADMIN: 'warning'
  }
  return typeMap[role] || 'info'
}

const statusText = computed(() => {
  const state = userInfo.value?.state
  if (state === 1 || state === undefined) return '正常'
  if (state === 0) return '禁用'
  return '未知'
})

const getScoreTagType = (score) => {
  if (score === null || score === undefined) return 'info'
  if (score >= 90) return 'success'
  if (score >= 80) return 'primary'
  if (score >= 60) return 'warning'
  return 'danger'
}

const formatDateTime = (dateTime) => {
  if (!dateTime) return '-'
  const date = new Date(dateTime)
  return date.toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit'
  })
}

const formatDate = (dateTime) => {
  if (!dateTime) return '-'
  const date = new Date(dateTime)
  return date.toLocaleDateString('zh-CN')
}

const beforeAvatarUpload = (file) => {
  const isImage = file.type.startsWith('image/')
  const isAllowed = /\.(png|jpe?g|gif|webp)$/i.test(file.name)

  if (!isImage) {
    ElMessage.error('只能上传图片文件！')
    return false
  }
  if (!isAllowed) {
    ElMessage.error('仅支持 PNG、JPG、JPEG、GIF、WebP 格式！')
    return false
  }
  const isLt5M = file.size / 1024 / 1024 < 5
  if (!isLt5M) {
    ElMessage.error('头像大小不能超过 5MB！')
    return false
  }
  return true
}

const handleAvatarUpload = async ({ file }) => {
  avatarLoading.value = true
  try {
    await authApi.uploadAvatar(file)
    ElMessage.success('头像上传成功')
    await userStore.getUserInfo()
    loadAvatar()
  } catch (error) {
    ElMessage.error(error.message || '头像上传失败')
  } finally {
    avatarLoading.value = false
  }
}

const loadAvatar = async () => {
  try {
    if (userInfo.value?.avatar && userInfo.value.avatar.trim() !== '') {
      avatarUrl.value = userInfo.value.avatar
      return
    }
  } catch (error) {
    console.error('加载头像失败', error)
  }
}

const loadStats = async () => {
  try {
    const [statsRes, scoresRes] = await Promise.all([
      studentApi.stats(),
      studentApi.scores()
    ])

    if (statsRes?.data) {
      stats.value = {
        experimentCount: Number(statsRes.data.experimentCount || 0),
        examCount: Number(statsRes.data.examCount || 0),
        questionCount: Number(statsRes.data.questionCount || 0),
        avgScore: Number(statsRes.data.avgScore || 0)
      }
    }

    if (scoresRes?.data) {
      const scores = Array.isArray(scoresRes.data) ? scoresRes.data : []
      recentScores.value = scores.slice(0, 5)
    }
  } catch (error) {
    console.error('获取统计数据失败:', error)
  }
}

const handleChangePassword = async () => {
  if (!passwordForm.value.oldPassword) {
    ElMessage.warning('请输入当前密码')
    return
  }
  if (!passwordForm.value.newPassword) {
    ElMessage.warning('请输入新密码')
    return
  }
  if (passwordForm.value.newPassword !== passwordForm.value.confirmPassword) {
    ElMessage.warning('两次输入的密码不一致')
    return
  }
  if (passwordForm.value.newPassword.length < 6) {
    ElMessage.warning('密码长度不能少于6位')
    return
  }

  loading.value = true
  try {
    await authApi.updatePassword({
      oldPassword: passwordForm.value.oldPassword,
      newPassword: passwordForm.value.newPassword
    })
    ElMessage.success('密码修改成功')
    showPasswordDialog.value = false
    passwordForm.value = { oldPassword: '', newPassword: '', confirmPassword: '' }
  } catch (error) {
    ElMessage.error(error.message || '密码修改失败')
  } finally {
    loading.value = false
  }
}

onMounted(async () => {
  await userStore.getUserInfo()
  loadAvatar()
  if (userInfo.value?.role === 'STUDENT') {
    loadStats()
  }
})
</script>

<style lang="scss" scoped>
.profile-page {
  max-width: 1200px;
  margin: 0 auto;
}

.page-header {
  margin-bottom: 20px;
  background: #e8f5e9;
  border: none;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.15);

  .header-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  .header-left {
    display: flex;
    align-items: center;
    gap: 20px;
  }

  .avatar-wrapper {
    position: relative;

    .el-upload {
      cursor: pointer;
    }

    .avatar-img {
      display: block;
      border-radius: 50%;
      box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
    }

    .avatar {
      width: 72px;
      height: 72px;
      border-radius: 50%;
      background: #4caf50;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 28px;
      font-weight: 600;
      color: #fff;
      text-transform: uppercase;
      box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
    }

    .avatar-hover {
      position: absolute;
      top: 0;
      left: 0;
      width: 72px;
      height: 72px;
      border-radius: 50%;
      background: rgba(0, 0, 0, 0.5);
      display: flex;
      align-items: center;
      justify-content: center;
      opacity: 0;
      transition: opacity 0.3s ease;
      color: #fff;
      font-size: 24px;

      .el-icon {
        font-size: 24px;
      }
    }

    &:hover .avatar-hover {
      opacity: 1;
    }
  }

  .user-info {
    h2 {
      color: #2e7d32;
      font-size: 24px;
      font-weight: 700;
      margin: 0 0 8px;
    }

    .user-meta {
      display: flex;
      align-items: center;
      gap: 12px;
      margin: 0;

      .meta-text {
        color: #606266;
        font-size: 14px;
      }
    }
  }
}

.profile-content {
  .el-card {
    border-radius: 12px;
    margin-bottom: 20px;
    border: 1px solid #ebeef5;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    transition: all 0.3s;

    &:hover {
      box-shadow: 0 4px 16px rgba(76, 175, 80, 0.15);
    }
  }
}

.card-header {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 16px;
  font-weight: 600;
  color: #303133;

  .el-icon {
    color: #4caf50;
  }
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 6px;

  &.full-width {
    grid-column: 1 / -1;
  }

  .label {
    font-size: 13px;
    color: #909399;
  }

  .value {
    font-size: 15px;
    color: #303133;
    font-weight: 500;
  }
}

.stats-card .stats-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 16px;
  background: #f5f7fa;
  border-radius: 8px;
  transition: all 0.3s;

  &:hover {
    background: #e8f5e9;
  }

  .stat-icon {
    width: 44px;
    height: 44px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;

    .el-icon {
      font-size: 20px;
    }

    &.green {
      background: rgba(76, 175, 80, 0.15);
      color: #4caf50;
    }

    &.blue {
      background: rgba(64, 158, 255, 0.15);
      color: #409eff;
    }

    &.purple {
      background: rgba(144, 147, 153, 0.15);
      color: #909399;
    }

    &.orange {
      background: rgba(230, 162, 60, 0.15);
      color: #e6a23c;
    }
  }

  .stat-info {
    display: flex;
    flex-direction: column;
    gap: 2px;

    .stat-value {
      font-size: 22px;
      font-weight: 700;
      color: #303133;
      line-height: 1.2;
    }

    .stat-label {
      font-size: 12px;
      color: #909399;
    }
  }
}

.scores-list {
  .score-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12px 0;
    border-bottom: 1px solid #f0f0f0;

    &:last-child {
      border-bottom: none;
    }

    .score-info {
      display: flex;
      flex-direction: column;
      gap: 4px;

      .score-name {
        font-size: 14px;
        color: #303133;
      }

      .score-time {
        font-size: 12px;
        color: #909399;
      }
    }
  }
}

@media (max-width: 768px) {
  .page-header {
    .header-content {
      flex-direction: column;
      gap: 16px;
      text-align: center;
    }

    .header-left {
      flex-direction: column;
    }
  }

  .info-grid {
    grid-template-columns: 1fr;
  }

  .stats-card .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}
</style>
