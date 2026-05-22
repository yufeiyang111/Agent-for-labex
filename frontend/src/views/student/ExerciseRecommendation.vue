<template>
  <div class="recommendation-page">
    <!-- Header -->
    <div class="page-header">
      <h2 class="page-title">习题推荐</h2>
      <p class="page-subtitle">基于你的学习情况，智能推荐针对性练习题</p>
    </div>

    <div class="page-content" v-loading="loading">
      <!-- Mastery Radar Section -->
      <el-row :gutter="20" class="top-section">
        <el-col :span="16">
          <div class="section-card">
            <h3 class="section-title">推荐习题</h3>
            <RecommendationCard
              v-for="item in recommendations"
              :key="item.questionId"
              :item="item"
              @practice="goToPractice(item)"
            />
            <el-empty v-if="!loading && recommendations.length === 0"
              description="暂无推荐，先去完成一些练习以获取个性化推荐吧！" />
          </div>
        </el-col>
        <el-col :span="8">
          <div class="section-card">
            <h3 class="section-title">能力雷达</h3>
            <MasteryRadar />
            <div class="mastery-summary" v-if="overallMastery > 0">
              <el-progress :percentage="Math.round(overallMastery * 100)"
                :color="overallMastery >= 0.6 ? '#67c23a' : overallMastery >= 0.4 ? '#e6a23c' : '#f56c6c'"
                :stroke-width="12" />
              <span class="mastery-label">综合掌握度</span>
            </div>
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { recommendationApi } from '@/api'
import RecommendationCard from '@/components/RecommendationCard.vue'
import MasteryRadar from '@/components/MasteryRadar.vue'

const router = useRouter()
const loading = ref(false)
const recommendations = ref([])
const overallMastery = ref(0)

const loadRecommendations = async () => {
  loading.value = true
  try {
    // Load personalized recommendations
    const res = await recommendationApi.forMe({ limit: 10, explain: true })
    if (res.code === 0) {
      recommendations.value = res.data || []
    }
  } catch (e) {
    console.error('Failed to load recommendations:', e)
    ElMessage.warning('加载推荐失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

const goToPractice = (item) => {
  // Navigate to experiment page — the recommended exercises are from the question bank
  // which may belong to different experiments; fallback to experiment list
  router.push('/student/experiment')
  ElMessage.info(`塔菲建议你练习一下 "${item.knowledgePoint}" 相关的题目喵~`)
}

onMounted(loadRecommendations)
</script>

<style scoped>
.recommendation-page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px;
}
.page-header {
  margin-bottom: 24px;
}
.page-title {
  font-size: 22px;
  font-weight: 600;
  color: #1f2328;
  margin: 0 0 6px;
}
.page-subtitle {
  font-size: 13px;
  color: #8b949e;
  margin: 0;
}
.page-content {
  min-height: 400px;
}
.top-section {
  margin-bottom: 20px;
}
.section-card {
  background: #fff;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.04);
  min-height: 200px;
}
.section-title {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  margin: 0 0 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid #f0f0f0;
}
.mastery-summary {
  margin-top: 16px;
  text-align: center;
}
.mastery-label {
  display: inline-block;
  margin-top: 6px;
  font-size: 12px;
  color: #909399;
}
</style>
