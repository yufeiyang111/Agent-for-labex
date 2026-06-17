<template>
  <div class="empty-state">
    <div class="empty-state__icon-wrap">
      <el-icon class="empty-state__icon" :size="56">
        <component :is="icon" />
      </el-icon>
    </div>
    <div class="empty-state__text">{{ description }}</div>
    <div v-if="hint" class="empty-state__hint">{{ hint }}</div>
    <div v-if="$slots.default" class="empty-state__action">
      <slot />
    </div>
  </div>
</template>

<script setup>
import { DocumentRemove } from '@element-plus/icons-vue'

defineProps({
  description: { type: String, default: '暂无数据' },
  hint: { type: String, default: '' },
  icon: { type: [String, Object], default: () => DocumentRemove }
})
</script>

<style lang="scss" scoped>
// Biophilic 亲自然风格 EmptyState - 柔和自然
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 64px 16px;
  color: #5a6b5a;

  &__icon-wrap {
    width: 72px;
    height: 72px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #e8f0e4 0%, #f4f8f0 100%);
    border-radius: 14px;
    color: #5a8f5c;
    margin-bottom: 20px;
    box-shadow: 0 4px 12px rgba(90, 143, 92, 0.1);
  }

  &__text {
    font-size: 14px;
    color: #5a6b5a;
  }

  &__hint {
    margin-top: 6px;
    font-size: 13px;
    color: #8a9b8a;
  }

  &__action {
    margin-top: 20px;
  }
}
</style>
