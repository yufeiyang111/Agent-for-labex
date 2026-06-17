<template>
  <div class="grade-entry-page wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-left">
          <el-button :icon="ArrowLeft" @click="$router.back()" text class="wabi-btn-text">返回</el-button>
          <h2 class="page-title">成绩录入</h2>
          <span class="page-subtitle">开课ID: {{ offeringId }}</span>
        </div>
        <div class="header-actions">
          <el-button :icon="Download" @click="onDownload" class="wabi-btn-ghost">下载模板</el-button>
          <el-button :icon="View" @click="showPreview = true" class="wabi-btn-ghost">预览</el-button>
          <el-button :icon="Download" @click="onExportGradeDetail" class="wabi-btn-ghost">导出明细</el-button>
          <el-upload
            :auto-upload="false"
            :show-file-list="false"
            accept=".xlsx,.xls"
            :on-change="onImport"
          >
            <el-button :icon="Upload" class="wabi-btn-ghost">导入 Excel</el-button>
          </el-upload>
          <el-button :icon="Refresh" @click="onSync" :loading="syncing" class="wabi-btn-ghost">同步成绩</el-button>
          <el-button type="primary" :icon="Check" @click="onSaveAll" :loading="saving" class="wabi-btn-primary">
            保存全部
          </el-button>
        </div>
      </div>

      <!-- 成绩矩阵容器 -->
      <div class="matrix-container">
        <div class="matrix-content" v-loading="loading">
          <div v-if="!loading && !matrix.students?.length" class="wabi-empty">
            <p class="wabi-empty-text">暂无学生数据</p>
          </div>
          <div v-else class="matrix-wrapper">
            <table class="grade-matrix">
              <thead>
                <tr>
                  <th class="fixed-col index-col">序</th>
                  <th class="fixed-col no-col">学号</th>
                  <th class="fixed-col name-col">姓名</th>
                  <th v-for="item in matrix.items" :key="item.itemId" class="item-col">
                    <div class="item-header">
                      <span class="item-name">{{ item.name }}</span>
                      <span class="item-meta">{{ item.maxScore }}分 / {{ item.weight }}</span>
                    </div>
                  </th>
                  <th class="total-col">加权总分</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(stu, index) in matrix.students" :key="stu.studentId">
                  <td class="fixed-col index-col">{{ (pagination.page - 1) * pagination.pageSize + index + 1 }}</td>
                  <td class="fixed-col no-col">{{ stu.studentNo }}</td>
                  <td class="fixed-col name-col">{{ stu.studentName }}</td>
                  <td v-for="item in matrix.items" :key="item.itemId" class="item-col">
                    <input
                      type="number"
                      v-model.number="stu.scores[item.itemId]"
                      :min="0"
                      :max="item.maxScore"
                      class="score-input"
                      @change="onScoreChange(stu, item)"
                    />
                  </td>
                  <td class="total-col">
                    <span class="total-score" :class="getTotalScoreClass(stu)">
                      {{ calculateTotalScore(stu) }}
                    </span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- 分页（常驻显示） -->
        <div class="matrix-pagination">
          <el-pagination
            v-model:current-page="pagination.page"
            v-model:page-size="pagination.pageSize"
            :page-sizes="[20, 40, 60, 100]"
            :total="pagination.total"
            layout="total, sizes, prev, pager, next, jumper"
            @size-change="loadMatrix"
            @current-change="loadMatrix"
          />
        </div>
      </div>
    </div>

    <!-- PDF预览弹窗 -->
    <ExcelPreviewDialog
      v-model="showPreview"
      title="成绩明细预览"
      :url="exportApi.gradeDetailDownloadUrl(offeringId)"
      :downloadName="`成绩明细-${offeringId}.xlsx`"
    />
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowLeft, Download, Upload, Check, View, Refresh } from '@element-plus/icons-vue'
import { offeringApi, scoringScoreApi, exportApi } from '@/api'
import ExcelPreviewDialog from '@/components/common/ExcelPreviewDialog.vue'

const route = useRoute()
const offeringId = Number(route.params.offeringId)

const loading = ref(false)
const saving = ref(false)
const syncing = ref(false)
const showPreview = ref(false)
const matrix = reactive({
  items: [],
  students: []
})
const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const loadMatrix = async () => {
  loading.value = true
  try {
    const res = await scoringScoreApi.matrix(offeringId, pagination.page, pagination.pageSize)
    matrix.items = res.data?.items || []
    matrix.students = res.data?.students || []
    pagination.total = res.data?.total || 0

    // 调试日志
    console.log('=== 成绩矩阵数据 ===')
    console.log('评分项数量:', matrix.items.length)
    console.log('评分项列表:', matrix.items.map(i => ({ id: i.itemId, name: i.name, weight: i.weight })))
    console.log('学生数量:', matrix.students.length)
    if (matrix.students.length > 0) {
      console.log('第一个学生:', matrix.students[0])
      console.log('第一个学生的成绩:', matrix.students[0].scores)
    }
    console.log('总记录数:', pagination.total)
  } catch (error) {
    console.error('加载成绩矩阵失败:', error)
  } finally {
    loading.value = false
  }
}

const onScoreChange = (stu, item) => {
  // 标记已修改
  stu._modified = true
}

// 计算加权总分
const calculateTotalScore = (stu) => {
  let total = 0
  for (const item of matrix.items) {
    const score = stu.scores[item.itemId]
    if (score != null && item.weight != null) {
      total += score * item.weight
    }
  }
  return total.toFixed(1)
}

// 获取总分样式类
const getTotalScoreClass = (stu) => {
  const total = parseFloat(calculateTotalScore(stu))
  if (total >= 90) return 'excellent'
  if (total >= 70) return 'good'
  if (total >= 60) return 'pass'
  return 'fail'
}

const onSaveAll = async () => {
  saving.value = true
  try {
    // 构建 ScoreMatrixVO 格式的数据
    const students = []
    for (const stu of matrix.students) {
      if (stu._modified) {
        const scores = {}
        for (const item of matrix.items) {
          if (stu.scores[item.itemId] != null) {
            scores[item.itemId] = stu.scores[item.itemId]
          }
        }
        if (Object.keys(scores).length > 0) {
          students.push({
            studentId: stu.studentId,
            scores: scores
          })
        }
      }
    }
    const matrixData = {
      items: matrix.items,
      students: students
    }
    await scoringScoreApi.saveMatrix(offeringId, matrixData)
    ElMessage.success('保存成功')
    loadMatrix()
  } catch (error) {
    console.error('保存失败:', error)
    ElMessage.error('保存失败')
  } finally {
    saving.value = false
  }
}

const onDownload = async () => {
  try {
    const blob = await scoringScoreApi.downloadTemplate(offeringId)
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `成绩模板-${offeringId}.xlsx`
    a.click()
    URL.revokeObjectURL(url)
  } catch (error) {
    ElMessage.error('下载失败')
  }
}

const onExportGradeDetail = async () => {
  try {
    const blob = await scoringScoreApi.exportGradeDetail(offeringId)
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `成绩明细-${offeringId}.xlsx`
    a.click()
    URL.revokeObjectURL(url)
  } catch (error) {
    ElMessage.error('导出失败')
  }
}

const onImport = async (file) => {
  try {
    await scoringScoreApi.importExcel(offeringId, file.raw)
    ElMessage.success('导入成功')
    loadMatrix()
  } catch (error) {
    ElMessage.error('导入失败')
  }
}

const onSync = async () => {
  syncing.value = true
  try {
    const res = await scoringScoreApi.syncScores(offeringId)
    const count = res.data?.synced || 0
    if (count > 0) {
      ElMessage.success(`同步完成，已同步 ${count} 条成绩`)
    } else {
      ElMessage.info('无新成绩可同步，请确认评分项已关联作业/考试/实验')
    }
    loadMatrix()
  } catch (error) {
    ElMessage.error('同步失败：' + (error.message || '未知错误'))
  } finally {
    syncing.value = false
  }
}

onMounted(loadMatrix)
</script>

<style scoped>
.grade-entry-page {
  min-height: 100vh;
  background: var(--wabi-bg, #f8f6f3);
}

.wabi-body {
  padding: 24px;
  max-width: 1400px;
  margin: 0 auto;
  height: calc(100vh - 48px);
  display: flex;
  flex-direction: column;
  animation: wabi-fade-in 0.4s ease;
}

@keyframes wabi-fade-in {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 页面头部 */
.page-header {
  flex-shrink: 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  flex-wrap: wrap;
  gap: 16px;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 12px;
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

.header-actions {
  display: flex;
  gap: 8px;
  align-items: center;
  flex-wrap: wrap;
}

/* 成绩矩阵容器 */
.matrix-container {
  flex: 1;
  min-height: 0;
  display: flex;
  flex-direction: column;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: var(--wabi-radius, 3px);
  overflow: hidden;
}

.matrix-content {
  flex: 1;
  min-height: 0;
  overflow: auto;
}

.matrix-wrapper {
  min-width: max-content;
}

.grade-matrix {
  width: 100%;
  border-collapse: collapse;
  font-size: 13px;
}

.grade-matrix th,
.grade-matrix td {
  padding: 8px 12px;
  border: 1px solid var(--wabi-border, #e8e4df);
  text-align: center;
}

.grade-matrix th {
  background: var(--wabi-surface-warm, #faf9f7);
  color: var(--wabi-text-secondary, #8a8580);
  font-weight: 500;
  position: sticky;
  top: 0;
  z-index: 1;
}

.grade-matrix td {
  background: var(--wabi-surface, #fff);
}

.grade-matrix tr:hover td {
  background: var(--wabi-accent-light, #e8ede5);
}

.fixed-col {
  position: sticky;
  z-index: 2;
  background: var(--wabi-surface, #fff);
}

.index-col {
  width: 50px;
  left: 0;
}

.no-col {
  width: 100px;
  left: 50px;
}

.name-col {
  width: 80px;
  left: 150px;
}

.item-col {
  min-width: 100px;
}

.total-col {
  min-width: 80px;
  background: var(--wabi-surface-warm, #faf9f7) !important;
  font-weight: 600;
}

.total-score {
  display: inline-block;
  padding: 2px 8px;
  border-radius: 4px;
  font-size: 13px;
}

.total-score.excellent {
  background: #e8f5e9;
  color: #2e7d32;
}

.total-score.good {
  background: #e3f2fd;
  color: #1565c0;
}

.total-score.pass {
  background: #fff3e0;
  color: #ef6c00;
}

.total-score.fail {
  background: #ffebee;
  color: #c62828;
}

.item-header {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.item-name {
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
}

.item-meta {
  font-size: 11px;
  color: var(--wabi-text-secondary, #8a8580);
}

.score-input {
  width: 70px;
  padding: 4px 8px;
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 4px;
  text-align: center;
  font-size: 13px;
  color: var(--wabi-text, #2c2c2c);
  background: var(--wabi-surface, #fff);
  transition: border-color 0.2s ease;
}

.score-input:focus {
  outline: none;
  border-color: var(--wabi-accent, #7a8b6f);
}

.score-input::-webkit-inner-spin-button,
.score-input::-webkit-outer-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* 空状态 */
.wabi-empty {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  min-height: 200px;
}

.wabi-empty-text {
  color: var(--wabi-text-secondary, #8a8580);
  font-size: 14px;
  margin: 0;
}

/* 分页（常驻显示在底部） */
.matrix-pagination {
  flex-shrink: 0;
  display: flex;
  justify-content: center;
  padding: 16px 20px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
  background: var(--wabi-surface-warm, #faf9f7);
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

.wabi-btn-ghost:hover {
  border-color: var(--wabi-accent, #7a8b6f);
  color: var(--wabi-accent, #7a8b6f);
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

  .page-header {
    flex-direction: column;
    align-items: flex-start;
  }

  .header-actions {
    width: 100%;
  }
}
</style>
