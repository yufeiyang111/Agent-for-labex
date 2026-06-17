<template>
  <div class="recommendation-page">
    <header class="page-header">
      <div>
        <h2>习题推荐</h2>
        <p>基于知识图谱、历史作答和知识点掌握度生成强化练习。</p>
      </div>
      <div class="header-actions">
        <el-button @click="loadPage" :loading="loading">刷新推荐</el-button>
        <el-button type="primary" @click="createPracticeSet()" :loading="creating" :disabled="recommendations.length === 0">
          一键生成强化训练
        </el-button>
      </div>
    </header>

    <section class="summary-grid">
      <div class="summary-card">
        <span class="summary-label">综合掌握度</span>
        <strong>{{ Math.round((mastery.overallMastery || 0) * 100) }}%</strong>
        <el-progress
          :percentage="Math.round((mastery.overallMastery || 0) * 100)"
          :stroke-width="8"
          :show-text="false"
        />
      </div>
      <div class="summary-card">
        <span class="summary-label">薄弱知识点</span>
        <strong>{{ mastery.weakPoints?.length || 0 }}</strong>
        <span class="summary-tip">优先进入推荐队列</span>
      </div>
      <div class="summary-card">
        <span class="summary-label">本轮推荐</span>
        <strong>{{ recommendations.length }}</strong>
        <span class="summary-tip">可直接生成训练集</span>
      </div>
    </section>

    <main class="content-layout" v-loading="loading">
      <section class="recommendation-panel">
        <div class="panel-head">
          <div>
            <h3>推荐习题</h3>
            <p>推荐结果会避开已掌握内容，优先补薄弱点。</p>
          </div>
        </div>

        <div v-if="recommendations.length" class="recommendation-list">
          <RecommendationCard
            v-for="item in recommendations"
            :key="item.questionId"
            :item="item"
            @practice="createPracticeSet([item.questionId])"
          />
        </div>

        <el-empty
          v-else-if="!loading"
          description="暂无推荐。请先让教师完成知识点抽取和题目-知识点关联，或完成一些训练/作业/考试。"
        />
      </section>

      <aside class="side-panel">
        <section class="side-card">
          <div class="panel-head compact">
            <h3>能力雷达</h3>
          </div>
          <MasteryRadar :radar-data="mastery.radarData || []" />
        </section>

        <section class="side-card">
          <div class="panel-head compact">
            <h3>薄弱点</h3>
          </div>
          <div v-if="mastery.weakPoints?.length" class="weak-list">
            <div v-for="item in mastery.weakPoints.slice(0, 6)" :key="item.kpId || item.kpName" class="weak-item">
              <span>{{ item.kpName }}</span>
              <el-tag :type="masteryTag(item.mastery)" size="small">
                {{ Math.round(item.mastery * 100) }}%
              </el-tag>
            </div>
          </div>
          <el-empty v-else description="暂无明显薄弱点" :image-size="70" />
        </section>
      </aside>
    </main>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { masteryApi, recommendationApi } from '@/api'
import RecommendationCard from '@/components/RecommendationCard.vue'
import MasteryRadar from '@/components/MasteryRadar.vue'

const router = useRouter()
const loading = ref(false)
const creating = ref(false)
const recommendations = ref([])
const mastery = ref({
  overallMastery: 0,
  weakPoints: [],
  strongPoints: [],
  radarData: []
})

async function loadPage() {
  loading.value = true
  try {
    const [recRes, masteryRes] = await Promise.all([
      recommendationApi.forMe({ limit: 12, explain: false }),
      masteryApi.myState()
    ])
    recommendations.value = recRes.data || []
    mastery.value = masteryRes.data || mastery.value
  } catch (e) {
    console.error('Failed to load recommendations:', e)
    ElMessage.error('加载推荐失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

async function createPracticeSet(questionIds = null) {
  if (creating.value) return
  creating.value = true
  try {
    const payload = {
      limit: 10,
      refresh: true
    }
    if (questionIds && questionIds.length) {
      payload.questionIds = questionIds
    }
    const res = await recommendationApi.createPracticeSet(payload)
    const data = res.data || {}
    if (!data.trainingSetId) {
      ElMessage.warning('未生成训练集，请检查知识图谱题目关联')
      return
    }
    ElMessage.success(`已生成 ${data.questionCount || 0} 道题的强化训练`)
    router.push(data.practiceUrl || `/student/training/${data.trainingSetId}/practice`)
  } catch (e) {
    console.error('Failed to create practice set:', e)
    ElMessage.error(e?.message || '生成强化训练失败')
  } finally {
    creating.value = false
  }
}

function masteryTag(value) {
  if (value < 0.4) return 'danger'
  if (value < 0.7) return 'warning'
  return 'success'
}

onMounted(loadPage)
</script>

<style scoped>
.recommendation-page {
  max-width: 1360px;
  margin: 0 auto;
}

.page-header {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 18px;
}

.page-header h2 {
  margin: 0;
  font-size: 24px;
  color: #111827;
}

.page-header p {
  margin: 8px 0 0;
  color: #667085;
  font-size: 14px;
}

.header-actions {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.summary-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 14px;
  margin-bottom: 16px;
}

.summary-card {
  border: 1px solid #d9dee7;
  border-radius: 8px;
  padding: 16px;
  background: #fff;
  display: grid;
  gap: 8px;
}

.summary-label,
.summary-tip {
  color: #667085;
  font-size: 13px;
}

.summary-card strong {
  color: #111827;
  font-size: 28px;
}

.content-layout {
  display: grid;
  grid-template-columns: minmax(0, 1fr) 360px;
  gap: 16px;
}

.recommendation-panel,
.side-card {
  border: 1px solid #d9dee7;
  border-radius: 8px;
  background: #fff;
}

.recommendation-panel {
  padding: 18px;
  min-height: 460px;
}

.side-panel {
  display: grid;
  gap: 16px;
  align-content: start;
}

.side-card {
  padding: 16px;
}

.panel-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 14px;
}

.panel-head h3 {
  margin: 0;
  font-size: 16px;
  color: #111827;
}

.panel-head p {
  margin: 6px 0 0;
  color: #667085;
  font-size: 13px;
}

.panel-head.compact {
  margin-bottom: 8px;
}

.recommendation-list {
  display: grid;
  gap: 12px;
}

.weak-list {
  display: grid;
  gap: 10px;
}

.weak-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 10px;
  color: #344054;
  font-size: 13px;
  padding: 9px 10px;
  border-radius: 8px;
  background: #f8fafc;
}

@media (max-width: 1080px) {
  .content-layout {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 760px) {
  .page-header {
    align-items: flex-start;
    flex-direction: column;
  }

  .summary-grid {
    grid-template-columns: 1fr;
  }
}
</style>
