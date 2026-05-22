<template>
  <div class="breadcrumb">
    <el-breadcrumb separator="/">
      <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item
        v-for="(item, index) in matched"
        :key="item.path"
        :to="item.path === currentPath ? null : item.path"
      >
        {{ item.meta?.title || item.name }}
      </el-breadcrumb-item>
    </el-breadcrumb>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

const matched = computed(() => {
  return route.matched.filter(item => item.meta?.title)
})

const currentPath = computed(() => route.path)
</script>

<style lang="scss" scoped>
.breadcrumb {
  display: flex;
  align-items: center;

  :deep(.el-breadcrumb__inner) {
    font-weight: 400;
    color: #606266;

    &.is-link {
      color: #606266;
      transition: color 0.2s;

      &:hover {
        color: #4caf50;
      }
    }
  }

  :deep(.el-breadcrumb__separator) {
    color: #c0c4cc;
  }
}
</style>
