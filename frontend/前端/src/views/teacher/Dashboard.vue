<template>
  <div class="dashboard wabi-page" v-loading="loading">
    <div class="wabi-body">
      <!-- 统计卡片 -->
      <div class="stats-grid">
        <div class="stat-card" v-for="(stat, index) in statCards" :key="index">
          <div class="stat-icon" :class="stat.class">
            <el-icon><component :is="stat.icon" /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-value">{{ stat.value }}</div>
            <div class="stat-label">{{ stat.label }}</div>
          </div>
        </div>
      </div>

      <!-- 快捷操作 + 监考预警 -->
      <div class="content-grid">
        <!-- 快捷操作 -->
        <div class="wabi-card quick-actions-card">
          <div class="wabi-card-header">
            <span class="wabi-card-title">快捷操作</span>
          </div>
          <div class="wabi-card-content">
            <div class="quick-actions">
              <router-link
                v-for="action in quickActions"
                :key="action.path"
                :to="action.path"
                class="action-item"
              >
                <div class="action-icon" :class="action.class">
                  <el-icon><component :is="action.icon" /></el-icon>
                </div>
                <span class="action-text">{{ action.label }}</span>
              </router-link>
            </div>
          </div>
        </div>

        <!-- 监考预警 -->
        <div class="wabi-card monitor-card">
          <div class="wabi-card-header">
            <span class="wabi-card-title">监考预警</span>
          </div>
          <div class="wabi-card-content">
            <div class="monitor-stats">
              <div class="monitor-stat danger">
                <div class="monitor-num">{{ overview.monitorTotalEvents }}</div>
                <div class="monitor-label">异常总数</div>
              </div>
              <div class="monitor-stat">
                <div class="monitor-num">{{ overview.monitorAffectedStudents }}</div>
                <div class="monitor-label">涉及学生</div>
              </div>
            </div>
            <div class="monitor-detail">
              <div class="detail-item">
                <span class="detail-label">切换标签</span>
                <span class="detail-value">{{ overview.monitorTabHidden || 0 }} 次</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">窗口失焦</span>
                <span class="detail-value">{{ overview.monitorWindowBlur || 0 }} 次</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">最近异常</span>
                <span class="detail-value">{{ formatDateTime(overview.monitorLatestAt) }}</span>
              </div>
            </div>
            <router-link to="/teacher/exam-grading" class="wabi-btn wabi-btn-primary monitor-btn">
              查看详细预警
            </router-link>
          </div>
        </div>
      </div>

      <!-- 图表区域 -->
      <div class="charts-grid">
        <div class="wabi-card">
          <div class="wabi-card-header">
            <span class="wabi-card-title">班级学生分布</span>
          </div>
          <div class="wabi-card-content">
            <v-chart class="chart-view" :option="classChartOption" autoresize />
          </div>
        </div>
        <div class="wabi-card">
          <div class="wabi-card-header">
            <span class="wabi-card-title">分数段分布</span>
          </div>
          <div class="wabi-card-content">
            <v-chart class="chart-view" :option="scoreChartOption" autoresize />
          </div>
        </div>
      </div>

      <!-- 表格区域 -->
      <div class="tables-grid">
        <!-- 最近实验 -->
        <div class="wabi-card">
          <div class="wabi-card-header">
            <span class="wabi-card-title">最近实验</span>
          </div>
          <div class="wabi-card-content">
            <div v-if="!overview.recentExperiments.length" class="wabi-empty">
              <p class="wabi-empty-text">暂无实验</p>
            </div>
            <div v-else class="experiment-list">
              <div v-for="exp in overview.recentExperiments" :key="exp.experimentId" class="experiment-item">
                <div class="experiment-info">
                  <span class="experiment-name">{{ exp.experimentName }}</span>
                  <span class="experiment-no">{{ exp.experimentNo }}</span>
                </div>
                <span class="wabi-tag" :class="exp.state === 1 ? 'wabi-tag-accent' : ''">
                  {{ exp.state === 1 ? '启用' : '禁用' }}
                </span>
              </div>
            </div>
          </div>
        </div>

        <!-- 最近监考事件 -->
        <div class="wabi-card">
          <div class="wabi-card-header">
            <span class="wabi-card-title">
              最近监考事件
              <span v-if="overview.recentMonitorEvents.length" class="event-count">
                ({{ displayedEvents.length }}/{{ overview.recentMonitorEvents.length }})
              </span>
            </span>
          </div>
          <div class="wabi-card-content">
            <div v-if="!overview.recentMonitorEvents.length" class="wabi-empty">
              <p class="wabi-empty-text">暂无监考异常记录</p>
            </div>
            <div v-else class="event-list" ref="eventListRef" @scroll="handleEventScroll">
              <div v-for="event in displayedEvents" :key="event.id || event.occurredAt" class="event-item">
                <div class="event-time">{{ formatDateTime(event.occurredAt) }}</div>
                <div class="event-info">
                  <span class="event-exam">{{ event.examName || '-' }}</span>
                  <span class="event-student">{{ event.studentName }}（{{ event.studentNo }}）</span>
                </div>
                <span class="wabi-tag" :class="eventTypeClass(event.eventType)">
                  {{ eventTypeText(event.eventType) }}
                </span>
              </div>
              <div v-if="loadingMoreEvents" class="loading-more">
                <span>加载中...</span>
              </div>
              <div v-if="!hasMoreEvents && displayedEvents.length > 0" class="no-more">
                已加载全部
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue'
import VChart from 'vue-echarts'
import { use } from 'echarts/core'
import { BarChart } from 'echarts/charts'
import { CanvasRenderer } from 'echarts/renderers'
import { GridComponent, TooltipComponent } from 'echarts/components'
import {
  OfficeBuilding,
  User,
  CollectionTag,
  TrendCharts,
  Plus,
  Upload,
  Edit,
  EditPen,
  Tickets,
  DocumentCopy,
  Collection
} from '@element-plus/icons-vue'
import { teacherApi } from '@/api'

use([BarChart, CanvasRenderer, GridComponent, TooltipComponent])

const loading = ref(false)
const loadingMoreEvents = ref(false)
const eventListRef = ref(null)
const INITIAL_EVENT_COUNT = 8
const LOAD_MORE_EVENT_COUNT = 6
const eventDisplayCount = ref(INITIAL_EVENT_COUNT)

const overview = ref({
  clazzCount: 0,
  studentCount: 0,
  experimentCount: 0,
  completionRate: 0,
  recentExperiments: [],
  classStudentDistribution: [],
  scoreRangeDistribution: [],
  monitorTotalEvents: 0,
  monitorAffectedStudents: 0,
  monitorTabHidden: 0,
  monitorWindowBlur: 0,
  monitorLatestAt: null,
  recentMonitorEvents: []
})

const statCards = computed(() => [
  {
    icon: 'OfficeBuilding',
    value: overview.value.clazzCount,
    label: '班级数',
    class: 'icon-green'
  },
  {
    icon: 'User',
    value: overview.value.studentCount,
    label: '学生数',
    class: 'icon-blue'
  },
  {
    icon: 'CollectionTag',
    value: overview.value.experimentCount,
    label: '实验数',
    class: 'icon-amber'
  },
  {
    icon: 'TrendCharts',
    value: overview.value.completionRate + '%',
    label: '完成率',
    class: 'icon-stone'
  }
])

const quickActions = [
  { path: '/teacher/clazz', icon: 'Plus', label: '新增班级', class: 'action-green' },
  { path: '/teacher/student', icon: 'Upload', label: '导入学生', class: 'action-blue' },
  { path: '/teacher/experiment', icon: 'Edit', label: '创建实验', class: 'action-amber' },
  { path: '/teacher/score', icon: 'TrendCharts', label: '查看成绩', class: 'action-stone' },
  { path: '/teacher/exam-grading', icon: 'EditPen', label: '考试批改', class: 'action-red' },
  { path: '/teacher/lecture', icon: 'DocumentCopy', label: '讲义管理', class: 'action-green' },
  { path: '/teacher/question', icon: 'Tickets', label: '题库管理', class: 'action-blue' },
  { path: '/teacher/paper', icon: 'Collection', label: '试卷管理', class: 'action-amber' },
  { path: '/teacher/homework', icon: 'CollectionTag', label: '作业管理', class: 'action-stone' }
]

const displayedEvents = computed(() =>
  overview.value.recentMonitorEvents.slice(0, eventDisplayCount.value)
)

const hasMoreEvents = computed(() =>
  eventDisplayCount.value < overview.value.recentMonitorEvents.length
)

const classChartOption = computed(() => {
  const data = overview.value.classStudentDistribution || []
  return {
    tooltip: { trigger: 'axis' },
    grid: { left: 48, right: 20, top: 24, bottom: 32 },
    xAxis: {
      type: 'category',
      data: data.map(item => item.name),
      axisTick: { alignWithLabel: true }
    },
    yAxis: { type: 'value', minInterval: 1 },
    series: [{
      type: 'bar',
      barMaxWidth: 40,
      itemStyle: { color: '#7a8b6f', borderRadius: [4, 4, 0, 0] },
      data: data.map(item => item.value || 0)
    }]
  }
})

const scoreChartOption = computed(() => {
  const data = overview.value.scoreRangeDistribution || []
  return {
    tooltip: { trigger: 'axis' },
    grid: { left: 48, right: 20, top: 24, bottom: 32 },
    xAxis: {
      type: 'category',
      data: data.map(item => item.name),
      axisTick: { alignWithLabel: true }
    },
    yAxis: { type: 'value', minInterval: 1 },
    series: [{
      type: 'bar',
      barMaxWidth: 40,
      itemStyle: { color: '#a0937d', borderRadius: [4, 4, 0, 0] },
      data: data.map(item => item.value || 0)
    }]
  }
})

function formatDateTime(value) {
  if (!value) return '-'
  return new Date(value).toLocaleString('zh-CN')
}

function eventTypeText(type) {
  if (type === 'TAB_HIDDEN') return '切换标签页'
  if (type === 'WINDOW_BLUR') return '窗口失焦'
  return type || '-'
}

function eventTypeClass(type) {
  if (type === 'TAB_HIDDEN') return 'wabi-tag-warning'
  if (type === 'WINDOW_BLUR') return 'wabi-tag-danger'
  return ''
}

async function loadOverview() {
  loading.value = true
  try {
    const res = await teacherApi.dashboard.overview()
    overview.value = { ...overview.value, ...(res.data || {}) }
    eventDisplayCount.value = INITIAL_EVENT_COUNT
  } catch (error) {
    console.error('加载教师工作台数据失败:', error)
  } finally {
    loading.value = false
  }
}

const loadMoreEvents = () => {
  if (loadingMoreEvents.value || !hasMoreEvents.value) return
  loadingMoreEvents.value = true
  setTimeout(() => {
    eventDisplayCount.value += LOAD_MORE_EVENT_COUNT
    loadingMoreEvents.value = false
  }, 300)
}

const handleEventScroll = (e) => {
  const { scrollTop, scrollHeight, clientHeight } = e.target
  if (scrollHeight - scrollTop - clientHeight < 50) {
    loadMoreEvents()
  }
}

onMounted(loadOverview)
</script>

<style scoped>
.dashboard {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-body {
  padding: 24px;
  max-width: 1400px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 24px;
  animation: wabi-fade-in 0.4s ease;
}

@keyframes wabi-fade-in {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 统计卡片 */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
}

.stat-card {
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  padding: 20px;
  display: flex;
  align-items: center;
  gap: 16px;
  transition: all 0.25s ease;
}

.stat-card:hover {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.stat-icon {
  width: 48px;
  height: 48px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 22px;
  color: #fff;
}

.icon-green { background: #7a8b6f; }
.icon-blue { background: #6b8a9a; }
.icon-amber { background: #a0937d; }
.icon-stone { background: #9a9590; }

.stat-content {
  display: flex;
  flex-direction: column;
}

.stat-value {
  font-size: 28px;
  font-weight: 600;
  color: var(--wabi-text, #2c2c2c);
  line-height: 1;
  font-family: 'Georgia', serif;
}

.stat-label {
  margin-top: 4px;
  color: var(--wabi-text-secondary, #8a8580);
  font-size: 13px;
}

/* 内容网格 */
.content-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 16px;
}

/* 快捷操作 */
.quick-actions {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}

.action-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 16px 12px;
  background: var(--wabi-bg, #f8f6f3);
  border-radius: 6px;
  text-decoration: none;
  transition: all 0.2s ease;
  cursor: pointer;
}

.action-item:hover {
  background: var(--wabi-accent-light, #e8ede5);
}

.action-icon {
  width: 40px;
  height: 40px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  color: #fff;
}

.action-green { background: #7a8b6f; }
.action-blue { background: #6b8a9a; }
.action-amber { background: #a0937d; }
.action-stone { background: #9a9590; }
.action-red { background: #c47c7c; }

.action-text {
  font-size: 13px;
  color: var(--wabi-text, #2c2c2c);
  font-weight: 400;
}

/* 监考预警 */
.monitor-stats {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
  margin-bottom: 16px;
}

.monitor-stat {
  padding: 16px;
  background: var(--wabi-bg, #f8f6f3);
  border-radius: 6px;
  text-align: center;
}

.monitor-stat.danger {
  background: #f5e8e8;
}

.monitor-num {
  font-size: 24px;
  font-weight: 600;
  color: var(--wabi-text, #2c2c2c);
  font-family: 'Georgia', serif;
}

.monitor-stat.danger .monitor-num {
  color: #c47c7c;
}

.monitor-label {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-top: 4px;
}

.monitor-detail {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 16px;
}

.detail-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 12px;
  background: var(--wabi-bg, #f8f6f3);
  border-radius: 4px;
  font-size: 13px;
}

.detail-label {
  color: var(--wabi-text-secondary, #8a8580);
}

.detail-value {
  color: var(--wabi-text, #2c2c2c);
  font-weight: 500;
}

.monitor-btn {
  display: block;
  width: 100%;
  text-align: center;
  text-decoration: none;
}

/* 图表网格 */
.charts-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
}

.chart-view {
  width: 100%;
  height: 300px;
}

/* 表格网格 */
.tables-grid {
  display: grid;
  grid-template-columns: 1fr 2fr;
  gap: 16px;
}

/* 实验列表 */
.experiment-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.experiment-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px;
  background: var(--wabi-bg, #f8f6f3);
  border-radius: 4px;
}

.experiment-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.experiment-name {
  font-size: 14px;
  color: var(--wabi-text, #2c2c2c);
  font-weight: 500;
}

.experiment-no {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 事件列表 */
.event-list {
  max-height: 400px;
  overflow-y: auto;
}

.event-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  border-bottom: 1px solid var(--wabi-border, #e8e4df);
}

.event-item:last-child {
  border-bottom: none;
}

.event-time {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  min-width: 140px;
  font-family: monospace;
}

.event-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 2px;
  min-width: 0;
}

.event-exam {
  font-size: 13px;
  color: var(--wabi-text, #2c2c2c);
  font-weight: 500;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.event-student {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

.event-count {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  font-weight: 400;
}

.loading-more,
.no-more {
  padding: 12px;
  text-align: center;
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
}

/* 标签变体 */
.wabi-tag {
  display: inline-block;
  padding: 2px 8px;
  background: var(--wabi-border-light, #f0ece8);
  color: var(--wabi-text-secondary, #8a8580);
  font-size: 12px;
  border-radius: 2px;
}

.wabi-tag-accent {
  background: var(--wabi-accent-light, #e8ede5);
  color: var(--wabi-accent, #7a8b6f);
}

.wabi-tag-warning {
  background: #f5efe4;
  color: #a0937d;
}

.wabi-tag-danger {
  background: #f5e8e8;
  color: #c47c7c;
}

/* 响应式 */
@media (max-width: 1200px) {
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .content-grid,
  .charts-grid,
  .tables-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .stats-grid {
    grid-template-columns: 1fr;
  }

  .quick-actions {
    grid-template-columns: repeat(2, 1fr);
  }

  .wabi-body {
    padding: 16px;
  }
}
</style>
