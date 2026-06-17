<template>
  <div class="profile-page">
    <!-- 页面标题 -->
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
              <el-tag type="warning" size="small">
                {{ roleText }}
              </el-tag>
              <span class="meta-text" v-if="userInfo?.teacherAccount">
                工号: {{ userInfo.teacherAccount || userInfo.account }}
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

    <!-- 内容区 -->
    <div class="profile-content">
      <el-row :gutter="20">
        <!-- 左侧信息卡片 -->
        <el-col :span="16">
          <!-- 基本信息 -->
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
                  <el-tag type="warning" size="small">
                    {{ roleText }}
                  </el-tag>
                </span>
              </div>
              <div class="info-item">
                <span class="label">工号</span>
                <span class="value">{{ userInfo?.teacherAccount || userInfo?.account || '-' }}</span>
              </div>
              <div class="info-item full-width" v-if="userInfo?.createTime">
                <span class="label">创建时间</span>
                <span class="value">{{ formatDateTime(userInfo?.createTime) }}</span>
              </div>
            </div>
          </el-card>

          <!-- 账号信息 -->
          <el-card class="info-card">
            <template #header>
              <div class="card-header">
                <el-icon><InfoFilled /></el-icon>
                <span>账号信息</span>
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
              <div class="info-item" v-if="userInfo?.ip">
                <span class="label">绑定IP</span>
                <span class="value">{{ userInfo?.ip }}</span>
              </div>
              <div class="info-item" v-if="userInfo?.errorCount !== undefined">
                <span class="label">错误次数</span>
                <span class="value">{{ userInfo?.errorCount || 0 }} 次</span>
              </div>
            </div>
          </el-card>
        </el-col>

        <!-- 右侧快捷操作 -->
        <el-col :span="8">
          <el-card class="actions-card">
            <template #header>
              <div class="card-header">
                <el-icon><Tools /></el-icon>
                <span>快捷操作</span>
              </div>
            </template>
            <div class="actions-list">
              <div class="action-item" @click="showPasswordDialog = true">
                <div class="action-icon">
                  <el-icon><Lock /></el-icon>
                </div>
                <div class="action-info">
                  <span class="action-title">修改密码</span>
                  <span class="action-desc">定期修改密码保护账号安全</span>
                </div>
                <el-icon class="action-arrow"><ArrowRight /></el-icon>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </div>

    <!-- 修改密码对话框 -->
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
import { authApi } from '@/api'
import { ElMessage } from 'element-plus'
import {
  User,
  Lock,
  Camera,
  InfoFilled,
  Tools,
  ArrowRight
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

const roleText = computed(() => {
  const role = userInfo.value?.role
  if (role === 'ADMIN') return '管理员'
  if (role === 'TEACHER') return '教师'
  return role || '-'
})

const statusText = computed(() => {
  const state = userInfo.value?.state
  if (state === 1 || state === undefined) return '正常'
  if (state === 0) return '禁用'
  return '未知'
})

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
})
</script>

<style lang="scss" scoped>
.profile-page {
  max-width: 1200px;
  margin: 0 auto;
}

// 页面标题卡片
.page-header {
  margin-bottom: 20px;
  background: #fff7f0;
  border: none;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(230, 162, 60, 0.15);

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
      box-shadow: 0 4px 12px rgba(230, 162, 60, 0.3);
    }

    .avatar {
      width: 72px;
      height: 72px;
      border-radius: 50%;
      background: #e6a23c;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 28px;
      font-weight: 600;
      color: #fff;
      text-transform: uppercase;
      box-shadow: 0 4px 12px rgba(230, 162, 60, 0.3);
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
      color: #b45309;
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

// 内容区
.profile-content {
  .el-card {
    border-radius: 12px;
    margin-bottom: 20px;
    border: 1px solid #ebeef5;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    transition: all 0.3s;

    &:hover {
      box-shadow: 0 4px 16px rgba(230, 162, 60, 0.15);
    }
  }
}

// 卡片头部
.card-header {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 16px;
  font-weight: 600;
  color: #303133;

  .el-icon {
    color: #e6a23c;
  }
}

// 信息网格
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

// 快捷操作
.actions-list {
  .action-item {
    display: flex;
    align-items: center;
    gap: 16px;
    padding: 16px;
    background: #f5f7fa;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s;

    &:hover {
      background: #fef0e6;

      .action-icon {
        background: #e6a23c;
        color: #fff;
      }

      .action-arrow {
        color: #e6a23c;
      }
    }

    .action-icon {
      width: 44px;
      height: 44px;
      border-radius: 10px;
      background: rgba(230, 162, 60, 0.15);
      color: #e6a23c;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all 0.3s;

      .el-icon {
        font-size: 20px;
      }
    }

    .action-info {
      flex: 1;
      display: flex;
      flex-direction: column;
      gap: 4px;

      .action-title {
        font-size: 15px;
        font-weight: 600;
        color: #303133;
      }

      .action-desc {
        font-size: 12px;
        color: #909399;
      }
    }

    .action-arrow {
      font-size: 16px;
      color: #c0c4cc;
      transition: color 0.3s;
    }
  }
}

// 响应式
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
}
</style>
