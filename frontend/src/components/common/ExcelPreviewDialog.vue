<template>
  <el-dialog
    v-model="visible"
    :title="title"
    width="90%"
    top="2vh"
    :close-on-click-modal="false"
    @closed="cleanup"
  >
    <div v-loading="loading" class="preview-container">
      <div v-if="sheets.length" class="sheet-tabs">
        <span
          v-for="(sheet, idx) in sheets"
          :key="sheet.name"
          class="sheet-tab"
          :class="{ active: activeSheet === idx }"
          @click="activeSheet = idx"
        >
          {{ sheet.name }}
        </span>
      </div>
      <div v-if="currentSheet" class="table-wrapper">
        <table class="excel-table" :style="{ width: tableWidth + 'px' }">
          <colgroup>
            <col v-for="c in currentSheet.cols" :key="c" :style="{ width: c + 'px' }" />
          </colgroup>
          <tbody>
            <tr v-for="(row, ri) in currentSheet.rows" :key="ri" :style="rowStyles[ri]">
              <td
                v-for="(cell, ci) in row"
                :key="ci"
                :colspan="getMerge(ri, ci, 'colspan')"
                :rowspan="getMerge(ri, ci, 'rowspan')"
                :class="getCellClass(ri, ci)"
                :style="getCellStyle(cell)"
                v-show="!isMergedHidden(ri, ci)"
              >
                <div v-if="cell && cell.f" class="cell-formula">{{ cell.f }}</div>
                <div v-else class="cell-value">{{ formatValue(cell) }}</div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <el-empty v-if="!sheets.length && !loading" :description="errorMsg || '暂无内容'" />
    </div>
    <template #footer>
      <el-button @click="visible = false">关闭</el-button>
      <el-button type="primary" :loading="loading" @click="load">刷新</el-button>
      <el-button type="success" :disabled="!sheets.length" @click="download">下载</el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, watch, computed, nextTick } from 'vue'
import { ElMessage } from 'element-plus'
import * as XLSX from 'xlsx'

const props = defineProps({
  modelValue: { type: Boolean, default: false },
  title: { type: String, default: '预览' },
  url: { type: String, required: true },
  downloadName: { type: String, default: 'download.xlsx' }
})
const emit = defineEmits(['update:modelValue'])

const visible = ref(false)
const loading = ref(false)
const sheets = ref([])
const activeSheet = ref(0)
const errorMsg = ref('')
let blobUrl = ''

const currentSheet = computed(() => sheets.value[activeSheet.value] || null)

const tableWidth = computed(() => {
  if (!currentSheet.value) return 0
  return currentSheet.value.cols.reduce((a, b) => a + b, 0)
})

const rowStyles = computed(() => {
  if (!currentSheet.value) return {}
  const styles = {}
  const sr = currentSheet.value.styles || {}
  for (const [ri, style] of Object.entries(sr)) {
    if (style.height) styles[ri] = { height: style.height + 'px' }
  }
  return styles
})

watch(() => props.modelValue, (v) => { visible.value = v; if (v) nextTick(load) })
watch(visible, (v) => emit('update:modelValue', v))

function cleanup() {
  if (blobUrl) {
    URL.revokeObjectURL(blobUrl)
    blobUrl = ''
  }
  sheets.value = []
  activeSheet.value = 0
  errorMsg.value = ''
}

// 获取合并单元格信息
function getMerge(ri, ci, type) {
  const merges = currentSheet.value?.merges || []
  for (const m of merges) {
    if (ri === m.r && ci === m.c) {
      return type === 'colspan' ? m.cs : m.rs
    }
  }
  return undefined
}

// 判断是否被合并单元格隐藏
function isMergedHidden(ri, ci) {
  const merges = currentSheet.value?.merges || []
  for (const m of merges) {
    if (ri >= m.r && ri < m.r + m.rs && ci >= m.c && ci < m.c + m.cs) {
      if (ri !== m.r || ci !== m.c) return true
    }
  }
  return false
}

function getCellClass(ri, ci) {
  const classes = []
  const cellStyles = currentSheet.value?.cellStyles || {}
  const key = `${ri}_${ci}`
  if (cellStyles[key]?.bold) classes.push('cell-bold')
  if (cellStyles[key]?.align === 'center') classes.push('cell-center')
  if (cellStyles[key]?.align === 'right') classes.push('cell-right')
  if (ri === 0) classes.push('cell-header')
  return classes
}

function getCellStyle(cell) {
  if (!cell) return {}
  const s = {}
  if (cell.s?.fill?.fgColor?.rgb) {
    s.backgroundColor = '#' + cell.s.fill.fgColor.rgb
  }
  if (cell.s?.font?.bold) s.fontWeight = 'bold'
  if (cell.s?.font?.sz) s.fontSize = cell.s.font.sz + 'pt'
  return s
}

function formatValue(cell) {
  if (cell == null) return ''
  if (typeof cell === 'object') {
    if (cell.w != null) return cell.w
    if (cell.v != null) return String(cell.v)
    return ''
  }
  return String(cell)
}

async function load() {
  cleanup()
  loading.value = true
  try {
    const token = localStorage.getItem('token') || ''
    const resp = await fetch('/api' + props.url, {
      headers: { Authorization: token ? `Bearer ${token}` : '' }
    })
    if (!resp.ok) {
      const text = await resp.text()
      throw new Error(`HTTP ${resp.status}: ${text.slice(0, 200)}`)
    }
    const blob = await resp.blob()
    blobUrl = URL.createObjectURL(blob)
    const arrayBuffer = await blob.arrayBuffer()
    const workbook = XLSX.read(arrayBuffer, { type: 'array', cellStyles: true, cellNF: true })

    sheets.value = workbook.SheetNames.map(name => {
      const sheet = workbook.Sheets[name]
      const range = XLSX.utils.decode_range(sheet['!ref'] || 'A1')
      const merges = (sheet['!merges'] || []).map(m => ({
        r: m.s.r, c: m.s.c,
        rs: m.e.r - m.s.r + 1,
        cs: m.e.c - m.s.c + 1
      }))
      // 列宽
      const cols = []
      const colInfo = sheet['!cols'] || []
      for (let c = range.s.c; c <= range.e.c; c++) {
        const info = colInfo[c]
        cols.push(info?.wpx ? info.wpx : 80)
      }
      // 行高
      const rowInfo = sheet['!rows'] || []
      const styles = {}
      for (let r = range.s.r; r <= range.e.r; r++) {
        if (rowInfo[r]?.hpx) styles[r] = { height: rowInfo[r].hpx }
      }
      // 单元格数据
      const rows = []
      const cellStyles = {}
      for (let r = range.s.r; r <= range.e.r; r++) {
        const row = []
        for (let c = range.s.c; c <= range.e.c; c++) {
          const addr = XLSX.utils.encode_cell({ r, c })
          const cell = sheet[addr]
          row.push(cell || null)
          if (cell?.s) {
            cellStyles[`${r}_${c}`] = {
              bold: cell.s.font?.bold,
              align: cell.s.alignment?.horizontal
            }
          }
        }
        rows.push(row)
      }
      return { name, rows, merges, cols, styles, cellStyles }
    })
  } catch (e) {
    console.error('Excel preview error', e)
    errorMsg.value = e.message || '加载失败'
    ElMessage.error(errorMsg.value)
  } finally {
    loading.value = false
  }
}

function download() {
  if (!blobUrl) return
  const a = document.createElement('a')
  a.href = blobUrl
  a.download = props.downloadName
  document.body.appendChild(a)
  a.click()
  document.body.removeChild(a)
}
</script>

<style scoped>
.preview-container {
  min-height: 50vh;
  max-height: 72vh;
  overflow: auto;
  background: #fff;
}
.sheet-tabs {
  display: flex;
  gap: 0;
  border-bottom: 2px solid #e4e7ed;
  background: #f5f7fa;
  padding: 0 8px;
  position: sticky;
  top: 0;
  z-index: 10;
}
.sheet-tab {
  padding: 8px 20px;
  cursor: pointer;
  font-size: 13px;
  color: #606266;
  border: 1px solid #e4e7ed;
  border-bottom: none;
  border-radius: 4px 4px 0 0;
  background: #f5f7fa;
  margin-bottom: -2px;
  transition: all 0.2s;
}
.sheet-tab.active {
  background: #fff;
  color: #409eff;
  border-color: #409eff;
  font-weight: 500;
}
.sheet-tab:hover { color: #409eff; }
.table-wrapper { overflow: auto; padding: 0; }
.excel-table {
  border-collapse: collapse;
  table-layout: fixed;
  font-size: 12px;
  font-family: 'Microsoft YaHei', 'SimSun', sans-serif;
}
.excel-table td {
  border: 1px solid #d0d0d0;
  padding: 2px 4px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  vertical-align: middle;
  height: 22px;
  background: #fff;
}
.cell-header { background: #e8f0fe !important; font-weight: 600; }
.cell-bold { font-weight: 700; }
.cell-center { text-align: center; }
.cell-right { text-align: right; }
.cell-value { overflow: hidden; text-overflow: ellipsis; }
.cell-formula { color: #999; font-size: 11px; font-style: italic; }
</style>
