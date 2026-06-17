<template>
  <div class="mastery-radar" v-loading="loading">
    <el-empty
      v-if="data.length === 0 && !loading"
      description="暂无能力数据，完成练习后会自动生成"
      :image-size="80"
    />
    <div v-else ref="chartRef" class="radar-chart"></div>
  </div>
</template>

<script setup>
import { nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import * as echarts from 'echarts'
import { masteryApi } from '@/api'

const props = defineProps({
  radarData: { type: Array, default: null }
})

const loading = ref(false)
const data = ref([])
const chartRef = ref(null)
let chart = null

async function load() {
  if (props.radarData) {
    data.value = props.radarData
    await nextTick()
    renderChart()
    return
  }
  loading.value = true
  try {
    const res = await masteryApi.myState()
    data.value = res.data?.radarData || []
  } catch (e) {
    console.error('Failed to load mastery data:', e)
    data.value = []
  } finally {
    loading.value = false
    await nextTick()
    renderChart()
  }
}

function renderChart() {
  if (!chartRef.value || data.value.length === 0) return
  if (chart) chart.dispose()
  chart = echarts.init(chartRef.value)
  chart.setOption({
    tooltip: {
      formatter: (params) => {
        const values = params.value || []
        return data.value.map((item, index) => `${item.kpName}: ${Math.round((values[index] || 0) * 100)}%`).join('<br/>')
      }
    },
    radar: {
      center: ['50%', '50%'],
      radius: '65%',
      indicator: data.value.slice(0, 8).map((d) => ({ name: d.kpName, max: 1 })),
      axisName: { fontSize: 11, color: '#475467' },
      splitLine: { lineStyle: { color: '#e5e7eb' } },
      splitArea: { areaStyle: { color: ['#f8fafc', '#fff'] } }
    },
    series: [{
      type: 'radar',
      data: [{
        value: data.value.slice(0, 8).map((d) => d.mastery),
        name: '掌握度',
        areaStyle: { color: 'rgba(47, 110, 245, 0.16)' },
        lineStyle: { color: '#2f6ef5', width: 2 },
        itemStyle: { color: '#2f6ef5' }
      }]
    }]
  })
}

watch(() => props.radarData, async (value) => {
  if (!value) return
  data.value = value
  await nextTick()
  renderChart()
}, { deep: true })

onMounted(load)
onBeforeUnmount(() => {
  if (chart) chart.dispose()
})
</script>

<style scoped>
.mastery-radar {
  min-height: 260px;
}

.radar-chart {
  width: 100%;
  height: 260px;
}
</style>
