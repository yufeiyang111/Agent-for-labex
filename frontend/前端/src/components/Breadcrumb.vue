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
// Biophilic 亲自然风格面包屑 - 自然色调
.breadcrumb {
  display: flex;
  align-items: center;

  :deep(.el-breadcrumb__inner) {
    font-weight: 400;
    color: #5a6b5a;

    &.is-link {
      color: #5a6b5a;
      transition: color 0.18s ease;

      &:hover {
        color: #3d6b3f;
      }
    }
  }

  :deep(.el-breadcrumb__separator) {
    color: #b8c4b8;
  }
}
</style>
