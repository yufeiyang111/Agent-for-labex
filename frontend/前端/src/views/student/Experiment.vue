<template>
  <div class="experiment-page">
    <el-card class="page-header">
      <div class="header-content">
        <div class="header-left">
          <h2>实验列表</h2>
          <p class="subtitle">选择实验开始学习</p>
        </div>
        <div class="header-right">
          <el-select v-model="filterType" placeholder="筛选类型" size="default" class="filter-select">
            <el-option label="全部" :value="0" />
            <el-option label="编程" :value="1" />
            <el-option label="练习" :value="2" />
          </el-select>
          <el-select v-model="filterState" placeholder="筛选状态" size="default" class="filter-select">
            <el-option label="全部" :value="0" />
            <el-option label="进行中" :value="1" />
            <el-option label="已禁用" :value="2" />
          </el-select>
        </div>
      </div>
    </el-card>

    <div v-loading="loading" class="experiment-list">
      <el-empty v-if="filteredExperiments.length === 0 && !loading" description="暂无可用实验" />

      <transition-group name="list" tag="div" class="experiment-grid">
        <el-card
          v-for="exp in paginatedExperiments"
          :key="exp.experimentId"
          class="experiment-card"
          shadow="hover"
        >
          <div class="card-header">
            <div class="exp-no">实验 #{{ exp.experimentNo }}</div>
            <el-tag :type="exp.state === 1 ? 'success' : 'danger'" size="small" effect="plain">
              {{ exp.state === 1 ? '进行中' : '已禁用' }}
            </el-tag>
          </div>

          <h3 class="exp-title">{{ exp.experimentName }}</h3>

          <div class="exp-meta">
            <el-tag v-if="exp.experimentType === 1" type="primary" size="small" effect="plain">编程</el-tag>
            <el-tag v-else-if="exp.experimentType === 2" type="warning" size="small" effect="plain">练习</el-tag>
            <el-tag v-else type="info" size="small" effect="plain">其他</el-tag>
          </div>

          <div class="exp-desc" v-html="exp.experimentRequirement || '暂无说明'"></div>

          <div class="card-footer">
            <el-button
              :type="exp.state === 1 ? 'primary' : 'default'"
              :disabled="exp.state !== 1"
              @click="goToExperiment(exp.experimentId)"
              size="default"
            >
              <el-icon><Reading /></el-icon>
              {{ exp.state === 1 ? '开始实验' : '实验未开放' }}
            </el-button>
          </div>
        </el-card>
      </transition-group>
    </div>

    <div class="pagination-wrapper" v-if="filteredExperiments.length > 0">
      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :page-sizes="[6, 12, 24, 48]"
        :total="filteredExperiments.length"
        layout="total, sizes, prev, pager, next, jumper"
        background
      />
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { useRouter } from 'vue-router'
import { Reading } from '@element-plus/icons-vue'
import { studentApi } from '@/api'

const router = useRouter()
const loading = ref(false)
const experiments = ref([])
const currentPage = ref(1)
const pageSize = ref(12)
const filterType = ref(0)
const filterState = ref(0)

const filteredExperiments = computed(() => {
  return experiments.value.filter(exp => {
    if (filterType.value !== 0 && exp.experimentType !== filterType.value) return false
    if (filterState.value !== 0) {
      if (filterState.value === 1 && exp.state !== 1) return false
      if (filterState.value === 2 && exp.state !== 0) return false
    }
    return true
  })
})

const paginatedExperiments = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  return filteredExperiments.value.slice(start, end)
})

onMounted(async () => {
  await loadExperiments()
})

const loadExperiments = async () => {
  loading.value = true
  try {
    const res = await studentApi.experiments()
    experiments.value = res.data || []
  } catch (error) {
    console.error('加载实验列表失败:', error)
  } finally {
    loading.value = false
  }
}

const goToExperiment = (experimentId) => {
  router.push(`/student/experiment/${experimentId}/detail`)
}

watch([filterType, filterState], () => {
  currentPage.value = 1
})
</script>

<style lang="scss" scoped>
.experiment-page {
  max-width: 1200px;
  margin: 0 auto;

  .page-header {
    margin-bottom: 24px;
    background: #ffffff;
    border: 1px solid #e1e4e8;
    border-radius: 6px;

    .header-content {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 16px 20px;
    }

    h2 {
      color: #24292e;
      font-size: 18px;
      font-weight: 600;
      margin: 0;
    }

    .subtitle {
      color: #586069;
      font-size: 13px;
      margin-top: 2px;
    }

    .filter-select {
      width: 120px;
    }
  }

  .experiment-list {
    min-height: 200px;
  }

  .experiment-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
    gap: 16px;
  }

  .experiment-card {
    border-radius: 6px;
    border: 1px solid #e1e4e8;
    background: #ffffff;
    transition: all 0.2s ease;

    &:hover {
      border-color: #4caf50;
      box-shadow: 0 4px 12px rgba(76, 175, 80, 0.1);
    }

    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 16px 20px;
      border-bottom: 1px solid #eaecef;

      .exp-no {
        font-size: 13px;
        color: #586069;
        font-weight: 500;
      }
    }

    .exp-title {
      font-size: 16px;
      font-weight: 600;
      color: #24292e;
      padding: 16px 20px 0;
      line-height: 1.4;
    }

    .exp-meta {
      padding: 12px 20px;
      display: flex;
      gap: 8px;
    }

    .exp-desc {
      font-size: 14px;
      color: #586069;
      line-height: 1.6;
      padding: 0 20px 16px;
      min-height: 40px;
      max-height: 60px;
      overflow: hidden;
    }

    .card-footer {
      padding: 12px 20px;
      border-top: 1px solid #eaecef;
    }
  }

  .pagination-wrapper {
    margin-top: 24px;
    display: flex;
    justify-content: center;
  }
}

.list-enter-active,
.list-leave-active {
  transition: all 0.3s ease;
}

.list-enter-from,
.list-leave-to {
  opacity: 0;
  transform: translateY(20px);
}

@media (max-width: 768px) {
  .experiment-page {
    .page-header {
      .header-content {
        flex-direction: column;
        align-items: flex-start;
        gap: 12px;
      }

      .filter-select {
        width: 100%;
      }
    }

    .experiment-grid {
      grid-template-columns: 1fr;
    }
  }
}
</style>
