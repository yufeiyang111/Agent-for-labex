<template>
  <div class="admin-dashboard">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator="/" class="breadcrumb">
      <el-breadcrumb-item :to="{ path: '/admin' }">管理员首页</el-breadcrumb-item>
      <el-breadcrumb-item>系统概览</el-breadcrumb-item>
    </el-breadcrumb>

    <!-- 页面标题 -->
    <h2 class="page-title">系统概览</h2>

    <!-- 统计卡片 -->
    <div class="stats-grid">
      <el-card class="stat-card" shadow="hover">
        <div class="stat-icon teacher-icon">
          <el-icon size="32"><User /></el-icon>
        </div>
        <div class="stat-content">
          <div class="stat-value">{{ stats.teacherCount || 0 }}</div>
          <div class="stat-label">教师数量</div>
        </div>
      </el-card>

      <el-card class="stat-card" shadow="hover">
        <div class="stat-icon student-icon">
          <el-icon size="32"><UserFilled /></el-icon>
        </div>
        <div class="stat-content">
          <div class="stat-value">{{ stats.studentCount || 0 }}</div>
          <div class="stat-label">学生数量</div>
        </div>
      </el-card>

      <el-card class="stat-card" shadow="hover">
        <div class="stat-icon clazz-icon">
          <el-icon size="32"><OfficeBuilding /></el-icon>
        </div>
        <div class="stat-content">
          <div class="stat-value">{{ stats.clazzCount || 0 }}</div>
          <div class="stat-label">班级数量</div>
        </div>
      </el-card>
    </div>

    <!-- 快捷操作 -->
    <el-card class="quick-actions" shadow="hover">
      <template #header>
        <div class="card-header">
          <span>快捷操作</span>
        </div>
      </template>
      <div class="actions-grid">
        <el-button type="primary" @click="router.push('/admin/teacher')">
          <el-icon><User /></el-icon>
          管理教师
        </el-button>
        <el-button type="success" @click="router.push('/admin/student')">
          <el-icon><UserFilled /></el-icon>
          管理学生
        </el-button>
        <el-button type="warning" @click="router.push('/admin/clazz')">
          <el-icon><OfficeBuilding /></el-icon>
          管理班级
        </el-button>
      </div>
    </el-card>

    <!-- 系统信息 -->
    <el-card class="system-info" shadow="hover">
      <template #header>
        <div class="card-header">
          <span>系统信息</span>
        </div>
      </template>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="系统名称">Labex 实验教学管理系统</el-descriptions-item>
        <el-descriptions-item label="版本">1.0.0</el-descriptions-item>
        <el-descriptions-item label="当前管理员">{{ userStore.userInfo?.name || '未知' }}</el-descriptions-item>
        <el-descriptions-item label="登录账号">{{ userStore.userInfo?.account || '未知' }}</el-descriptions-item>
      </el-descriptions>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/user'
import { adminApi } from '@/api/index.js'
import { User, UserFilled, OfficeBuilding } from '@element-plus/icons-vue'

const router = useRouter()
const userStore = useUserStore()

const stats = reactive({
  teacherCount: 0,
  studentCount: 0,
  clazzCount: 0
})

const loadStats = async () => {
  try {
    const response = await adminApi.stats()
    if (response.data) {
      Object.assign(stats, response.data)
    }
  } catch (error) {
    console.error('加载统计信息失败', error)
  }
}

onMounted(() => {
  loadStats()
})
</script>

<style scoped>
.admin-dashboard {
  padding: 32px;
}

.breadcrumb {
  margin-bottom: 28px;
}

.page-title {
  font-size: 28px;
  font-weight: 700;
  color: #1d1d1f;
  margin: 0 0 28px 0;
  letter-spacing: -0.5px;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
  margin-bottom: 28px;
}

.stat-card {
  display: flex;
  align-items: center;
  padding: 28px;
  border-radius: 20px;
  transition: all 0.35s cubic-bezier(0.25, 0.1, 0.25, 1);
  border: none;
  background: #ffffff;
}

.stat-card:hover {
  transform: translateY(-3px) scale(1.02);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
}

.stat-icon {
  width: 68px;
  height: 68px;
  border-radius: 18px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 24px;
  color: #fff;
}

.teacher-icon {
  background: #4caf50;
  box-shadow: 0 8px 24px rgba(76, 175, 80, 0.35);
}

.student-icon {
  background: #3b82f6;
  box-shadow: 0 8px 24px rgba(59, 130, 246, 0.35);
}

.clazz-icon {
  background: #f59e0b;
  box-shadow: 0 8px 24px rgba(245, 158, 11, 0.35);
}

.stat-content {
  flex: 1;
}

.stat-value {
  font-size: 36px;
  font-weight: 700;
  color: #1d1d1f;
  line-height: 1;
  letter-spacing: -1px;
}

.stat-label {
  font-size: 14px;
  color: #6e6e73;
  margin-top: 8px;
  font-weight: 500;
}

.quick-actions {
  margin-bottom: 28px;
  border-radius: 20px;
  border: none;
}

.card-header {
  font-size: 16px;
  font-weight: 600;
  color: #1d1d1f;
  padding: 20px 24px;
  border-bottom: 1px solid #f0f0f0;
}

.actions-grid {
  display: flex;
  gap: 16px;
  padding: 24px;
}

.actions-grid .el-button {
  padding: 16px 32px;
  font-size: 14px;
  font-weight: 600;
  border-radius: 14px;
  transition: all 0.3s cubic-bezier(0.25, 0.1, 0.25, 1);
}

.actions-grid .el-button .el-icon {
  margin-right: 10px;
}

.system-info {
  border-radius: 20px;
  border: none;
}

.system-info :deep(.el-descriptions__label) {
  background: #fafafa;
  color: #6e6e73;
  font-weight: 600;
  font-size: 13px;
}

.system-info :deep(.el-descriptions__content) {
  color: #1d1d1f;
  font-size: 14px;
}
</style>