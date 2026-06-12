<template>
  <div class="grade-v2-page">
    <el-page-header @back="$router.back()" :content="`成绩录入 V2 - 开课ID ${offeringId}`" />

    <el-card class="mt-4">
      <template #header>
        <div class="card-header">
          <span class="title">学生 × 评分项 矩阵</span>
          <div>
            <el-button :icon="Download" @click="onDownload">下载模板</el-button>
            <el-upload
              :auto-upload="false"
              :show-file-list="false"
              accept=".xlsx,.xls"
              :on-change="onImport"
            >
              <el-button :icon="Upload" type="warning" class="ml-2">导入 Excel</el-button>
            </el-upload>
            <el-button type="success" :icon="Check" @click="onSaveAll" class="ml-2">保存全部</el-button>
          </div>
        </div>
      </template>

      <el-table
        :data="matrix.students"
        v-loading="loading"
        stripe
        :max-height="600"
        border
      >
        <el-table-column type="index" label="序" width="60" fixed align="center" />
        <el-table-column prop="studentNo" label="学号" width="110" fixed />
        <el-table-column prop="studentName" label="姓名" width="100" fixed />
        <el-table-column
          v-for="item in matrix.items"
          :key="item.itemId"
          :label="item.name"
          :width="130"
          align="center"
        >
          <template #header>
            <el-tooltip placement="top">
              <template #content>
                满分: {{ item.maxScore }} / 期望: {{ item.passingScore }} / 权重: {{ item.weight }}
              </template>
              <div>
                <div>{{ item.name }}</div>
                <div class="muted-small">{{ item.maxScore }} / {{ item.weight }}</div>
              </div>
            </el-tooltip>
          </template>
          <template #default="{ row }">
            <el-input-number
              v-model="row.scores[item.itemId]"
              :min="0"
              :max="item.maxScore"
              :controls="false"
              size="small"
              style="width: 90px"
              @change="markDirty(row.studentId, item.itemId)"
            />
          </template>
        </el-table-column>
        <el-table-column label="加权总分" width="100" align="center" fixed="right">
          <template #default="{ row }">
            <el-tag :type="weightedScore(row) >= 60 ? 'success' : 'warning'">
              {{ weightedScore(row).toFixed(1) }}
            </el-tag>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!loading && !matrix.students?.length" description="该开课暂无学生" />
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage, ElLoading } from 'element-plus'
import { Check, Download, Upload } from '@element-plus/icons-vue'
import { scoringScoreApi } from '@/api'

const route = useRoute()
const offeringId = computed(() => Number(route.params.offeringId))

const matrix = reactive({ items: [], students: [] })
const loading = ref(false)
const dirtySet = ref(new Set())

const fetch = async () => {
  loading.value = true
  try {
    const res = await scoringScoreApi.getMatrix(offeringId.value)
    Object.assign(matrix, res.data || { items: [], students: [] })
    // 确保 scores 对象不为 null
    matrix.students.forEach(s => { if (!s.scores) s.scores = {} })
    dirtySet.value.clear()
  } finally {
    loading.value = false
  }
}
onMounted(fetch)

const markDirty = (studentId, itemId) => {
  dirtySet.value.add(`${studentId}-${itemId}`)
}

const weightedScore = (row) => {
  let total = 0
  for (const item of matrix.items) {
    const s = Number(row.scores[item.itemId] || 0)
    total += s * Number(item.weight || 0)
  }
  return total
}

const onSaveAll = async () => {
  await scoringScoreApi.saveMatrix(offeringId.value, matrix)
  ElMessage.success('全部成绩已保存')
  dirtySet.value.clear()
  fetch()
}

const onDownload = async () => {
  const blob = await scoringScoreApi.downloadTemplate(offeringId.value)
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `成绩明细表-${offeringId.value}.xlsx`
  a.click()
  URL.revokeObjectURL(url)
}

const onImport = async (file) => {
  const loadingInstance = ElLoading.service({ text: 'Excel 导入中...' })
  try {
    const res = await scoringScoreApi.importExcel(offeringId.value, file.raw)
    ElMessage.success(`导入 ${res.data?.count ?? 0} 条成绩`)
    fetch()
  } finally {
    loadingInstance.close()
  }
}
</script>

<style scoped>
.grade-v2-page { padding: 20px; }
.card-header { display: flex; justify-content: space-between; align-items: center; }
.title { font-weight: 600; font-size: 16px; }
.muted-small { color: #909399; font-size: 11px; }
.mt-4 { margin-top: 16px; }
.ml-2 { margin-left: 8px; }
</style>
