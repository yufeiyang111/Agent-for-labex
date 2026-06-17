<template>
  <div class="table-card" :class="{ 'table-card--flat': flat }">
    <div v-if="title || $slots.header" class="table-card__header">
      <div class="table-card__title-block">
        <h3 v-if="title" class="table-card__title">
          <el-icon v-if="icon" class="title-icon"><component :is="icon" /></el-icon>
          {{ title }}
        </h3>
        <p v-if="subtitle" class="table-card__subtitle">{{ subtitle }}</p>
      </div>
      <div v-if="$slots.header" class="table-card__actions">
        <slot name="header" />
      </div>
    </div>
    <div class="table-card__body">
      <slot />
    </div>
  </div>
</template>

<script setup>
defineProps({
  title: { type: String, default: '' },
  subtitle: { type: String, default: '' },
  icon: { type: [String, Object], default: '' },
  flat: { type: Boolean, default: false }
})
</script>

<style lang="scss" scoped>
// Biophilic 亲自然风格 TableCard - 柔和绿植
.table-card {
  background: linear-gradient(135deg, #ffffff 0%, #fafcf8 100%);
  border: 1px solid #d4ddd0;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(90, 143, 92, 0.06);
  overflow: hidden;
  margin-bottom: 24px;

  &--flat {
    box-shadow: none;
  }

  &__header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    padding: 16px 20px;
    border-bottom: 1px solid #e4ebe0;
    background: linear-gradient(90deg, #f4f8f0 0%, #fafcf8 100%);
  }

  &__title-block {
    min-width: 0;
  }

  &__title {
    display: flex;
    align-items: center;
    gap: 8px;
    margin: 0;
    font-size: 15px;
    font-weight: 600;
    color: #2c3e2c;
  }

  .title-icon {
    color: #5a8f5c;
  }

  &__subtitle {
    margin: 2px 0 0 0;
    font-size: 12px;
    color: #5a6b5a;
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

  &__body {
    padding: 16px 20px;
    overflow-x: auto;
  }

  &__body:has(> .el-table):empty,
  &__body:has(> :only-child:empty) {
    padding: 0;
  }
}

.table-card__actions :deep(.el-button),
.table-card__actions :deep(.el-select),
.table-card__actions :deep(.el-input) {
  flex-shrink: 0;
}
</style>
