<template>
  <article class="recommendation-card">
    <div class="card-head">
      <div class="tags">
        <el-tag :type="typeColor" size="small" effect="light">{{ item.typeName || '习题' }}</el-tag>
        <el-tag v-if="item.knowledgePoint" type="info" size="small" effect="plain">
          {{ item.knowledgePoint }}
        </el-tag>
      </div>
      <span class="score" v-if="typeof item.masteryScore === 'number'">
        掌握度 {{ Math.round(item.masteryScore * 100) }}%
      </span>
    </div>

    <p class="question-text">{{ item.question }}</p>

    <div class="reason" v-if="item.reason">
      <el-icon><InfoFilled /></el-icon>
      <span>{{ item.reason }}</span>
    </div>

    <div class="card-foot">
      <div class="meta">
        <span v-if="item.attemptCount">相关作答 {{ item.attemptCount }} 次</span>
        <span v-if="item.source === 'question-bank-fallback'">题库兜底</span>
      </div>
      <el-button type="primary" size="small" @click="$emit('practice', item)">
        {{ item.actionText || '加入强化训练' }}
      </el-button>
    </div>
  </article>
</template>

<script setup>
import { computed } from 'vue'
import { InfoFilled } from '@element-plus/icons-vue'

const props = defineProps({
  item: { type: Object, required: true }
})

defineEmits(['practice'])

const typeColor = computed(() => {
  switch (props.item.type) {
    case 6: return 'danger'
    case 1:
    case 5:
    case 7:
      return 'warning'
    case 2:
    case 3:
    case 4:
      return 'primary'
    default:
      return 'info'
  }
})
</script>

<style scoped>
.recommendation-card {
  padding: 16px;
  border: 1px solid #d9dee7;
  border-radius: 8px;
  background: #fff;
  display: grid;
  gap: 10px;
}

.card-head,
.card-foot {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
}

.tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.score {
  color: #475467;
  font-size: 12px;
  white-space: nowrap;
}

.question-text {
  margin: 0;
  color: #111827;
  font-size: 14px;
  line-height: 1.65;
  white-space: pre-wrap;
}

.reason {
  display: flex;
  align-items: flex-start;
  gap: 6px;
  color: #667085;
  font-size: 13px;
  line-height: 1.55;
  padding: 10px 12px;
  border-radius: 8px;
  background: #f8fafc;
}

.meta {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  color: #667085;
  font-size: 12px;
}

@media (max-width: 640px) {
  .card-head,
  .card-foot {
    align-items: flex-start;
    flex-direction: column;
  }
}
</style>
