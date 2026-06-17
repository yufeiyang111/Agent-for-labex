<template>
  <div class="student-layout">
    <!-- 侧边栏 -->
    <aside class="sidebar" :class="{ collapsed: isCollapse }">
      <div class="logo-container">
        <div class="logo">
          <AppIcon :size="isCollapse ? 34 : 38" compact />
          <span v-if="!isCollapse">Labex</span>
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
        <el-menu-item index="/student/experiment">
          <el-icon><Notebook /></el-icon>
          <template #title>实验列表</template>
        </el-menu-item>
        <el-menu-item index="/student/lecture">
          <el-icon><Document /></el-icon>
          <template #title>讲义学习</template>
        </el-menu-item>
        <el-menu-item index="/student/exam">
          <el-icon><EditPen /></el-icon>
          <template #title>在线考试</template>
        </el-menu-item>
        <el-menu-item index="/student/homework">
          <el-icon><CollectionTag /></el-icon>
          <template #title>作业提交</template>
        </el-menu-item>
        <el-menu-item index="/student/rag-chat">
          <el-icon><ChatDotRound /></el-icon>
          <template #title>知识问答</template>
        </el-menu-item>
        <el-menu-item index="/student/training">
          <el-icon><List /></el-icon>
          <template #title>题目训练</template>
        </el-menu-item>
        <el-menu-item index="/student/cloud-space">
          <el-icon><Cloudy /></el-icon>
          <template #title>云代码空间</template>
        </el-menu-item>
        <el-menu-item index="/student/recommendation">
          <el-icon><Aim /></el-icon>
          <template #title>习题推荐</template>
        </el-menu-item>
        <el-menu-item index="/student/achievement">
          <el-icon><DataAnalysis /></el-icon>
          <template #title>我的达成度</template>
        </el-menu-item>
        <el-menu-item index="/student/course-evaluation">
          <el-icon><ChatDotRound /></el-icon>
          <template #title>课程评价</template>
        </el-menu-item>
        <el-menu-item index="/student/profile">
          <el-icon><UserFilled /></el-icon>
          <template #title>个人中心</template>
        </el-menu-item>
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
              <span class="username">{{ userStore.userInfo?.name || '学生' }}</span>
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
        <router-view v-slot="{ Component, route }">
          <transition name="el-fade-in-linear" >
            <component :is="Component" :key="route.path" />
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
import { Document, UserFilled, EditPen, CollectionTag, Notebook, Fold, Expand, ChatDotRound, Aim, List, Cloudy, DataAnalysis } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'
import AppIcon from '@/components/AppIcon.vue'

const route = useRoute()
const router = useRouter()
const userStore = useUserStore()
const baseUrl = import.meta.env.VITE_API_BASE_URL || ''

const isCollapse = ref(false)

const activeMenu = computed(() => route.path)

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
    navigateTo('/student/profile')
  }
}
</script>

<style lang="scss" scoped>
// Biophilic 亲自然风格 Layout - 学生视角的阳光绿植空间
.student-layout {
  display: flex;
  width: 100%;
  height: 100vh;
  overflow: hidden;
  background: #f8faf6;
}

.sidebar {
  width: 248px;
  height: 100%;
  background: linear-gradient(180deg, #ffffff 0%, #fafcf8 100%);
  border-right: 1px solid #d4ddd0;
  display: flex;
  flex-direction: column;
  transition: width 0.22s ease;
  box-shadow: 2px 0 12px rgba(90, 143, 92, 0.04);

  &.collapsed {
    width: 68px;
  }

  .logo-container {
    height: 64px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-bottom: 1px solid #e4ebe0;
    overflow: hidden;
    background: linear-gradient(135deg, #f4f8f0 0%, #ffffff 100%);

    .logo {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 18px;
      font-weight: 600;
      color: #2c3e2c;
      letter-spacing: -0.3px;
    }
  }

  .el-menu {
    border-right: none;
    flex: 1;
    overflow-y: auto;
    padding: 12px 8px;
    background: transparent;

    :deep(.el-menu-item) {
      height: 42px;
      line-height: 42px;
      border-radius: 8px;
      margin-bottom: 2px;
      color: #5a6b5a;
      font-size: 14px;
      font-weight: 400;
      transition: all 0.18s ease;

      .el-icon {
        font-size: 16px;
        margin-right: 10px;
        transition: color 0.18s ease;
      }

      &:hover {
        background: #f4f8f0;
        color: #2c3e2c;
        filter: brightness(1.02);
      }

      &.is-active {
        background: linear-gradient(90deg, #e8f0e4 0%, transparent 100%);
        color: #3d6b3f;
        font-weight: 500;
        border-left: 3px solid #5a8f5c;
        border-radius: 0 8px 8px 0;

        .el-icon {
          color: #5a8f5c;
        }
      }
    }
  }

  &.collapsed {
    .el-menu {
      padding: 12px 6px;

      :deep(.el-menu-item) {
        padding: 0 !important;
        display: flex;
        align-items: center;
        justify-content: center;
        min-width: 56px;

        .el-icon {
          margin: 0;
          width: 18px;
          text-align: center;
        }

        &.is-active {
          border-left: none;
          border-bottom: 3px solid #5a8f5c;
          border-radius: 8px 8px 0 0;
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
  height: 56px;
  background: linear-gradient(90deg, #ffffff 0%, #fafcf8 100%);
  border-bottom: 1px solid #d4ddd0;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
  box-shadow: 0 2px 8px rgba(90, 143, 92, 0.04);

  .header-left {
    display: flex;
    align-items: center;
    gap: 12px;

    :deep(.el-button) {
      padding: 8px;
      border-radius: 6px;
      color: #5a6b5a;
      transition: all 0.18s ease;

      &:hover {
        background: #f4f8f0;
        color: #3d6b3f;
      }
    }
  }

  .header-right {
    .user-dropdown {
      display: flex;
      align-items: center;
      gap: 8px;
      cursor: pointer;
      padding: 6px 14px;
      border-radius: 8px;
      transition: all 0.18s ease;

      &:hover {
        background: #f4f8f0;
        box-shadow: 0 1px 3px rgba(90, 143, 92, 0.06);
      }

      .username {
        font-size: 14px;
        color: #2c3e2c;
        font-weight: 400;
      }
    }
  }
}

.main-content {
  flex: 1;
  padding: 32px;
  overflow-y: auto;
  background: linear-gradient(180deg, #f8faf6 0%, #f4f8f0 100%);
  min-height: calc(100vh - 56px);
  position: relative;

  // 微噪点纸纤维质感
  &::before {
    content: '';
    position: fixed;
    inset: 0;
    opacity: 0.015;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.5'/%3E%3C/svg%3E");
    pointer-events: none;
    z-index: 0;
  }
}
</style>
