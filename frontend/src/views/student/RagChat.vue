<template>
  <div class="rag-chat-wrapper">
    <div class="rag-chat-container">
    <!-- 左侧会话列表 -->
    <div class="sidebar">
      <div class="sidebar-header">
        <span class="sidebar-title">会话列表</span>
        <el-button type="primary" size="small" @click="createSession">
          <el-icon><Plus /></el-icon> 新建会话
        </el-button>
      </div>
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
                <el-icon><Delete /></el-icon> 清空会话
              </el-button>
            </div>
          </div>
        </template>

        <div class="chat-messages" ref="messagesContainer">
          <!-- 调试信息 -->
          <div style="display:none">{{ messages.length }}</div>

          <div v-if="messages.length === 0" class="empty-chat">
            <el-empty description="开始向知识库提问吧！" />
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
                <div class="message-text" v-html="formatMessage(msg.content)"></div>
                <div v-if="msg.sources && msg.sources.length > 0" class="sources">
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
                  <span v-if="msg.fromKnowledgeBase === false" class="ai-source-badge" title="此回答来自AI自身知识，可能不准确，请谨慎参考">AI 知识</span>
                  <button class="action-btn" @click="copyMessage(msg.content)" title="复制内容">
                    <el-icon><CopyDocument /></el-icon>
                  </button>
                </div>
              </div>
            </div>
          </div>

          <div v-if="loading" class="message assistant">
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

        <div class="chat-input-area">
          <el-input
            v-model="question"
            type="textarea"
            :rows="3"
            :placeholder="sessionFull ? '此会话已达对话上限，请新建会话喵~' : '输入您的问题，按 Enter 发送，Shift+Enter 换行...'"
            @keydown.enter.exact.prevent="sendMessage"
            :disabled="loading || sessionFull"
          />
          <div class="input-actions">
            <span class="hint">{{ sessionFull ? '已达对话上限，请新建会话' : '按 Enter 发送，Shift+Enter 换行' }}</span>
            <el-button type="primary" :loading="loading" @click="sendMessage" :disabled="!question.trim() || sessionFull || loading">
              <el-icon><Promotion /></el-icon> 发送
            </el-button>
          </div>
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
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick, computed, watch } from 'vue'
import { marked } from 'marked'
import hljs from 'highlight.js'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Delete, Promotion, UserFilled, Service, Plus, Document, View, CopyDocument, EditPen, CircleCloseFilled } from '@element-plus/icons-vue'
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
const sessionFull = ref(false)  // 是否已达对话上限

// 讲义预览
const previewVisible = ref(false)
const previewLecture = ref(null)
const previewLoading = ref(false)
const previewError = ref(false)

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

const currentSessionTitle = computed(() => {
  const current = sessions.value.find(s => s.sessionId === currentSessionId.value)
  return current ? current.title : '知识库问答'
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
    console.log('Loading history for session:', sessionId)
    const res = await ragApi.getHistory(sessionId)
    console.log('History response:', res)
    if (res.code === 0) {
      const raw = res.data || []
      console.log('History raw data count:', raw.length)
      // 解析sources字段（数据库中存为JSON字符串）
      const parsed = raw.map(msg => {
        let sources = msg.sources || []
        if (typeof sources === 'string') {
          try { sources = JSON.parse(sources) } catch { sources = [] }
        }
        return { ...msg, sources }
      })
      console.log('Parsed messages count:', parsed.length)
      // 使用splice替换数组内容以保持响应性（与sendMessage的push一致）
      messages.value.splice(0, messages.value.length, ...parsed)
      console.log('Messages after splice:', messages.value.length)
      checkSessionFull()
      nextTick(() => scrollToBottom())
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

const sendMessage = async () => {
  const q = question.value.trim()
  if (!q || loading.value || sessionFull.value) return

  messages.value.push({
    role: 'user',
    content: q,
    timestamp: Date.now(),
    sources: []
  })

  question.value = ''
  loading.value = true
  scrollToBottom()

  try {
    const res = await ragApi.query({
      question: q,
      sessionId: currentSessionId.value
    })

    if (res.code === 0) {
      const data = res.data
      if (data.sessionId && data.sessionId !== currentSessionId.value) {
        currentSessionId.value = data.sessionId
        await loadSessions()
      }

      messages.value.push({
        role: 'assistant',
        content: data.answer,
        sources: data.sources || [],
        fromKnowledgeBase: data.fromKnowledgeBase !== false,
        timestamp: Date.now()
      })
    } else {
      messages.value.push({
        role: 'assistant',
        content: '抱歉，发生了错误：' + (res.message || '未知错误'),
        sources: [],
        timestamp: Date.now()
      })
    }
  } catch (error) {
    messages.value.push({
      role: 'assistant',
      content: '抱歉，无法连接到服务器，请检查后端服务是否运行。',
      sources: [],
      timestamp: Date.now()
    })
  }

  loading.value = false
  checkSessionFull()
  nextTick(() => scrollToBottom())
}

const openLecture = (source) => {
  if (source.lectureId) {
    window.open(`/student/lecture?lectureId=${source.lectureId}`, '_blank')
  }
}

const clearHistory = () => {
  messages.value = []
  if (currentSessionId.value) {
    ragApi.clearHistory(currentSessionId.value)
  }
}

const scrollToBottom = () => {
  if (messagesContainer.value) {
    messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight
  }
}

const formatMessage = (content) => {
  if (!content) return ''
  return marked.parse(content, { renderer })
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

// 调试：监听messages变化
watch(messages, (newVal) => {
  console.log('[Watch] messages changed, length:', newVal.length)
}, { deep: true })

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
.rag-chat-container {
  display: flex;
  height: calc(100vh - 120px);
  gap: 16px;
}

/* ==================== Sidebar ==================== */
.sidebar {
  width: 260px;
  background: #fff;
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  border: 1px solid #e8ecf0;
  flex-shrink: 0;
}

.sidebar-header {
  padding: 14px 16px;
  border-bottom: 1px solid #f0f2f5;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.sidebar-title {
  font-size: 14px;
  font-weight: 600;
  color: #1f2328;
}

.session-list {
  flex: 1;
  overflow-y: auto;
  padding: 8px;
}

.session-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 12px;
  border-radius: 8px;
  cursor: pointer;
  margin-bottom: 2px;
  transition: background 0.15s;
}

.session-item:hover { background: #f5f7fa; }
.session-item.active { background: #e6f4ea; }

.session-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
  overflow: hidden;
  flex: 1;
  min-width: 0;
}

.session-title {
  font-size: 13px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  color: #303133;
}

.session-time {
  font-size: 11px;
  color: #909399;
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
.chat-area { flex: 1; min-width: 0; }

.chat-card {
  height: 100%;
  display: flex;
  flex-direction: column;
  border-radius: 10px;
  border: 1px solid #e8ecf0;
}

.chat-card :deep(.el-card__body) {
  flex: 1;
  display: flex;
  flex-direction: column;
  padding: 0;
  overflow: hidden;
}

.chat-card :deep(.el-card__header) {
  border-bottom: 1px solid #f0f2f5;
  padding: 12px 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-header .title {
  font-size: 15px;
  font-weight: 600;
  color: #1f2328;
}

.turn-counter {
  font-size: 12px;
  color: #909399;
  margin-right: 8px;
  padding: 2px 10px;
  background: #f0f2f5;
  border-radius: 10px;
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
  padding: 20px 24px;
  display: flex;
  flex-direction: column;
  gap: 20px;
  background: #f5f7fa;
  scroll-behavior: smooth;
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

/* ==================== Message Row ==================== */
.message {
  display: flex;
  gap: 10px;
  max-width: 88%;
  animation: msgFadeIn 0.3s ease;
}

@keyframes msgFadeIn {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

.message.user {
  align-self: flex-end;
  flex-direction: row-reverse;
}

.message.assistant {
  align-self: flex-start;
}

.message-avatar { flex-shrink: 0; margin-top: 2px; }

.message-content {
  display: flex;
  flex-direction: column;
  gap: 3px;
  min-width: 0;
}

.message.user .message-content { align-items: flex-end; }

/* ==================== Message Bubble ==================== */
.message-bubble {
  padding: 12px 18px;
  border-radius: 14px;
  line-height: 1.7;
  font-size: 14px;
  position: relative;
  word-wrap: break-word;
  overflow-wrap: break-word;
}

.message.user .message-bubble {
  background: linear-gradient(135deg, #409eff 0%, #337ecc 100%);
  color: white;
  border-bottom-right-radius: 4px;
}

.message.assistant .message-bubble {
  background: #fff;
  color: #303133;
  border-bottom-left-radius: 4px;
  border: 1px solid #e8ecf0;
}

/* ==================== Message Text Typography ==================== */
.message-text { word-break: break-word; }

.message-text :deep(p) { margin: 8px 0; }
.message-text :deep(p:first-child) { margin-top: 0; }
.message-text :deep(p:last-child) { margin-bottom: 0; }

/* Headings in AI answers */
.message-text :deep(h1),
.message-text :deep(h2),
.message-text :deep(h3),
.message-text :deep(h4) {
  margin: 18px 0 8px;
  font-weight: 600;
  color: #1f2328;
  line-height: 1.4;
}
.message-text :deep(h1) { font-size: 1.35em; padding-bottom: 6px; border-bottom: 1px solid #e8ecf0; }
.message-text :deep(h2) { font-size: 1.2em; }
.message-text :deep(h3) { font-size: 1.1em; }
.message-text :deep(h1:first-child) { margin-top: 0; }

.message.user .message-text :deep(h1),
.message.user .message-text :deep(h2),
.message.user .message-text :deep(h3) {
  color: rgba(255,255,255,0.95);
  border-bottom-color: rgba(255,255,255,0.2);
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

.message.user .message-text :deep(code) {
  background: rgba(255,255,255,0.18);
  color: rgba(255,255,255,0.92);
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
  background: rgba(255,255,255,0.1);
  border-left-color: rgba(255,255,255,0.5);
  color: rgba(255,255,255,0.9);
}

/* Strong / emphasis */
.message-text :deep(strong) { font-weight: 600; color: #1f2328; }
.message.user .message-text :deep(strong) { color: rgba(255,255,255,0.95); }

/* Horizontal rule */
.message-text :deep(hr) {
  margin: 14px 0;
  border: none;
  border-top: 1px solid #e0e4e8;
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

/* ==================== Input Area ==================== */
.chat-input-area {
  padding: 14px 20px 16px;
  border-top: 1px solid #f0f2f5;
  background: #fff;
}

.chat-input-area :deep(.el-textarea__inner) {
  border-radius: 10px;
  resize: none;
  padding: 10px 14px;
  font-size: 14px;
  line-height: 1.6;
  transition: border-color 0.2s;
}

.chat-input-area :deep(.el-textarea__inner:focus) {
  border-color: #409eff;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.08);
}

.input-actions {
  margin-top: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.hint { font-size: 12px; color: #909399; }

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
</style>
