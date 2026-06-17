<template>
  <div class="lecture-page">
    <div class="lecture-layout">
      <!-- 左侧固定分类导航栏 -->
      <aside class="lecture-sidebar">
        <div class="sidebar-header">
          <h3><el-icon style="vertical-align:-3px"><Document /></el-icon> 讲义分类</h3>
        </div>
        <div class="sidebar-body">
          <!-- 全部 -->
          <div
            class="sidebar-item"
            :class="{ active: isAllSelected }"
            @click="selectAll"
          >
            <span class="item-label">全部讲义</span>
            <span class="item-count">{{ lectures.length }}</span>
          </div>

          <div class="sidebar-divider"></div>

          <!-- 类型分组 -->
          <div class="sidebar-section-label">按类型</div>
          <div
            v-for="t in typeOptions"
            :key="t.value"
            class="sidebar-item"
            :class="{ active: filterType === t.value && !filterCategory }"
            @click="selectType(t.value)"
          >
            <span class="item-label">{{ t.label }}</span>
            <span class="item-count">{{ getTypeCount(t.value) }}</span>
          </div>

          <div class="sidebar-divider"></div>

          <!-- 分类分组 -->
          <div class="sidebar-section-label">按分类</div>
          <div
            v-for="c in categories"
            :key="c"
            class="sidebar-item"
            :class="{ active: filterCategory === c }"
            @click="selectCategory(c)"
          >
            <span class="item-label">{{ c }}</span>
            <span class="item-count">{{ getCategoryCount(c) }}</span>
          </div>
          <div v-if="categories.length === 0" class="sidebar-empty">
            暂无分类
          </div>
        </div>
      </aside>

      <!-- 右侧滚动主内容区 -->
      <main class="lecture-main">
        <div class="main-header">
          <h2>{{ headerTitle }}</h2>
          <p class="header-count">共 {{ filteredLectures.length }} 个讲义</p>
        </div>

        <div v-loading="loading" class="lecture-list">
          <el-empty v-if="filteredLectures.length === 0 && !loading" description="暂无可用讲义" />

          <transition-group name="list" tag="div" class="lecture-grid">
            <el-card
              v-for="lecture in paginatedLectures"
              :key="lecture.lectureId"
              class="lecture-card"
              shadow="hover"
            >
              <div class="card-header">
                <div class="lecture-icon">
                  <el-icon><Document /></el-icon>
                </div>
                <div class="lecture-info">
                  <div class="lecture-name">{{ lecture.lectureName }}</div>
                  <div class="lecture-meta">
                    <el-tag :type="getTypeTag(lecture.lectureType)" size="small" effect="plain">
                      {{ getTypeName(lecture.lectureType) }}
                    </el-tag>
                    <el-tag v-if="lecture.category" type="success" size="small" effect="plain">
                      {{ lecture.category }}
                    </el-tag>
                    <span class="file-type" v-if="lecture.lectureFiletype">
                      {{ lecture.lectureFiletype.toUpperCase() }}
                    </span>
                  </div>
                </div>
              </div>

              <div class="card-footer">
                <el-button type="primary" size="small" @click="viewLecture(lecture)">
                  <el-icon><View /></el-icon>
                  预览
                </el-button>
                <el-button type="success" size="small" @click="downloadLecture(lecture)">
                  <el-icon><Download /></el-icon>
                  下载
                </el-button>
              </div>
            </el-card>
          </transition-group>
        </div>

        <div class="pagination-wrapper" v-if="filteredLectures.length > 0">
          <el-pagination
            v-model:current-page="currentPage"
            v-model:page-size="pageSize"
            :page-sizes="[9, 18, 27, 36]"
            :total="filteredLectures.length"
            layout="total, sizes, prev, pager, next, jumper"
            background
          />
        </div>
      </main>
    </div>

    <!-- 讲义预览对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="currentLecture?.lectureName || '讲义详情'"
      width="90%"
      :fullscreen="isFullscreen"
      class="lecture-dialog"
      @closed="onDialogClosed"
    >
      <template #header="{ titleId }">
        <div class="dialog-header">
          <span :id="titleId">{{ currentLecture?.lectureName }}</span>
          <div class="header-actions">
            <el-button v-if="currentLecture?.filePath" type="primary" link @click="isFullscreen = !isFullscreen">
              {{ isFullscreen ? '退出全屏' : '全屏预览' }}
            </el-button>
            <el-button
              v-if="currentLecture?.filePath && isPptFile"
              type="primary"
              link
              @click="openPptPreviewWindow"
            >
              <el-icon><View /></el-icon> 打开原文件
            </el-button>
            <el-button v-if="currentLecture?.filePath" type="success" link @click="downloadLecture(currentLecture)">
              <el-icon><Download /></el-icon> 下载
            </el-button>
          </div>
        </div>
      </template>

      <div class="lecture-content" v-if="currentLecture">
        <div v-if="currentLecture.lectureContent && !isMarkdownFile" v-html="currentLecture.lectureContent"></div>

        <div v-else-if="markdownHtmlContent && isMarkdownFile" class="markdown-container">
          <div class="markdown-content" v-html="markdownHtmlContent"></div>
        </div>

        <div v-else-if="currentLecture.filePath" class="file-preview">
          <div v-if="isPdfFile" class="pdf-container">
            <div v-if="pdfLoading" class="preview-loading">
              <el-icon class="is-loading" size="32"><Loading /></el-icon>
              <span>正在加载 PDF...</span>
            </div>
            <div v-else-if="pdfError" class="preview-error">
              <el-icon size="48" color="#f56c6c"><CircleCloseFilled /></el-icon>
              <p>{{ pdfError }}</p>
              <el-button type="primary" @click="downloadLecture(currentLecture)">
                下载后查看
              </el-button>
            </div>
            <div v-else ref="pdfContainerRef" class="pdf-viewer"></div>
          </div>

          <div v-else-if="isImageFile" class="image-preview">
            <el-image
              :src="previewUrl"
              :preview-src-list="[previewUrl]"
              fit="contain"
              style="max-height: 75vh;"
              :crossorigin="'anonymous'"
            />
          </div>

          <div v-else-if="isWordFile" class="word-container">
            <div v-if="docLoading" class="preview-loading">
              <el-icon class="is-loading" size="32"><Loading /></el-icon>
              <span>正在加载 {{ docPreviewName }}...</span>
            </div>
            <div v-else-if="docError" class="preview-error">
              <el-icon size="48" color="#f56c6c"><CircleCloseFilled /></el-icon>
              <p>{{ docError }}</p>
              <el-button type="primary" @click="downloadLecture(currentLecture)">
                下载后查看
              </el-button>
            </div>
            <div v-else class="word-content" v-html="wordHtmlContent"></div>
          </div>

          <div v-else-if="isMarkdownFile" class="markdown-container">
            <div v-if="docLoading" class="preview-loading">
              <el-icon class="is-loading" size="32"><Loading /></el-icon>
              <span>正在加载 {{ docPreviewName }}...</span>
            </div>
            <div v-else-if="docError" class="preview-error">
              <el-icon size="48" color="#f56c6c"><CircleCloseFilled /></el-icon>
              <p>{{ docError }}</p>
              <el-button type="primary" @click="downloadLecture(currentLecture)">
                下载后查看
              </el-button>
            </div>
            <div v-else class="markdown-content" v-html="markdownHtmlContent"></div>
          </div>

          <div v-else-if="isHtmlFile" class="html-container">
            <div v-if="htmlLoading" class="preview-loading">
              <el-icon class="is-loading" size="32"><Loading /></el-icon>
              <span>正在加载 HTML 文档...</span>
            </div>
            <div v-else-if="htmlError" class="preview-error">
              <el-icon size="48" color="#f56c6c"><CircleCloseFilled /></el-icon>
              <p>{{ htmlError }}</p>
              <el-button type="primary" @click="downloadLecture(currentLecture)">
                下载后查看
              </el-button>
            </div>
            <iframe
              v-else
              class="html-preview-frame"
              :srcdoc="htmlSrcdoc"
              sandbox="allow-scripts allow-forms allow-modals allow-popups allow-same-origin"
              title="HTML 预览"
            ></iframe>
          </div>

          <div v-else-if="isSpreadsheetFile" class="sheet-container">
            <div class="sheet-toolbar">
              <div class="sheet-toolbar-left">
                <el-tag type="success" effect="dark">在线预览</el-tag>
                <span class="sheet-tip">共 {{ sheetNames.length }} 个工作表</span>
              </div>
              <div class="sheet-toolbar-right">
                <el-select
                  v-if="sheetNames.length"
                  :model-value="activeSheetName"
                  placeholder="选择工作表"
                  size="small"
                  style="width: 180px"
                  @change="selectSpreadsheetSheet"
                >
                  <el-option
                    v-for="name in sheetNames"
                    :key="name"
                    :label="name"
                    :value="name"
                  />
                </el-select>
                <el-button size="small" plain @click="loadSpreadsheetPreview">
                  <el-icon><Refresh /></el-icon>
                  重新加载
                </el-button>
              </div>
            </div>

            <div v-if="sheetLoading" class="preview-loading sheet-loading-block">
              <el-icon class="is-loading" size="32"><Loading /></el-icon>
              <span>正在解析表格文件...</span>
            </div>

            <div v-else-if="sheetError" class="preview-error">
              <el-icon size="48" color="#f56c6c"><CircleCloseFilled /></el-icon>
              <p>{{ sheetError }}</p>
              <el-button type="primary" @click="loadSpreadsheetPreview">重新加载</el-button>
            </div>

            <div v-else class="sheet-table-wrap">
              <el-table
                :data="sheetRows"
                border
                stripe
                style="width: 100%"
                max-height="62vh"
                empty-text="当前工作表暂无数据"
              >
                <el-table-column label="#" type="index" width="70" fixed="left" />
                <el-table-column
                  v-for="col in sheetColumns"
                  :key="col.key"
                  :prop="col.key"
                  :label="col.label"
                  min-width="140"
                  show-overflow-tooltip
                />
              </el-table>
            </div>
          </div>

          <div v-else-if="isPptFile" class="ppt-container">
            <div class="ppt-toolbar">
              <div class="ppt-toolbar-left">
                <el-tag type="success" effect="dark">在线预览</el-tag>
                <span class="ppt-tip">共 {{ pptSlides.length }} 页 · 内网渲染预览</span>
              </div>
              <div class="ppt-toolbar-actions">
                <el-button size="small" plain @click="loadPptPreview">
                  <el-icon><Refresh /></el-icon>
                  重新加载
                </el-button>
                <el-button size="small" type="primary" @click="openPptPreviewWindow">
                  <el-icon><View /></el-icon>
                  打开原文件
                </el-button>
              </div>
            </div>

            <div v-if="pptLoading" class="preview-loading ppt-loading-block">
              <el-icon class="is-loading" size="32"><Loading /></el-icon>
              <span>正在渲染 PPT 幻灯片...</span>
            </div>

            <div v-else-if="pptError" class="preview-error">
              <el-icon size="48" color="#f56c6c"><CircleCloseFilled /></el-icon>
              <p>{{ pptError }}</p>
              <div class="ppt-error-actions">
                <el-button type="primary" @click="loadPptPreview">重新渲染</el-button>
                <el-button @click="downloadLecture(currentLecture)">下载后查看</el-button>
              </div>
            </div>

            <div v-else-if="pptSlides.length" class="ppt-viewer-wrap">
              <div class="ppt-main">
                <img
                  :src="pptSlides[pptCurrentSlideIndex]?.url"
                  :alt="`幻灯片 ${pptCurrentSlideIndex + 1}`"
                  class="ppt-slide-image"
                />
              </div>

              <div class="ppt-pagination">
                <el-button :disabled="pptCurrentSlideIndex <= 0" @click="prevPptSlide">上一页</el-button>
                <span class="ppt-page-indicator">{{ pptCurrentSlideIndex + 1 }} / {{ pptSlides.length }}</span>
                <el-button :disabled="pptCurrentSlideIndex >= pptSlides.length - 1" @click="nextPptSlide">下一页</el-button>
              </div>

              <div class="ppt-thumbs">
                <button
                  v-for="(slide, idx) in pptSlides"
                  :key="slide.index"
                  class="ppt-thumb"
                  :class="{ active: idx === pptCurrentSlideIndex }"
                  type="button"
                  @click="selectPptSlide(idx)"
                >
                  <img :src="slide.url" :alt="`缩略图 ${idx + 1}`" />
                  <span>{{ idx + 1 }}</span>
                </button>
              </div>
            </div>

            <div v-else class="preview-error">
              <el-icon size="48" color="#f56c6c"><CircleCloseFilled /></el-icon>
              <p>PPT 暂无可预览页面</p>
            </div>
          </div>

          <div v-else class="unsupported-preview">
            <el-icon size="64" color="#909399"><Document /></el-icon>
            <h3>此文件格式暂不支持在线预览</h3>
            <p>文件类型: {{ currentLecture.lectureFiletype }}</p>
            <el-button type="primary" size="large" @click="downloadLecture(currentLecture)">
              <el-icon><Download /></el-icon>
              下载文件到本地查看
            </el-button>
          </div>
        </div>

        <el-empty v-else description="暂无内容" />
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch, nextTick, onUnmounted } from 'vue'
import { studentApi } from '@/api'
import { ElMessage } from 'element-plus'
import { Document, Download, Loading, CircleCloseFilled, View, Refresh } from '@element-plus/icons-vue'
import * as pdfjsLib from 'pdfjs-dist'
import mammoth from 'mammoth'
import { marked } from 'marked'
import hljs from 'highlight.js'
import * as XLSX from 'xlsx'

pdfjsLib.GlobalWorkerOptions.workerSrc = new URL(
  'pdfjs-dist/build/pdf.worker.mjs',
  import.meta.url
).toString()

const loading = ref(false)
const lectures = ref([])
const dialogVisible = ref(false)
const currentLecture = ref(null)
const isFullscreen = ref(false)
const currentPage = ref(1)
const pageSize = ref(18)
const filterType = ref(0)
const filterCategory = ref('')
const categories = ref([])

const typeOptions = [
  { value: 1, label: '课件' },
  { value: 2, label: '参考' },
  { value: 3, label: '其他' }
]

const isAllSelected = computed(() => filterType.value === 0 && !filterCategory.value)

const headerTitle = computed(() => {
  if (filterCategory.value) return filterCategory.value
  if (filterType.value !== 0) {
    const t = typeOptions.find(t => t.value === filterType.value)
    return t ? t.label : '讲义列表'
  }
  return '全部讲义'
})

const selectAll = () => {
  filterType.value = 0
  filterCategory.value = ''
  currentPage.value = 1
}

const selectType = (type) => {
  filterType.value = filterType.value === type ? 0 : type
  filterCategory.value = ''
  currentPage.value = 1
}

const selectCategory = (category) => {
  filterType.value = 0
  filterCategory.value = filterCategory.value === category ? '' : category
  currentPage.value = 1
}

const getTypeCount = (type) => {
  return lectures.value.filter(l => l.lectureType === type).length
}

const getCategoryCount = (category) => {
  return lectures.value.filter(l => l.category === category).length
}

const pdfLoading = ref(false)
const pdfError = ref('')
const pdfContainerRef = ref(null)
let pdfDoc = null

const docLoading = ref(false)
const docError = ref('')
const wordHtmlContent = ref('')
const markdownHtmlContent = ref('')
const htmlLoading = ref(false)
const htmlError = ref('')
const htmlSrcdoc = ref('')

const sheetLoading = ref(false)
const sheetError = ref('')
const sheetNames = ref([])
const activeSheetName = ref('')
const sheetColumns = ref([])
const sheetRows = ref([])
let spreadsheetWorkbook = null

const pptLoading = ref(false)
const pptError = ref('')
const pptSlides = ref([])
const pptCurrentSlideIndex = ref(0)

const filteredLectures = computed(() => {
  let result = lectures.value
  if (filterType.value !== 0) {
    result = result.filter((l) => l.lectureType === filterType.value)
  }
  if (filterCategory.value) {
    result = result.filter((l) => l.category === filterCategory.value)
  }
  return result
})

const paginatedLectures = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  return filteredLectures.value.slice(start, end)
})

const normalizedFileExt = computed(() => {
  const lecture = currentLecture.value
  if (!lecture) return ''

  const rawType = String(lecture.lectureFiletype || '').trim().toLowerCase().replace(/^\./, '')
  if (rawType) {
    return rawType
  }

  const filePath = String(lecture.filePath || '').trim().toLowerCase()
  const match = filePath.match(/\.([a-z0-9]+)(?:$|[?#])/)
  if (match) return match[1]

  if (lecture.lectureContent && /^#\s|```|^>\s|\*\*|^\|.*\|/m.test(lecture.lectureContent)) {
    return 'md'
  }

  return ''
})

const isPdfFile = computed(() => {
  const ext = normalizedFileExt.value
  return ext === 'pdf'
})

const isImageFile = computed(() => {
  const ext = normalizedFileExt.value
  return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'svg'].includes(ext)
})

const isWordFile = computed(() => {
  const ext = normalizedFileExt.value
  return ['docx'].includes(ext)
})

const isMarkdownFile = computed(() => {
  const ext = normalizedFileExt.value
  return ['md', 'markdown'].includes(ext)
})

const isHtmlFile = computed(() => {
  const ext = normalizedFileExt.value
  return ['html', 'htm'].includes(ext)
})

const isSpreadsheetFile = computed(() => {
  const ext = normalizedFileExt.value
  return ['csv', 'tsv', 'xls', 'xlsx', 'xlsm', 'ods'].includes(ext)
})

const docPreviewName = computed(() => {
  if (isMarkdownFile.value) return 'Markdown 文档'
  return 'Word 文档'
})

const isPptFile = computed(() => {
  const ext = normalizedFileExt.value
  return ['ppt', 'pptx'].includes(ext)
})

const previewUrl = computed(() => {
  if (!currentLecture.value?.lectureId) return ''
  return `/api/preview/lecture/${currentLecture.value.lectureId}`
})

onMounted(async () => {
  await loadLectures()
})

const loadLectures = async () => {
  loading.value = true
  try {
    const res = await studentApi.lectures()
    lectures.value = res.data || []
    const cats = [...new Set(lectures.value.map(l => l.category).filter(Boolean))]
    cats.sort()
    categories.value = cats
  } catch (error) {
    console.error('加载讲义列表失败:', error)
  } finally {
    loading.value = false
  }
}

const getTypeTag = (type) => {
  const map = { 1: 'primary', 2: 'success', 3: 'warning' }
  return map[type] || 'info'
}

const getTypeName = (type) => {
  const map = { 1: '课件', 2: '参考', 3: '其他' }
  return map[type] || '其他'
}

const viewLecture = async (row) => {
  try {
    const res = await studentApi.getLecture(row.lectureId)
    currentLecture.value = res.data || row
  } catch (error) {
    currentLecture.value = row
  }
  dialogVisible.value = true
  isFullscreen.value = false
  docLoading.value = false
  docError.value = ''
  pdfError.value = ''
  pptLoading.value = false
  pptError.value = ''
  pptSlides.value = []
  pptCurrentSlideIndex.value = 0
  wordHtmlContent.value = ''
  markdownHtmlContent.value = ''
  htmlLoading.value = false
  htmlError.value = ''
  htmlSrcdoc.value = ''
  sheetLoading.value = false
  sheetError.value = ''
  sheetNames.value = []
  activeSheetName.value = ''
  sheetColumns.value = []
  sheetRows.value = []
  spreadsheetWorkbook = null

  await nextTick()

  if (currentLecture.value?.lectureContent && isMarkdownFile.value) {
    markdownHtmlContent.value = marked.parse(currentLecture.value.lectureContent, { renderer: markdownRenderer })
  } else if (currentLecture.value?.filePath) {
    loadFilePreview()
  }
}

const onDialogClosed = () => {
  if (pdfDoc) {
    pdfDoc.destroy()
    pdfDoc = null
  }
  pdfError.value = ''
  docError.value = ''
  pptLoading.value = false
  pptError.value = ''
  pptSlides.value = []
  pptCurrentSlideIndex.value = 0
  wordHtmlContent.value = ''
  markdownHtmlContent.value = ''
  htmlLoading.value = false
  htmlError.value = ''
  htmlSrcdoc.value = ''
  sheetLoading.value = false
  sheetError.value = ''
  sheetNames.value = []
  activeSheetName.value = ''
  sheetColumns.value = []
  sheetRows.value = []
  spreadsheetWorkbook = null
}

const loadFilePreview = async () => {
  if (!currentLecture.value?.lectureId) return

  if (isPdfFile.value) {
    loadPdfPreview()
  } else if (isWordFile.value) {
    loadWordPreview()
  } else if (isMarkdownFile.value) {
    loadMarkdownPreview()
  } else if (isHtmlFile.value) {
    loadHtmlPreview()
  } else if (isSpreadsheetFile.value) {
    loadSpreadsheetPreview()
  } else if (isPptFile.value) {
    loadPptPreview()
  }
}

marked.setOptions({
  gfm: true,
  breaks: true
})

let mdTableIndex = 0
const markdownRenderer = new marked.Renderer()

markdownRenderer.heading = ({ tokens, depth }) => {
  const text = marked.Parser.parseInline(tokens || [])
  const id = `h-${depth}-${mdTableIndex++}`
  return `<h${depth} id="${id}">${text}</h${depth}>`
}

markdownRenderer.code = ({ text, lang }) => {
  const language = lang || 'text'
  const langClass = language ? `language-${language}` : ''

  let highlighted
  if (language && hljs.getLanguage(language)) {
    try {
      highlighted = hljs.highlight(text, { language }).value
    } catch (e) {
      highlighted = hljs.highlightAuto(text).value
    }
  } else {
    highlighted = hljs.highlightAuto(text).value
  }

  return `<div class="code-block-wrapper">
    <div class="code-block-header">
      <span class="code-lang-label">${language}</span>
      <button class="code-copy-btn" onclick="navigator.clipboard.writeText(this.closest('.code-block-wrapper').querySelector('code').textContent).then(()=>{this.textContent='已复制';setTimeout(()=>{this.textContent='复制'},1500)})">复制</button>
    </div>
    <pre><code class="${langClass}">${highlighted}</code></pre>
  </div>`
}

markdownRenderer.table = ({ header, rows }) => {
  const headerHtml = header.map(cell => {
    const content = marked.Parser.parseInline(cell.tokens || [])
    return `<th>${content}</th>`
  }).join('')

  const rowsHtml = rows.map(row => {
    const cells = row.map(cell => {
      const content = marked.Parser.parseInline(cell.tokens || [])
      return `<td>${content}</td>`
    }).join('')
    return `<tr>${cells}</tr>`
  }).join('')

  return `<div class="table-wrapper">
    <div class="table-header-bar">
      <span class="table-label">表格</span>
      <button class="table-copy-btn" onclick="(function(){const tbl=this.closest('.table-wrapper').querySelector('table');let csv='';tbl.querySelectorAll('tr').forEach((r,ri)=>{let row='';r.querySelectorAll('th,td').forEach((c,ci)=>{let val=c.textContent.trim().replace(/"/g,'""');if(ri>0&&(ci===0||row))row+=',';row+='"'+val+'"';});csv+=row+'\\n';});navigator.clipboard.writeText(csv).then(()=>{this.textContent='已复制';setTimeout(()=>{this.textContent='复制表格'},1500)})})()">复制表格</button>
    </div>
    <div class="table-scroll">
      <table>
        <thead><tr>${headerHtml}</tr></thead>
        <tbody>${rowsHtml}</tbody>
      </table>
    </div>
  </div>`
}

markdownRenderer.link = ({ href, title, tokens }) => {
  const safeHref = href || '#'
  const titleAttr = title ? ` title="${title}"` : ''
  return `<a href="${safeHref}"${titleAttr} target="_blank" rel="noopener noreferrer">${marked.Parser.parseInline(tokens || [])}</a>`
}

markdownRenderer.list = ({ ordered, items }) => {
  const tag = ordered ? 'ol' : 'ul'
  const itemsHtml = items.map(item => {
    const content = marked.Parser.parseInline(item.tokens || [])
    return `<li>${content}</li>`
  }).join('')
  return `<${tag}>${itemsHtml}</${tag}>`
}

markdownRenderer.blockquote = ({ tokens }) => {
  const body = marked.Parser.parse(tokens || [])
  return `<blockquote>${body}</blockquote>`
}

markdownRenderer.image = ({ href, title, text }) => {
  const alt = text || ''
  const titleAttr = title ? ` title="${title}"` : ''
  return `<img src="${href}" alt="${alt}"${titleAttr} loading="lazy" />`
}

markdownRenderer.hr = () => `<hr />`

markdownRenderer.checkbox = ({ checked }) => {
  return `<input type="checkbox" ${checked ? 'checked' : ''} disabled />`
}

const loadPptPreview = async () => {
  pptError.value = ''
  pptLoading.value = true
  try {
    const lectureId = currentLecture.value.lectureId
    const response = await fetch(`/api/preview/lecture/${lectureId}/slides?debug=true`)
    const rawText = await response.text()
    let result = null

    try {
      result = JSON.parse(rawText)
    } catch (parseError) {
      throw new Error('服务返回异常，PPT预览暂时不可用')
    }

    if (!response.ok || result?.code !== 200) {
      throw new Error(result?.msg || 'PPT预览加载失败')
    }
    const slides = result?.data?.slides || []
    pptSlides.value = slides
    pptCurrentSlideIndex.value = 0
    outputPptDebugLog(lectureId, result?.data || {})
  } catch (error) {
    pptSlides.value = []
    pptError.value = error.message || 'PPT预览加载失败'
  } finally {
    pptLoading.value = false
  }
}

const outputPptDebugLog = (lectureId, data) => {
  try {
    const debug = data?.debug
    const debugError = data?.debugError
    const total = data?.total || 0
    const renderVersion = data?.renderVersion || 'unknown'

    console.groupCollapsed(
      `[PPT Preview Debug] lectureId=${lectureId}, totalSlides=${total}, renderVersion=${renderVersion}`
    )

    if (debugError) {
      console.warn('debug build status:', debugError)
    }

    if (!debug) {
      console.warn('No debug payload returned from backend.')
      console.groupEnd()
      return
    }

    const slides = Array.isArray(debug.slides) ? debug.slides : []
    const missingFonts = []
    for (const slide of slides) {
      const names = Array.isArray(slide?.missingFontsOnServer) ? slide.missingFontsOnServer : []
      for (const name of names) {
        if (!missingFonts.includes(name)) {
          missingFonts.push(name)
        }
      }
    }

    console.info('sourceFile:', debug.sourceFile)
    console.info('fallbackFont:', debug.fallbackFont)
    console.info('fallbackCanDisplayChinese:', debug.fallbackCanDisplayChinese)
    console.info('loadedExternalFonts:', debug.loadedExternalFonts || [])
    console.info('missingFontsOnServer(all slides):', missingFonts)
    console.info('slideDebugCount:', slides.length)
    console.table(
      slides.map((s) => ({
        index: s.index,
        textShapeCount: s.textShapeCount,
        runCount: s.runCount,
        textLength: s.textLength,
        missingFontCount: Array.isArray(s.missingFontsOnServer) ? s.missingFontsOnServer.length : 0,
      }))
    )
    console.debug('fullDebugPayload:', debug)
    console.groupEnd()
  } catch (e) {
    console.warn('[PPT Preview Debug] print failed:', e)
  }
}

const openPptPreviewWindow = () => {
  window.open(previewUrl.value, '_blank', 'noopener')
}

const prevPptSlide = () => {
  if (pptCurrentSlideIndex.value > 0) {
    pptCurrentSlideIndex.value--
  }
}

const nextPptSlide = () => {
  if (pptCurrentSlideIndex.value < pptSlides.value.length - 1) {
    pptCurrentSlideIndex.value++
  }
}

const selectPptSlide = (index) => {
  pptCurrentSlideIndex.value = index
}

const loadPdfPreview = async () => {
  if (!pdfContainerRef.value) return

  pdfLoading.value = true
  pdfError.value = ''

  try {
    const pdfUrl = `/api/preview/lecture/${currentLecture.value.lectureId}`

    const loadingTask = pdfjsLib.getDocument({
      url: pdfUrl,
      cMapUrl: 'https://cdn.jsdelivr.net/npm/pdfjs-dist@5.6.205/cmaps/',
      cMapPacked: true,
    })

    pdfDoc = await loadingTask.promise
    await renderPdfPage(1)
  } catch (error) {
    console.error('PDF加载失败:', error)
    pdfError.value = 'PDF加载失败: ' + (error.message || '请尝试下载后查看')
  } finally {
    pdfLoading.value = false
  }
}

const renderPdfPage = async (pageNum) => {
  if (!pdfDoc || !pdfContainerRef.value) return

  try {
    const page = await pdfDoc.getPage(pageNum)
    const scale = 1.5
    const viewport = page.getViewport({ scale })

    pdfContainerRef.value.innerHTML = ''

    const canvas = document.createElement('canvas')
    const context = canvas.getContext('2d')
    canvas.height = viewport.height
    canvas.width = viewport.width
    canvas.style.display = 'block'
    canvas.style.margin = '0 auto'
    pdfContainerRef.value.appendChild(canvas)

    await page.render({
      canvasContext: context,
      viewport: viewport
    }).promise

    const pageInfo = document.createElement('div')
    pageInfo.style.textAlign = 'center'
    pageInfo.style.marginTop = '10px'
    pageInfo.style.color = '#666'
    pageInfo.textContent = `第 ${pageNum} / ${pdfDoc.numPages} 页`
    pdfContainerRef.value.appendChild(pageInfo)

    if (pdfDoc.numPages > 1) {
      const btnContainer = document.createElement('div')
      btnContainer.style.textAlign = 'center'
      btnContainer.style.marginTop = '10px'

      const prevBtn = document.createElement('button')
      prevBtn.textContent = '上一页'
      prevBtn.disabled = pageNum <= 1
      prevBtn.style.marginRight = '10px'
      prevBtn.style.padding = '8px 16px'
      prevBtn.style.cursor = 'pointer'
      prevBtn.onclick = () => renderPdfPage(pageNum - 1)

      const nextBtn = document.createElement('button')
      nextBtn.textContent = '下一页'
      nextBtn.disabled = pageNum >= pdfDoc.numPages
      nextBtn.style.padding = '8px 16px'
      nextBtn.style.cursor = 'pointer'
      nextBtn.onclick = () => renderPdfPage(pageNum + 1)

      btnContainer.appendChild(prevBtn)
      btnContainer.appendChild(nextBtn)
      pdfContainerRef.value.appendChild(btnContainer)
    }
  } catch (error) {
    console.error('PDF页面渲染失败:', error)
    pdfError.value = 'PDF页面渲染失败'
  }
}

const loadWordPreview = async () => {
  docLoading.value = true
  docError.value = ''
  markdownHtmlContent.value = ''

  try {
    const wordUrl = `/api/preview/lecture/${currentLecture.value.lectureId}`
    const response = await fetch(wordUrl)
    if (!response.ok) {
      throw new Error('无法加载文档')
    }

    const arrayBuffer = await response.arrayBuffer()

    const result = await mammoth.convertToHtml(
      { arrayBuffer },
      {
        styleMap: [
          "p[style-name='Heading 1'] => h1:fresh",
          "p[style-name='Heading 2'] => h2:fresh",
          "p[style-name='Heading 3'] => h3:fresh",
          'b => strong',
          'i => em',
          'u => u'
        ]
      }
    )

    wordHtmlContent.value = result.value

    if (result.messages && result.messages.length > 0) {
      console.warn('Word转换警告:', result.messages)
    }
  } catch (error) {
    console.error('Word文档加载失败:', error)
    docError.value = '文档加载失败: ' + (error.message || '请尝试下载后查看')
  } finally {
    docLoading.value = false
  }
}

const loadMarkdownPreview = async () => {
  docLoading.value = true
  docError.value = ''
  wordHtmlContent.value = ''

  try {
    const markdownUrl = `/api/preview/lecture/${currentLecture.value.lectureId}`
    const response = await fetch(markdownUrl)
    if (!response.ok) {
      throw new Error('无法加载文档')
    }

    const markdownText = await response.text()
    markdownHtmlContent.value = marked.parse(markdownText, { renderer: markdownRenderer })
  } catch (error) {
    console.error('Markdown文档加载失败:', error)
    docError.value = '文档加载失败: ' + (error.message || '请尝试下载后查看')
  } finally {
    docLoading.value = false
  }
}

const loadHtmlPreview = async () => {
  htmlLoading.value = true
  htmlError.value = ''
  htmlSrcdoc.value = ''

  try {
    const htmlUrl = `/api/preview/lecture/${currentLecture.value.lectureId}`
    const response = await fetch(htmlUrl)
    if (!response.ok) {
      throw new Error('无法加载 HTML 文档')
    }
    htmlSrcdoc.value = await response.text()
  } catch (error) {
    console.error('HTML文档加载失败:', error)
    htmlError.value = 'HTML加载失败: ' + (error.message || '请尝试下载后查看')
  } finally {
    htmlLoading.value = false
  }
}

const buildSpreadsheetTable = (sheetName) => {
  if (!spreadsheetWorkbook || !spreadsheetWorkbook.Sheets?.[sheetName]) {
    sheetColumns.value = []
    sheetRows.value = []
    return
  }

  const matrix = XLSX.utils.sheet_to_json(spreadsheetWorkbook.Sheets[sheetName], {
    header: 1,
    defval: ''
  })

  const maxColumns = matrix.reduce((max, row) => Math.max(max, Array.isArray(row) ? row.length : 0), 0)
  if (maxColumns === 0) {
    sheetColumns.value = []
    sheetRows.value = []
    return
  }

  const headerRow = Array.isArray(matrix[0]) ? matrix[0] : []
  const columns = []
  for (let i = 0; i < maxColumns; i++) {
    const key = `col_${i}`
    const name = String(headerRow[i] || '').trim()
    columns.push({
      key,
      label: name || `列${i + 1}`
    })
  }

  const rows = matrix.slice(1).map((row, rowIndex) => {
    const item = {
      _rowKey: `${sheetName}_${rowIndex}`,
      _rowNo: rowIndex + 1
    }
    columns.forEach((col, colIndex) => {
      item[col.key] = Array.isArray(row) ? row[colIndex] : ''
    })
    return item
  })

  sheetColumns.value = columns
  sheetRows.value = rows
}

const selectSpreadsheetSheet = (sheetName) => {
  if (!sheetName) return
  activeSheetName.value = sheetName
  buildSpreadsheetTable(sheetName)
}

const loadSpreadsheetPreview = async () => {
  sheetLoading.value = true
  sheetError.value = ''
  sheetNames.value = []
  activeSheetName.value = ''
  sheetColumns.value = []
  sheetRows.value = []
  spreadsheetWorkbook = null

  try {
    const sheetUrl = `/api/preview/lecture/${currentLecture.value.lectureId}`
    const response = await fetch(sheetUrl)
    if (!response.ok) {
      throw new Error('无法加载表格文件')
    }

    const arrayBuffer = await response.arrayBuffer()
    spreadsheetWorkbook = XLSX.read(arrayBuffer, {
      type: 'array',
      cellDates: true
    })

    const names = Array.isArray(spreadsheetWorkbook.SheetNames) ? spreadsheetWorkbook.SheetNames : []
    if (!names.length) {
      throw new Error('表格为空，暂无可预览内容')
    }

    sheetNames.value = names
    selectSpreadsheetSheet(names[0])
  } catch (error) {
    console.error('表格文档加载失败:', error)
    sheetError.value = '表格加载失败: ' + (error.message || '请尝试下载后查看')
  } finally {
    sheetLoading.value = false
  }
}

const downloadLecture = async (row) => {
  try {
    ElMessage.info('正在准备下载...')
    window.open(`/api/teacher/lecture/download/${row.lectureId}`, '_blank')
  } catch (error) {
    ElMessage.error('下载失败')
  }
}

watch(dialogVisible, async (newVal) => {
  if (newVal && currentLecture.value?.filePath) {
    await nextTick()
    loadFilePreview()
  }
})

watch([filterType, filterCategory], () => {
  currentPage.value = 1
})

onUnmounted(() => {
  if (pdfDoc) {
    pdfDoc.destroy()
    pdfDoc = null
  }
})
</script>

<style lang="scss" scoped>
@import 'highlight.js/styles/github.css';

.lecture-page {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
}

.lecture-layout {
  display: flex;
  gap: 24px;
  align-items: flex-start;
}

/* ===== 左侧固定导航栏 ===== */
.lecture-sidebar {
  width: 240px;
  flex-shrink: 0;
  background: #ffffff;
  border: 1px solid #e6e9ed;
  border-radius: 10px;
  overflow: hidden;
  position: sticky;
  top: 8px;
  align-self: flex-start;
  max-height: calc(100vh - 16px);
  overflow-y: auto;
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);

  .sidebar-header {
    padding: 16px 16px 12px;
    border-bottom: 1px solid #f0f2f5;
    h3 {
      margin: 0;
      font-size: 15px;
      font-weight: 600;
      color: #1a2332;
      .el-icon { margin-right: 4px; color: #4caf50; }
    }
  }

  .sidebar-body { padding: 8px 0; }

  .sidebar-section-label {
    padding: 10px 16px 4px;
    font-size: 11px;
    font-weight: 600;
    color: #8c959f;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }

  .sidebar-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 9px 16px;
    cursor: pointer;
    transition: all 0.15s ease;
    border-left: 3px solid transparent;
    margin: 1px 0;

    .item-label { font-size: 13.5px; color: #3d4c5e; font-weight: 500; }
    .item-count {
      font-size: 11px; color: #8c959f; background: #f2f4f7;
      padding: 0 7px; border-radius: 10px; line-height: 18px;
      min-width: 18px; text-align: center;
    }

    &:hover { background: #f5f7fa; .item-label { color: #1a2332; } }

    &.active {
      background: #e8f5e9; border-left-color: #4caf50;
      .item-label { color: #2e7d32; font-weight: 600; }
      .item-count { background: #4caf50; color: #fff; }
    }
  }

  .sidebar-divider { height: 1px; background: #f0f2f5; margin: 6px 12px; }
  .sidebar-empty { padding: 16px; text-align: center; color: #b0b8c4; font-size: 13px; }
}

/* ===== 右侧滚动主内容 ===== */
.lecture-main {
  flex: 1;
  min-width: 0;
}

.main-header {
  margin-bottom: 20px;
  h2 { margin: 0; font-size: 20px; font-weight: 600; color: #1a2332; }
  .header-count { margin: 2px 0 0; font-size: 13px; color: #8c959f; }
}

.lecture-list {
  min-height: 200px;
}

.lecture-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 16px;
}

.lecture-card {
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
    align-items: flex-start;
    gap: 14px;
    padding: 16px 20px;
  }

  .lecture-icon {
    width: 44px;
    height: 44px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #e6f4ea;
    border-radius: 8px;
    flex-shrink: 0;

    .el-icon { font-size: 22px; color: #4caf50; }
  }

  .lecture-info {
    flex: 1;
    min-width: 0;
  }

  .lecture-name {
    font-size: 15px;
    font-weight: 600;
    color: #24292e;
    margin-bottom: 8px;
    line-height: 1.4;
  }

  .lecture-meta {
    display: flex;
    align-items: center;
    gap: 8px;
    .file-type { font-size: 12px; color: #8c959f; }
  }

  .card-footer {
    padding: 12px 20px;
    border-top: 1px solid #eaecef;
    display: flex;
    gap: 10px;
  }
}

.pagination-wrapper {
  margin-top: 24px;
  display: flex;
  justify-content: center;
}

/* ===== 预览对话框 ===== */
.lecture-content {
  padding: 20px;
  line-height: 1.7;
  color: #303133;
}

:deep(.lecture-dialog) {
  .el-dialog {
    box-shadow: 0 25px 60px rgba(0, 0, 0, 0.25);
    border-radius: 12px;
  }
  .el-dialog__header {
    border-bottom: 1px solid #eaecef;
    padding: 16px 20px;
    margin-right: 0;
  }
  .el-dialog__body { padding: 0; }
  .el-overlay { background: rgba(0, 0, 0, 0.5); }
}

.file-preview { width: 100%; min-height: 400px; }

.pdf-container {
  width: 100%;
  min-height: 60vh;
  background: #f6f8fa;
  border-radius: 6px;
  padding: 20px;
  .pdf-viewer {
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
    background: white;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
    border-radius: 6px;
    overflow: hidden;
    canvas { max-width: 100%; height: auto !important; }
  }
}

.word-container {
  width: 100%;
  min-height: 60vh;
  background: white;
  border-radius: 6px;
  padding: 32px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  .word-content {
    max-width: 800px;
    margin: 0 auto;
    line-height: 1.7;
    :deep(h1) { font-size: 22px; font-weight: bold; margin: 18px 0 10px; color: #24292e; }
    :deep(h2) { font-size: 18px; font-weight: bold; margin: 16px 0 8px; color: #24292e; }
    :deep(h3) { font-size: 16px; font-weight: bold; margin: 14px 0 8px; color: #24292e; }
    :deep(p) { margin: 10px 0; }
    :deep(table) { border-collapse: collapse; width: 100%; margin: 15px 0;
      th, td { border: 1px solid #e1e4e8; padding: 8px; text-align: left; }
      th { background: #f6f8fa; font-weight: bold; }
    }
    :deep(img) { max-width: 100%; height: auto; margin: 10px 0; }
    :deep(ul), :deep(ol) { margin: 10px 0 10px 32px; }
    :deep(li) { margin: 5px 0; }
  }
}

.markdown-container {
  width: 100%;
  min-height: 60vh;
  max-height: calc(90vh - 140px);
  overflow-y: auto;
  background: #ffffff;
  border-radius: 6px;
  padding: 32px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  .markdown-content {
    max-width: 860px;
    margin: 0 auto;
    line-height: 1.75;
    color: #24292f;
    overflow-wrap: break-word;

    :deep(h1), :deep(h2), :deep(h3), :deep(h4), :deep(h5), :deep(h6) {
      margin: 24px 0 14px;
      line-height: 1.35;
      font-weight: 600;
      color: #1f2328;
    }
    :deep(h1) { font-size: 28px; border-bottom: 2px solid #d0d7de; padding-bottom: 12px; margin-top: 32px; }
    :deep(h2) { font-size: 22px; border-bottom: 1px solid #d8dee4; padding-bottom: 10px; margin-top: 28px; }
    :deep(h3) { font-size: 18px; margin-top: 24px; }
    :deep(h4) { font-size: 16px; }
    :deep(h5) { font-size: 14px; }
    :deep(h6) { font-size: 13px; color: #636c76; }

    :deep(p) { margin: 14px 0; }

    :deep(ul), :deep(ol) { margin: 12px 0 12px 28px; padding: 0; }
    :deep(li) { margin: 5px 0; }
    :deep(li > ul), :deep(li > ol) { margin: 4px 0 4px 20px; }

    :deep(blockquote) {
      margin: 16px 0;
      padding: 12px 18px;
      border-left: 4px solid #8ab4f8;
      background: linear-gradient(135deg, #f0f7ff 0%, #f4f8ff 100%);
      color: #3d4c63;
      border-radius: 0 8px 8px 0;
      :deep(p) { margin: 4px 0; }
    }

    :deep(.code-block-wrapper) {
      margin: 16px 0;
      border-radius: 10px;
      overflow: hidden;
      border: 1px solid #1e293b;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
      .code-block-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 8px 14px;
        background: #1e293b;
        border-bottom: 1px solid #334155;
        .code-lang-label {
          font-size: 12px;
          font-weight: 600;
          color: #94a3b8;
          text-transform: uppercase;
          letter-spacing: 0.5px;
        }
        .code-copy-btn {
          padding: 4px 12px;
          font-size: 12px;
          font-weight: 500;
          color: #94a3b8;
          background: rgba(255, 255, 255, 0.08);
          border: 1px solid rgba(255, 255, 255, 0.12);
          border-radius: 6px;
          cursor: pointer;
          transition: all 0.2s ease;
          &:hover {
            color: #e2e8f0;
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.2);
          }
        }
      }
      pre {
        margin: 0 !important;
        padding: 16px !important;
        background: #0f172a !important;
        border-radius: 0 !important;
        overflow-x: auto;
        code {
          font-family: 'JetBrains Mono', 'Fira Code', 'Consolas', 'Monaco', 'Courier New', monospace;
          color: #e2e8f0;
          font-size: 13px;
          line-height: 1.6;
          background: none !important;
          padding: 0 !important;
        }
      }
    }

    :deep(pre) {
      margin: 16px 0;
      padding: 0;
      background: transparent;
      border-radius: 0;
      overflow: visible;
    }

    :deep(code) {
      font-family: 'JetBrains Mono', 'Fira Code', 'Consolas', 'Monaco', 'Courier New', monospace;
    }

    :deep(:not(pre) > code) {
      background: #f1f3f5;
      padding: 2px 6px;
      border-radius: 5px;
      color: #b42318;
      font-size: 13px;
      font-weight: 500;
      border: 1px solid #e8e8e8;
    }

    :deep(.table-wrapper) {
      margin: 16px 0;
      border-radius: 10px;
      border: 1px solid #d0d7de;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
      .table-header-bar {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 8px 14px;
        background: #f6f8fa;
        border-bottom: 1px solid #d0d7de;
        .table-label {
          font-size: 12px;
          font-weight: 600;
          color: #636c76;
          text-transform: uppercase;
          letter-spacing: 0.5px;
        }
        .table-copy-btn {
          padding: 4px 12px;
          font-size: 12px;
          font-weight: 500;
          color: #636c76;
          background: #ffffff;
          border: 1px solid #d0d7de;
          border-radius: 6px;
          cursor: pointer;
          transition: all 0.2s ease;
          &:hover {
            color: #0969da;
            border-color: #0969da;
            background: #f0f7ff;
          }
        }
      }
      .table-scroll {
        overflow-x: auto;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin: 0;
        font-size: 14px;
        thead {
          tr { background: #f6f8fa; }
          th {
            padding: 10px 14px;
            text-align: left;
            font-weight: 600;
            color: #24292f;
            border-bottom: 2px solid #d0d7de;
            white-space: nowrap;
          }
        }
        tbody {
          tr {
            transition: background 0.15s ease;
            &:nth-child(even) { background: #f9fafb; }
            &:hover { background: #f0f7ff; }
          }
          td {
            padding: 10px 14px;
            border-bottom: 1px solid #eaecef;
            color: #3d4c5e;
            vertical-align: top;
          }
        }
      }
    }

    :deep(table) {
      width: 100%;
      border-collapse: collapse;
      margin: 16px 0;
      border: 1px solid #d0d7de;
    }
    :deep(th), :deep(td) {
      border: 1px solid #d0d7de;
      padding: 8px 10px;
      text-align: left;
      vertical-align: top;
    }
    :deep(th) {
      background: #f6f8fa;
      font-weight: 600;
    }

    :deep(a) { color: #0969da; text-decoration: none; }
    :deep(a:hover) { text-decoration: underline; }

    :deep(img) {
      max-width: 100%;
      border-radius: 8px;
      margin: 14px 0;
      box-shadow: 0 2px 8px rgba(15, 23, 42, 0.12);
    }

    :deep(hr) {
      border: 0;
      border-top: 2px solid #d0d7de;
      margin: 24px 0;
    }

    :deep(input[type="checkbox"]) {
      margin-right: 6px;
      transform: scale(1.1);
    }

    :deep(strong) { font-weight: 600; color: #1f2328; }
    :deep(em) { font-style: italic; }
    :deep(del) { text-decoration: line-through; color: #636c76; }
  }
}

.html-container {
  width: 100%;
  min-height: 72vh;
  border: 1px solid #dce3ec;
  border-radius: 8px;
  overflow: hidden;
  background: #ffffff;
  .html-preview-frame {
    display: block;
    width: 100%;
    min-height: 72vh;
    border: 0;
    background: #ffffff;
  }
}

.sheet-container {
  min-height: 68vh;
  border-radius: 12px;
  padding: 14px;
  background: linear-gradient(145deg, #f7fbff 0%, #f7fff9 60%, #ffffff 100%);
  border: 1px solid #d8e8df;
  .sheet-toolbar { display: flex; justify-content: space-between; align-items: center; gap: 12px; margin-bottom: 12px; padding: 10px 12px; border-radius: 10px; border: 1px solid #dbe8f2; background: rgba(255,255,255,0.9); }
  .sheet-toolbar-left { display: flex; align-items: center; gap: 10px; }
  .sheet-toolbar-right { display: flex; align-items: center; gap: 8px; }
  .sheet-tip { color: #445169; font-size: 13px; }
  .sheet-table-wrap { border: 1px solid #dfe7ee; border-radius: 10px; overflow: hidden; background: #fff; }
  .sheet-loading-block { min-height: 45vh; border-radius: 10px; border: 1px dashed #c8d9ff; background: rgba(255,255,255,0.78); }
}

.ppt-container {
  min-height: 68vh;
  border-radius: 14px;
  padding: 16px;
  background: linear-gradient(145deg, #eef5ff 0%, #f5fff8 55%, #ffffff 100%);
  border: 1px solid #dce8ff;
  .ppt-toolbar { display: flex; justify-content: space-between; align-items: center; gap: 12px; margin-bottom: 14px; padding: 10px 12px; border-radius: 10px; background: rgba(255,255,255,0.88); border: 1px solid rgba(132,161,255,0.28); }
  .ppt-toolbar-left { display: flex; align-items: center; gap: 10px; }
  .ppt-tip { color: #445169; font-size: 13px; }
  .ppt-toolbar-actions { display: flex; gap: 8px; }
  .ppt-viewer-wrap { display: flex; flex-direction: column; gap: 14px; }
  .ppt-main { border-radius: 10px; overflow: hidden; background: #ffffff; border: 1px solid #e6ebf7; box-shadow: inset 0 0 0 1px rgba(220,232,255,0.4); }
  .ppt-slide-image { width: 100%; display: block; }
  .ppt-pagination { display: flex; align-items: center; justify-content: center; gap: 14px;
    .ppt-page-indicator { color: #33445d; font-size: 13px; min-width: 70px; text-align: center; }
  }
  .ppt-thumbs { display: grid; grid-template-columns: repeat(auto-fill, minmax(92px, 1fr)); gap: 10px; max-height: 170px; overflow-y: auto; padding-right: 4px; }
  .ppt-thumb { border: 1px solid #d9e4fb; border-radius: 8px; background: #fff; padding: 6px; cursor: pointer; display: flex; flex-direction: column; align-items: center; gap: 4px;
    img { width: 100%; height: 52px; object-fit: cover; border-radius: 4px; border: 1px solid #eef3ff; }
    span { font-size: 12px; color: #52607a; line-height: 1; }
    &.active { border-color: #4c7cf8; box-shadow: 0 0 0 2px rgba(76,124,248,0.16); }
  }
  .ppt-error-actions { display: flex; gap: 8px; }
  .ppt-loading-block { min-height: 45vh; border-radius: 10px; border: 1px dashed #c8d9ff; background: rgba(255,255,255,0.78); }
}

.image-preview { display: flex; justify-content: center; align-items: center; padding: 20px; background: #f6f8fa; border-radius: 6px; }

.preview-loading { display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 300px; color: #586069; span { margin-top: 10px; } }
.preview-error { display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 300px; color: #cb2431; p { margin: 10px 0 20px; } }

.unsupported-preview { display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 300px; padding: 32px; background: #f6f8fa; border-radius: 6px;
  h3 { margin: 16px 0 8px; color: #24292e; }
  p { margin-bottom: 16px; color: #586069; }
}

.list-enter-active, .list-leave-active { transition: all 0.3s ease; }
.list-enter-from, .list-leave-to { opacity: 0; transform: translateY(20px); }

@media (max-width: 768px) {
  .lecture-layout { flex-direction: column; }
  .lecture-sidebar { width: 100%; position: static; max-height: none; }
  .lecture-grid { grid-template-columns: 1fr; }
}
</style>
