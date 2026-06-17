<template>
  <div class="layout wabi-layout">
    <!-- 侧边栏 -->
    <aside class="sidebar" :class="{ collapsed: isCollapse }">
      <div class="logo-container">
        <div class="logo">
          <AppIcon :size="isCollapse ? 30 : 34" compact />
          <span v-if="!isCollapse" class="logo-text">Labex</span>
        </div>
      </div>

      <nav class="nav-menu">
        <router-link
          v-for="item in menuList"
          :key="item.path"
          :to="item.path"
          class="nav-item"
          :class="{ active: activeMenu === item.path }"
        >
          <el-icon class="nav-icon"><component :is="item.icon" /></el-icon>
          <span v-if="!isCollapse" class="nav-label">{{ item.title }}</span>
        </router-link>
      </nav>
    </aside>

    <!-- 主内容区 -->
    <div class="main-wrapper">
      <!-- 顶栏 -->
      <header class="header">
        <div class="header-left">
          <el-button
            :icon="isCollapse ? Expand : Fold"
            @click="isCollapse = !isCollapse"
            text
            class="toggle-btn"
          />
          <breadcrumb />
        </div>

        <div class="header-right">
          <el-dropdown @command="handleCommand" trigger="click">
            <span class="user-dropdown">
              <el-avatar
                v-if="userStore.userInfo?.avatar"
                :src="baseUrl + userStore.userInfo.avatar"
                :size="32"
                class="user-avatar"
              />
              <el-avatar v-else :size="32" class="user-avatar">
                <span class="avatar-placeholder">{{ (userStore.userInfo?.name || '用')[0] }}</span>
              </el-avatar>
              <span class="username">{{ userStore.userInfo?.name || '用户' }}</span>
            </span>
            <template #dropdown>
              <el-dropdown-menu class="wabi-dropdown-menu">
                <el-dropdown-item command="profile">个人中心</el-dropdown-item>
                <el-dropdown-item divided command="logout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </header>

      <!-- 内容区 -->
      <main class="main-content">
        <router-view v-slot="{ Component }">
          <transition name="wabi-fade" mode="out-in">
            <component :is="Component" />
          </transition>
        </router-view>
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessageBox } from 'element-plus'
import { Fold, Expand } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'
import AppIcon from '@/components/AppIcon.vue'

const route = useRoute()
const router = useRouter()
const userStore = useUserStore()
const baseUrl = import.meta.env.VITE_API_BASE_URL || ''

const isCollapse = ref(false)

const activeMenu = computed(() => route.path)

const menuList = computed(() => {
  const role = userStore.role
  if (role === 'TEACHER') {
    return [
      { path: '/teacher/dashboard', title: '工作台', icon: 'Odometer' },
      { path: '/teacher/clazz', title: '班级管理', icon: 'OfficeBuilding' },
      { path: '/teacher/student', title: '学生管理', icon: 'User' },
      { path: '/teacher/course', title: '课程管理', icon: 'Notebook' },
      { path: '/teacher/offering', title: '开课管理', icon: 'School' },
      { path: '/teacher/graduation-requirement', title: '毕业要求', icon: 'Medal' },
      { path: '/teacher/experiment', title: '实验管理', icon: 'CollectionTag' },
      { path: '/teacher/lecture', title: '讲义管理', icon: 'Document' },
      { path: '/teacher/score', title: '成绩管理', icon: 'TrendCharts' },
      { path: '/teacher/question', title: '题库管理', icon: 'Tickets' },
      { path: '/teacher/paper', title: '试卷管理', icon: 'DocumentCopy' },
      { path: '/teacher/exam', title: '考试管理', icon: 'Edit' },
      { path: '/teacher/exam-grading', title: '考试批改', icon: 'EditPen' },
      { path: '/teacher/homework', title: '作业管理', icon: 'Collection' },
      { path: '/teacher/training-set', title: '题目训练', icon: 'List' },
      { path: '/teacher/knowledge-graph', title: '知识图谱', icon: 'Share' },
      { path: '/teacher/ai-question-generator', title: 'AI题目生成', icon: 'MagicStick' },
      { path: '/teacher/profile', title: '个人中心', icon: 'UserFilled' }
    ]
  } else {
    return [
      { path: '/student/experiment', title: '实验列表', icon: 'Reading' },
      { path: '/student/lecture', title: '讲义学习', icon: 'DocumentCopy' },
      { path: '/student/profile', title: '个人中心', icon: 'UserFilled' }
    ]
  }
})

const handleCommand = async (command) => {
  if (command === 'logout') {
    try {
      await ElMessageBox.confirm('确定要退出登录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      })
      userStore.logout()
      router.push('/login')
    } catch {
      // 用户取消
    }
  } else if (command === 'profile') {
    router.push('/teacher/profile')
  }
}
</script>

<style lang="scss" scoped>
.wabi-layout {
  --sidebar-width: 220px;
  --sidebar-collapsed-width: 64px;
  --header-height: 56px;
  --wabi-bg: #f8f6f3;
  --wabi-surface: #ffffff;
  --wabi-border: #e8e4df;
  --wabi-text: #2c2c2c;
  --wabi-text-secondary: #8a8580;
  --wabi-accent: #7a8b6f;
  --wabi-accent-light: #e8ede5;

  display: flex;
  width: 100%;
  height: 100vh;
  overflow: hidden;
  background: var(--wabi-bg);
}

/* 侧边栏 */
.sidebar {
  width: var(--sidebar-width);
  height: 100%;
  background: var(--wabi-surface);
  border-right: 1px solid var(--wabi-border);
  display: flex;
  flex-direction: column;
  transition: width 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  flex-shrink: 0;

  &.collapsed {
    width: var(--sidebar-collapsed-width);
  }
}

.logo-container {
  height: var(--header-height);
  display: flex;
  align-items: center;
  justify-content: center;
  border-bottom: 1px solid var(--wabi-border);
  padding: 0 16px;
}

.logo {
  display: flex;
  align-items: center;
  gap: 10px;
}

.logo-text {
  font-size: 18px;
  font-weight: 600;
  color: var(--wabi-text);
  letter-spacing: -0.5px;
  font-family: 'Georgia', serif;
}

/* 导航菜单 */
.nav-menu {
  flex: 1;
  overflow-y: auto;
  padding: 12px 8px;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px 16px;
  margin-bottom: 2px;
  color: var(--wabi-text-secondary);
  text-decoration: none;
  border-radius: 6px;
  transition: all 0.2s ease;
  font-size: 14px;

  &:hover {
    background: var(--wabi-accent-light);
    color: var(--wabi-text);
  }

  &.active {
    background: var(--wabi-accent-light);
    color: var(--wabi-accent);
    font-weight: 500;
  }
}

.nav-icon {
  font-size: 18px;
  flex-shrink: 0;
}

.nav-label {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* 折叠状态 */
.sidebar.collapsed {
  .nav-item {
    padding: 10px;
    justify-content: center;
  }

  .nav-icon {
    margin: 0;
  }
}

/* 主内容区 */
.main-wrapper {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  min-width: 0;
}

/* 顶栏 */
.header {
  height: var(--header-height);
  background: var(--wabi-surface);
  border-bottom: 1px solid var(--wabi-border);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
  flex-shrink: 0;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.toggle-btn {
  color: var(--wabi-text-secondary);
  transition: color 0.2s ease;

  &:hover {
    color: var(--wabi-accent);
  }
}

.header-right {
  display: flex;
  align-items: center;
}

.user-dropdown {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  padding: 6px 12px;
  border-radius: 6px;
  transition: background 0.2s ease;

  &:hover {
    background: var(--wabi-accent-light);
  }
}

.user-avatar {
  background: var(--wabi-accent-light);
  border: none;
}

.avatar-placeholder {
  color: var(--wabi-accent);
  font-size: 14px;
  font-weight: 500;
}

.username {
  font-size: 14px;
  color: var(--wabi-text);
  font-weight: 400;
}

/* 主内容 */
.main-content {
  flex: 1;
  overflow-y: auto;
  background: var(--wabi-bg);
}

/* 下拉菜单 */
.wabi-dropdown-menu {
  border: 1px solid var(--wabi-border);
  border-radius: 6px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
}

/* 页面过渡动画 */
.wabi-fade-enter-active,
.wabi-fade-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}

.wabi-fade-enter-from {
  opacity: 0;
  transform: translateY(4px);
}

.wabi-fade-leave-to {
  opacity: 0;
  transform: translateY(-4px);
}

/* 滚动条 */
.nav-menu::-webkit-scrollbar {
  width: 4px;
}

.nav-menu::-webkit-scrollbar-track {
  background: transparent;
}

.nav-menu::-webkit-scrollbar-thumb {
  background: var(--wabi-border);
  border-radius: 2px;
}

/* 响应式 */
@media (max-width: 768px) {
  .sidebar {
    position: fixed;
    z-index: 100;
    transform: translateX(-100%);

    &:not(.collapsed) {
      transform: translateX(0);
    }
  }
}
</style>
