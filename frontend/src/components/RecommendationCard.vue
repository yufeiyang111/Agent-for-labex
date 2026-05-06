<template>
  <div class="recommendation-card" @click="$emit('practice')">
    <div class="card-top">
      <el-tag :type="typeColor" size="small" effect="light">{{ item.typeName }}</el-tag>
      <span v-if="item.knowledgePoint" class="kp-tag">
        <el-icon><Collection /></el-icon> {{ item.knowledgePoint }}
      </span>
    </div>
    <p class="question-text">{{ item.question }}</p>
    <div class="card-bottom">
      <div class="reason" v-if="item.reason">
        <el-icon><InfoFilled /></el-icon>
        <span>{{ item.reason }}</span>
      </div>
      <div class="actions">
        <span v-if="item.masteryScore > 0" class="mastery-score">
          掌握度 {{ Math.round(item.masteryScore * 100) }}%
        </span>
        <el-button type="primary" size="small" round>去练习</el-button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  item: { type: Object, required: true }
})

defineEmits(['practice'])

const typeColor = computed(() => {
  switch (props.item.type) {
    case 6: return 'danger'
    case 1: case 5: case 7: return 'warning'
    default: return 'primary'
  }
})
</script>

<style scoped>
.recommendation-card {
  padding: 14px 18px;
  margin-bottom: 10px;
  background: #fafbfc;
  border: 1px solid #edf0f5;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.2s;
}
.recommendation-card:hover {
  border-color: #409eff;
  background: #f0f7ff;
  box-shadow: 0 2px 8px rgba(64, 158, 255, 0.1);
}
.card-top {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 8px;
}
.kp-tag {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
  color: #606266;
  background: #eef1f6;
  padding: 2px 8px;
  border-radius: 4px;
}
.question-text {
  font-size: 14px;
  color: #303133;
  line-height: 1.6;
  margin: 0 0 10px;
}
.card-bottom {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.reason {
  display: flex;
  align-items: flex-start;
  gap: 4px;
  font-size: 12px;
  color: #909399;
  flex: 1;
  line-height: 1.5;
}
.actions {
  display: flex;
  align-items: center;
  gap: 10px;
  flex-shrink: 0;
}
.mastery-score {
  font-size: 12px;
  color: #909399;
}
</style>
