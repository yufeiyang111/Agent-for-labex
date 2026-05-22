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
.admin-layout {
  height: 100vh;
}

.el-container {
  height: 100%;
}

.sidebar {
  background: #ffffff;
  transition: width 0.35s cubic-bezier(0.25, 0.1, 0.25, 1);
  overflow: hidden;
}

.logo {
  height: 64px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 20px;
  border-bottom: 1px solid #f0f0f0;
  background: #ffffff;
}

.logo-text {
  color: #1d1d1f;
  font-size: 18px;
  font-weight: 700;
  letter-spacing: -0.5px;
  margin-left: 10px;
}

.logo-collapse {
  color: #4caf50;
  font-size: 22px;
  font-weight: 700;
}

.sidebar-menu {
  border-right: none;
  background: transparent;
  padding: 12px;
}

.sidebar-menu:not(.el-menu--collapse) {
  width: 220px;
}

.sidebar-menu .el-menu-item {
  color: #6e6e73;
  height: 48px;
  line-height: 48px;
  border-radius: 12px;
  margin-bottom: 4px;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.25s cubic-bezier(0.25, 0.1, 0.25, 1);
}

.sidebar-menu .el-menu-item:hover {
  background: #f5f5f7;
  color: #1d1d1f;
}

.sidebar-menu .el-menu-item.is-active {
  background: #e6f4ea;
  color: #4caf50;
}

.sidebar-menu .el-menu-item .el-icon {
  color: inherit;
  font-size: 18px;
  margin-right: 12px;
}

.sidebar-menu.el-menu--collapse .el-menu-item {
  padding: 0 !important;
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 64px;
}

.sidebar-menu.el-menu--collapse .el-menu-item .el-icon {
  margin: 0;
  width: 18px;
  text-align: center;
}

.header {
  background: #ffffff;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 28px;
  border-bottom: 1px solid #f0f0f0;
}

.header-left {
  display: flex;
  align-items: center;
}

.collapse-btn {
  color: #6e6e73;
  padding: 10px;
  border-radius: 10px;
  transition: all 0.25s cubic-bezier(0.25, 0.1, 0.25, 1);
}

.collapse-btn:hover {
  background: #f5f5f7;
  color: #4caf50;
}

.header-right {
  display: flex;
  align-items: center;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 8px 16px;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.25, 0.1, 0.25, 1);
  color: #6e6e73;
}

.user-info:hover {
  background: #f5f5f7;
  color: #4caf50;
}

.username {
  color: #1d1d1f;
  font-size: 14px;
  font-weight: 500;
}

.main-content {
  background: #f5f5f7;
  padding: 28px;
  overflow-y: auto;
  min-height: calc(100vh - 64px);
}
</style>
