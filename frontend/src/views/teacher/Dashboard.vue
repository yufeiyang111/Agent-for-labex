<template>
  <div class="dashboard" v-loading="loading">
    <el-row :gutter="16" class="stats-row">
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card class="stat-card">
          <div class="stat-icon icon-clazz"><el-icon><OfficeBuilding /></el-icon></div>
          <div class="stat-main">
            <div class="stat-value">{{ overview.clazzCount }}</div>
            <div class="stat-label">班级数</div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card class="stat-card">
          <div class="stat-icon icon-student"><el-icon><User /></el-icon></div>
          <div class="stat-main">
            <div class="stat-value">{{ overview.studentCount }}</div>
            <div class="stat-label">学生数</div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card class="stat-card">
          <div class="stat-icon icon-exp"><el-icon><CollectionTag /></el-icon></div>
          <div class="stat-main">
            <div class="stat-value">{{ overview.experimentCount }}</div>
            <div class="stat-label">实验数</div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card class="stat-card">
          <div class="stat-icon icon-rate"><el-icon><TrendCharts /></el-icon></div>
          <div class="stat-main">
            <div class="stat-value">{{ overview.completionRate }}%</div>
            <div class="stat-label">完成率</div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="16" class="actions-row">
      <el-col :xs="24" :lg="16" class="action-col">
        <el-card class="quick-actions-card">
          <template #header>
            <div class="section-title">快捷操作</div>
          </template>
          <div class="quick-actions">
            <div class="action-item" @click="$router.push('/teacher/clazz')">
              <div class="action-icon icon-primary"><el-icon><Plus /></el-icon></div>
              <span class="action-text">新增班级</span>
            </div>
            <div class="action-item" @click="$router.push('/teacher/student')">
              <div class="action-icon icon-success"><el-icon><Upload /></el-icon></div>
              <span class="action-text">导入学生</span>
            </div>
            <div class="action-item" @click="$router.push('/teacher/experiment')">
              <div class="action-icon icon-warning"><el-icon><Edit /></el-icon></div>
              <span class="action-text">创建实验</span>
            </div>
            <div class="action-item" @click="$router.push('/teacher/score')">
              <div class="action-icon icon-info"><el-icon><TrendCharts /></el-icon></div>
              <span class="action-text">查看成绩</span>
            </div>
            <div class="action-item" @click="$router.push('/teacher/exam-grading')">
              <div class="action-icon icon-danger"><el-icon><EditPen /></el-icon></div>
              <span class="action-text">考试批改</span>
            </div>
            <div class="action-item" @click="$router.push('/teacher/lecture')">
              <div class="action-icon icon-primary"><el-icon><DocumentCopy /></el-icon></div>
              <span class="action-text">讲义管理</span>
            </div>
            <div class="action-item" @click="$router.push('/teacher/question')">
              <div class="action-icon icon-success"><el-icon><Tickets /></el-icon></div>
              <span class="action-text">题库管理</span>
            </div>
            <div class="action-item" @click="$router.push('/teacher/paper')">
              <div class="action-icon icon-warning"><el-icon><Collection /></el-icon></div>
              <span class="action-text">试卷管理</span>
            </div>
            <div class="action-item" @click="$router.push('/teacher/homework')">
              <div class="action-icon icon-info"><el-icon><CollectionTag /></el-icon></div>
              <span class="action-text">作业管理</span>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :lg="8" class="action-col">
        <el-card class="monitor-summary">
          <template #header>
            <div class="section-title">监考预警</div>
          </template>
          <div class="monitor-stats">
            <div class="stat-box danger">
              <div class="stat-num">{{ overview.monitorTotalEvents }}</div>
              <div class="stat-desc">异常总数</div>
            </div>
            <div class="stat-box">
              <div class="stat-num">{{ overview.monitorAffectedStudents }}</div>
              <div class="stat-desc">涉及学生</div>
            </div>
          </div>
          <div class="monitor-detail">
            <div class="detail-item">
              <el-icon class="detail-icon warning"><Warning /></el-icon>
              <span class="detail-label">切换标签</span>
              <span class="detail-value">{{ overview.monitorTabHidden || 0 }} 次</span>
            </div>
            <div class="detail-item">
              <el-icon class="detail-icon danger"><Warning /></el-icon>
              <span class="detail-label">窗口失焦</span>
              <span class="detail-value">{{ overview.monitorWindowBlur || 0 }} 次</span>
            </div>
            <div class="detail-item">
              <el-icon class="detail-icon info"><Clock /></el-icon>
              <span class="detail-label">最近异常</span>
              <span class="detail-value">{{ formatDateTime(overview.monitorLatestAt) }}</span>
            </div>
          </div>
          <el-button type="primary" @click="$router.push('/teacher/exam-grading')" class="view-btn">查看详细预警</el-button>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="16" class="charts-row">
      <el-col :xs="24" :lg="12">
        <el-card>
          <template #header><div class="section-title">班级学生分布</div></template>
          <v-chart class="chart-view" :option="classChartOption" autoresize />
        </el-card>
      </el-col>
      <el-col :xs="24" :lg="12">
        <el-card>
          <template #header><div class="section-title">分数段分布</div></template>
          <v-chart class="chart-view" :option="scoreChartOption" autoresize />
        </el-card>
      </el-col>
      <el-col :xs="24">
        <el-card>
          <template #header><div class="section-title">监考异常类型</div></template>
          <v-chart class="chart-view chart-pie" :option="monitorTypeChartOption" autoresize />
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="16" class="tables-row">
      <el-col :xs="24" :lg="10">
        <el-card>
          <template #header><div class="section-title">最近实验</div></template>
          <el-empty v-if="!overview.recentExperiments.length" description="暂无实验" />
          <el-table v-else :data="overview.recentExperiments" size="small" max-height="320">
            <el-table-column prop="experimentName" label="实验名称" min-width="180" />
            <el-table-column prop="experimentNo" label="编号" width="90" />
            <el-table-column label="状态" width="90">
              <template #default="{ row }">
                <el-tag size="small" :type="row.state === 1 ? 'success' : 'info'">
                  {{ row.state === 1 ? '启用' : '禁用' }}
                </el-tag>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
      <el-col :xs="24" :lg="14">
        <el-card>
          <template #header>
            <div class="section-title">
              <span>最近监考事件</span>
              <span class="event-count" v-if="overview.recentMonitorEvents.length">({{ displayedEvents.length }}/{{ overview.recentMonitorEvents.length }})</span>
            </div>
          </template>
          <div v-if="!overview.recentMonitorEvents.length" class="empty-events">
            <el-empty description="暂无监考异常记录" />
          </div>
          <div v-else class="event-list" ref="eventListRef" @scroll="handleEventScroll">
            <div v-for="event in displayedEvents" :key="event.id || event.occurredAt" class="event-item">
              <div class="event-time">{{ formatDateTime(event.occurredAt) }}</div>
              <div class="event-exam">{{ event.examName || '-' }}</div>
              <div class="event-student">{{ event.studentName }}（{{ event.studentNo }}）</div>
              <div class="event-type">
                <el-tag size="small" :type="eventTypeTag(event.eventType)">{{ eventTypeText(event.eventType) }}</el-tag>
              </div>
              <div class="event-desc" :title="event.eventDesc">{{ event.eventDesc || '-' }}</div>
            </div>
            <div v-if="loadingMoreEvents" class="loading-more">
              <el-icon class="is-loading"><Loading /></el-icon>
              <span>加载中...</span>
            </div>
            <div v-if="!hasMoreEvents && displayedEvents.length > 0" class="no-more-events">
              已加载全部 {{ overview.recentMonitorEvents.length }} 条事件
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue'
import VChart from 'vue-echarts'
import { use } from 'echarts/core'
import { BarChart, PieChart } from 'echarts/charts'
import { CanvasRenderer } from 'echarts/renderers'
import { GridComponent, TooltipComponent, LegendComponent, TitleComponent } from 'echarts/components'
import {
  OfficeBuilding,
  User,
  CollectionTag,
  TrendCharts,
  Plus,
  Upload,
  Edit,
  Document,
  Warning,
  Loading,
  Tickets,
  DocumentCopy,
  Collection,
  EditPen,
  Clock
} from '@element-plus/icons-vue'
import { teacherApi } from '@/api'

use([BarChart, PieChart, CanvasRenderer, GridComponent, TooltipComponent, LegendComponent, TitleComponent])

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
  monitorTypeDistribution: [],
  monitorTotalEvents: 0,
  monitorAffectedStudents: 0,
  monitorLatestAt: null,
  recentMonitorEvents: []
})

const displayedEvents = computed(() => {
  return overview.value.recentMonitorEvents.slice(0, eventDisplayCount.value)
})

const hasMoreEvents = computed(() => {
  return eventDisplayCount.value < overview.value.recentMonitorEvents.length
})

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
    series: [
      {
        type: 'bar',
        barMaxWidth: 48,
        itemStyle: { color: '#4f8cff', borderRadius: [6, 6, 0, 0] },
        data: data.map(item => item.value || 0)
      }
    ]
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
    series: [
      {
        type: 'bar',
        barMaxWidth: 48,
        itemStyle: { color: '#13c2c2', borderRadius: [6, 6, 0, 0] },
        data: data.map(item => item.value || 0)
      }
    ]
  }
})

const monitorTypeChartOption = computed(() => {
  const raw = overview.value.monitorTypeDistribution || []
  const data = raw.map(item => ({
    name: eventTypeText(item.name),
    value: item.value || 0
  }))
  return {
    tooltip: { trigger: 'item' },
    legend: { bottom: 0, left: 'center' },
    series: [
      {
        type: 'pie',
        radius: ['38%', '68%'],
        center: ['50%', '46%'],
        itemStyle: { borderRadius: 8, borderColor: '#fff', borderWidth: 2 },
        label: { formatter: '{b}: {d}%' },
        data
      }
    ]
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

function eventTypeTag(type) {
  if (type === 'TAB_HIDDEN') return 'warning'
  if (type === 'WINDOW_BLUR') return 'danger'
  return 'info'
}

async function loadOverview() {
  loading.value = true
  try {
    const res = await teacherApi.dashboard.overview()
    overview.value = {
      ...overview.value,
      ...(res.data || {})
    }
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
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.stats-row .el-col {
  margin-bottom: 16px;
}

.actions-row {
  display: flex;
}

.actions-row .action-col {
  display: flex;
  flex-direction: column;
}

.actions-row .action-col .el-card {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.actions-row .action-col .el-card :deep(.el-card__body) {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.stat-card {
  border-radius: 20px;
  border: none;
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 24px;
  background: #ffffff;
  transition: all 0.35s cubic-bezier(0.25, 0.1, 0.25, 1);
}

.stat-card:hover {
  transform: translateY(-3px) scale(1.02);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
}

.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 16px;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 26px;
}

.icon-clazz { background: #4caf50; box-shadow: 0 8px 24px rgba(76, 175, 80, 0.35); }
.icon-student { background: #3b82f6; box-shadow: 0 8px 24px rgba(59, 130, 246, 0.35); }
.icon-exp { background: #f59e0b; box-shadow: 0 8px 24px rgba(245, 158, 11, 0.35); }
.icon-rate { background: #6b7280; box-shadow: 0 8px 24px rgba(107, 114, 128, 0.35); }

.stat-main {
  display: flex;
  flex-direction: column;
}

.stat-value {
  font-size: 32px;
  font-weight: 700;
  color: #1d1d1f;
  line-height: 1;
  letter-spacing: -1px;
}

.stat-label {
  margin-top: 6px;
  color: #6e6e73;
  font-size: 13px;
  font-weight: 500;
}

.section-title {
  font-size: 15px;
  font-weight: 600;
  color: #1d1d1f;
}

.quick-actions {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(3, 1fr);
  gap: 16px;
  padding: 8px;
  flex: 1;
  min-height: 0;
}

.action-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 10px;
  padding: 20px 16px;
  background: #f5f7fa;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.25, 0.1, 0.25, 1);

  &:hover {
    background: #e8f5e9;
    transform: translateY(-2px);

    .action-icon {
      transform: scale(1.1);
    }
  }

  .action-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
    color: #fff;
    transition: transform 0.25s;
  }

  .action-text {
    font-size: 13px;
    font-weight: 500;
    color: #374151;
  }
}

.icon-primary { background: #4caf50; }
.icon-success { background: #3b82f6; }
.icon-warning { background: #f59e0b; }
.icon-info { background: #6b7280; }
.icon-danger { background: #ef4444; }

.monitor-summary .monitor-stats {
  display: flex;
  gap: 12px;
  margin-bottom: 16px;
}

.monitor-summary .stat-box {
  flex: 1;
  padding: 16px;
  border-radius: 14px;
  text-align: center;
  background: #f0f0f0;
}

.monitor-summary .stat-box.danger {
  background: #fee2e2;
}

.monitor-summary .stat-num {
  font-size: 28px;
  font-weight: 700;
  color: #1d1d1f;
  line-height: 1;
}

.monitor-summary .stat-box.danger .stat-num {
  color: #ef4444;
}

.monitor-summary .stat-desc {
  font-size: 12px;
  color: #6e6e73;
  margin-top: 6px;
}

.monitor-summary .monitor-detail {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-bottom: 16px;
}

.monitor-summary .detail-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 12px;
  background: #f5f7fa;
  border-radius: 10px;
  font-size: 13px;
}

.monitor-summary .detail-icon {
  font-size: 16px;
}

.monitor-summary .detail-icon.warning {
  color: #f59e0b;
}

.monitor-summary .detail-icon.danger {
  color: #ef4444;
}

.monitor-summary .detail-icon.info {
  color: #6b7280;
}

.monitor-summary .detail-label {
  flex: 1;
  color: #6e6e73;
}

.monitor-summary .detail-value {
  color: #1d1d1f;
  font-weight: 500;
}

.monitor-summary .view-btn {
  width: 100%;
  border-radius: 10px;
  font-weight: 500;
}

.charts-row .el-col,
.tables-row .el-col {
  margin-bottom: 16px;
}

.chart-view {
  width: 100%;
  height: 320px;
}

.chart-pie {
  height: 360px;
}

.el-card {
  border-radius: 20px;
  border: none;
}

.el-card :deep(.el-card__header) {
  padding: 18px 24px;
  border-bottom: 1px solid #f0f0f0;
}

.el-card :deep(.el-card__body) {
  padding: 24px;
}

.empty-events {
  padding: 20px 0;
}

.event-list {
  max-height: 320px;
  overflow-y: auto;
  scrollbar-width: thin;
}

.event-item {
  display: grid;
  grid-template-columns: 160px 120px 140px 90px 1fr;
  gap: 12px;
  align-items: center;
  padding: 12px 0;
  border-bottom: 1px solid #f0f0f0;
  font-size: 13px;
  transition: background-color 0.2s ease;
}

.event-item:hover {
  background: #fafafa;
  border-radius: 8px;
  margin: 0 -8px;
  padding: 12px 8px;
}

.event-item:last-child {
  border-bottom: none;
}

.event-time {
  color: #6e6e73;
  font-size: 12px;
}

.event-exam {
  color: #374151;
  font-weight: 500;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.event-student {
  color: #1d1d1f;
  font-size: 12px;
}

.event-desc {
  color: #6e6e73;
  font-size: 12px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.loading-more,
.no-more-events {
  padding: 12px;
  text-align: center;
  color: #9ca3af;
  font-size: 12px;
}

.loading-more {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.loading-more .el-icon {
  font-size: 16px;
}

.event-count {
  font-size: 12px;
  color: #9ca3af;
  font-weight: 400;
  margin-left: 6px;
}

@media (max-width: 992px) {
  .chart-view,
  .chart-pie {
    height: 280px;
  }
}
</style>
