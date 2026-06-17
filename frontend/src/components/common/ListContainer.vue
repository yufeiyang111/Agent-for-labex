<template>
  <div class="list-container" :style="{ height: height }">
    <!-- 头部工具栏 -->
    <div class="list-header" v-if="$slots.header">
      <slot name="header" />
    </div>

    <!-- 内容区域 -->
    <div class="list-content" v-loading="loading">
      <slot />
      <div v-if="!loading && empty" class="list-empty">
        <slot name="empty">
          <el-empty :description="emptyText" />
        </slot>
      </div>
    </div>

    <!-- 分页 -->
    <div class="list-pagination" v-if="showPagination">
      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="currentPageSize"
        :page-sizes="pageSizes"
        :total="total"
        :layout="layout"
        :small="small"
        @size-change="handleSizeChange"
        @current-change="handlePageChange"
      />
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  // 列表数据
  data: {
    type: Array,
    default: () => []
  },
  // 是否加载中
  loading: {
    type: Boolean,
    default: false
  },
  // 总记录数
  total: {
    type: Number,
    default: 0
  },
  // 当前页
  page: {
    type: Number,
    default: 1
  },
  // 每页大小
  pageSize: {
    type: Number,
    default: 20
  },
  // 可选每页大小
  pageSizes: {
    type: Array,
    default: () => [20, 40, 60, 100]
  },
  // 分页布局
  layout: {
    type: String,
    default: 'total, sizes, prev, pager, next, jumper'
  },
  // 是否显示分页
  showPagination: {
    type: Boolean,
    default: true
  },
  // 空状态文字
  emptyText: {
    type: String,
    default: '暂无数据'
  },
  // 高度
  height: {
    type: String,
    default: '100%'
  },
  // 是否小尺寸分页
  small: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['update:page', 'update:pageSize', 'page-change', 'size-change'])

const empty = computed(() => !props.loading && (!props.data || props.data.length === 0))

const currentPage = computed({
  get: () => props.page,
  set: (val) => emit('update:page', val)
})

const currentPageSize = computed({
  get: () => props.pageSize,
  set: (val) => emit('update:pageSize', val)
})

const handlePageChange = (page) => {
  emit('page-change', page)
}

const handleSizeChange = (size) => {
  emit('size-change', size)
}
</script>

<style scoped>
.list-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  min-height: 0;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: var(--wabi-radius, 3px);
  overflow: hidden;
}

.list-header {
  flex-shrink: 0;
  padding: 16px 20px;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
  background: var(--wabi-surface-warm, #faf9f7);
}

.list-content {
  flex: 1;
  min-height: 0;
  overflow-y: auto;
  padding: 0;
}

.list-empty {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  min-height: 200px;
}

.list-pagination {
  flex-shrink: 0;
  display: flex;
  justify-content: center;
  padding: 16px 20px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
  background: var(--wabi-surface-warm, #faf9f7);
}

/* 覆盖 el-table 样式 */
.list-content :deep(.el-table) {
  height: 100%;
  border: none;
}

.list-content :deep(.el-table__body-wrapper) {
  overflow-y: auto;
}

/* 覆盖分页样式 */
.list-pagination :deep(.el-pagination) {
  --el-pagination-bg-color: transparent;
  --el-pagination-text-color: var(--wabi-text-secondary, #8a8580);
  --el-pagination-button-bg-color: transparent;
  --el-pagination-hover-color: var(--wabi-accent, #7a8b6f);
}

.list-pagination :deep(.el-pager li) {
  background: transparent;
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: var(--wabi-radius-sm, 2px);
  margin: 0 2px;
}

.list-pagination :deep(.el-pager li:hover) {
  color: var(--wabi-accent, #7a8b6f);
  border-color: var(--wabi-accent, #7a8b6f);
}

.list-pagination :deep(.el-pager li.is-active) {
  background: var(--wabi-accent, #7a8b6f);
  border-color: var(--wabi-accent, #7a8b6f);
  color: #fff;
}
</style>
