<template>
  <div class="kg-visualization">
    <!-- 工具栏 -->
    <GraphToolbar
      :layout="currentLayout"
      :filter-types="filterTypes"
      :max-nodes="maxNodes"
      :graph-stats="graphStats"
      @layout-change="changeLayout"
      @search="handleSearch"
      @filter-change="handleFilterChange"
      @max-nodes-change="handleMaxNodesChange"
      @fit="fitGraph"
      @fullscreen="toggleFullscreen"
      @reload="loadGraphData"
    />

    <!-- 节点数量提示 -->
    <div v-if="nodeCountInfo" class="node-count-info">
      <el-alert
        :title="nodeCountInfo"
        type="info"
        :closable="false"
        show-icon
      />
    </div>

    <!-- 图谱容器 - 使用独立的 div 避免 Vue 和 Cytoscape DOM 冲突 -->
    <div class="graph-wrapper" :class="{ fullscreen: isFullscreen }">
      <!-- 加载状态 -->
      <div v-if="loading" class="graph-loading">
        <el-icon class="is-loading" :size="32"><Loading /></el-icon>
        <span>加载图谱数据中...</span>
      </div>

      <!-- 空状态 -->
      <div v-else-if="!hasData" class="graph-empty">
        <el-empty description="暂无图谱数据">
          <template #image>
            <el-icon :size="64" color="#c0c4cc"><DataBoard /></el-icon>
          </template>
        </el-empty>
      </div>

      <!-- Cytoscape 容器 - 不包含任何 Vue 响应式元素 -->
      <div ref="graphContainer" class="graph-container"></div>

      <!-- 图例 - 放在容器外面避免 DOM 冲突 -->
      <div v-if="hasData" class="graph-legend">
        <div class="legend-item" v-for="item in legendItems" :key="item.type">
          <span class="legend-dot" :style="{ background: item.color }"></span>
          <span class="legend-label">{{ item.label }} ({{ getNodeCount(item.type) }})</span>
        </div>
      </div>

      <!-- 展开节点提示 -->
      <div v-if="hasData" class="expand-hint">
        <span>点击节点可展开查看关联</span>
      </div>
    </div>

    <!-- 节点详情抽屉 -->
    <NodeDetailDrawer
      v-model="showDrawer"
      :node-type="selectedNodeType"
      :node-id="selectedNodeId"
      :node-data="selectedNodeData"
    />
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch, nextTick } from 'vue'
import { ElMessage } from 'element-plus'
import { Loading, DataBoard } from '@element-plus/icons-vue'
import cytoscape from 'cytoscape'
import coseBilkent from 'cytoscape-cose-bilkent'
import GraphToolbar from './GraphToolbar.vue'
import NodeDetailDrawer from './NodeDetailDrawer.vue'
import { kgApi } from '@/api'

// 注册布局插件
cytoscape.use(coseBilkent)

const props = defineProps({
  topicId: { type: String, default: '' }
})

const emit = defineEmits(['node-click'])

// 状态
const graphContainer = ref(null)
const loading = ref(false)
const hasData = ref(false)
const isFullscreen = ref(false)
const currentLayout = ref('cose-bilkent')
const filterTypes = ref(['KnowledgePoint', 'Topic']) // 默认只显示知识点和主题
const searchKeyword = ref('')
const maxNodes = ref(30) // 每种类型最大节点数
const graphStats = ref({ knowledgePoints: 0, questions: 0, documents: 0, topics: 0 })
const nodeCountInfo = ref('')

// 节点详情
const showDrawer = ref(false)
const selectedNodeType = ref('')
const selectedNodeId = ref('')
const selectedNodeData = ref(null)

// 图谱实例
let cyInstance = null
let graphData = null
let resizeObserver = null

// 图例配置
const legendItems = [
  { type: 'KnowledgePoint', label: '知识点', color: '#409EFF' },
  { type: 'QuestionRef', label: '题目', color: '#67C23A' },
  { type: 'Document', label: '讲义', color: '#E6A23C' },
  { type: 'Topic', label: '主题', color: '#909399' }
]

// 节点样式配置
const nodeStyles = {
  KnowledgePoint: {
    shape: 'round-rectangle',
    'background-color': '#409EFF',
    width: 80,
    height: 40
  },
  QuestionRef: {
    shape: 'diamond',
    'background-color': '#67C23A',
    width: 50,
    height: 50
  },
  Document: {
    shape: 'barrel',
    'background-color': '#E6A23C',
    width: 60,
    height: 45
  },
  Topic: {
    shape: 'hexagon',
    'background-color': '#909399',
    width: 90,
    height: 55
  }
}

// 边样式配置
const edgeStyles = {
  BELONGS_TO: {
    'line-color': '#909399',
    'target-arrow-color': '#909399',
    'line-style': 'solid'
  },
  TESTS: {
    'line-color': '#67C23A',
    'target-arrow-color': '#67C23A',
    'line-style': 'dashed'
  },
  COVERS: {
    'line-color': '#E6A23C',
    'target-arrow-color': '#E6A23C',
    'line-style': 'solid'
  },
  PREREQUISITE_FOR: {
    'line-color': '#409EFF',
    'target-arrow-color': '#409EFF',
    'line-style': 'solid',
    'target-arrow-shape': 'triangle'
  }
}

// 获取节点数量
const getNodeCount = (type) => {
  if (!graphData) return 0
  return graphData.nodes.filter(n => n.type === type).length
}

// 加载图谱统计信息
const loadGraphStats = async () => {
  try {
    const res = await kgApi.getGraphStats()
    if (res.code === 0) {
      graphStats.value = res.data
    }
  } catch (e) {
    console.error('加载图谱统计失败:', e)
  }
}

// 加载图谱数据
const loadGraphData = async () => {
  loading.value = true
  nodeCountInfo.value = ''
  try {
    const params = {
      topicId: props.topicId || undefined,
      nodeTypes: filterTypes.value,
      maxNodes: maxNodes.value
    }

    const res = await kgApi.getGraphData(params)
    if (res.code === 0) {
      graphData = res.data
      hasData.value = graphData.nodes.length > 0

      // 生成节点数量提示
      const totalNodes = graphData.nodes.length
      const totalEdges = graphData.edges.length
      if (totalNodes > 0) {
        const counts = {}
        graphData.nodes.forEach(n => {
          counts[n.type] = (counts[n.type] || 0) + 1
        })
        const parts = Object.entries(counts).map(([type, count]) => {
          const names = { KnowledgePoint: '知识点', QuestionRef: '题目', Document: '讲义', Topic: '主题' }
          return `${names[type] || type}: ${count}`
        })
        nodeCountInfo.value = `当前显示 ${parts.join('，')}，共 ${totalNodes} 个节点，${totalEdges} 条关系`
      }

      if (hasData.value) {
        // 确保容器已渲染且有正确的尺寸
        await nextTick()
        // 等待容器获得尺寸
        await new Promise(resolve => setTimeout(resolve, 100))
        renderGraph()
      }
    }
  } catch (e) {
    console.error('加载图谱数据失败:', e)
    ElMessage.error('加载图谱数据失败')
  } finally {
    loading.value = false
  }
}

// 处理节点数量限制变化
const handleMaxNodesChange = (val) => {
  maxNodes.value = val
  loadGraphData()
}

// 渲染图谱
const renderGraph = () => {
  if (!graphContainer.value || !graphData) return

  // 销毁旧实例
  if (cyInstance) {
    cyInstance.destroy()
    cyInstance = null
  }

  // 清空容器
  graphContainer.value.innerHTML = ''

  // 转换数据格式
  const elements = []

  // 添加节点
  graphData.nodes.forEach(node => {
    if (!filterTypes.value.includes(node.type)) return

    const style = nodeStyles[node.type] || nodeStyles.KnowledgePoint
    elements.push({
      group: 'nodes',
      data: {
        id: node.id,
        label: node.label || '未知',
        type: node.type,
        properties: node.properties || {}
      },
      classes: node.type
    })
  })

  // 添加边
  graphData.edges.forEach(edge => {
    // 检查源和目标节点是否都存在
    const sourceExists = elements.some(el => el.group === 'nodes' && el.data.id === edge.source)
    const targetExists = elements.some(el => el.group === 'nodes' && el.data.id === edge.target)

    if (sourceExists && targetExists) {
      elements.push({
        group: 'edges',
        data: {
          id: `${edge.source}-${edge.target}-${edge.type}`,
          source: edge.source,
          target: edge.target,
          type: edge.type,
          properties: edge.properties || {}
        },
        classes: edge.type
      })
    }
  })

  // 创建图谱实例
  cyInstance = cytoscape({
    container: graphContainer.value,
    elements: elements,
    style: [
      // 节点基础样式
      {
        selector: 'node',
        style: {
          'label': 'data(label)',
          'text-wrap': 'ellipsis',
          'text-max-width': '120px',
          'font-size': '12px',
          'font-weight': 'bold',
          'text-valign': 'center',
          'text-halign': 'center',
          'color': '#fff',
          'text-outline-width': 2,
          'text-outline-color': '#409EFF',
          'background-color': '#409EFF',
          'border-width': 2,
          'border-color': '#fff',
          'overlay-padding': 6,
          'overlay-opacity': 0.1,
          'transition-property': 'background-color, border-color, opacity',
          'transition-duration': 0.2
        }
      },
      // 知识点样式
      {
        selector: '.KnowledgePoint',
        style: {
          ...nodeStyles.KnowledgePoint,
          'text-outline-color': '#337ecc',
          'background-color': '#409EFF'
        }
      },
      // 题目样式
      {
        selector: '.QuestionRef',
        style: {
          ...nodeStyles.QuestionRef,
          'text-outline-color': '#529b2e',
          'background-color': '#67C23A'
        }
      },
      // 讲义样式
      {
        selector: '.Document',
        style: {
          ...nodeStyles.Document,
          'text-outline-color': '#b88230',
          'background-color': '#E6A23C'
        }
      },
      // 主题样式
      {
        selector: '.Topic',
        style: {
          ...nodeStyles.Topic,
          'text-outline-color': '#73767a',
          'background-color': '#909399'
        }
      },
      // 边基础样式
      {
        selector: 'edge',
        style: {
          'width': 2,
          'curve-style': 'bezier',
          'opacity': 0.6,
          'overlay-padding': 3,
          'transition-property': 'opacity, width',
          'transition-duration': 0.2
        }
      },
      // BELONGS_TO 关系
      {
        selector: '.BELONGS_TO',
        style: edgeStyles.BELONGS_TO
      },
      // TESTS 关系
      {
        selector: '.TESTS',
        style: edgeStyles.TESTS
      },
      // COVERS 关系
      {
        selector: '.COVERS',
        style: edgeStyles.COVERS
      },
      // PREREQUISITE_FOR 关系
      {
        selector: '.PREREQUISITE_FOR',
        style: edgeStyles.PREREQUISITE_FOR
      },
      // 搜索高亮样式
      {
        selector: '.highlighted',
        style: {
          'border-width': 4,
          'border-color': '#F56C6C',
          'background-color': '#F56C6C',
          'opacity': 1
        }
      },
      // 半透明样式
      {
        selector: '.dimmed',
        style: {
          'opacity': 0.15
        }
      },
      // 选中样式
      {
        selector: ':active',
        style: {
          'overlay-opacity': 0.2
        }
      }
    ],
    layout: {
      name: currentLayout.value,
      animate: true,
      animationDuration: 800,
      fit: true,
      padding: 60,
      // cose-bilkent 特定参数 - 增加节点间距
      idealEdgeLength: 200,
      nodeOverlap: 30,
      nodeRepulsion: 8000,
      gravity: 0.15,
      numIter: 1500,
      componentSpacing: 150,
      nestingFactor: 0.1,
      randomize: true
    },
    minZoom: 0.05,
    maxZoom: 5,
    boxSelectionEnabled: false
  })

  // 绑定事件
  bindEvents()
}

// 绑定图谱事件
const bindEvents = () => {
  if (!cyInstance) return

  // 节点点击事件 - 展开关联
  cyInstance.on('tap', 'node', async (evt) => {
    const node = evt.target
    const data = node.data()

    // 显示详情抽屉
    selectedNodeType.value = data.type
    selectedNodeId.value = data.id
    selectedNodeData.value = data.properties
    showDrawer.value = true

    // 以该节点为中心展开关联
    await expandNode(data.id, data.type)

    emit('node-click', { type: data.type, id: data.id, data: data.properties })
  })

  // 点击空白处关闭抽屉
  cyInstance.on('tap', (evt) => {
    if (evt.target === cyInstance) {
      showDrawer.value = false
    }
  })

  // 鼠标悬停效果
  cyInstance.on('mouseover', 'node', (evt) => {
    evt.target.style('border-width', 4)
    evt.target.style('border-color', '#F56C6C')
    evt.target.connectedEdges().style('opacity', 1)
    evt.target.connectedEdges().style('width', 3)
  })

  cyInstance.on('mouseout', 'node', (evt) => {
    evt.target.style('border-width', 2)
    evt.target.style('border-color', '#fff')
    evt.target.connectedEdges().style('opacity', 0.6)
    evt.target.connectedEdges().style('width', 2)
  })
}

// 展开节点关联
const expandNode = async (nodeId, nodeType) => {
  loading.value = true
  try {
    const res = await kgApi.getGraphData({
      centerNodeId: nodeId,
      maxNodes: 20
    })

    if (res.code === 0 && res.data.nodes.length > 0) {
      // 合并新数据到现有图谱
      const newNodes = res.data.nodes.filter(n => !cyInstance.getElementById(n.id).length)
      const newEdges = res.data.edges.filter(e => {
        const edgeId = `${e.source}-${e.target}-${e.type}`
        return !cyInstance.getElementById(edgeId).length
      })

      // 添加新节点
      newNodes.forEach(node => {
        cyInstance.add({
          group: 'nodes',
          data: {
            id: node.id,
            label: node.label || '未知',
            type: node.type,
            properties: node.properties || {}
          },
          classes: node.type,
          position: {
            x: cyInstance.getElementById(nodeId).position().x + Math.random() * 200 - 100,
            y: cyInstance.getElementById(nodeId).position().y + Math.random() * 200 - 100
          }
        })
      })

      // 添加新边
      newEdges.forEach(edge => {
        cyInstance.add({
          group: 'edges',
          data: {
            id: `${edge.source}-${edge.target}-${edge.type}`,
            source: edge.source,
            target: edge.target,
            type: edge.type
          },
          classes: edge.type
        })
      })

      // 重新运行布局 - 使用 requestAnimationFrame 避免 DOM 冲突
      if (newNodes.length > 0) {
        requestAnimationFrame(() => {
          if (cyInstance) {
            cyInstance.layout({
              name: currentLayout.value,
              animate: true,
              animationDuration: 500,
              fit: true,
              padding: 60
            }).run()
          }
        })
      }
    }
  } catch (e) {
    console.error('展开节点失败:', e)
  } finally {
    loading.value = false
  }
}

// 切换布局
const changeLayout = (layout) => {
  currentLayout.value = layout
  if (cyInstance) {
    const layoutOptions = {
      name: layout,
      animate: true,
      animationDuration: 800,
      fit: true,
      padding: 60
    }

    // cose-bilkent 特定参数
    if (layout === 'cose-bilkent') {
      Object.assign(layoutOptions, {
        idealEdgeLength: 200,
        nodeOverlap: 30,
        nodeRepulsion: 8000,
        gravity: 0.15,
        numIter: 1500,
        componentSpacing: 150,
        nestingFactor: 0.1,
        randomize: true
      })
    }
    // cose 布局参数
    else if (layout === 'cose') {
      Object.assign(layoutOptions, {
        idealEdgeLength: 180,
        nodeOverlap: 25,
        nodeRepulsion: 7000,
        gravity: 0.2,
        numIter: 1000
      })
    }
    // 其他布局使用默认参数
    else {
      Object.assign(layoutOptions, {
        spacingFactor: 1.5,
        avoidOverlap: true,
        nodeDimensionsIncludeLabels: true
      })
    }

    cyInstance.layout(layoutOptions).run()
  }
}

// 搜索处理
const handleSearch = (keyword) => {
  searchKeyword.value = keyword
  if (!cyInstance) return

  // 清除之前的高亮
  cyInstance.elements().removeClass('highlighted dimmed')

  if (!keyword) return

  // 搜索匹配节点
  const matchedNodes = cyInstance.nodes().filter(node => {
    const label = node.data('label') || ''
    return label.toLowerCase().includes(keyword.toLowerCase())
  })

  if (matchedNodes.length > 0) {
    // 高亮匹配节点
    matchedNodes.addClass('highlighted')
    // 其他节点半透明
    cyInstance.nodes().not(matchedNodes).addClass('dimmed')
    cyInstance.edges().addClass('dimmed')
    // 连接到高亮节点的边恢复正常
    matchedNodes.connectedEdges().removeClass('dimmed')
    // 聚焦到第一个匹配节点
    cyInstance.animate({
      center: { eles: matchedNodes.first() },
      zoom: 1.5
    }, { duration: 300 })
  }
}

// 筛选处理
const handleFilterChange = (types) => {
  filterTypes.value = types
  renderGraph()
}

// 适应画布
const fitGraph = () => {
  if (cyInstance) {
    cyInstance.animate({
      fit: { padding: 50 }
    }, { duration: 300 })
  }
}

// 全屏切换
const toggleFullscreen = () => {
  isFullscreen.value = !isFullscreen.value
  nextTick(() => {
    if (cyInstance) {
      cyInstance.resize()
      fitGraph()
    }
  })
}

// 监听 topicId 变化
watch(() => props.topicId, () => {
  loadGraphData()
})

// 生命周期
onMounted(() => {
  loadGraphStats()
  loadGraphData()

  // 监听容器尺寸变化 - 使用防抖避免频繁触发
  let resizeTimer = null
  if (graphContainer.value) {
    resizeObserver = new ResizeObserver(() => {
      clearTimeout(resizeTimer)
      resizeTimer = setTimeout(() => {
        if (cyInstance && graphContainer.value) {
          cyInstance.resize()
        }
      }, 100)
    })
    resizeObserver.observe(graphContainer.value)
  }
})

onUnmounted(() => {
  // 先移除监听器
  if (resizeObserver) {
    resizeObserver.disconnect()
    resizeObserver = null
  }
  // 再销毁图谱实例
  if (cyInstance) {
    cyInstance.destroy()
    cyInstance = null
  }
  graphData = null
})
</script>

<style scoped lang="scss">
.kg-visualization {
  height: 100%;
  min-height: 600px;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.node-count-info {
  :deep(.el-alert) {
    border-radius: 8px;
  }
}

.graph-wrapper {
  flex: 1;
  min-height: 550px;
  height: 100%;
  background: linear-gradient(135deg, #f5f7fa 0%, #fafafa 100%);
  border-radius: 12px;
  border: 1px solid #e4e7ed;
  position: relative;
  overflow: hidden;
  box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.02);

  &.fullscreen {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 9999;
    border-radius: 0;
    min-height: 100vh;
  }
}

.graph-container {
  width: 100%;
  height: 100%;
  position: absolute;
  top: 0;
  left: 0;
}

.graph-loading {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  color: #909399;

  span {
    font-size: 14px;
  }
}

.graph-empty {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.graph-legend {
  position: absolute;
  bottom: 16px;
  left: 16px;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 8px;
  padding: 12px 16px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  display: flex;
  gap: 16px;

  .legend-item {
    display: flex;
    align-items: center;
    gap: 6px;

    .legend-dot {
      width: 12px;
      height: 12px;
      border-radius: 3px;
    }

    .legend-label {
      font-size: 12px;
      color: #606266;
    }
  }
}

.expand-hint {
  position: absolute;
  top: 16px;
  right: 16px;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 6px;
  padding: 6px 12px;
  font-size: 12px;
  color: #909399;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}
</style>
