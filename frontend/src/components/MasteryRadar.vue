<template>
  <div class="mastery-radar" v-loading="loading">
    <div v-if="data.length === 0 && !loading" class="empty-state">
      <el-empty description="暂无能力数据，完成一些练习后将自动生成" :image-size="80" />
    </div>
    <div v-else ref="chartRef" class="radar-chart"></div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch, nextTick } from 'vue'
import * as echarts from 'echarts'
import { masteryApi } from '@/api'

const loading = ref(false)
const data = ref([])
const chartRef = ref(null)
let chart = null

const load = async () => {
  loading.value = true
  try {
    const res = await masteryApi.myState()
    if (res.data?.code === 0 && res.data.data) {
      data.value = res.data.data.radarData || []
    }
  } catch (e) {
    console.error('Failed to load mastery data:', e)
  } finally {
    loading.value = false
    await nextTick()
    renderChart()
  }
}

const renderChart = () => {
  if (!chartRef.value || data.value.length === 0) return

  if (chart) chart.dispose()

  chart = echarts.init(chartRef.value)
  chart.setOption({
    radar: {
      center: ['50%', '50%'],
      radius: '65%',
      indicator: data.value.map(d => ({ name: d.kpName, max: 1.0 })),
      axisName: { fontSize: 11, color: '#606266' }
    },
    series: [{
      type: 'radar',
      data: [{
        value: data.value.map(d => d.mastery),
        name: '掌握度',
        areaStyle: { color: 'rgba(64, 158, 255, 0.2)' },
        lineStyle: { color: '#409eff', width: 2 },
        itemStyle: { color: '#409eff' }
      }]
    }]
  })
}

onMounted(load)
watch(() => data.value, () => nextTick(renderChart), { deep: true })
</script>

<style scoped>
.mastery-radar {
  min-height: 260px;
  background: #fff;
  border-radius: 12px;
  padding: 16px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.04);
}
.radar-chart {
  width: 100%;
  height: 260px;
}
.empty-state {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 260px;
}
</style>
