<template>
  <div class="rag-chat-wrapper">
    <div class="rag-chat-container">
    <div class="sidebar">
      <div class="sidebar-brand">
        <div>
          <span class="brand-title">Labex</span>
          <span class="brand-subtitle">知识问答</span>
        </div>
      </div>

      <nav class="sidebar-nav" aria-label="知识问答导航">
        <button type="button" class="sidebar-nav-item active" @click="createSession">
          <el-icon><Edit /></el-icon>
          <span>新聊天</span>
        </button>
      </nav>

      <div class="sidebar-section-title">最近</div>
      <div class="session-list">
        <div
          v-for="sess in sessions"
          :key="sess.sessionId"
          :class="['session-item', { active: currentSessionId === sess.sessionId }]"
          @click="switchSession(sess.sessionId)"
        >
          <div class="session-info">
            <span class="session-title">{{ sess.title || '新会话' }}</span>
            <span class="session-time">{{ formatTime(sess.lastActiveTime) }}</span>
          </div>
          <div class="session-actions">
            <el-button
              type="primary"
              size="small"
              text
              @click.stop="renameSession(sess)"
              class="rename-btn"
            >
              <el-icon><EditPen /></el-icon>
            </el-button>
            <el-button
              type="danger"
              size="small"
              text
              @click.stop="deleteSession(sess.sessionId)"
              class="delete-btn"
            >
              <el-icon><Delete /></el-icon>
            </el-button>
          </div>
        </div>
        <div v-if="sessions.length === 0" class="no-sessions">
          暂无会话
        </div>
      </div>
    </div>

    <!-- 右侧聊天区 -->
    <div class="chat-area">
      <el-card class="chat-card">
        <template #header>
          <div class="card-header">
            <span class="title">{{ currentSessionTitle }}</span>
            <div class="header-actions">
              <span class="turn-counter" :class="{ full: sessionFull }">
                {{ Math.ceil(messages.length / 2) }} / {{ MAX_TURNS }} 次对话
              </span>
              <el-button type="primary" link @click="clearHistory">
                <el-icon><Delete /></el-icon> 清空
              </el-button>
            </div>
          </div>
        </template>

        <div class="chat-messages" ref="messagesContainer" @scroll="handleMessagesScroll">
          <!-- 调试信息 -->
          <div style="display:none">{{ messages.length }}</div>

          <div v-if="messages.length === 0" class="empty-chat">
            <div class="empty-center">
              <h1>今天想学习什么？</h1>
              <div class="empty-suggestions">
                <button
                  v-for="item in quickSuggestions"
                  :key="item.text"
                  type="button"
                  @click="applyQuickSuggestion(item)"
                >
                  <el-icon><component :is="item.icon" /></el-icon>
                  <span>{{ item.text }}</span>
                </button>
              </div>
            </div>
          </div>

          <div v-for="(msg, index) in messages" :key="index" :class="['message', msg.role]">
            <div class="message-avatar">
              <el-avatar v-if="msg.role === 'user'" :size="36">
                <img :src="userAvatarUrl" @error.once="userAvatarError = true" v-if="!userAvatarError" />
                <el-icon v-else :size="20"><UserFilled /></el-icon>
              </el-avatar>
              <el-avatar v-else :size="36">
                <img :src="assistantAvatarUrl" @error.once="assistantAvatarError = true" v-if="!assistantAvatarError" />
                <el-icon v-else :size="20"><Service /></el-icon>
              </el-avatar>
            </div>
            <div class="message-content">
              <div class="message-bubble">
                <!-- 思考过程面板：显示模型的真实思考内容 -->
                <details v-if="msg.thinkingTrace" class="thinking-panel" :open="msg.streaming">
                  <summary class="thinking-summary">
                    <span class="summary-left">
                      <el-icon :class="{ 'thinking-icon-pulse': msg.streaming }"><Opportunity /></el-icon>
                      <span>思考过程</span>
                      <span v-if="msg.streaming" class="thinking-live-dots">
                        <span class="thinking-live-dot"></span>
                        <span class="thinking-live-dot"></span>
                        <span class="thinking-live-dot"></span>
                      </span>
                    </span>
                    <el-icon class="summary-arrow"><ArrowRight /></el-icon>
                  </summary>
                  <div class="thinking-raw-content">
                    {{ msg.thinkingTrace }}<span v-if="msg.streaming" class="streaming-cursor"></span>
                  </div>
                </details>

                <!-- 思考阶段加载指示器：流式传输中但尚无任何可见内容时显示 -->
                <div v-if="msg.streaming && !msg.content && !(msg.thinkingTrace && getThinkingSections(msg.thinkingTrace).length > 0)" class="thinking-loading">
                  <span class="thinking-loading-dot"></span>
                  <span class="thinking-loading-dot"></span>
                  <span class="thinking-loading-dot"></span>
                  <span class="thinking-loading-text">正在思考</span>
                </div>

                <div
                  v-if="msg.content"
                  :class="['message-text', { 'streaming-text': msg.streaming }]"
                  v-html="msg.streaming ? formatStreamingMessage(msg.content) : formatMessage(msg.content)"
                ></div>

                <div v-if="getMessageAttachments(msg).length > 0" class="message-attachments">
                  <button
                    v-for="(attachment, aIdx) in getMessageAttachments(msg)"
                    :key="aIdx"
                    type="button"
                    class="message-attachment"
                    @click="previewImageAttachment(attachment)"
                  >
                    <img :src="attachment.url" :alt="attachment.name || '图片附件'" />
                  </button>
                </div>

                <details v-if="getMessageSources(msg).length > 0" class="references-panel">
                  <summary class="references-summary">
                    <span class="summary-left">
                      <el-icon><Document /></el-icon>
                      {{ buildReferencesSummary(msg) }}
                    </span>
                    <el-icon class="summary-arrow"><ArrowRight /></el-icon>
                  </summary>
                  <div v-if="formatSearchKeywords(msg)" class="references-keywords">
                    {{ formatSearchKeywords(msg) }}
                  </div>
                  <ol class="reference-list">
                    <li
                      v-for="(source, sIdx) in getMessageSources(msg)"
                      :key="sIdx"
                      :class="['reference-item', getReferenceClass(source)]"
                    >
                      <a
                        v-if="source.type === 'web'"
                        class="reference-link"
                        :href="source.url"
                        target="_blank"
                        rel="noopener noreferrer"
                      >
                        {{ sIdx + 1 }}. {{ source.title || source.url || '网页资料' }}
                      </a>
                      <span v-else-if="source.type === 'image'" class="reference-link reference-static">
                        {{ sIdx + 1 }}. {{ source.title || source.name || '图片理解结果' }}
                      </span>
                      <button v-else class="reference-link reference-button" type="button" @click="previewLectureFn(source)">
                        {{ sIdx + 1 }}. {{ source.lectureName || source.title || '知识库资料' }}
                      </button>
                      <p class="reference-snippet">{{ getSourceSnippet(source) }}</p>
                      <div class="reference-meta">
                        <span>{{ getReferenceTypeLabel(source) }}</span>
                        <span v-if="source.score">相关度 {{ (source.score * 100).toFixed(0) }}%</span>
                        <span v-if="source.type === 'knowledge' || (!source.type && source.lectureId)">点击预览</span>
                        <span v-if="source.type === 'web'">点击访问</span>
                        <span v-if="source.type === 'web' && source.contentFetched">已读正文</span>
                        <span v-if="source.type === 'image'">{{ source.success === false ? '识别失败' : '工具读取' }}</span>
                      </div>
                    </li>
                  </ol>
                </details>
                <div v-if="false && msg.sources && msg.sources.length > 0" class="sources legacy-sources">
                  <div class="sources-title">
                    <el-icon><Document /></el-icon>
                    参考资料 ({{ msg.sources.length }})
                  </div>
                  <div
                    v-for="(source, sIdx) in msg.sources"
                    :key="sIdx"
                    class="source-item"
                    @click="previewLectureFn(source)"
                  >
                    <div class="source-icon">
                      <el-icon><Document /></el-icon>
                    </div>
                    <div class="source-info">
                      <div class="source-name">{{ source.lectureName || '未知讲义' }}</div>
                      <div class="source-excerpt">{{ source.text ? source.text.substring(0, 80) : '' }}...</div>
                      <div class="source-meta">
                        <span v-if="source.score" class="source-score">
                          相关度: {{ (source.score * 100).toFixed(0) }}%
                        </span>
                        <span class="source-action">点击预览</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="message-footer">
                <span class="message-time">{{ formatTime(msg.timestamp) }}</span>
                <div class="message-actions">
                  <span v-if="msg.role === 'assistant'" class="ai-source-badge">{{ getModeBadge(msg) }}</span>
                  <button class="action-btn" @click="copyMessage(msg.content)" title="复制内容">
                    <el-icon><CopyDocument /></el-icon>
                  </button>
                </div>
              </div>
            </div>
          </div>

          <div v-if="loading && !hasAssistantMessage" class="message assistant">
            <div class="message-avatar">
              <el-avatar :size="36">
                <img :src="assistantAvatarUrl" @error.once="assistantAvatarError = true" v-if="!assistantAvatarError" />
                <el-icon v-else :size="20"><Service /></el-icon>
              </el-avatar>
            </div>
            <div class="message-content">
              <div class="message-bubble loading">
                <span class="loading-dot"></span>
                <span class="loading-dot"></span>
                <span class="loading-dot"></span>
              </div>
            </div>
          </div>
        </div>

        <div class="chat-input-area" @paste="handlePaste">
          <div class="composer-card">
            <div v-if="pendingAttachments.length > 0" class="pending-attachments">
              <div
                v-for="(attachment, index) in pendingAttachments"
                :key="attachment.id"
                class="pending-attachment"
              >
                <img :src="attachment.url" :alt="attachment.name" />
                <button type="button" class="remove-attachment" @click="removeAttachment(index)">
                  <el-icon><Close /></el-icon>
                </button>
              </div>
            </div>

            <el-input
              v-model="question"
              type="textarea"
              :autosize="{ minRows: 2, maxRows: 7 }"
              :placeholder="sessionFull ? '此会话已达对话上限，请新建会话' : '问问 Labex，搜索网页或课程资料'"
              @keydown.enter.exact.prevent="sendMessage"
              :disabled="loading || sessionFull"
            />

            <div class="composer-bottom">
              <div class="composer-tools">
                <button type="button" class="composer-icon-btn" title="上传图片" @click="openImagePicker" :disabled="loading || sessionFull">
                  <el-icon><Plus /></el-icon>
                </button>
                <input ref="imageInputRef" class="hidden-file-input" type="file" accept="image/*" multiple @change="handleImageInput" />
                <el-radio-group v-model="retrievalMode" size="small" :disabled="loading || sessionFull" class="retrieval-mode-group">
                  <el-radio-button value="web">
                    <el-icon><Search /></el-icon>
                    联网搜索
                  </el-radio-button>
                  <el-radio-button value="knowledge">
                    <el-icon><Document /></el-icon>
                    知识库
                  </el-radio-button>
                  <el-radio-button value="hybrid">
                    <el-icon><Connection /></el-icon>
                    混合
                  </el-radio-button>
                </el-radio-group>
                <div class="thinking-mode" :class="{ disabled: loading || sessionFull }">
                  <button type="button" :class="{ active: !deepThinking }" :disabled="loading || sessionFull" @click="deepThinking = false">快速</button>
                  <button type="button" :class="{ active: deepThinking }" :disabled="loading || sessionFull" @click="deepThinking = true">深度思考</button>
                </div>
              </div>
              <button type="button" class="send-button" :class="{ loading }" @click="sendMessage" :disabled="!canSend || sessionFull || loading" title="发送">
                <el-icon v-if="!loading"><Promotion /></el-icon>
                <span v-else class="send-loader"></span>
              </button>
            </div>
          </div>
          <span class="hint">{{ sessionFull ? '已达对话上限，请新建会话' : 'Labex 可能会出错，请核对关键资料。Enter 发送，Shift+Enter 换行' }}</span>
        </div>
      </el-card>
    </div>
  </div>
  <!-- 讲义预览弹窗 -->
  <el-dialog v-model="previewVisible" title="讲义预览" width="80%" class="preview-dialog" destroy-on-close>
    <div v-loading="previewLoading" class="preview-content">
      <div v-if="previewError" class="preview-error-state">
        <el-icon size="48" color="#f56c6c"><CircleCloseFilled /></el-icon>
        <p>{{ previewError }}</p>
        <el-button type="primary" @click="openFullLecture">前往讲义页查看</el-button>
      </div>

      <div v-else-if="previewLecture">
        <div class="preview-meta">
          <el-tag v-if="previewLecture.lectureType" type="primary" size="small" effect="plain">
            {{ previewLecture.lectureType === 1 ? '课件' : previewLecture.lectureType === 2 ? '参考' : '其他' }}
          </el-tag>
          <el-tag v-if="previewLecture.lectureFiletype" size="small" effect="plain">
            {{ previewLecture.lectureFiletype.toUpperCase() }}
          </el-tag>
        </div>

        <div v-if="previewLecture.lectureContent" class="preview-html" v-html="previewLecture.lectureContent"></div>

        <!-- Markdown 文件 -->
        <div v-else-if="isMarkdownFile" class="markdown-preview">
          <div v-if="markdownLoading" class="preview-status">
            <span class="preview-status-text">正在加载 Markdown 文档...</span>
          </div>
          <div v-else-if="markdownError" class="preview-status">
            <el-icon size="32" color="#f56c6c"><CircleCloseFilled /></el-icon>
            <p>{{ markdownError }}</p>
            <el-button type="primary" link @click="openFullLecture">在新窗口打开查看</el-button>
          </div>
          <div v-else class="markdown-content" v-html="markdownContent"></div>
        </div>

        <!-- PPT 文件 -->
        <div v-else-if="isPptFile" class="ppt-preview">
          <div v-if="pptLoading" class="preview-status">
            <span class="preview-status-text">正在渲染 PPT 幻灯片...</span>
          </div>
          <div v-else-if="pptError" class="preview-status">
            <el-icon size="32" color="#f56c6c"><CircleCloseFilled /></el-icon>
            <p>{{ pptError }}</p>
            <el-button type="primary" link @click="openFullLecture">在新窗口打开查看</el-button>
          </div>
          <div v-else-if="pptSlides.length" class="ppt-viewer">
            <div class="ppt-slide-main">
              <img :src="pptSlides[pptCurrentSlideIndex]?.url" :alt="`幻灯片 ${pptCurrentSlideIndex + 1}`" class="ppt-slide-image" />
            </div>
            <div class="ppt-pagination">
              <el-button size="small" :disabled="pptCurrentSlideIndex <= 0" @click="prevPptSlide">上一页</el-button>
              <span class="ppt-page-indicator">{{ pptCurrentSlideIndex + 1 }} / {{ pptSlides.length }}</span>
              <el-button size="small" :disabled="pptCurrentSlideIndex >= pptSlides.length - 1" @click="nextPptSlide">下一页</el-button>
            </div>
          </div>
          <div v-else class="preview-status">
            <p>PPT 暂无可预览页面</p>
            <el-button type="primary" link @click="openFullLecture">在新窗口打开查看</el-button>
          </div>
        </div>

        <!-- PDF/图片/HTML → iframe 直接显示 -->
        <div v-else-if="previewLecture.filePath" class="file-preview-frame">
          <iframe :src="previewFileUrl" class="preview-iframe" frameborder="0"></iframe>
          <div class="preview-iframe-footer">
            <span class="hint">如果内容无法正常显示，</span>
            <el-button type="primary" link @click="openFullLecture">在新窗口打开查看</el-button>
          </div>
        </div>

        <el-empty v-else description="暂无内容" />
      </div>
    </div>
  </el-dialog>
  <el-dialog v-model="imagePreviewVisible" title="图片预览" width="70%" class="image-preview-dialog" destroy-on-close>
    <div v-if="imagePreview" class="image-preview-content">
      <img :src="imagePreview.url" :alt="imagePreview.name || '图片附件'" />
      <div class="image-preview-name">{{ imagePreview.name || '图片附件' }}</div>
    </div>
  </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick, computed } from 'vue'
import { marked } from 'marked'
import hljs from 'highlight.js'
import { ElMessage, ElMessageBox } from 'element-plus'
import {
  Connection,
  CopyDocument,
  Delete,
  Document,
  Edit,
  EditPen,
  Opportunity,
  Plus,
  Promotion,
  Search,
  Service,
  UserFilled,
  ArrowRight,
  CircleCloseFilled,
  Close
} from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'
import { ragApi } from '@/api'

// Custom renderer for code blocks with language label and copy button
const renderer = new marked.Renderer()

renderer.code = ({ text, lang }) => {
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
      <span class="code-lang-tag">${language}</span>
      <button class="code-copy-btn" type="button"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg> 复制</button>
    </div>
    <pre><code class="${langClass}">${highlighted}</code></pre>
  </div>`
}

renderer.table = (token) => {
  const headerHtml = token.header.map(cell => {
    const align = cell.align ? ` align="${cell.align}"` : ""
    return `<th${align}>${marked.parseInline(cell.text)}</th>`
  }).join("")

  const bodyHtml = token.rows.map(row => {
    return '<tr>' + row.map(cell => {
      const align = cell.align ? ` align="${cell.align}"` : ""
      return `<td${align}>${marked.parseInline(cell.text)}</td>`
    }).join("") + '</tr>'
  }).join("")

  return `<div class="table-wrapper">
    <div class="table-header">
      <span class="table-type-tag">表格</span>
    </div>
    <div class="table-scroll">
      <table><thead><tr>${headerHtml}</tr></thead><tbody>${bodyHtml}</tbody></table>
    </div>
  </div>`
}

renderer.link = ({ href, title, tokens }) => {
  const safeHref = href || '#'
  const titleAttr = title ? ` title="${title}"` : ''
  return `<a href="${safeHref}"${titleAttr} target="_blank" rel="noopener noreferrer">${marked.Parser.parseInline(tokens || [])}</a>`
}

renderer.del = ({ tokens, text }) => {
  const inner = tokens ? marked.Parser.parseInline(tokens) : marked.parseInline(text || '')
  return `<span class="md-no-strike">${inner}</span>`
}

marked.setOptions({
  gfm: true,
  breaks: true
})

const userStore = useUserStore()

const baseUrl = import.meta.env.VITE_API_BASE_URL || ''
const userAvatarError = ref(false)
const assistantAvatarError = ref(false)

const userAvatarUrl = computed(() => {
  const avatar = userStore.userInfo?.avatar
  return avatar ? baseUrl + avatar : ''
})

const assistantAvatarUrl = computed(() => baseUrl + '/api/uploads/avatar/pd-image.png')

const MAX_TURNS = 100  // 最大对话次数（一次对话=用户提问+机器人回答）
const MAX_MESSAGES = MAX_TURNS * 2  // 对应最大消息数

const sessions = ref([])
const currentSessionId = ref('')
const messages = ref([])
const question = ref('')
const loading = ref(false)
const messagesContainer = ref(null)
const imageInputRef = ref(null)
const stickToBottom = ref(true)
let scrollFrame = 0
const retrievalMode = ref('hybrid')
const deepThinking = ref(false)
const streamingAssistant = ref(false)
const pendingAttachments = ref([])
const sessionFull = ref(false)  // 是否已达对话上限
const quickSuggestions = [
  { text: '联网搜索一个最新技术问题', mode: 'web', prompt: '联网搜索并总结：' , icon: Search },
  { text: '从知识库里找课程资料', mode: 'knowledge', prompt: '请从知识库检索并解释：', icon: Document },
  { text: '混合检索并给出结构化答案', mode: 'hybrid', prompt: '请混合检索资料，给出结构化回答：', icon: Connection },
  { text: '开启深度思考分析复杂问题', mode: 'hybrid', prompt: '请深度分析这个问题：', icon: Opportunity, deep: true }
]

// 讲义预览
const previewVisible = ref(false)
const previewLecture = ref(null)
const previewLoading = ref(false)
const previewError = ref(false)
const imagePreviewVisible = ref(false)
const imagePreview = ref(null)

// 文件检测
const normalizedFileExt = computed(() => {
  const lecture = previewLecture.value
  if (!lecture) return ''
  const rawType = String(lecture.lectureFiletype || '').trim().toLowerCase().replace(/^\./, '')
  if (rawType) return rawType
  const filePath = String(lecture.filePath || '').trim().toLowerCase()
  const match = filePath.match(/\.([a-z0-9]+)(?:$|[?#])/)
  return match ? match[1] : ''
})
const isPdfFile = computed(() => normalizedFileExt.value === 'pdf')
const isImageFile = computed(() => ['jpg','jpeg','png','gif','bmp','webp','svg'].includes(normalizedFileExt.value))
const isMarkdownFile = computed(() => ['md','markdown'].includes(normalizedFileExt.value))
const isHtmlFile = computed(() => ['html','htm'].includes(normalizedFileExt.value))
const isPptFile = computed(() => ['ppt','pptx'].includes(normalizedFileExt.value))

// Markdown 预览
const markdownContent = ref('')
const markdownLoading = ref(false)
const markdownError = ref('')

// PPT 预览
const pptSlides = ref([])
const pptCurrentSlideIndex = ref(0)
const pptLoading = ref(false)
const pptError = ref('')

const openFullLecture = () => {
  if (previewLecture.value?.lectureId) {
    previewVisible.value = false
    window.open(`/api/preview/lecture/${previewLecture.value.lectureId}`, '_blank')
  }
}

const previewFileUrl = computed(() => {
  if (!previewLecture.value?.lectureId) return ''
  return `/api/preview/lecture/${previewLecture.value.lectureId}`
})

const loadFilePreview = async () => {
  if (!previewLecture.value?.lectureId) return
  if (isMarkdownFile.value) {
    markdownLoading.value = true
    markdownError.value = ''
    try {
      const resp = await fetch(previewFileUrl.value)
      const text = await resp.text()
      markdownContent.value = marked.parse(text, { renderer })
    } catch (e) {
      markdownError.value = 'Markdown 预览加载失败'
    } finally {
      markdownLoading.value = false
    }
  } else if (isPptFile.value) {
    pptLoading.value = true
    pptError.value = ''
    try {
      const lectureId = previewLecture.value.lectureId
      const resp = await fetch(`/api/preview/lecture/${lectureId}/slides?debug=true`)
      const rawText = await resp.text()
      let result = null
      try { result = JSON.parse(rawText) } catch { throw new Error('PPT预览暂时不可用') }
      if (!resp.ok || result?.code !== 200) throw new Error(result?.msg || 'PPT预览加载失败')
      pptSlides.value = result?.data?.slides || []
      pptCurrentSlideIndex.value = 0
    } catch (e) {
      pptSlides.value = []
      pptError.value = e.message || 'PPT预览加载失败'
    } finally {
      pptLoading.value = false
    }
  }
}

const prevPptSlide = () => { if (pptCurrentSlideIndex.value > 0) pptCurrentSlideIndex.value-- }
const nextPptSlide = () => { if (pptCurrentSlideIndex.value < pptSlides.value.length - 1) pptCurrentSlideIndex.value++ }
const selectPptSlide = (idx) => { pptCurrentSlideIndex.value = idx }

const previewLectureFn = async (source) => {
  if (!source.lectureId) return
  previewVisible.value = true
  previewLoading.value = true
  previewError.value = false
  previewLecture.value = null
  markdownContent.value = ''
  markdownError.value = ''
  pptSlides.value = []
  pptError.value = ''

  try {
    const res = await ragApi.getLecture(source.lectureId)
    if (res.code === 0) {
      previewLecture.value = res.data
      await nextTick()
      loadFilePreview()
    } else {
      previewError.value = res.message || '加载讲义失败喵~'
    }
  } catch (error) {
    previewError.value = '无法加载讲义内容，请检查网络连接喵~'
  } finally {
    previewLoading.value = false
  }
}

const previewImageAttachment = (attachment) => {
  imagePreview.value = attachment
  imagePreviewVisible.value = true
}

const currentSessionTitle = computed(() => {
  const current = sessions.value.find(s => s.sessionId === currentSessionId.value)
  return current ? current.title : '知识库问答'
})

const canSend = computed(() => question.value.trim().length > 0 || pendingAttachments.value.length > 0)

const hasAssistantMessage = computed(() => {
  return messages.value.some(m => m.role === 'assistant')
})

const assistantHasContent = computed(() => {
  const lastAssistant = [...messages.value].reverse().find(m => m.role === 'assistant')
  if (!lastAssistant) return false
  return !!(lastAssistant.content || (lastAssistant.thinkingTrace && getThinkingSections(lastAssistant.thinkingTrace).length > 0))
})

const loadSessions = async () => {
  try {
    const res = await ragApi.getSessions()
    if (res.code === 0) {
      sessions.value = res.data || []
      // If no current session, select the first one
      if (!currentSessionId.value && sessions.value.length > 0) {
        await switchSession(sessions.value[0].sessionId)
      }
    }
  } catch (error) {
    console.error('加载会话列表失败:', error)
  }
}

const refreshSessionsOnly = async () => {
  try {
    const res = await ragApi.getSessions()
    if (res.code === 0) {
      sessions.value = res.data || []
    }
  } catch (error) {
    console.error('刷新会话列表失败:', error)
  }
}

const createSession = async () => {
  try {
    const res = await ragApi.createSession('新会话')
    if (res.code === 0) {
      sessions.value.unshift(res.data)
      await switchSession(res.data.sessionId)
    }
  } catch (error) {
    ElMessage.error('创建会话失败')
  }
}

const switchSession = async (sessionId) => {
  currentSessionId.value = sessionId
  await loadHistory(sessionId)
}

const loadHistory = async (sessionId) => {
  try {
    const res = await ragApi.getHistory(sessionId)
    if (res.code === 0) {
      const raw = res.data || []
      // 解析sources字段（数据库中存为JSON字符串）
      const parsed = raw.map(msg => {
        let sources = msg.sources || []
        if (typeof sources === 'string') {
          try { sources = JSON.parse(sources) } catch { sources = [] }
        }
        let searchKeywords = msg.searchKeywords || []
        if (typeof searchKeywords === 'string') {
          try { searchKeywords = JSON.parse(searchKeywords) } catch { searchKeywords = [] }
        }
        let attachments = msg.attachments || []
        if (typeof attachments === 'string') {
          try { attachments = JSON.parse(attachments) } catch { attachments = [] }
        }
        return { ...msg, sources, searchKeywords, attachments }
      })
      // 使用splice替换数组内容以保持响应性（与sendMessage的push一致）
      messages.value.splice(0, messages.value.length, ...parsed)
      checkSessionFull()
      scrollToBottom(true)
    } else {
      console.warn('History response code not 0:', res.code, res.message)
    }
  } catch (error) {
    console.error('加载历史失败:', error)
  }
}

const deleteSession = async (sessionId) => {
  try {
    await ElMessageBox.confirm('确定要删除这个会话吗？', '确认删除', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })

    const res = await ragApi.deleteSession(sessionId)
    if (res.code === 0) {
      ElMessage.success('删除成功')
      sessions.value = sessions.value.filter(s => s.sessionId !== sessionId)
      if (currentSessionId.value === sessionId) {
        currentSessionId.value = sessions.value.length > 0 ? sessions.value[0].sessionId : ''
        messages.value = []
      }
    }
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('删除会话失败')
    }
  }
}

const renameSession = async (sess) => {
  try {
    const { value: newTitle } = await ElMessageBox.prompt('请输入新的会话名称', '修改会话名称', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      inputValue: sess.title || '新会话',
      inputPlaceholder: '请输入会话名称',
      inputValidator: (val) => !!val.trim(),
      inputErrorMessage: '名称不能为空'
    })

    const res = await ragApi.updateSessionTitle(sess.sessionId, newTitle.trim())
    if (res.code === 0) {
      sess.title = newTitle.trim()
      ElMessage.success('名称已修改')
    } else {
      ElMessage.error(res.message || '修改失败')
    }
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('修改会话名称失败')
    }
  }
}

const handlePaste = async (event) => {
  const items = Array.from(event.clipboardData?.items || [])
  const imageItems = items.filter(item => item.type && item.type.startsWith('image/'))
  if (imageItems.length === 0) return

  event.preventDefault()
  for (const item of imageItems) {
    const file = item.getAsFile()
    if (file) await addImageAttachment(file)
  }
}

const openImagePicker = () => {
  imageInputRef.value?.click()
}

const handleImageInput = async (event) => {
  const files = Array.from(event.target?.files || []).filter(file => file.type?.startsWith('image/'))
  for (const file of files) {
    await addImageAttachment(file)
  }
  if (event.target) {
    event.target.value = ''
  }
}

const addImageAttachment = async (file) => {
  if (pendingAttachments.value.length >= 6) {
    ElMessage.warning('最多一次粘贴 6 张图片')
    return
  }
  if (file.size > 4 * 1024 * 1024) {
    ElMessage.warning('单张图片不能超过 4MB')
    return
  }
  const url = await fileToDataUrl(file)
  pendingAttachments.value.push({
    id: `${Date.now()}-${Math.random().toString(16).slice(2)}`,
    type: 'image',
    name: file.name || `pasted-image-${pendingAttachments.value.length + 1}.png`,
    mimeType: file.type || 'image/png',
    size: file.size,
    url
  })
}

const fileToDataUrl = (file) => new Promise((resolve, reject) => {
  const reader = new FileReader()
  reader.onload = () => resolve(reader.result)
  reader.onerror = reject
  reader.readAsDataURL(file)
})

const removeAttachment = (index) => {
  pendingAttachments.value.splice(index, 1)
}

const applyQuickSuggestion = (item) => {
  retrievalMode.value = item.mode || retrievalMode.value
  deepThinking.value = !!item.deep
  question.value = item.prompt || ''
}

const cloneAttachmentsForSend = () => pendingAttachments.value.map(({ id, ...attachment }) => ({ ...attachment }))

const streamRagQuery = async (payload, onEvent) => {
  const headers = {
    'Content-Type': 'application/json',
    Accept: 'text/event-stream'
  }
  if (userStore.token) {
    headers.Authorization = `Bearer ${userStore.token}`
  }

  const response = await fetch(`${baseUrl}/api/rag/query-stream`, {
    method: 'POST',
    headers,
    body: JSON.stringify(payload)
  })
  if (!response.ok || !response.body) {
    throw new Error(`流式接口请求失败: ${response.status}`)
  }

  const reader = response.body.getReader()
  const decoder = new TextDecoder('utf-8')
  let buffer = ''

  while (true) {
    const { value, done } = await reader.read()
    if (done) break
    buffer += decoder.decode(value, { stream: true })
    const blocks = buffer.split(/\r?\n\r?\n/)
    buffer = blocks.pop() || ''
    for (const block of blocks) {
      const parsed = parseSseBlock(block)
      if (parsed) {
        await onEvent(parsed.event, parsed.data)
      }
    }
  }

  if (buffer.trim()) {
    const parsed = parseSseBlock(buffer)
    if (parsed) {
      await onEvent(parsed.event, parsed.data)
    }
  }
}

const parseSseBlock = (block) => {
  const lines = block.split(/\r?\n/)
  let event = 'message'
  const dataLines = []
  for (const line of lines) {
    if (line.startsWith('event:')) {
      event = line.slice(6).trim()
    } else if (line.startsWith('data:')) {
      dataLines.push(line.slice(5).trimStart())
    }
  }
  if (dataLines.length === 0) return null
  const raw = dataLines.join('\n')
  try {
    return { event, data: JSON.parse(raw) }
  } catch {
    return { event, data: { text: raw, message: raw } }
  }
}

const sendMessage = async () => {
  const q = question.value.trim()
  if ((!q && pendingAttachments.value.length === 0) || loading.value || sessionFull.value) return
  const attachments = cloneAttachmentsForSend()
  const modeAtSend = retrievalMode.value
  const deepThinkingAtSend = deepThinking.value

  messages.value.push({
    role: 'user',
    content: q,
    timestamp: Date.now(),
    sources: [],
    attachments
  })

  question.value = ''
  pendingAttachments.value = []
  loading.value = true
  streamingAssistant.value = true
  scrollToBottom(true)

  const assistantMessage = {
    role: 'assistant',
    content: '',
    sources: [],
    attachments: [],
    retrievalMode: modeAtSend,
    searchKeywords: [],
    thinkingTrace: deepThinkingAtSend ? '' : '',
    fromKnowledgeBase: true,
    timestamp: Date.now(),
    streaming: true,
    status: ''
  }
  messages.value.push(assistantMessage)

  // 收集完整文本，流式结束后用打字机效果逐字显示
  let fullThinking = ''
  let fullAnswer = ''
  let donePayload = null
  let cancelled = false

  // 打字机效果：用 requestAnimationFrame 逐字写入，不受 Vue 批量更新影响
  const typewriterReveal = (target, field, text, charsPerFrame = 3) => {
    if (!text) return Promise.resolve()
    return new Promise(resolve => {
      let i = 0
      const step = () => {
        if (cancelled || i >= text.length) { resolve(); return }
        const end = Math.min(i + charsPerFrame, text.length)
        target[field] += text.slice(i, end)
        i = end
        scheduleScrollToBottom(false)
        requestAnimationFrame(step)
      }
      requestAnimationFrame(step)
    })
  }

  try {
    await streamRagQuery({
      question: q,
      sessionId: currentSessionId.value,
      retrievalMode: modeAtSend,
      deepThinking: deepThinkingAtSend,
      attachments
    }, async (event, data) => {
      if (event === 'session' && data.sessionId && data.sessionId !== currentSessionId.value) {
        currentSessionId.value = data.sessionId
      } else if (event === 'status') {
        return
      } else if (event === 'metadata') {
        assistantMessage.sources = data.sources || []
        assistantMessage.retrievalMode = data.retrievalMode || modeAtSend
        assistantMessage.searchKeywords = data.searchKeywords || []
        assistantMessage.fromKnowledgeBase = data.fromKnowledgeBase !== false
        if (data.sessionId && data.sessionId !== currentSessionId.value) currentSessionId.value = data.sessionId
      } else if (event === 'thinking_delta' && deepThinkingAtSend) {
        // 只收集，不立即显示
        fullThinking += data.text || ''
      } else if (event === 'answer_delta') {
        // 只收集，不立即显示
        fullAnswer += data.text || ''
      } else if (event === 'done') {
        donePayload = data
        assistantMessage.sources = data.sources || assistantMessage.sources
        assistantMessage.retrievalMode = data.retrievalMode || modeAtSend
        assistantMessage.searchKeywords = data.searchKeywords || []
        assistantMessage.fromKnowledgeBase = data.fromKnowledgeBase !== false
        if (data.answer) fullAnswer += data.answer
        if (deepThinkingAtSend && data.thinkingTrace && !fullThinking) fullThinking = data.thinkingTrace
        if (data.sessionId && data.sessionId !== currentSessionId.value) currentSessionId.value = data.sessionId
      } else if (event === 'error') {
        fullAnswer = fullAnswer || ('抱歉，发生了错误：' + (data.message || '未知错误'))
      }
    })

    // 流式接收完成，开始打字机效果逐字显示
    // 先显示思考过程，再显示回答
    await typewriterReveal(assistantMessage, 'thinkingTrace', fullThinking, 4)
    await typewriterReveal(assistantMessage, 'content', fullAnswer, 3)

    assistantMessage.streaming = false
    assistantMessage.status = ''
    if (donePayload) {
      await refreshSessionsOnly()
    }
  } catch (error) {
    cancelled = true
    assistantMessage.content = fullAnswer || '抱歉，无法连接到服务器或流式接口中断，请检查后端服务是否运行。'
    assistantMessage.thinkingTrace = fullThinking
    assistantMessage.streaming = false
    assistantMessage.status = ''
  }

  loading.value = false
  streamingAssistant.value = false
  checkSessionFull()
  scrollToBottom(false)
}

const openLecture = (source) => {
  if (source.lectureId) {
    window.open(`/student/lecture?lectureId=${source.lectureId}`, '_blank')
  }
}

const clearHistory = async () => {
  if (!currentSessionId.value) return
  try {
    await ElMessageBox.confirm('确定要清空当前会话的所有消息吗？', '确认清空', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    const res = await ragApi.clearHistory(currentSessionId.value)
    if (res.code === 0) {
      messages.value = []
      ElMessage.success('会话已清空')
    } else {
      ElMessage.error(res.message || '清空会话失败')
    }
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('清空会话失败')
    }
  }
}

const isNearBottom = (threshold = 140) => {
  const el = messagesContainer.value
  if (!el) return true
  return el.scrollHeight - el.scrollTop - el.clientHeight <= threshold
}

const handleMessagesScroll = () => {
  stickToBottom.value = isNearBottom(180)
}

const scheduleScrollToBottom = (force = false) => {
  const el = messagesContainer.value
  if (!el) return
  if (!force && !stickToBottom.value && !isNearBottom(180)) return
  if (scrollFrame) cancelAnimationFrame(scrollFrame)
  scrollFrame = requestAnimationFrame(() => {
    const current = messagesContainer.value
    if (!current) return
    current.scrollTop = current.scrollHeight
    stickToBottom.value = true
    scrollFrame = 0
  })
}

const scrollToBottom = (force = true) => {
  nextTick(() => scheduleScrollToBottom(force))
}

const formatMessage = (content) => {
  if (!content) return ''
  return marked.parse(content, { renderer })
}

const escapeHtml = (text) => String(text)
  .replace(/&/g, '&amp;')
  .replace(/</g, '&lt;')
  .replace(/>/g, '&gt;')
  .replace(/"/g, '&quot;')
  .replace(/'/g, '&#39;')

const formatStreamingMessage = (content) => {
  if (!content) return ''
  return `${escapeHtml(content).replace(/\n/g, '<br>')}<span class="streaming-cursor" aria-hidden="true"></span>`
}

const getMessageSources = (msg) => Array.isArray(msg?.sources) ? msg.sources : []
const getMessageAttachments = (msg) => Array.isArray(msg?.attachments) ? msg.attachments : []

const getSourceSnippet = (source) => {
  const text = source?.snippet || source?.text || ''
  return text.length > 520 ? text.substring(0, 520) + '...' : text
}

const getReferenceClass = (source) => {
  if (source?.type === 'web') return 'web-source'
  if (source?.type === 'image') return 'image-source'
  return 'knowledge-source'
}

const getReferenceTypeLabel = (source) => {
  if (source?.type === 'web') return source.engine || 'Web'
  if (source?.type === 'image') return source.tool || 'understand_image'
  return '知识库'
}

const getModeBadge = (msg) => {
  const mode = msg?.retrievalMode || inferRetrievalMode(getMessageSources(msg))
  if (mode === 'web') return '联网搜索'
  if (mode === 'hybrid') return '混合检索'
  if (mode === 'image') return '图片理解'
  return msg?.fromKnowledgeBase === false ? 'AI 知识' : '知识库'
}

const buildReferencesSummary = (msg) => {
  const sources = getMessageSources(msg)
  const keywordCount = Array.isArray(msg?.searchKeywords) ? msg.searchKeywords.length : 0
  const imageCount = sources.filter(source => source.type === 'image').length
  const fetchedCount = sources.filter(source => source.type === 'web' && source.contentFetched).length
  const mode = msg?.retrievalMode || inferRetrievalMode(sources)
  const imageText = imageCount ? `，读取 ${imageCount} 张图片` : ''
  const pageText = fetchedCount ? `，阅读全文 ${fetchedCount} 篇` : ''
  if (mode === 'image') return `图片理解，读取 ${imageCount} 张图片`
  if (mode === 'web') return `搜索 ${keywordCount || 1} 个关键词，参考 ${sources.length} 篇资料${pageText}${imageText}`
  if (mode === 'hybrid') return `混合检索，搜索 ${keywordCount || 1} 个关键词，参考 ${sources.length} 篇资料${pageText}${imageText}`
  return `知识库检索，参考 ${sources.length} 篇资料${imageText}`
}

const inferRetrievalMode = (sources) => {
  const hasWeb = sources.some(source => source.type === 'web')
  const hasKnowledge = sources.some(source => source.type !== 'web' && source.type !== 'image')
  const hasImage = sources.some(source => source.type === 'image')
  if (hasWeb && hasKnowledge) return 'hybrid'
  if (hasWeb) return 'web'
  if (hasImage && !hasKnowledge) return 'image'
  return 'knowledge'
}

const formatSearchKeywords = (msg) => {
  const keywords = Array.isArray(msg?.searchKeywords) ? msg.searchKeywords.filter(Boolean) : []
  if (keywords.length === 0) return ''
  return keywords.map(keyword => `“${keyword}”`).join('、')
}

const getThinkingSections = (trace) => {
  if (!trace) return []
  return trace.split(/\n(?=[^\n]{2,24}\n)/)
    .map(block => block.trim())
    .filter(Boolean)
    .map(block => {
      const [title, ...bodyLines] = block.split('\n')
      return {
        title: title.trim(),
        body: bodyLines.join('\n').trim()
      }
    })
}

const copyMessage = (content) => {
  const text = content.replace(/<[^>]*>/g, '')
  navigator.clipboard.writeText(text).then(() => {
    ElMessage.success('已复制到剪贴板喵~')
  }).catch(() => {
    ElMessage.error('复制失败喵~')
  })
}

const handleCodeCopy = (e) => {
  const btn = e.target.closest('.code-copy-btn')
  if (!btn) return
  const wrapper = btn.closest('.code-block-wrapper')
  const codeBlock = wrapper?.querySelector('pre code')
  if (codeBlock) {
    const code = codeBlock.textContent
    navigator.clipboard.writeText(code).then(() => {
      btn.innerHTML = '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg> 已复制'
      setTimeout(() => {
        btn.innerHTML = '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="14" height="14" rx="2" ry="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg> 复制'
      }, 2000)
    }).catch(() => {
      ElMessage.error('复制失败喵~')
    })
  }
}

const formatTime = (timestamp) => {
  if (!timestamp) return ''
  const date = new Date(timestamp)
  const now = new Date()
  const diff = now.getTime() - date.getTime()

  if (diff < 60000) return '刚刚'
  if (diff < 3600000) return Math.floor(diff / 60000) + '分钟前'
  if (diff < 86400000) return Math.floor(diff / 3600000) + '小时前'
  if (diff < 604800000) return Math.floor(diff / 86400000) + '天前'

  return date.toLocaleDateString('zh-CN', { month: 'short', day: 'numeric' })
}

// 检查是否达到对话上限
const checkSessionFull = () => {
  const turnCount = Math.ceil(messages.value.length / 2)  // 一次对话=用户+助手两条消息
  sessionFull.value = messages.value.length >= MAX_MESSAGES
  if (sessionFull.value) {
    ElMessage.warning(`此会话已达到${MAX_TURNS}次对话上限，请新建会话继续对话喵~`)
  } else if (turnCount >= MAX_TURNS - 5 && turnCount < MAX_TURNS) {
    // 剩余不到5次对话时提醒
    ElMessage.info(`当前会话还剩 ${MAX_TURNS - turnCount} 次对话空间，达到上限后请新建会话喵~`)
  }
}

onMounted(() => {
  loadSessions()
  nextTick(() => {
    if (messagesContainer.value) {
      messagesContainer.value.addEventListener('click', handleCodeCopy)
    }
  })
})
</script>

<style scoped>
@import 'highlight.js/styles/github.css';

/* ==================== Layout ==================== */
.rag-chat-wrapper {
  height: calc(100vh - 80px);
  min-height: 640px;
  background: #fff;
  color: #111827;
}

.rag-chat-container {
  display: flex;
  height: 100%;
  gap: 0;
  background: #fff;
}

/* ==================== Sidebar ==================== */
.sidebar {
  width: 286px;
  background: #fafafa;
  border-radius: 0;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  border: none;
  border-right: 1px solid #ededed;
  flex-shrink: 0;
}

.sidebar-brand {
  height: 72px;
  padding: 18px 18px 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.brand-title {
  display: block;
  font-size: 24px;
  font-weight: 650;
  color: #0f0f0f;
  letter-spacing: 0;
}

.brand-subtitle {
  display: block;
  margin-top: 4px;
  font-size: 13px;
  color: #777;
}

.composer-icon-btn {
  width: 34px;
  height: 34px;
  border: none;
  border-radius: 10px;
  background: transparent;
  color: #444;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: background 0.15s, color 0.15s;
}

.composer-icon-btn:hover {
  background: #ececec;
  color: #111;
}

.sidebar-nav {
  display: flex;
  flex-direction: column;
  gap: 4px;
  padding: 8px 10px 12px;
}

.sidebar-nav-item {
  border: none;
  background: transparent;
  color: #111;
  min-height: 40px;
  border-radius: 12px;
  padding: 0 14px;
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 16px;
  line-height: 1;
  cursor: pointer;
  text-align: left;
  transition: background 0.15s;
  width: 100%;
}

.sidebar-nav-item :deep(.el-icon) {
  width: 20px;
  height: 20px;
  font-size: 20px;
}

.sidebar-nav-item:hover,
.sidebar-nav-item.active {
  background: #eeeeef;
}

.sidebar-section-title {
  padding: 14px 18px 8px;
  font-size: 16px;
  font-weight: 650;
  color: #111;
}

.session-list {
  flex: 1;
  overflow-y: auto;
  padding: 0 10px 16px;
}

.session-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 14px;
  border-radius: 12px;
  cursor: pointer;
  margin-bottom: 2px;
  transition: background 0.15s, color 0.15s;
}

.session-item:hover { background: #f0f0f0; }
.session-item.active { background: #eeeeef; }

.session-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
  overflow: hidden;
  flex: 1;
  min-width: 0;
}

.session-title {
  font-size: 15px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  color: #111;
}

.session-time {
  display: none;
}

.session-actions { display: none; gap: 2px; flex-shrink: 0; }
.session-item:hover .session-actions { display: flex; }

.rename-btn,
.delete-btn {
  font-size: 14px;
  padding: 4px !important;
  margin-left: 0 !important;
}

.no-sessions {
  text-align: center;
  color: #909399;
  padding: 32px 0;
  font-size: 13px;
}

/* ==================== Chat Area ==================== */
.chat-area {
  flex: 1;
  min-width: 0;
  background: #fff;
}

.chat-card {
  height: 100%;
  display: flex;
  flex-direction: column;
  border-radius: 0;
  border: none;
  box-shadow: none;
}

.chat-card :deep(.el-card__body) {
  flex: 1;
  display: flex;
  flex-direction: column;
  padding: 0;
  overflow: hidden;
}

.chat-card :deep(.el-card__header) {
  border-bottom: 1px solid #ededed;
  padding: 11px 26px;
  background: rgba(255, 255, 255, 0.92);
  backdrop-filter: blur(10px);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-header .title {
  font-size: 16px;
  font-weight: 600;
  color: #111;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 6px;
}

.turn-counter {
  font-size: 12px;
  color: #6b7280;
  margin-right: 0;
  padding: 3px 10px;
  background: #f4f4f4;
  border-radius: 999px;
}

.turn-counter.full {
  color: #e65100;
  background: #fff3e0;
  font-weight: 600;
}

/* ==================== Messages Container ==================== */
.chat-messages {
  flex: 1;
  overflow-y: auto;
  padding: 30px 24px 150px;
  display: flex;
  flex-direction: column;
  gap: 22px;
  background: #fff;
  scroll-behavior: auto;
}

.chat-messages::-webkit-scrollbar { width: 5px; }
.chat-messages::-webkit-scrollbar-track { background: transparent; }
.chat-messages::-webkit-scrollbar-thumb {
  background: #d0d5dd;
  border-radius: 3px;
}
.chat-messages::-webkit-scrollbar-thumb:hover { background: #b0b5bd; }

.empty-chat {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
}

.empty-center {
  width: min(100%, 760px);
  text-align: center;
  padding: 34px 18px 120px;
}

.empty-center h1 {
  margin: 0 0 24px;
  font-size: 29px;
  line-height: 1.25;
  font-weight: 650;
  letter-spacing: 0;
  color: #111;
}

.empty-suggestions {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 10px;
  max-width: 620px;
  margin: 0 auto;
}

.empty-suggestions button {
  min-height: 46px;
  border: 1px solid #e8e8e8;
  border-radius: 14px;
  background: #fff;
  color: #343541;
  display: flex;
  align-items: center;
  justify-content: flex-start;
  gap: 10px;
  padding: 0 14px;
  font-size: 14px;
  cursor: pointer;
  transition: background 0.15s, border-color 0.15s, transform 0.15s;
}

.empty-suggestions button:hover {
  background: #f7f7f8;
  border-color: #dcdcdc;
  transform: translateY(-1px);
}

.empty-suggestions :deep(.el-icon) {
  color: #10a37f;
}

/* ==================== Message Row ==================== */
.message {
  display: flex;
  gap: 12px;
  width: min(100%, 920px);
  max-width: 920px;
  margin: 0 auto;
  animation: msgFadeIn 0.3s ease;
}

@keyframes msgFadeIn {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

.message.user {
  align-self: center;
  flex-direction: row-reverse;
}

.message.assistant {
  align-self: center;
}

.message-avatar { flex-shrink: 0; margin-top: 2px; }

.message-content {
  display: flex;
  flex-direction: column;
  gap: 3px;
  min-width: 0;
}

.message.user .message-content { align-items: flex-end; }
.message.assistant .message-content { width: 100%; }

/* ==================== Message Bubble ==================== */
.message-bubble {
  padding: 13px 17px;
  border-radius: 18px;
  line-height: 1.78;
  font-size: 15px;
  position: relative;
  word-wrap: break-word;
  overflow-wrap: break-word;
}

.message.user .message-bubble {
  background: #f4f4f4;
  color: #111827;
  border-bottom-right-radius: 6px;
  max-width: min(720px, 100%);
}

.message.assistant .message-bubble {
  background: transparent;
  color: #202123;
  border-bottom-left-radius: 6px;
  border: none;
  padding-left: 0;
  padding-right: 0;
}

/* ==================== Message Text Typography ==================== */
.message-text { word-break: break-word; }

.message-text.streaming-text {
  white-space: normal;
}

.message-text :deep(.streaming-cursor) {
  display: inline-block;
  width: 7px;
  height: 1.1em;
  margin-left: 2px;
  border-radius: 999px;
  background: #111827;
  vertical-align: -0.18em;
  animation: streamCursorBlink 0.9s steps(2, start) infinite;
}

@keyframes streamCursorBlink {
  0%, 45% { opacity: 1; }
  46%, 100% { opacity: 0; }
}

.message.assistant .message-text {
  font-size: 15.5px;
  line-height: 1.82;
  color: #202123;
}

.message.assistant .message-bubble::after {
  content: "";
  display: inline-block;
  width: 0;
  height: 0;
}

.message-text :deep(p) { margin: 10px 0; }
.message-text :deep(p:first-child) { margin-top: 0; }
.message-text :deep(p:last-child) { margin-bottom: 0; }

/* Headings in AI answers */
.message-text :deep(h1),
.message-text :deep(h2),
.message-text :deep(h3),
.message-text :deep(h4) {
  margin: 22px 0 10px;
  font-weight: 600;
  color: #1f2328;
  line-height: 1.4;
}
.message-text :deep(h1) { font-size: 1.42em; padding-bottom: 7px; border-bottom: 1px solid #e8ecf0; }
.message-text :deep(h2) { font-size: 1.24em; }
.message-text :deep(h3) { font-size: 1.12em; }
.message-text :deep(h1:first-child) { margin-top: 0; }

.message.user .message-text :deep(h1),
.message.user .message-text :deep(h2),
.message.user .message-text :deep(h3) {
  color: #111827;
  border-bottom-color: rgba(17,24,39,0.12);
}

/* Lists */
.message-text :deep(ul),
.message-text :deep(ol) {
  margin: 6px 0;
  padding-left: 22px;
}
.message-text :deep(li) { margin: 3px 0; line-height: 1.7; }
.message-text :deep(li > ul),
.message-text :deep(li > ol) { margin: 2px 0; }

/* Inline code */
.message-text :deep(code) {
  background: #eef0f4;
  padding: 1px 6px;
  border-radius: 4px;
  font-family: 'Consolas', 'Monaco', 'Courier New', monospace;
  font-size: 0.88em;
  color: #d63384;
}

.message-text :deep(del),
.message-text :deep(s),
.message-text :deep(.md-no-strike) {
  text-decoration: none;
}

.message.user .message-text :deep(code) {
  background: rgba(17,24,39,0.08);
  color: #1f2937;
}

/* Blockquote */
.message-text :deep(blockquote) {
  margin: 10px 0;
  padding: 8px 14px;
  border-left: 4px solid #409eff;
  background: #f0f7ff;
  border-radius: 6px;
  color: #555;
}

.message.user .message-text :deep(blockquote) {
  background: rgba(17,24,39,0.04);
  border-left-color: rgba(17,24,39,0.28);
  color: #374151;
}

/* Strong / emphasis */
.message-text :deep(strong) { font-weight: 600; color: #1f2328; }
.message.user .message-text :deep(strong) { color: #111827; }

/* Horizontal rule */
.message-text :deep(hr) {
  margin: 14px 0;
  border: none;
  border-top: 1px solid #e0e4e8;
}

.message-text :deep(img) {
  max-width: min(100%, 420px);
  max-height: 360px;
  object-fit: contain;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
  display: block;
  margin: 10px 0;
}

/* ==================== Code Blocks ==================== */
.message-text :deep(.code-block-wrapper) {
  margin: 10px -18px;
  border-radius: 0;
  overflow: hidden;
  border: none;
  border-top: 1px solid #e0e0e0;
  border-bottom: 1px solid #e0e0e0;
}

.message.user .message-text :deep(.code-block-wrapper) {
  border-color: rgba(255,255,255,0.2);
}

.message-text :deep(.code-block-header) {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 6px 14px;
  background: #f0f0f0;
}

.message.user .message-text :deep(.code-block-header) {
  background: rgba(255,255,255,0.12);
}

.message-text :deep(.code-lang-tag) {
  font-size: 11px;
  color: #888;
  font-weight: 600;
  text-transform: lowercase;
}

.message.user .message-text :deep(.code-lang-tag) {
  color: rgba(255,255,255,0.7);
}

.message-text :deep(.code-copy-btn) {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 2px 8px;
  border: none;
  background: transparent;
  color: #999;
  font-size: 11px;
  cursor: pointer;
  border-radius: 4px;
  transition: all 0.15s;
}

.message-text :deep(.code-copy-btn:hover) {
  background: #ddd;
  color: #333;
}

.message.user .message-text :deep(.code-copy-btn:hover) {
  background: rgba(255,255,255,0.2);
  color: #fff;
}

.message-text :deep(pre) {
  margin: 0;
  padding: 14px 18px;
  background: #1a1a2e !important;
  overflow-x: auto;
  line-height: 1.6;
}

.message.user .message-text :deep(pre) {
  background: #1a1a2e !important;
}

.message-text :deep(pre code) {
  background: transparent !important;
  padding: 0;
  color: #e2e8f0 !important;
  font-size: 13px;
  line-height: 1.6;
  font-family: 'Consolas', 'Monaco', 'Courier New', monospace;
}

/* ==================== Tables ==================== */
.message-text :deep(.table-wrapper) {
  margin: 8px -18px;
  border-radius: 0;
  overflow: hidden;
  border-top: 1px solid #e0e0e0;
  border-bottom: 1px solid #e0e0e0;
}

.message.user .message-text :deep(.table-wrapper) {
  border-color: rgba(255,255,255,0.2);
}

.message-text :deep(.table-header) {
  padding: 4px 14px;
  background: #f5f5f5;
  border-bottom: 1px solid #e0e0e0;
}

.message.user .message-text :deep(.table-header) {
  background: rgba(255,255,255,0.12);
  border-bottom-color: rgba(255,255,255,0.1);
}

.message-text :deep(.table-type-tag) {
  font-size: 11px;
  color: #888;
  font-weight: 600;
}

.message.user .message-text :deep(.table-type-tag) {
  color: rgba(255,255,255,0.7);
}

.message-text :deep(.table-scroll) { overflow-x: auto; }
.message-text :deep(table) {
  width: 100%;
  border-collapse: collapse;
  font-size: 13px;
}
.message-text :deep(th),
.message-text :deep(td) {
  padding: 8px 12px;
  border: 1px solid #d0d7de;
  text-align: left;
}
.message-text :deep(th) {
  background: #f0f2f5;
  font-weight: 600;
  color: #1f2328;
  white-space: nowrap;
  font-size: 13px;
}
.message-text :deep(td) { color: #303133; }
.message-text :deep(tr:nth-child(even) td) { background: #f8f9fb; }

.message.user .message-text :deep(th) {
  background: rgba(255,255,255,0.15);
  border-color: rgba(255,255,255,0.2);
  color: rgba(255,255,255,0.95);
}
.message.user .message-text :deep(td) {
  border-color: rgba(255,255,255,0.12);
  color: rgba(255,255,255,0.9);
}
.message.user .message-text :deep(tr:nth-child(even) td) {
  background: rgba(255,255,255,0.04);
}

/* ==================== Thinking & References ==================== */
.thinking-panel,
.references-panel {
  margin-bottom: 10px;
  border-bottom: 1px solid #edf0f3;
  padding-bottom: 8px;
}

.references-panel {
  margin-top: 12px;
  margin-bottom: 0;
  border: 1px solid #edf0f3;
  border-radius: 12px;
  background: #fbfbfc;
  padding: 10px 12px;
}

.thinking-summary,
.references-summary {
  list-style: none;
  cursor: pointer;
  color: #8a8f99;
  font-size: 13px;
  line-height: 1.6;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
}

.thinking-summary::-webkit-details-marker,
.references-summary::-webkit-details-marker {
  display: none;
}

.summary-left {
  display: inline-flex;
  align-items: center;
  gap: 7px;
  min-width: 0;
}

.summary-arrow {
  transition: transform 0.15s ease;
  flex-shrink: 0;
}

.thinking-panel[open] .summary-arrow,
.references-panel[open] .summary-arrow {
  transform: rotate(90deg);
}

/* 思考过程原始文本显示 */
.thinking-raw-content {
  margin-top: 10px;
  padding: 12px 14px;
  max-height: 260px;
  overflow-y: auto;
  border-top: 1px solid #edf0f3;
  font-family: 'JetBrains Mono', 'Consolas', 'Monaco', monospace;
  font-size: 12.5px;
  line-height: 1.7;
  color: #6b7280;
  white-space: pre-wrap;
  word-break: break-word;
}

/* 思考过程脉动动画 */
.thinking-icon-pulse {
  animation: thinkingIconPulse 1.5s ease-in-out infinite;
}

@keyframes thinkingIconPulse {
  0%, 100% { opacity: 0.5; }
  50% { opacity: 1; }
}

/* 思考中的三个小圆点 */
.thinking-live-dots {
  display: inline-flex;
  align-items: center;
  gap: 3px;
  margin-left: 2px;
}

.thinking-live-dot {
  width: 4px;
  height: 4px;
  border-radius: 50%;
  background: #10a37f;
  animation: thinkingLiveDot 1.2s ease-in-out infinite;
}

.thinking-live-dot:nth-child(2) { animation-delay: 0.2s; }
.thinking-live-dot:nth-child(3) { animation-delay: 0.4s; }

@keyframes thinkingLiveDot {
  0%, 60%, 100% { opacity: 0.3; transform: scale(0.8); }
  30% { opacity: 1; transform: scale(1); }
}

.message-attachments {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-top: 10px;
}

.message-attachment {
  width: 112px;
  height: 84px;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 0;
  overflow: hidden;
  background: #fff;
  cursor: pointer;
}

.message-attachment img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.references-keywords {
  margin: 4px 0 8px;
  color: #8a8f99;
  font-size: 13px;
  line-height: 1.6;
}

.reference-list {
  margin: 8px 0 0;
  padding: 0;
  list-style: none;
}

.reference-item {
  padding: 9px 0;
  border-top: 1px solid #edf0f3;
}

.reference-item:first-child {
  border-top: none;
}

.reference-link {
  display: inline;
  border: none;
  background: transparent;
  color: #006dff;
  cursor: pointer;
  padding: 0;
  text-align: left;
  font-size: 14px;
  line-height: 1.6;
  text-decoration: none;
}

.reference-link:hover {
  text-decoration: underline;
}

.reference-button {
  font-family: inherit;
}

.reference-static {
  color: #5b5f66;
  cursor: default;
}

.reference-static:hover {
  text-decoration: none;
}

.image-source .reference-snippet {
  color: #4b5563;
  background: #f6f8fb;
  border-left: 3px solid #aeb7c8;
  padding: 6px 9px;
  border-radius: 4px;
}

.reference-snippet {
  margin: 3px 0 0;
  color: #606266;
  font-size: 13px;
  line-height: 1.6;
}

.reference-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 3px;
  color: #9aa0a6;
  font-size: 12px;
}

.reference-meta span {
  display: inline-flex;
  align-items: center;
  min-height: 20px;
  padding: 0 7px;
  border-radius: 999px;
  background: #f2f4f7;
}

/* ==================== Sources ==================== */
.sources {
  margin-top: 12px;
  padding-top: 10px;
  border-top: 1px solid #e8ecf0;
}

.sources-title {
  font-size: 12px;
  font-weight: 600;
  color: #606266;
  margin-bottom: 8px;
  display: flex;
  align-items: center;
  gap: 4px;
}

.sources-title :deep(.el-icon) {
  font-size: 14px;
  color: #409eff;
}

.source-item {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  padding: 10px 12px;
  background: linear-gradient(135deg, #f8fafb 0%, #f0f7ff 100%);
  border-radius: 8px;
  margin-top: 6px;
  cursor: pointer;
  transition: all 0.2s ease;
  border: 1px solid #e8ecf0;
}

.source-item:hover {
  background: linear-gradient(135deg, #e8f5e9 0%, #e3f2fd 100%);
  border-color: #c8e6c9;
  transform: translateY(-1px);
  box-shadow: 0 2px 8px rgba(64, 158, 255, 0.1);
}

.source-icon {
  width: 32px;
  height: 32px;
  border-radius: 6px;
  background: linear-gradient(135deg, #409eff 0%, #337ecc 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.source-icon :deep(.el-icon) {
  font-size: 16px;
  color: #fff;
}

.source-info {
  flex: 1;
  min-width: 0;
}

.source-name {
  font-size: 13px;
  font-weight: 600;
  color: #1f2328;
  margin-bottom: 4px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.source-excerpt {
  font-size: 12px;
  color: #606266;
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.source-meta {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-top: 6px;
}

.source-score {
  font-size: 11px;
  color: #67c23a;
  font-weight: 500;
  background: #f0f9eb;
  padding: 2px 6px;
  border-radius: 4px;
}

.source-action {
  font-size: 11px;
  color: #409eff;
  font-weight: 500;
}

/* ==================== Footer ==================== */
.message-footer {
  display: flex;
  align-items: center;
  gap: 6px;
  margin-top: 2px;
  padding: 0 4px;
}

.message.user .message-footer { justify-content: flex-end; }

.message-time {
  font-size: 11px;
  color: #b0b4ba;
}

.message-actions {
  display: flex;
  gap: 2px;
  opacity: 0;
  transition: opacity 0.15s;
}

.message:hover .message-actions { opacity: 1; }

.action-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 26px;
  height: 26px;
  border: none;
  background: transparent;
  color: #bbb;
  cursor: pointer;
  border-radius: 4px;
  transition: all 0.15s;
  font-size: 13px;
}

.action-btn:hover { background: #eee; color: #409eff; }

.ai-source-badge {
  display: inline-flex;
  align-items: center;
  padding: 1px 7px;
  border-radius: 4px;
  font-size: 11px;
  background: #fff3e0;
  color: #e65100;
  border: 1px solid #ffe0b2;
  cursor: help;
  white-space: nowrap;
}

/* ==================== Loading ==================== */
.message-bubble.loading {
  display: flex;
  gap: 5px;
  padding: 14px 18px;
  background: #fff;
  border: 1px solid #e8ecf0;
}

.loading-dot {
  width: 8px;
  height: 8px;
  background: #909399;
  border-radius: 50%;
  animation: bounce 1.4s infinite ease-in-out both;
}

.loading-dot:nth-child(1) { animation-delay: -0.32s; }
.loading-dot:nth-child(2) { animation-delay: -0.16s; }

@keyframes bounce {
  0%, 80%, 100% { transform: scale(0); }
  40% { transform: scale(1); }
}

/* 思考阶段加载指示器 */
.thinking-loading {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 4px 0;
}

.thinking-loading-dot {
  width: 6px;
  height: 6px;
  background: #10a37f;
  border-radius: 50%;
  animation: thinkingPulse 1.4s infinite ease-in-out both;
}

.thinking-loading-dot:nth-child(1) { animation-delay: -0.32s; }
.thinking-loading-dot:nth-child(2) { animation-delay: -0.16s; }

.thinking-loading-text {
  font-size: 13px;
  color: #8a8f99;
  margin-left: 4px;
  animation: thinkingFade 1.4s infinite ease-in-out;
}

@keyframes thinkingPulse {
  0%, 80%, 100% { transform: scale(0); opacity: 0.4; }
  40% { transform: scale(1); opacity: 1; }
}

@keyframes thinkingFade {
  0%, 100% { opacity: 0.4; }
  50% { opacity: 1; }
}

@keyframes pulseDot {
  0%, 100% {
    opacity: 0.35;
    transform: scale(0.8);
    box-shadow: 0 0 0 0 rgba(16, 163, 127, 0.28);
  }
  50% {
    opacity: 1;
    transform: scale(1);
    box-shadow: 0 0 0 7px rgba(16, 163, 127, 0);
  }
}

/* ==================== Input Area ==================== */
.chat-input-area {
  padding: 10px 24px 18px;
  border-top: 1px solid #ededed;
  background: linear-gradient(180deg, rgba(255,255,255,0.64), #fff 34%);
  display: flex;
  flex-direction: column;
  align-items: center;
  box-shadow: 0 -14px 34px rgba(17, 24, 39, 0.04);
}

.chat-input-area > * {
  width: min(100%, 880px);
}

.composer-card {
  border: 1px solid #d9d9d9;
  border-radius: 28px;
  background: #fff;
  padding: 9px 10px 10px;
  box-shadow: 0 10px 34px rgba(17, 24, 39, 0.12);
}

.chat-input-area :deep(.el-textarea__inner) {
  border-radius: 20px;
  resize: none;
  padding: 10px 12px;
  font-size: 15px;
  line-height: 1.65;
  border-color: transparent;
  background: #fff;
  box-shadow: none;
  transition: border-color 0.2s, box-shadow 0.2s;
}

.chat-input-area :deep(.el-textarea__inner:focus) {
  border-color: transparent;
  box-shadow: none;
}

.composer-bottom {
  margin-top: 6px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
}

.composer-tools {
  display: flex;
  align-items: center;
  gap: 8px;
  flex-wrap: wrap;
  min-width: 0;
}

.composer-icon-btn {
  border: 1px solid #e5e5e5;
  border-radius: 50%;
  width: 34px;
  height: 34px;
}

.composer-icon-btn:disabled {
  cursor: not-allowed;
  opacity: 0.5;
}

.hidden-file-input {
  display: none;
}

.retrieval-mode-group :deep(.el-radio-button__inner) {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  height: 34px;
  border: none;
  border-radius: 999px !important;
  color: #5f6368;
  background: #f5f5f5;
  box-shadow: none;
  padding: 0 12px;
  font-weight: 500;
}

.retrieval-mode-group :deep(.el-radio-button:first-child .el-radio-button__inner),
.retrieval-mode-group :deep(.el-radio-button:last-child .el-radio-button__inner) {
  border-radius: 999px !important;
}

.retrieval-mode-group :deep(.el-radio-button__original-radio:checked + .el-radio-button__inner) {
  background: #111;
  border-color: #111;
  box-shadow: none;
  color: #fff;
}

.composer-tools :deep(.el-switch) {
  padding-left: 4px;
}

.composer-tools :deep(.el-switch__label) {
  color: #6b7280;
  font-weight: 500;
}

.thinking-mode {
  display: inline-flex;
  align-items: center;
  padding: 2px;
  border-radius: 999px;
  background: #f5f5f5;
  border: 1px solid #ececec;
}

.thinking-mode button {
  height: 30px;
  border: none;
  border-radius: 999px;
  background: transparent;
  color: #5f6368;
  padding: 0 12px;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  transition: background 0.15s, color 0.15s;
}

.thinking-mode button.active {
  background: #111;
  color: #fff;
}

.thinking-mode button:disabled {
  cursor: not-allowed;
}

.thinking-mode.disabled {
  opacity: 0.62;
}

.pending-attachments {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
  margin-bottom: 10px;
}

.pending-attachment {
  position: relative;
  width: 96px;
  height: 72px;
  border-radius: 10px;
  overflow: hidden;
  border: 1px solid #d8dee8;
  background: #f8fafc;
}

.pending-attachment img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.remove-attachment {
  position: absolute;
  top: 4px;
  right: 4px;
  width: 22px;
  height: 22px;
  border-radius: 50%;
  border: none;
  background: rgba(17, 24, 39, 0.82);
  color: #fff;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  padding: 0;
}

.input-actions {
  margin-top: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
}

.hint {
  width: min(100%, 880px);
  margin-top: 10px;
  text-align: center;
  font-size: 12px;
  color: #8b8b8b;
}

.send-button {
  width: 42px;
  height: 42px;
  border-radius: 50%;
  border: none;
  background: #111;
  color: #fff;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  cursor: pointer;
  box-shadow: 0 8px 22px rgba(17, 24, 39, 0.16);
  transition: background 0.15s, transform 0.15s;
}

.send-button:hover,
.send-button:focus {
  background: #000;
  color: #fff;
  transform: translateY(-1px);
}

.send-button:disabled {
  cursor: not-allowed;
  background: #d9d9d9;
  box-shadow: none;
  transform: none;
}

.send-loader {
  width: 15px;
  height: 15px;
  border-radius: 50%;
  border: 2px solid rgba(255,255,255,0.45);
  border-top-color: #fff;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

/* ==================== Preview Dialog ==================== */
.preview-dialog .preview-content {
  min-height: 200px;
  max-height: 68vh;
  overflow-y: auto;
}

.preview-dialog :deep(.el-dialog__body) {
  overflow: hidden;
}

.markdown-preview .markdown-content {
  max-height: 62vh;
  overflow-y: auto;
  padding: 4px 0;
  line-height: 1.8;
  font-size: 14px;
}

.preview-html {
  padding: 8px 0;
  line-height: 1.8;
  font-size: 14px;
}

.file-preview-frame {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.preview-iframe {
  width: 100%;
  height: 65vh;
  border: 1px solid #e8ecf0;
  border-radius: 6px;
  background: #fff;
}

.preview-iframe-footer {
  margin-top: 8px;
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 13px;
}

.preview-error-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px 20px;
  gap: 12px;
  color: #909399;
}

.preview-meta {
  margin-bottom: 12px;
  display: flex;
  gap: 8px;
}

/* ==================== Markdown Preview ==================== */
.markdown-preview {
  width: 100%;
}

.markdown-preview .markdown-content {
  padding: 4px 0;
  line-height: 1.8;
  font-size: 14px;
}

/* :deep() styles to penetrate v-html rendered content */
.markdown-preview .markdown-content :deep(h1),
.markdown-preview .markdown-content :deep(h2),
.markdown-preview .markdown-content :deep(h3),
.markdown-preview .markdown-content :deep(h4) {
  margin: 1.2em 0 0.6em;
  color: #1f2328;
}

.markdown-preview .markdown-content :deep(p) {
  margin: 0 0 1em;
  color: #333;
}

.markdown-preview .markdown-content :deep(pre) {
  background: #1a1a2e;
  border-radius: 6px;
  padding: 14px 16px;
  overflow-x: auto;
  line-height: 1.6;
}

.markdown-preview .markdown-content :deep(code) {
  font-size: 13px;
  font-family: 'Consolas', 'Monaco', 'Courier New', monospace;
}

.markdown-preview .markdown-content :deep(pre code) {
  background: transparent !important;
  padding: 0;
  color: #e2e8f0 !important;
}

.markdown-preview .markdown-content :deep(img) {
  max-width: 100%;
  border-radius: 6px;
}

.markdown-preview .markdown-content :deep(blockquote) {
  margin: 1em 0;
  padding: 8px 16px;
  border-left: 4px solid #409eff;
  background: #f8faff;
  color: #555;
  border-radius: 0 6px 6px 0;
}

.markdown-preview .markdown-content :deep(ul),
.markdown-preview .markdown-content :deep(ol) {
  padding-left: 1.5em;
  margin: 0.5em 0;
}

.markdown-preview .markdown-content :deep(li) {
  margin: 0.3em 0;
}

.markdown-preview .markdown-content :deep(a) {
  color: #409eff;
  text-decoration: none;
}

.markdown-preview .markdown-content :deep(a:hover) {
  text-decoration: underline;
}

.markdown-preview .markdown-content :deep(.code-block-wrapper) {
  margin: 12px 0;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  overflow: hidden;
}

.markdown-preview .markdown-content :deep(.code-block-header) {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 6px 14px;
  background: #f0f0f0;
}

.markdown-preview .markdown-content :deep(.code-lang-tag) {
  font-size: 11px;
  color: #888;
  font-weight: 600;
  text-transform: lowercase;
}

.markdown-preview .markdown-content :deep(.code-copy-btn) {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 2px 8px;
  border: none;
  background: transparent;
  color: #999;
  font-size: 11px;
  cursor: pointer;
  border-radius: 4px;
  transition: all 0.15s;
}

.markdown-preview .markdown-content :deep(.code-copy-btn:hover) {
  background: #ddd;
  color: #333;
}

.markdown-preview .markdown-content :deep(.table-wrapper) {
  margin: 12px 0;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  overflow: hidden;
}

.markdown-preview .markdown-content :deep(.table-header) {
  padding: 4px 14px;
  background: #f5f5f5;
  font-size: 12px;
  color: #999;
}

.markdown-preview .markdown-content :deep(table) {
  width: 100%;
  border-collapse: collapse;
}

.markdown-preview .markdown-content :deep(th),
.markdown-preview .markdown-content :deep(td) {
  padding: 8px 12px;
  text-align: left;
  border-bottom: 1px solid #eee;
  font-size: 13px;
}

.markdown-preview .markdown-content :deep(th) {
  background: #fafafa;
  font-weight: 600;
  color: #333;
}

.markdown-preview .markdown-content :deep(tr:last-child td) {
  border-bottom: none;
}

/* ==================== PPT Preview ==================== */
.ppt-preview {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.ppt-viewer {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.ppt-slide-main {
  width: 100%;
  display: flex;
  justify-content: center;
  background: #f0f2f5;
  border-radius: 6px;
  padding: 16px;
}

.ppt-slide-image {
  max-width: 100%;
  max-height: 55vh;
  object-fit: contain;
  border-radius: 4px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.12);
}

.ppt-pagination {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-top: 12px;
}

.ppt-page-indicator {
  font-size: 13px;
  color: #606266;
  min-width: 80px;
  text-align: center;
}

/* ==================== Common Preview Status ==================== */
.preview-status {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px 20px;
  gap: 12px;
  color: #909399;
}

.preview-status-text {
  font-size: 14px;
  color: #909399;
}

.image-preview-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
}

.image-preview-content img {
  max-width: 100%;
  max-height: 70vh;
  object-fit: contain;
  border-radius: 8px;
}

.image-preview-name {
  color: #606266;
  font-size: 13px;
}

@media (max-width: 860px) {
  .sidebar {
    display: none;
  }

  .chat-messages {
    padding-left: 16px;
    padding-right: 16px;
  }

  .empty-suggestions {
    grid-template-columns: 1fr;
  }

  .composer-bottom {
    align-items: stretch;
    flex-direction: column;
  }

  .composer-tools {
    width: 100%;
  }

  .send-button {
    align-self: flex-end;
  }
}
</style>

<!-- 非 scoped 样式：确保 v-html 注入的流式光标能正确显示 -->
<style>
.streaming-cursor {
  display: inline-block;
  width: 7px;
  height: 1.1em;
  margin-left: 2px;
  border-radius: 999px;
  background: #111827;
  vertical-align: -0.18em;
  animation: streamCursorBlink 0.9s steps(2, start) infinite;
}

@keyframes streamCursorBlink {
  0%, 45% { opacity: 1; }
  46%, 100% { opacity: 0; }
}
</style>
