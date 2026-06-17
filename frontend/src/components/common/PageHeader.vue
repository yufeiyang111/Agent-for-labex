<template>
  <div class="page-header">
    <div class="page-header__left">
      <el-button v-if="backable" :icon="ArrowLeft" link size="large" class="back-btn" @click="onBack">
        返回
      </el-button>
      <div class="page-header__title-block">
        <h1 class="page-header__title">
          <el-icon v-if="icon" class="title-icon"><component :is="icon" /></el-icon>
          {{ title }}
        </h1>
        <p v-if="subtitle" class="page-header__subtitle">{{ subtitle }}</p>
      </div>
    </div>
    <div v-if="$slots.actions" class="page-header__actions">
      <slot name="actions" />
    </div>
  </div>
</template>

<script setup>
import { ArrowLeft } from '@element-plus/icons-vue'

const props = defineProps({
  title: { type: String, required: true },
  subtitle: { type: String, default: '' },
  icon: { type: [String, Object], default: '' },
  backable: { type: Boolean, default: false }
})
const emit = defineEmits(['back'])
function onBack() {
  emit('back')
  // 默认行为：调用 history.back
  if (window.history.length > 1) window.history.back()
}
</script>

<style lang="scss" scoped>
// Biophilic 亲自然风格 PageHeader - 绿植光影
.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 16px;
  padding: 24px;
  margin-bottom: 24px;
  background: linear-gradient(135deg, #ffffff 0%, #fafcf8 100%);
  border: 1px solid #d4ddd0;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(90, 143, 92, 0.06);

  &__left {
    display: flex;
    align-items: center;
    gap: 12px;
    min-width: 0;
  }

  &__title-block {
    min-width: 0;
  }

  &__title {
    display: flex;
    align-items: center;
    gap: 8px;
    margin: 0;
    font-size: 24px;
    font-weight: 600;
    color: #2c3e2c;
    line-height: 1.3;
    letter-spacing: -0.02em;
  }

  .title-icon {
    color: #5a8f5c;
    font-size: 20px;
  }

  &__subtitle {
    margin: 4px 0 0 0;
    font-size: 14px;
    color: #5a6b5a;
    line-height: 1.5;
  }

  &__actions {
    display: flex;
    gap: 8px;
    flex-wrap: nowrap;
    overflow-x: auto;
    max-width: 100%;
    white-space: nowrap;
    padding-bottom: 2px;
  }
}

.page-header__actions :deep(.el-button) {
  flex-shrink: 0;
}

.back-btn {
  font-size: 14px;
  color: #5a6b5a;
  transition: color 0.18s ease;

  &:hover {
    color: #3d6b3f;
  }
}
</style>
