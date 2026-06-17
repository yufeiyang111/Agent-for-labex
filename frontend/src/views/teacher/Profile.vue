<template>
  <div class="profile-page wabi-page">
    <div class="wabi-body">
      <!-- 用户信息头部 -->
      <div class="profile-header wabi-card">
        <div class="wabi-card-content">
          <div class="user-section">
            <div class="avatar-wrapper">
              <el-upload
                :show-file-list="false"
                :before-upload="beforeAvatarUpload"
                :http-request="handleAvatarUpload"
                accept="image/png,image/jpeg,image/jpg,image/gif,image/webp"
              >
                <el-avatar v-if="avatarUrl" :src="avatarUrl" :size="64" class="avatar-img" />
                <div v-else class="avatar-placeholder">
                  {{ userInfo?.name?.[0] || userInfo?.account?.[0] || '?' }}
                </div>
                <div class="avatar-overlay">
                  <el-icon><Camera /></el-icon>
                </div>
              </el-upload>
            </div>
            <div class="user-info">
              <h2 class="user-name">{{ userInfo?.name || userInfo?.account || '未登录' }}</h2>
              <div class="user-meta">
                <span class="wabi-tag" :class="getRoleClass(userInfo?.role)">{{ roleText }}</span>
                <span v-if="userInfo?.teacherAccount" class="meta-text">
                  工号: {{ userInfo.teacherAccount || userInfo.account }}
                </span>
              </div>
            </div>
          </div>
          <el-button @click="showPasswordDialog = true" class="wabi-btn-ghost">
            修改密码
          </el-button>
        </div>
      </div>

      <!-- 详细信息 -->
      <div class="profile-content">
        <div class="wabi-card">
          <div class="wabi-card-header">
            <span class="wabi-card-title">基本信息</span>
          </div>
          <div class="wabi-card-content">
            <div class="info-grid">
              <div class="info-item">
                <span class="info-label">用户名</span>
                <span class="info-value">{{ userInfo?.account || '-' }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">姓名</span>
                <span class="info-value">{{ userInfo?.name || '-' }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">角色</span>
                <span class="info-value">
                  <span class="wabi-tag" :class="getRoleClass(userInfo?.role)">{{ roleText }}</span>
                </span>
              </div>
              <div class="info-item">
                <span class="info-label">工号</span>
                <span class="info-value">{{ userInfo?.teacherAccount || userInfo?.account || '-' }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">性别</span>
                <span class="info-value">{{ genderText }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">邮箱</span>
                <span class="info-value">{{ userInfo?.email || '-' }}</span>
              </div>
              <div class="info-item full-width">
                <span class="info-label">个人简介</span>
                <span class="info-value">{{ userInfo?.intro || '暂无简介' }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 修改密码对话框 -->
    <el-dialog v-model="showPasswordDialog" title="修改密码" width="400" class="wabi-dialog">
      <el-form ref="passwordFormRef" :model="passwordForm" :rules="passwordRules" label-width="100" class="wabi-form">
        <el-form-item label="原密码" prop="oldPassword">
          <el-input v-model="passwordForm.oldPassword" type="password" show-password />
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
          <el-input v-model="passwordForm.newPassword" type="password" show-password />
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input v-model="passwordForm.confirmPassword" type="password" show-password />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showPasswordDialog = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="handleChangePassword" class="wabi-btn-primary">确认</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { Camera } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'
import { teacherApi, authApi } from '@/api'

const userStore = useUserStore()
const userInfo = computed(() => userStore.userInfo)
const avatarUrl = ref('')
const showPasswordDialog = ref(false)
const passwordFormRef = ref()

const passwordForm = ref({
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
})

const passwordRules = {
  oldPassword: [{ required: true, message: '请输入原密码', trigger: 'blur' }],
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, message: '密码长度不能小于6位', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认密码', trigger: 'blur' },
    {
      validator: (rule, value, callback) => {
        if (value !== passwordForm.value.newPassword) {
          callback(new Error('两次密码不一致'))
        } else {
          callback()
        }
      },
      trigger: 'blur'
    }
  ]
}

const roleText = computed(() => {
  const role = userInfo.value?.role
  if (role === 'TEACHER') return '教师'
  if (role === 'ADMIN') return '管理员'
  if (role === 'STUDENT') return '学生'
  return '未知'
})

const genderText = computed(() => {
  const gender = userInfo.value?.gender
  if (gender === 'male' || gender === 1) return '男'
  if (gender === 'female' || gender === 2) return '女'
  return '未设置'
})

const getRoleClass = (role) => ({
  TEACHER: 'wabi-tag-accent',
  ADMIN: 'wabi-tag-warning',
  STUDENT: ''
}[role] || '')

const beforeAvatarUpload = (file) => {
  const isImage = ['image/png', 'image/jpeg', 'image/jpg', 'image/gif', 'image/webp'].includes(file.type)
  const isLt2M = file.size / 1024 / 1024 < 2
  if (!isImage) {
    ElMessage.error('只能上传图片文件')
    return false
  }
  if (!isLt2M) {
    ElMessage.error('图片大小不能超过 2MB')
    return false
  }
  return true
}

const handleAvatarUpload = async (options) => {
  try {
    const res = await authApi.uploadAvatar(options.file)
    avatarUrl.value = res.data?.url || ''
    userStore.updateUserInfo({ avatar: avatarUrl.value })
    ElMessage.success('头像更新成功')
  } catch (error) {
    ElMessage.error('头像上传失败')
  }
}

const handleChangePassword = async () => {
  await passwordFormRef.value.validate()
  try {
    await authApi.updatePassword({
      oldPassword: passwordForm.value.oldPassword,
      newPassword: passwordForm.value.newPassword
    })
    ElMessage.success('密码修改成功')
    showPasswordDialog.value = false
    passwordForm.value = { oldPassword: '', newPassword: '', confirmPassword: '' }
  } catch (error) {
    ElMessage.error('密码修改失败')
  }
}

onMounted(() => {
  if (userInfo.value?.avatar) {
    avatarUrl.value = userInfo.value.avatar
  }
})
</script>

<style scoped>
.profile-page {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-body {
  padding: 24px;
  max-width: 900px;
  margin: 0 auto;
  animation: wabi-fade-in 0.4s ease;
}

@keyframes wabi-fade-in {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 头部卡片 */
.profile-header .wabi-card-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.user-section {
  display: flex;
  align-items: center;
  gap: 20px;
}

.avatar-wrapper {
  position: relative;
  cursor: pointer;
}

.avatar-img {
  border: 2px solid var(--wabi-border, #e8e4df);
}

.avatar-placeholder {
  width: 64px;
  height: 64px;
  border-radius: 50%;
  background: var(--wabi-accent-light, #e8ede5);
  color: var(--wabi-accent, #7a8b6f);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  font-weight: 500;
}

.avatar-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  opacity: 0;
  transition: opacity 0.2s ease;
}

.avatar-wrapper:hover .avatar-overlay {
  opacity: 1;
}

.user-name {
  font-size: 20px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0 0 4px 0;
}

.user-meta {
  display: flex;
  align-items: center;
  gap: 8px;
}

.meta-text {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 详细信息 */
.profile-content {
  margin-top: 16px;
}

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
  color: var(--wabi-text-secondary, #8a8580);
}

.info-value {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
}

/* 标签 */
.wabi-tag {
  display: inline-block;
  padding: 2px 8px;
  background: var(--wabi-border-light, #f0ece8);
  color: var(--wabi-text-secondary, #8a8580);
  font-size: 12px;
  border-radius: 2px;
}

.wabi-tag-accent {
  background: var(--wabi-accent-light, #e8ede5);
  color: var(--wabi-accent, #7a8b6f);
}

.wabi-tag-warning {
  background: #f5efe4;
  color: #a0937d;
}

/* 按钮 */
.wabi-btn-primary {
  background: var(--wabi-accent, #7a8b6f);
  border-color: var(--wabi-accent, #7a8b6f);
  border-radius: 4px;
}

.wabi-btn-primary:hover {
  background: #6b7d60;
  border-color: #6b7d60;
}

.wabi-btn-ghost {
  border-color: var(--wabi-border, #e8e4df);
  color: var(--wabi-text-secondary, #8a8580);
  border-radius: 4px;
}

.wabi-btn-ghost:hover {
  border-color: var(--wabi-accent, #7a8b6f);
  color: var(--wabi-accent, #7a8b6f);
}

/* 响应式 */
@media (max-width: 768px) {
  .wabi-body {
    padding: 16px;
  }

  .profile-header .wabi-card-content {
    flex-direction: column;
    gap: 16px;
  }

  .user-section {
    flex-direction: column;
    text-align: center;
  }

  .user-meta {
    justify-content: center;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }

  .info-item.full-width {
    grid-column: span 1;
  }
}
</style>
