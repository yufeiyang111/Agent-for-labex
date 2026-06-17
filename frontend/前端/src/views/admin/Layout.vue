<template>
  <div class="admin-layout">
    <el-container>
      <!-- 侧边栏 -->
      <el-aside :width="isCollapsed ? '64px' : '220px'" class="sidebar">
        <div class="logo">
          <AppIcon :size="isCollapsed ? 34 : 36" compact />
          <span v-if="!isCollapsed" class="logo-text">Labex</span>
        </div>

        <el-menu
          :default-active="activeMenu"
          class="sidebar-menu"
          :collapse="isCollapsed"
          :collapse-transition="false"
          router
        >
          <el-menu-item index="/admin/dashboard">
            <el-icon><Odometer /></el-icon>
            <template #title>系统概览</template>
          </el-menu-item>
          <el-menu-item index="/admin/teacher">
            <el-icon><User /></el-icon>
            <template #title>教师管理</template>
          </el-menu-item>
          <el-menu-item index="/admin/student">
            <el-icon><UserFilled /></el-icon>
            <template #title>学生管理</template>
          </el-menu-item>
          <el-menu-item index="/admin/clazz">
            <el-icon><OfficeBuilding /></el-icon>
            <template #title>班级管理</template>
          </el-menu-item>
          <el-menu-item index="/admin/profile">
            <el-icon><Setting /></el-icon>
            <template #title>个人中心</template>
          </el-menu-item>
        </el-menu>
      </el-aside>

      <el-container>
        <!-- 顶部导航 -->
        <el-header class="header">
          <div class="header-left">
            <el-button
              text
              @click="isCollapsed = !isCollapsed"
              class="collapse-btn"
            >
              <el-icon size="20">
                <Fold v-if="!isCollapsed" />
                <Expand v-else />
              </el-icon>
            </el-button>
          </div>
          <div class="header-right">
            <el-dropdown @command="handleCommand">
              <span class="user-info">
                <el-avatar
                  v-if="userStore.userInfo?.avatar"
                  :src="baseUrl + userStore.userInfo.avatar"
                  :size="32"
                />
                <el-icon v-else><UserFilled /></el-icon>
                <span class="username">{{ userStore.userInfo?.name || '管理员' }}</span>
                <el-icon><ArrowDown /></el-icon>
              </span>
              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item command="profile">
                    <el-icon><User /></el-icon>
                    个人设置
                  </el-dropdown-item>
                  <el-dropdown-item command="logout" divided>
                    <el-icon><SwitchButton /></el-icon>
                    退出登录
                  </el-dropdown-item>
                </el-dropdown-menu>
              </template>
            </el-dropdown>
          </div>
        </el-header>

        <!-- 主内容区 -->
        <el-main class="main-content">
          <router-view />
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessageBox, ElMessage } from 'element-plus'
import { useUserStore } from '@/stores/user'
import AppIcon from '@/components/AppIcon.vue'
import {
  Odometer,
  User,
  UserFilled,
  OfficeBuilding,
  Fold,
  Expand,
  ArrowDown,
  SwitchButton,
  Setting
} from '@element-plus/icons-vue'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()
const baseUrl = import.meta.env.VITE_API_BASE_URL || ''

const isCollapsed = ref(false)

const activeMenu = computed(() => route.path)

const handleCommand = async (command) => {
  if (command === 'logout') {
    try {
      await ElMessageBox.confirm('确定要退出登录吗？', '提示', {
        type: 'warning'
      })
      userStore.logout()
      router.push('/login')
      ElMessage.success('已退出登录')
    } catch {
      // 取消操作
    }
  } else if (command === 'profile') {
    router.push('/admin/profile')
  }
}
</script>

<style scoped>
/* Biophilic 亲自然风格 Layout - 管理员视角的绿植空间 */
.admin-layout {
  height: 100vh;
  background: #f8faf6;
}

.el-container {
  height: 100%;
}

.sidebar {
  background: linear-gradient(180deg, #ffffff 0%, #fafcf8 100%);
  transition: width 0.22s ease;
  overflow: hidden;
  box-shadow: 2px 0 12px rgba(90, 143, 92, 0.04);
}

.logo {
  height: 64px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 20px;
  border-bottom: 1px solid #e4ebe0;
  background: linear-gradient(135deg, #f4f8f0 0%, #ffffff 100%);
}

.logo-text {
  color: #2c3e2c;
  font-size: 18px;
  font-weight: 600;
  letter-spacing: -0.3px;
  margin-left: 10px;
}

.logo-collapse {
  color: #2c3e2c;
  font-size: 20px;
  font-weight: 600;
}

.sidebar-menu {
  border-right: none;
  background: transparent;
  padding: 12px 8px;
}

.sidebar-menu:not(.el-menu--collapse) {
  width: 220px;
}

.sidebar-menu .el-menu-item {
  color: #5a6b5a;
  height: 42px;
  line-height: 42px;
  border-radius: 8px;
  margin-bottom: 2px;
  font-size: 14px;
  font-weight: 400;
  transition: all 0.18s ease;
}

.sidebar-menu .el-menu-item:hover {
  background: #f4f8f0;
  color: #2c3e2c;
  filter: brightness(1.02);
}

.sidebar-menu .el-menu-item.is-active {
  background: linear-gradient(90deg, #e8f0e4 0%, transparent 100%);
  color: #3d6b3f;
  font-weight: 500;
  border-left: 3px solid #5a8f5c;
  border-radius: 0 8px 8px 0;
}

.sidebar-menu .el-menu-item .el-icon {
  color: inherit;
  font-size: 16px;
  margin-right: 10px;
  transition: color 0.18s ease;
}

.sidebar-menu .el-menu-item:hover .el-icon {
  color: #5a8f5c;
}

.sidebar-menu .el-menu-item.is-active .el-icon {
  color: #5a8f5c;
}

.sidebar-menu.el-menu--collapse .el-menu-item {
  padding: 0 !important;
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 48px;
}

.sidebar-menu.el-menu--collapse .el-menu-item .el-icon {
  margin: 0;
  width: 18px;
  text-align: center;
}

.sidebar-menu.el-menu--collapse .el-menu-item.is-active {
  border-left: none;
  border-bottom: 3px solid #5a8f5c;
  border-radius: 8px 8px 0 0;
}

.header {
  background: linear-gradient(90deg, #ffffff 0%, #fafcf8 100%);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
  border-bottom: 1px solid #d4ddd0;
  height: 56px;
  box-shadow: 0 2px 8px rgba(90, 143, 92, 0.04);
}

.header-left {
  display: flex;
  align-items: center;
}

.collapse-btn {
  color: #5a6b5a;
  padding: 8px;
  border-radius: 6px;
  transition: all 0.18s ease;
}

.collapse-btn:hover {
  background: #f4f8f0;
  color: #3d6b3f;
}

.header-right {
  display: flex;
  align-items: center;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 6px 14px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.18s ease;
  color: #5a6b5a;
}

.user-info:hover {
  background: #f4f8f0;
  color: #3d6b3f;
  box-shadow: 0 1px 3px rgba(90, 143, 92, 0.06);
}

.username {
  color: #2c3e2c;
  font-size: 14px;
  font-weight: 400;
}

.main-content {
  background: linear-gradient(180deg, #f8faf6 0%, #f4f8f0 100%);
  padding: 32px;
  overflow-y: auto;
  min-height: calc(100vh - 56px);
  position: relative;
}

/* 微噪点纸纤维质感 */
.main-content::before {
  content: '';
  position: fixed;
  inset: 0;
  opacity: 0.015;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.5'/%3E%3C/svg%3E");
  pointer-events: none;
  z-index: 0;
}
</style>
