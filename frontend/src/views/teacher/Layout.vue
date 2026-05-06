<template>
  <div class="layout">
    <!-- 侧边栏 -->
    <aside class="sidebar" :class="{ collapsed: isCollapse }">
      <div class="logo-container">
        <div class="logo">
          <span v-if="!isCollapse">Labex</span>
          <span v-else>L</span>
        </div>
      </div>

      <el-menu
        :default-active="activeMenu"
        :collapse="isCollapse"
        background-color="#ffffff"
        text-color="#606266"
        active-text-color="#4caf50"
        router
      >
        <template v-for="item in menuList" :key="item.path">
          <el-menu-item :index="item.path">
            <el-icon><component :is="item.icon" /></el-icon>
            <template #title>{{ item.title }}</template>
          </el-menu-item>
        </template>
      </el-menu>
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
          />
          <breadcrumb />
        </div>

        <div class="header-right">
          <el-dropdown @command="handleCommand">
            <span class="user-dropdown">
              <el-avatar
                v-if="userStore.userInfo?.avatar"
                :src="baseUrl + userStore.userInfo.avatar"
                :size="32"
              />
              <el-avatar v-else :size="32" icon="User" />
              <span class="username">{{ userStore.userInfo?.name || '用户' }}</span>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
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
          <transition name="el-fade-in-linear" mode="out-in">
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

const route = useRoute()
const router = useRouter()
const userStore = useUserStore()
const baseUrl = import.meta.env.VITE_API_BASE_URL || ''

const isCollapse = ref(false)

// 当前激活菜单
const activeMenu = computed(() => route.path)

// 根据角色生成菜单
const menuList = computed(() => {
  const role = userStore.role
  if (role === 'TEACHER') {
    return [
      { path: '/teacher/dashboard', title: '工作台', icon: 'Odometer' },
      { path: '/teacher/clazz', title: '班级管理', icon: 'OfficeBuilding' },
      { path: '/teacher/student', title: '学生管理', icon: 'User' },
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

// 下拉菜单处理
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
.layout {
  display: flex;
  width: 100%;
  height: 100vh;
  overflow: hidden;
}

.sidebar {
  width: 248px;
  height: 100%;
  background: #ffffff;
  border-right: 1px solid #f0f0f0;
  display: flex;
  flex-direction: column;
  transition: width 0.35s cubic-bezier(0.25, 0.1, 0.25, 1);

  &.collapsed {
    width: 68px;
  }

  .logo-container {
    height: 64px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-bottom: 1px solid #f0f0f0;
    overflow: hidden;

    .logo {
      font-size: 20px;
      font-weight: 700;
      color: #4caf50;
      letter-spacing: -0.5px;
    }
  }

  .el-menu {
    border-right: none;
    flex: 1;
    overflow-y: auto;
    padding: 12px;
    background: transparent;

    :deep(.el-menu-item) {
      height: 48px;
      line-height: 48px;
      border-radius: 12px;
      margin-bottom: 4px;
      color: #6e6e73;
      font-size: 14px;
      font-weight: 500;
      transition: all 0.25s cubic-bezier(0.25, 0.1, 0.25, 1);

      .el-icon {
        font-size: 18px;
        margin-right: 12px;
      }

      &:hover {
        background: #f5f5f7;
        color: #1d1d1f;
      }

      &.is-active {
        background: #e6f4ea;
        color: #4caf50;
      }
    }
  }

  &.collapsed {
    .el-menu {
      :deep(.el-menu-item) {
        padding: 0 !important;
        display: flex;
        align-items: center;
        justify-content: center;
        min-width: 68px;

        .el-icon {
          margin: 0;
          width: 18px;
          text-align: center;
        }
      }
    }
  }
}

.main-wrapper {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.header {
  height: 64px;
  background: #ffffff;
  border-bottom: 1px solid #f0f0f0;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 28px;

  .header-left {
    display: flex;
    align-items: center;
    gap: 16px;

    :deep(.el-button) {
      padding: 10px;
      border-radius: 10px;
      color: #6e6e73;
      transition: all 0.25s cubic-bezier(0.25, 0.1, 0.25, 1);

      &:hover {
        background: #f5f5f7;
        color: #4caf50;
      }
    }
  }

  .header-right {
    .user-dropdown {
      display: flex;
      align-items: center;
      gap: 10px;
      cursor: pointer;
      padding: 8px 16px;
      border-radius: 12px;
      transition: all 0.25s cubic-bezier(0.25, 0.1, 0.25, 1);

      &:hover {
        background: #f5f5f7;
      }

      .username {
        font-size: 14px;
        color: #1d1d1f;
        font-weight: 500;
      }
    }
  }
}

.main-content {
  flex: 1;
  padding: 28px;
  overflow-y: auto;
  background: #f5f5f7;
  min-height: calc(100vh - 64px);
}
</style>
