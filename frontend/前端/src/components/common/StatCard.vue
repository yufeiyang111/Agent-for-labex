<template>
  <div class="stat-card" :class="`stat-card--${variant}`" @click="$emit('click')">
    <div class="stat-card__icon-wrap">
      <el-icon class="stat-card__icon" :size="28">
        <component :is="icon" />
      </el-icon>
    </div>
    <div class="stat-card__body">
      <div class="stat-card__value">
        {{ value }}<span v-if="suffix" class="stat-card__suffix">{{ suffix }}</span>
      </div>
      <div class="stat-card__label">{{ label }}</div>
      <div v-if="hint" class="stat-card__hint">{{ hint }}</div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  label: { type: String, required: true },
  value: { type: [String, Number], required: true },
  suffix: { type: String, default: '' },
  hint: { type: String, default: '' },
  icon: { type: [String, Object], default: '' },
  variant: {
    type: String,
    default: 'primary',
    validator: (v) => ['primary', 'success', 'warning', 'danger', 'info'].includes(v)
  }
})
defineEmits(['click'])
</script>

<style lang="scss" scoped>
// Biophilic 亲自然风格 StatCard - 柔和光影
.stat-card {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 20px;
  background: linear-gradient(135deg, #ffffff 0%, #fafcf8 100%);
  border: 1px solid #d4ddd0;
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(90, 143, 92, 0.06);
  transition: all 0.18s ease;
  cursor: pointer;
  user-select: none;

  &:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(90, 143, 92, 0.1);
    border-color: #b8c8b0;
    filter: brightness(1.02);
  }

  &:active {
    transform: translateY(1px);
    box-shadow: 0 1px 3px rgba(90, 143, 92, 0.06);
  }

  &__icon-wrap {
    flex-shrink: 0;
    width: 48px;
    height: 48px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 10px;
    background: #e8f0e4;
  }

  &__body {
    flex: 1;
    min-width: 0;
  }

  &__value {
    font-size: 28px;
    font-weight: 600;
    color: #2c3e2c;
    line-height: 1.2;
  }

  &__suffix {
    font-size: 14px;
    font-weight: 400;
    color: #5a6b5a;
    margin-left: 4px;
  }

  &__label {
    margin-top: 4px;
    font-size: 13px;
    color: #5a6b5a;
  }

  &__hint {
    margin-top: 2px;
    font-size: 12px;
    color: #8a9b8a;
  }

  // Variants - 自然色盘
  &--primary &__icon-wrap { background: #e8f0e4; color: #5a8f5c; }
  &--success &__icon-wrap { background: #e0f0e0; color: #6b9e6b; }
  &--warning &__icon-wrap { background: #f8f0e8; color: #c4956b; }
  &--danger  &__icon-wrap { background: #f8ecec; color: #b87070; }
  &--info    &__icon-wrap { background: #e8f0f8; color: #6b9ac4; }
}
</style>
