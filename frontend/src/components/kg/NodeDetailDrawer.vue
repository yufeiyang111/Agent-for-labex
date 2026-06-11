<template>
  <el-drawer
    v-model="visible"
    :title="drawerTitle"
    size="400px"
    :before-close="handleClose"
  >
    <div v-loading="loading" class="node-detail">
      <!-- 知识点详情 -->
      <template v-if="nodeType === 'KnowledgePoint' && detail">
        <div class="detail-section">
          <h4 class="section-title">基本信息</h4>
          <el-descriptions :column="1" border size="small">
            <el-descriptions-item label="名称">{{ detail.knowledgePoint?.name }}</el-descriptions-item>
            <el-descriptions-item label="描述">{{ detail.knowledgePoint?.description || '暂无描述' }}</el-descriptions-item>
            <el-descriptions-item label="来源">
              <el-tag :type="detail.knowledgePoint?.source === 'LLM_EXTRACTED' ? 'info' : 'success'" size="small">
                {{ detail.knowledgePoint?.source === 'LLM_EXTRACTED' ? 'AI提取' : '手动创建' }}
              </el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="置信度">
              <el-progress
                v-if="detail.knowledgePoint?.confidence"
                :percentage="Math.round(detail.knowledgePoint.confidence * 100)"
                :stroke-width="8"
                :color="detail.knowledgePoint.confidence >= 0.8 ? '#67c23a' : '#e6a23c'"
              />
              <span v-else>-</span>
            </el-descriptions-item>
            <el-descriptions-item label="所属主题">
              {{ detail.topic?.name || '未分类' }}
            </el-descriptions-item>
          </el-descriptions>
        </div>

        <!-- 关联题目 -->
        <div class="detail-section" v-if="detail.questions?.length">
          <h4 class="section-title">
            关联题目
            <el-tag size="small" type="info">{{ detail.questions.length }}</el-tag>
          </h4>
          <div class="related-list">
            <div v-for="q in detail.questions" :key="q.questionId" class="related-item">
              <el-tag :type="getQuestionTypeTag(q.type)" size="small" effect="plain">
                {{ getQuestionTypeName(q.type) }}
              </el-tag>
              <span class="item-text">{{ truncateText(q.questionText, 50) }}</span>
            </div>
          </div>
        </div>

        <!-- 关联讲义 -->
        <div class="detail-section" v-if="detail.documents?.length">
          <h4 class="section-title">
            关联讲义
            <el-tag size="small" type="info">{{ detail.documents.length }}</el-tag>
          </h4>
          <div class="related-list">
            <div v-for="doc in detail.documents" :key="doc.lectureId" class="related-item">
              <el-icon><Document /></el-icon>
              <span class="item-text">{{ doc.title || '未命名讲义' }}</span>
            </div>
          </div>
        </div>

        <!-- 前置知识 -->
        <div class="detail-section" v-if="detail.prerequisites?.length">
          <h4 class="section-title">
            前置知识
            <el-tag size="small" type="warning">{{ detail.prerequisites.length }}</el-tag>
          </h4>
          <div class="related-list">
            <div v-for="pre in detail.prerequisites" :key="pre.id" class="related-item">
              <el-icon><Top /></el-icon>
              <span class="item-text">{{ pre.name }}</span>
            </div>
          </div>
        </div>

        <!-- 后续知识 -->
        <div class="detail-section" v-if="detail.postrequisites?.length">
          <h4 class="section-title">
            后续知识
            <el-tag size="small" type="success">{{ detail.postrequisites.length }}</el-tag>
          </h4>
          <div class="related-list">
            <div v-for="post in detail.postrequisites" :key="post.id" class="related-item">
              <el-icon><Bottom /></el-icon>
              <span class="item-text">{{ post.name }}</span>
            </div>
          </div>
        </div>
      </template>

      <!-- 题目详情 -->
      <template v-if="nodeType === 'QuestionRef' && detail">
        <div class="detail-section">
          <h4 class="section-title">题目信息</h4>
          <el-descriptions :column="1" border size="small">
            <el-descriptions-item label="题号">{{ detail.question?.questionId }}</el-descriptions-item>
            <el-descriptions-item label="类型">
              <el-tag :type="getQuestionTypeTag(detail.question?.type)" size="small">
                {{ getQuestionTypeName(detail.question?.type) }}
              </el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="编程题">
              <el-tag :type="detail.question?.isProgramming ? 'success' : 'info'" size="small">
                {{ detail.question?.isProgramming ? '是' : '否' }}
              </el-tag>
            </el-descriptions-item>
          </el-descriptions>
        </div>

        <div class="detail-section">
          <h4 class="section-title">题目内容</h4>
          <div class="question-content">{{ detail.question?.questionText || '暂无内容' }}</div>
        </div>

        <div class="detail-section" v-if="detail.knowledgePoints?.length">
          <h4 class="section-title">
            关联知识点
            <el-tag size="small" type="info">{{ detail.knowledgePoints.length }}</el-tag>
          </h4>
          <div class="related-list">
            <div v-for="kp in detail.knowledgePoints" :key="kp.id" class="related-item">
              <el-icon><Collection /></el-icon>
              <span class="item-text">{{ kp.name }}</span>
            </div>
          </div>
        </div>
      </template>

      <!-- 讲义详情 -->
      <template v-if="nodeType === 'Document' && detail">
        <div class="detail-section">
          <h4 class="section-title">讲义信息</h4>
          <el-descriptions :column="1" border size="small">
            <el-descriptions-item label="讲义ID">{{ detail.document?.lectureId }}</el-descriptions-item>
            <el-descriptions-item label="标题">{{ detail.document?.title || '未命名' }}</el-descriptions-item>
          </el-descriptions>
        </div>

        <div class="detail-section" v-if="detail.knowledgePoints?.length">
          <h4 class="section-title">
            覆盖知识点
            <el-tag size="small" type="info">{{ detail.knowledgePoints.length }}</el-tag>
          </h4>
          <div class="related-list">
            <div v-for="kp in detail.knowledgePoints" :key="kp.id" class="related-item">
              <el-icon><Collection /></el-icon>
              <span class="item-text">{{ kp.name }}</span>
            </div>
          </div>
        </div>
      </template>

      <!-- 主题详情 -->
      <template v-if="nodeType === 'Topic' && detail">
        <div class="detail-section">
          <h4 class="section-title">主题信息</h4>
          <el-descriptions :column="1" border size="small">
            <el-descriptions-item label="名称">{{ detail.topic?.name }}</el-descriptions-item>
            <el-descriptions-item label="描述">{{ detail.topic?.description || '暂无描述' }}</el-descriptions-item>
          </el-descriptions>
        </div>

        <div class="detail-section" v-if="detail.knowledgePoints?.length">
          <h4 class="section-title">
            包含知识点
            <el-tag size="small" type="info">{{ detail.knowledgePoints.length }}</el-tag>
          </h4>
          <div class="related-list">
            <div v-for="kp in detail.knowledgePoints" :key="kp.id" class="related-item">
              <el-icon><Collection /></el-icon>
              <span class="item-text">{{ kp.name }}</span>
            </div>
          </div>
        </div>
      </template>

      <!-- 无数据状态 -->
      <el-empty v-if="!loading && !detail" description="暂无详细信息" />
    </div>
  </el-drawer>
</template>

<script setup>
import { ref, watch, computed } from 'vue'
import { Document, Top, Bottom, Collection } from '@element-plus/icons-vue'
import { kgApi } from '@/api'

const props = defineProps({
  modelValue: { type: Boolean, default: false },
  nodeType: { type: String, default: '' },
  nodeId: { type: String, default: '' },
  nodeData: { type: Object, default: null }
})

const emit = defineEmits(['update:modelValue'])

const visible = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
})

const loading = ref(false)
const detail = ref(null)

// 抽屉标题
const drawerTitle = computed(() => {
  const titles = {
    KnowledgePoint: '知识点详情',
    QuestionRef: '题目详情',
    Document: '讲义详情',
    Topic: '主题详情'
  }
  return titles[props.nodeType] || '节点详情'
})

// 题目类型映射
const questionTypeMap = {
  1: { name: '填空题', tag: '' },
  2: { name: '单选题', tag: 'success' },
  3: { name: '多选题', tag: 'warning' },
  4: { name: '判断题', tag: 'info' },
  5: { name: '简答题', tag: 'danger' },
  6: { name: '编程题', tag: 'success' },
  7: { name: '综合题', tag: 'warning' }
}

const getQuestionTypeName = (type) => questionTypeMap[type]?.name || '未知'
const getQuestionTypeTag = (type) => questionTypeMap[type]?.tag || ''

// 文本截断
const truncateText = (text, len) => {
  if (!text) return ''
  return text.length > len ? text.substring(0, len) + '...' : text
}

// 加载节点详情
const loadDetail = async () => {
  if (!props.nodeType || !props.nodeId) {
    detail.value = null
    return
  }

  loading.value = true
  try {
    const res = await kgApi.getNodeDetail(props.nodeType, props.nodeId)
    if (res.code === 0) {
      detail.value = res.data
    } else {
      detail.value = null
    }
  } catch (e) {
    console.error('加载节点详情失败:', e)
    detail.value = null
  } finally {
    loading.value = false
  }
}

const handleClose = () => {
  visible.value = false
}

// 监听节点变化
watch(() => [props.nodeType, props.nodeId], () => {
  if (visible.value) {
    loadDetail()
  }
})

watch(visible, (val) => {
  if (val) {
    loadDetail()
  } else {
    detail.value = null
  }
})
</script>

<style scoped lang="scss">
.node-detail {
  padding: 0 4px;
}

.detail-section {
  margin-bottom: 24px;

  &:last-child {
    margin-bottom: 0;
  }
}

.section-title {
  font-size: 15px;
  font-weight: 600;
  color: #303133;
  margin: 0 0 12px;
  display: flex;
  align-items: center;
  gap: 8px;
}

.related-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.related-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 12px;
  background: #f5f7fa;
  border-radius: 6px;
  font-size: 13px;
  color: #606266;

  .el-icon {
    color: #909399;
    flex-shrink: 0;
  }

  .item-text {
    flex: 1;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
}

.question-content {
  padding: 12px;
  background: #f5f7fa;
  border-radius: 6px;
  font-size: 13px;
  color: #303133;
  line-height: 1.6;
  white-space: pre-wrap;
}
</style>
