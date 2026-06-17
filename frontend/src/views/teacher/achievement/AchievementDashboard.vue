<template>
  <div class="achievement-dashboard wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <el-button :icon="ArrowLeft" @click="$router.back()" text class="wabi-btn-text">返回</el-button>
        <h2 class="page-title">达成度分析</h2>
        <span class="page-subtitle">开课ID: {{ offeringId }}</span>
      </div>

      <!-- 总体统计 -->
      <div class="stats-grid">
        <div class="stat-card wabi-card">
          <div class="wabi-card-content">
            <div class="stat-value">{{ (data.overallReachedRatio * 100).toFixed(2) }}%</div>
            <div class="stat-label">学生达到课程总目标比例</div>
          </div>
        </div>
        <div class="action-card wabi-card">
          <div class="wabi-card-content">
            <div class="action-buttons">
              <el-button type="primary" :icon="Refresh" @click="onRecalc" :loading="loading" class="wabi-btn-primary">
                重新计算
              </el-button>
              <el-button :icon="Picture" @click="onSnapshot" class="wabi-btn-ghost">
                创建快照
              </el-button>
            </div>
            <p class="action-hint">快照用于评价报告固化历史数据</p>
          </div>
        </div>
      </div>

      <!-- 各课程目标达成度 -->
      <div class="wabi-card section-card">
        <div class="wabi-card-header">
          <span class="wabi-card-title">各课程目标达成度</span>
        </div>
        <div class="wabi-card-content">
          <div class="objective-list">
            <div v-for="obj in objectiveSummary" :key="obj.objectiveId" class="objective-item">
              <div class="objective-header">
                <span class="objective-code">{{ obj.code }}</span>
                <span class="objective-desc">{{ obj.description }}</span>
              </div>
              <div class="objective-stats">
                <div class="progress-wrapper">
                  <div class="progress-bar">
                    <div
                      class="progress-fill"
                      :class="{ success: Number(obj.value || 0) >= 1, warning: Number(obj.value || 0) < 1 }"
                      :style="{ width: Math.min(100, Number(obj.value || 0) * 100) + '%' }"
                    ></div>
                  </div>
                  <span class="progress-text">{{ (Number(obj.value || 0) * 100).toFixed(1) }}%</span>
                </div>
                <div class="objective-meta">
                  <span>达到：{{ obj.reachedCount }} / {{ obj.totalCount }}</span>
                  <span>班级平均：{{ (Number(obj.avgScore || 0) * 100).toFixed(2) }}%</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 学生明细 -->
      <div class="wabi-card section-card">
        <div class="wabi-card-header">
          <span class="wabi-card-title">学生明细</span>
          <el-input
            v-model="searchKeyword"
            placeholder="搜索学号/姓名"
            clearable
            size="small"
            class="wabi-search"
          />
        </div>
        <div class="wabi-card-content">
          <div class="student-list">
            <div v-for="stu in filteredStudents" :key="stu.studentId" class="student-item">
              <div class="student-info">
                <span class="student-no">{{ stu.studentNo }}</span>
                <span class="student-name">{{ stu.studentName }}</span>
              </div>
              <div class="student-scores">
                <span
                  v-for="obj in objectiveSummary"
                  :key="obj.objectiveId"
                  class="score-item"
                  :class="{ reached: stu[obj.objectiveId + '_reached'] }"
                >
                  {{ obj.code }}: {{ (Number(stu[obj.objectiveId] || 0) * 100).toFixed(0) }}%
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowLeft, Refresh, Picture } from '@element-plus/icons-vue'
import { achievementApi } from '@/api'

const route = useRoute()
const offeringId = computed(() => Number(route.params.offeringId))

const loading = ref(false)
const data = ref({ overallReachedRatio: 0 })
const objectiveSummary = ref([])
const students = ref([])
const searchKeyword = ref('')

const filteredStudents = computed(() => {
  if (!searchKeyword.value) return students.value
  const kw = searchKeyword.value.toLowerCase()
  return students.value.filter(s =>
    s.studentNo?.toLowerCase().includes(kw) ||
    s.studentName?.toLowerCase().includes(kw)
  )
})

const loadData = async () => {
  loading.value = true
  try {
    const res = await achievementApi.offering(offeringId.value)
    data.value = res.data || {}
    objectiveSummary.value = res.data?.objectiveSummary || []
    students.value = res.data?.students || []
  } catch (error) {
    console.error('加载达成度数据失败:', error)
  } finally {
    loading.value = false
  }
}

const onRecalc = async () => {
  loading.value = true
  try {
    await achievementApi.recalc(offeringId.value)
    ElMessage.success('计算完成')
    loadData()
  } catch (error) {
    ElMessage.error('计算失败')
  } finally {
    loading.value = false
  }
}

const onSnapshot = async () => {
  try {
    await achievementApi.snapshot(offeringId.value)
    ElMessage.success('快照创建成功')
  } catch (error) {
    ElMessage.error('快照创建失败')
  }
}

onMounted(loadData)
</script>

<style scoped>
.achievement-dashboard {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-body {
  padding: 24px;
  max-width: 1200px;
  margin: 0 auto;
  animation: wabi-fade-in 0.4s ease;
}

@keyframes wabi-fade-in {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 页面头部 */
.page-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 24px;
}

.page-title {
  font-size: 20px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
}

.page-subtitle {
  font-size: 14px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 统计卡片 */
.stats-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  margin-bottom: 24px;
}

.stat-card .stat-value {
  font-size: 36px;
  font-weight: 600;
  color: var(--wabi-accent, #7a8b6f);
  font-family: 'Georgia', serif;
}

.stat-card .stat-label {
  font-size: 14px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-top: 4px;
}

.action-buttons {
  display: flex;
  gap: 8px;
  margin-bottom: 8px;
}

.action-hint {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  margin: 0;
}

/* 目标列表 */
.objective-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.objective-item {
  padding: 16px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
}

.objective-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 12px;
}

.objective-code {
  font-family: monospace;
  font-size: 14px;
  color: var(--wabi-text-secondary, #8a8580);
  font-weight: 500;
}

.objective-desc {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
}

.objective-stats {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.progress-wrapper {
  display: flex;
  align-items: center;
  gap: 12px;
}

.progress-bar {
  flex: 1;
  height: 8px;
  background: var(--wabi-border-light, #f0ece8);
  border-radius: 4px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  border-radius: 4px;
  transition: width 0.3s ease;
}

.progress-fill.success {
  background: var(--wabi-accent, #7a8b6f);
}

.progress-fill.warning {
  background: var(--wabi-warning, #a0937d);
}

.progress-text {
  font-size: 14px;
  font-weight: 600;
  color: var(--wabi-text, #2c2c2c);
  min-width: 50px;
  text-align: right;
}

.objective-meta {
  display: flex;
  gap: 16px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 学生列表 */
.wabi-search {
  width: 200px;
}

.student-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.student-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 4px;
}

.student-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.student-no {
  font-family: monospace;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.student-name {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
  font-weight: 500;
}

.student-scores {
  display: flex;
  gap: 12px;
}

.score-item {
  font-size: 12px;
  padding: 2px 8px;
  background: var(--wabi-border-light, #f0ece8);
  border-radius: 2px;
  color: var(--wabi-text-secondary, #8a8580);
}

.score-item.reached {
  background: var(--wabi-accent-light, #e8ede5);
  color: var(--wabi-accent, #7a8b6f);
}

/* 分区卡片 */
.section-card {
  margin-bottom: 24px;
}

/* 按钮 */
.wabi-btn-primary {
  background: var(--wabi-accent, #7a8b6f);
  border-color: var(--wabi-accent, #7a8b6f);
  border-radius: 4px;
}

.wabi-btn-primary:hover {
  background: #6b7d60;
  border-color: #6b7d60;
}

.wabi-btn-ghost {
  border-color: var(--wabi-border, #e8e4df);
  color: var(--wabi-text-secondary, #8a8580);
  border-radius: 4px;
}

.wabi-btn-text {
  color: var(--wabi-text-secondary, #8a8580);
}

.wabi-btn-text:hover {
  color: var(--wabi-accent, #7a8b6f);
}

/* 响应式 */
@media (max-width: 768px) {
  .wabi-body {
    padding: 16px;
  }

  .stats-grid {
    grid-template-columns: 1fr;
  }

  .student-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }

  .student-scores {
    flex-wrap: wrap;
  }
}
</style>
