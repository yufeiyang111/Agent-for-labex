<template>
  <div class="pagination-wrapper">
    <el-pagination
      v-model:current-page="currentPageSync"
      v-model:page-size="pageSizeSync"
      :page-sizes="pageSizes"
      :total="total"
      :layout="layout"
      :background="background"
      :small="small"
      :disabled="disabled"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  modelValue: {
    type: Object,
    default: () => ({ page: 1, pageSize: 10 })
  },
  total: {
    type: Number,
    default: 0
  },
  pageSizes: {
    type: Array,
    default: () => [5, 10, 20, 50]
  },
  layout: {
    type: String,
    default: 'total, sizes, prev, pager, next, jumper'
  },
  background: {
    type: Boolean,
    default: true
  },
  small: {
    type: Boolean,
    default: false
  },
  disabled: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['update:modelValue', 'change', 'page-change', 'size-change'])

const currentPageSync = computed({
  get: () => props.modelValue.page,
  set: (val) => {
    emit('update:modelValue', { ...props.modelValue, page: val })
    emit('page-change', val)
  }
})

const pageSizeSync = computed({
  get: () => props.modelValue.pageSize,
  set: (val) => {
    emit('update:modelValue', { ...props.modelValue, pageSize: val, page: 1 })
    emit('size-change', val)
  }
})

const handleSizeChange = (size) => {
  emit('change', { page: 1, pageSize: size })
}

const handleCurrentChange = (page) => {
  emit('change', { page, pageSize: props.modelValue.pageSize })
}
</script>

<style lang="scss" scoped>
.pagination-wrapper {
  display: flex;
  justify-content: center;
  padding: 16px 0;
}
</style>
