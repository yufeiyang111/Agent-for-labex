<template>
  <div class="ws-shell">
    <header class="ws-topbar">
      <button class="ws-btn ws-btn-ghost" @click="goBack">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="15 18 9 12 15 6"/></svg>
        <span>返回</span>
      </button>
      <div class="ws-title-section">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#6366f1" stroke-width="2"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/></svg>
        <span class="ws-title">{{ projectName || '工作空间' }}</span>
      </div>
      <div class="ws-topbar-right">
        <span v-if="fileContentDirty" class="ws-unsaved">未保存</span>
        <button v-if="activePath" class="ws-btn ws-btn-outline ws-btn-sm" @click="saveFile" :disabled="savingFile">{{ savingFile ? '保存中...' : '保存' }}</button>
      </div>
    </header>
    <div class="ws-body">
      <aside class="ws-sidebar">
        <div class="ws-sidebar-header">
          <span>文件资源管理器</span>
          <button class="ws-btn ws-btn-ghost ws-btn-sm" @click="loadRoot"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 4 23 10 17 10"/><path d="M20.49 15a9 9 0 1 1-2.12-9.36L23 10"/></svg></button>
        </div>
        <div class="ws-tree" v-loading="treeLoading">
          <FileTreeNode v-for="child in fileTree" :key="child.path" :node="child" :selected-path="activePath" :load-children="loadChildren" @select="openFile"/>
          <div v-if="!treeLoading && fileTree.length === 0" class="ws-tree-empty">暂无文件</div>
        </div>
      </aside>
      <main class="ws-editor">
        <div v-if="!activePath" class="ws-editor-empty">
          <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#e5e7eb" stroke-width="1"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
          <p>选择文件开始编辑</p>
          <p class="ws-editor-hint">从左侧文件树中选择一个文件</p>
        </div>
        <template v-else>
          <div class="ws-editor-tabs">
            <div class="ws-tab active">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
              <span>{{ fileName }}</span>
              <span class="ws-tab-path">{{ activePath }}</span>
            </div>
          </div>
          <div class="ws-monaco"><MonacoEditor v-if="editorReady" v-model="fileContent" :language="detectedLang" height="100%"/></div>
        </template>
      </main>
      <aside class="ws-agent">
        <div class="ws-agent-header">
          <div class="ws-agent-title">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#6366f1" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
            <span>Labex 编程助手</span>
          </div>
          <button class="ws-btn ws-btn-ghost ws-btn-sm" @click="messages = []"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg></button>
        </div>
        <div class="ws-agent-messages" ref="msgContainer">
          <div v-if="messages.length === 0" class="ws-agent-empty">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#e5e7eb" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><path d="M8 14s1.5 2 4 2 4-2 4-2"/><line x1="9" y1="9" x2="9.01" y2="9"/><line x1="15" y1="9" x2="15.01" y2="9"/></svg>
            <p>向编程助手提问，获取代码帮助</p>
          </div>
          <TransitionGroup name="msg" tag="div" class="ws-msg-list">
            <div v-for="(msg, i) in messages" :key="i" class="ws-msg" :class="msg.role"><div class="ws-msg-bubble"><div class="ws-msg-text">{{ msg.content }}</div></div></div>
          </TransitionGroup>
          <div v-if="agentLoading" class="ws-msg assistant"><div class="ws-msg-bubble"><div class="ws-thinking"><span class="ws-dot"></span><span class="ws-dot"></span><span class="ws-dot"></span></div></div></div>
        </div>
        <div class="ws-agent-input">
          <textarea v-model="agentInput" class="ws-textarea" rows="2" :placeholder="'输入问题，例如：这段代码有什么问题？'" @keydown.enter.exact="sendMessage" :disabled="agentLoading"/>
          <button class="ws-btn ws-btn-primary ws-btn-sm ws-send" @click="sendMessage" :disabled="agentLoading || !agentInput.trim()">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>
          </button>
        </div>
      </aside>
    </div>
  </div>
</template>
<script setup>
import { ref, computed, onMounted, nextTick, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { projectApi } from '@/api'
import FileTreeNode from '@/components/cloud/FileTreeNode.vue'
import MonacoEditor from '@/components/MonacoEditor.vue'
const route = useRoute()
const router = useRouter()
const projectId = ref(null)
const projectName = ref('')
const fileTree = ref([])
const activePath = ref('')
const fileContent = ref('')
const fileContentDirty = ref(false)
const savingFile = ref(false)
const editorReady = ref(false)
const treeLoading = ref(false)
const messages = ref([])
const agentInput = ref('')
const agentLoading = ref(false)
const msgContainer = ref(null)
const detectedLang = ref('plaintext')
const langMap = { js: 'javascript', jsx: 'javascript', ts: 'typescript', tsx: 'typescript', vue: 'html', py: 'python', java: 'java', c: 'c', cpp: 'cpp', html: 'html', css: 'css', scss: 'scss', json: 'json', xml: 'xml', yml: 'yaml', yaml: 'yaml', md: 'markdown', sql: 'sql', sh: 'shell', bat: 'shell', ps1: 'powershell', go: 'go', rs: 'rust', php: 'php' }
const fileName = computed(() => { const p = activePath.value; return p ? p.split('/')?.pop() || '' : '' })
onMounted(async () => { const pid = route.params.projectId; if (!pid) { ElMessage.error('项目ID不存在'); router.replace({ name: 'StudentCloudSpace' }); return }; projectId.value = parseInt(pid); try { const r = await projectApi.detail(projectId.value); projectName.value = r.data?.projectName || '未命名项目' } catch (e) { ElMessage.error('无法加载项目信息'); router.replace({ name: 'StudentCloudSpace' }); return }; await loadRoot() })
async function loadRoot() { if (!projectId.value) return; treeLoading.value = true; try { const r = await projectApi.getTree(projectId.value, ''); fileTree.value = r.data || [] } catch (e) { fileTree.value = [] } finally { treeLoading.value = false } }
async function loadChildren(dirPath) { if (!projectId.value) return []; try { const r = await projectApi.getTree(projectId.value, dirPath); return r.data || [] } catch (e) { return [] } }
async function openFile(path) { if (!projectId.value) return; activePath.value = path; editorReady.value = false; try { const r = await projectApi.readFile(projectId.value, path); fileContent.value = r.data?.content || ''; fileContentDirty.value = false; const ext = path.split('.').pop()?.toLowerCase(); detectedLang.value = langMap[ext] || 'plaintext' } catch (e) { fileContent.value = '' }; await nextTick(); editorReady.value = true }
async function saveFile() { if (!projectId.value || !activePath.value || savingFile.value) return; savingFile.value = true; try { await projectApi.saveFile(projectId.value, activePath.value, fileContent.value); fileContentDirty.value = false; ElMessage.success('文件已保存') } catch (e) { ElMessage.error('保存失败') } finally { savingFile.value = false } }
watch(fileContent, (val, old) => { if (old !== undefined && val !== old) { fileContentDirty.value = true } })
async function sendMessage() { const q = agentInput.value.trim(); if (!q || agentLoading.value) return; messages.value.push({ role: 'user', content: q }); agentInput.value = ''; agentLoading.value = true; await nextTick(); scrollDown(); try { const r = await projectApi.askAgent(projectId.value, { path: activePath.value || '', question: q, mode: 'code' }); messages.value.push({ role: 'assistant', content: r.data?.answer || '(无响应)' }) } catch (e) { messages.value.push({ role: 'assistant', content: '错误: ' + (e?.response?.data?.message || e?.message || '请求失败') }) } finally { agentLoading.value = false; await nextTick(); scrollDown() } }
function scrollDown() { if (msgContainer.value) { msgContainer.value.scrollTop = msgContainer.value.scrollHeight } }
function goBack() { router.push({ name: 'StudentCloudSpace' }) }
</script>
<style scoped>
.ws-shell { display: flex; flex-direction: column; height: 100vh; background: #fff; }
.ws-topbar { display: flex; align-items: center; gap: 12px; padding: 0 16px; height: 44px; background: #fafbfc; border-bottom: 1px solid #f0f0f0; flex-shrink: 0; }
.ws-title-section { display: flex; align-items: center; gap: 6px; flex: 1; }
.ws-title { font-size: 13px; font-weight: 600; color: #111827; }
.ws-topbar-right { display: flex; align-items: center; gap: 8px; }
.ws-unsaved { font-size: 11px; color: #f59e0b; background: #fef3c7; padding: 2px 8px; border-radius: 4px; }
.ws-body { flex: 1; display: flex; overflow: hidden; }
.ws-sidebar { width: 240px; border-right: 1px solid #f0f0f0; display: flex; flex-direction: column; background: #fafbfc; flex-shrink: 0; }
.ws-sidebar-header { display: flex; align-items: center; justify-content: space-between; padding: 10px 12px; font-size: 11px; font-weight: 600; color: #9ca3af; text-transform: uppercase; letter-spacing: 0.5px; border-bottom: 1px solid #f0f0f0; }
.ws-tree { flex: 1; overflow-y: auto; padding: 6px 4px; }
.ws-tree-empty { padding: 16px; color: #9ca3af; font-size: 13px; text-align: center; }
.ws-editor { flex: 1; display: flex; flex-direction: column; overflow: hidden; background: #fff; min-width: 0; }
.ws-editor-empty { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 8px; color: #9ca3af; font-size: 13px; }
.ws-editor-hint { font-size: 12px; color: #d1d5db; }
.ws-editor-tabs { display: flex; border-bottom: 1px solid #f0f0f0; background: #fafbfc; padding: 0 8px; flex-shrink: 0; }
.ws-tab { display: flex; align-items: center; gap: 6px; padding: 7px 14px; font-size: 12px; color: #374151; border-bottom: 2px solid transparent; cursor: default; }
.ws-tab.active { color: #111827; border-bottom-color: #6366f1; background: #fff; }
.ws-tab-path { font-size: 11px; color: #9ca3af; margin-left: 4px; }
.ws-monaco { flex: 1; overflow: hidden; }
.ws-agent { width: 340px; border-left: 1px solid #f0f0f0; display: flex; flex-direction: column; background: #fafbfc; flex-shrink: 0; }
.ws-agent-header { display: flex; align-items: center; justify-content: space-between; padding: 10px 12px; border-bottom: 1px solid #f0f0f0; }
.ws-agent-title { display: flex; align-items: center; gap: 6px; font-size: 12px; font-weight: 600; color: #111827; }
.ws-agent-messages { flex: 1; overflow-y: auto; padding: 12px; }
.ws-agent-empty { display: flex; flex-direction: column; align-items: center; gap: 8px; padding: 32px 16px; color: #9ca3af; font-size: 12px; text-align: center; }
.ws-msg-list { display: flex; flex-direction: column; gap: 8px; }
.ws-msg { max-width: 100%; animation: msgIn 0.2s ease; }
@keyframes msgIn { from { opacity: 0; transform: translateY(6px); } to { opacity: 1; transform: translateY(0); } }
.ws-msg.user .ws-msg-bubble { background: #4f46e5; color: #fff; border-radius: 12px 12px 4px 12px; margin-left: 32px; }
.ws-msg.assistant .ws-msg-bubble { background: #fff; color: #374151; border: 1px solid #e5e7eb; border-radius: 12px 12px 12px 4px; margin-right: 32px; }
.ws-msg-bubble { padding: 10px 14px; }
.ws-msg-text { font-size: 13px; line-height: 1.6; white-space: pre-wrap; word-break: break-word; }
.ws-thinking { display: flex; gap: 4px; padding: 4px 0; }
.ws-dot { width: 6px; height: 6px; background: #9ca3af; border-radius: 50%; animation: dotPulse 1.4s ease-in-out infinite; }
.ws-dot:nth-child(2) { animation-delay: 0.2s; }
.ws-dot:nth-child(3) { animation-delay: 0.4s; }
@keyframes dotPulse { 0%, 80%, 100% { transform: scale(0.6); opacity: 0.4; } 40% { transform: scale(1); opacity: 1; } }
.ws-agent-input { display: flex; gap: 8px; padding: 10px 12px; border-top: 1px solid #f0f0f0; background: #fff; }
.ws-textarea { flex: 1; border: 1px solid #e5e7eb; border-radius: 8px; padding: 8px 10px; font-size: 13px; resize: none; outline: none; font-family: inherit; transition: border-color 0.2s; }
.ws-textarea:focus { border-color: #6366f1; }
.ws-send { align-self: flex-end; padding: 8px 10px !important; }
.ws-btn { display: inline-flex; align-items: center; gap: 4px; border: none; border-radius: 6px; cursor: pointer; font-size: 12px; font-weight: 500; padding: 6px 10px; transition: all 0.15s ease; font-family: inherit; background: transparent; color: #374151; }
.ws-btn svg { flex-shrink: 0; }
.ws-btn:hover { background: #f3f4f6; }
.ws-btn-primary { background: #4f46e5; color: #fff; }
.ws-btn-primary:hover { background: #4338ca; }
.ws-btn-outline { background: #fff; border: 1px solid #e5e7eb; }
.ws-btn-outline:hover { background: #f9fafb; }
.ws-btn-ghost { padding: 4px 6px; color: #6b7280; }
.ws-btn-ghost:hover { background: #f3f4f6; color: #111827; }
.ws-btn-sm { padding: 5px 10px; font-size: 12px; }
.ws-btn:disabled { opacity: 0.4; cursor: not-allowed; }
.msg-enter-active { transition: all 0.3s ease; }
.msg-leave-active { transition: all 0.2s ease; }
.msg-enter-from { opacity: 0; transform: translateY(10px); }
.msg-leave-to { opacity: 0; }
</style>