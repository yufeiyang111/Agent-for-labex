<template>
  <div class="graph-toolbar">
    <!-- 布局切换 -->
    <el-select
      v-model="currentLayout"
      placeholder="布局"
      style="width: 140px"
      @change="$emit('layout-change', currentLayout)"
    >
      <el-option label="力导向布局" value="cose-bilkent" />
      <el-option label="圆形布局" value="circle" />
      <el-option label="层次布局" value="breadthfirst" />
      <el-option label="同心圆布局" value="concentric" />
      <el-option label="网格布局" value="grid" />
    </el-select>

    <!-- 节点数量限制 -->
    <el-select
      v-model="currentMaxNodes"
      placeholder="节点数量"
      style="width: 140px"
      @change="$emit('max-nodes-change', currentMaxNodes)"
    >
      <el-option label="每类20个" :value="20" />
      <el-option label="每类30个" :value="30" />
      <el-option label="每类50个" :value="50" />
      <el-option label="每类100个" :value="100" />
      <el-option label="不限制" :value="9999" />
    </el-select>

    <!-- 搜索框 -->
    <el-input
      v-model="searchText"
      placeholder="搜索节点..."
      clearable
      style="width: 200px"
      @input="handleSearch"
      @clear="handleClearSearch"
    >
      <template #prefix>
        <el-icon><Search /></el-icon>
      </template>
    </el-input>

    <!-- 显示筛选 -->
    <el-popover placement="bottom" :width="220" trigger="click">
      <template #reference>
        <el-button :icon="Filter">显示筛选</el-button>
      </template>
      <div class="filter-options">
        <el-checkbox-group v-model="selectedTypes" @change="$emit('filter-change', selectedTypes)">
          <el-checkbox value="KnowledgePoint">
            <span class="filter-dot" style="background: #409EFF"></span>
            知识点 ({{ graphStats.knowledgePoints }})
          </el-checkbox>
          <el-checkbox value="QuestionRef">
            <span class="filter-dot" style="background: #67C23A"></span>
            题目 ({{ graphStats.questions }})
          </el-checkbox>
          <el-checkbox value="Document">
            <span class="filter-dot" style="background: #E6A23C"></span>
            讲义 ({{ graphStats.documents }})
          </el-checkbox>
          <el-checkbox value="Topic">
            <span class="filter-dot" style="background: #909399"></span>
            主题 ({{ graphStats.topics }})
          </el-checkbox>
        </el-checkbox-group>
      </div>
    </el-popover>

    <!-- 右侧按钮组 -->
    <div class="toolbar-right">
      <!-- 重新加载 -->
      <el-tooltip content="重新加载">
        <el-button :icon="Refresh" circle @click="$emit('reload')" />
      </el-tooltip>

      <!-- 适应画布 -->
      <el-tooltip content="适应画布">
        <el-button :icon="FullScreen" circle @click="$emit('fit')" />
      </el-tooltip>

      <!-- 全屏 -->
      <el-tooltip :content="isFullscreen ? '退出全屏' : '全屏'">
        <el-button
          :icon="isFullscreen ? CloseFullScreenIcon : FullScreenIcon"
          circle
          @click="handleFullscreen"
        />
      </el-tooltip>
    </div>
  </div>
</template>

<script setup>
import { ref, watch, onBeforeUnmount } from 'vue'
import { Search, Filter, FullScreen, FullScreen as FullScreenIcon, Close as CloseFullScreenIcon, Refresh } from '@element-plus/icons-vue'

const props = defineProps({
  layout: { type: String, default: 'cose-bilkent' },
  filterTypes: { type: Array, default: () => ['KnowledgePoint', 'Topic'] },
  maxNodes: { type: Number, default: 30 },
  graphStats: { type: Object, default: () => ({ knowledgePoints: 0, questions: 0, documents: 0, topics: 0 }) }
})

const emit = defineEmits(['layout-change', 'search', 'filter-change', 'max-nodes-change', 'fit', 'fullscreen', 'reload'])

const currentLayout = ref(props.layout)
const currentMaxNodes = ref(props.maxNodes)
const searchText = ref('')
const selectedTypes = ref([...props.filterTypes])
const isFullscreen = ref(false)

// 搜索防抖
let searchTimer = null
const handleSearch = (value) => {
  clearTimeout(searchTimer)
  searchTimer = setTimeout(() => {
    emit('search', value)
  }, 300)
}

const handleClearSearch = () => {
  emit('search', '')
}

const handleFullscreen = () => {
  isFullscreen.value = !isFullscreen.value
  emit('fullscreen')
}

// 监听外部布局变化
watch(() => props.layout, (val) => {
  currentLayout.value = val
})

// 监听外部筛选变化
watch(() => props.filterTypes, (val) => {
  selectedTypes.value = [...val]
})

// 监听外部节点数量变化
watch(() => props.maxNodes, (val) => {
  currentMaxNodes.value = val
})

// 清理定时器，防止内存泄漏
onBeforeUnmount(() => {
  if (searchTimer) {
    clearTimeout(searchTimer)
    searchTimer = null
  }
})
</script>

<style scoped lang="scss">
.graph-toolbar {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 16px;
  background: #fff;
  border-radius: 8px;
  border: 1px solid #e4e7ed;
}

.toolbar-right {
  margin-left: auto;
  display: flex;
  gap: 8px;
}

.filter-options {
  .el-checkbox {
    display: flex;
    align-items: center;
    margin-bottom: 8px;

    &:last-child {
      margin-bottom: 0;
    }
  }
}

.filter-dot {
  display: inline-block;
  width: 10px;
  height: 10px;
  border-radius: 2px;
  margin-right: 6px;
}
</style>
