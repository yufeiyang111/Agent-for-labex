<template>
  <div class="tc-card" :class="'tc-' + call.status">
    <div class="tc-header" @click="expanded = !expanded">
      <div class="tc-icon-wrap">
        <svg v-if="call.status === 'running'" class="tc-spin" width="14" height="14" viewBox="0 0 24 24" fill="none" :stroke="statusColor" stroke-width="2"><path d="M21 12a9 9 0 1 1-6.219-8.56"/></svg>
        <svg v-else-if="call.status === 'completed'" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#10b981" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg>
        <svg v-else-if="call.status === 'error'" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#ef4444" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
        <svg v-else width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
      </div>
      <div class="tc-info">
        <span class="tc-name">{{ toolLabel }}</span>
        <span class="tc-summary" v-if="call.summary">{{ call.summary }}</span>
      </div>
      <div class="tc-toggle">
        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="2" :style="{ transform: expanded ? 'rotate(180deg)' : '' }"><polyline points="6 9 12 15 18 9"/></svg>
      </div>
    </div>

    <Transition name="tc-slide">
      <div v-if="expanded" class="tc-body">
        <!-- Args Section -->
        <div v-if="call.args" class="tc-section">
          <div class="tc-section-label">参数</div>
          <div class="tc-args">
            <template v-if="isEditTool">
              <div class="tc-arg-row" v-if="argsObj.path || argsObj.file_path">
                <span class="tc-arg-key">文件</span>
                <span class="tc-arg-val tc-arg-file">{{ argsObj.path || argsObj.file_path }}</span>
              </div>
              <div class="tc-arg-row" v-if="argsObj.old_string || argsObj.old_text">
                <span class="tc-arg-key">查找</span>
                <pre class="tc-arg-code">{{ truncate(argsObj.old_string || argsObj.old_text, 200) }}</pre>
              </div>
              <div class="tc-arg-row" v-if="argsObj.new_string || argsObj.new_text">
                <span class="tc-arg-key">替换</span>
                <pre class="tc-arg-code">{{ truncate(argsObj.new_string || argsObj.new_text, 200) }}</pre>
              </div>
            </template>
            <template v-else-if="isShellTool">
              <div class="tc-arg-row">
                <span class="tc-arg-key">命令</span>
                <code class="tc-arg-cmd">{{ argsObj.command || argsObj.cmd }}</code>
              </div>
              <div class="tc-arg-row" v-if="argsObj.description">
                <span class="tc-arg-key">说明</span>
                <span class="tc-arg-val">{{ argsObj.description }}</span>
              </div>
            </template>
            <template v-else-if="isReadTool">
              <div class="tc-arg-row">
                <span class="tc-arg-key">文件</span>
                <span class="tc-arg-val tc-arg-file">{{ argsObj.path || argsObj.file_path }}</span>
              </div>
            </template>
            <template v-else-if="isSearchTool">
              <div class="tc-arg-row">
                <span class="tc-arg-key">模式</span>
                <code class="tc-arg-cmd">{{ argsObj.pattern || argsObj.query }}</code>
              </div>
              <div class="tc-arg-row" v-if="argsObj.path || argsObj.directory">
                <span class="tc-arg-key">目录</span>
                <span class="tc-arg-val tc-arg-file">{{ argsObj.path || argsObj.directory }}</span>
              </div>
            </template>
            <template v-else>
              <pre class="tc-args-json">{{ formatJson(call.args) }}</pre>
            </template>
          </div>
        </div>

        <!-- Result Section -->
        <div v-if="call.result" class="tc-section">
          <div class="tc-section-label">结果</div>
          <div v-if="isShellTool" class="tc-shell-output">
            <pre>{{ truncate(call.result, 1000) }}</pre>
          </div>
          <div v-else-if="hasDiff" class="tc-diff-wrap">
            <DiffViewer :diff="extractDiff(call.result)" />
          </div>
          <div v-else class="tc-result-text">
            <pre>{{ truncate(call.result, 1000) }}</pre>
          </div>
        </div>

        <div v-if="isPermissionAsk" class="tc-approval">
          <div class="tc-approval-title">需要确认后才能继续执行</div>
          <div class="tc-approval-actions">
            <button type="button" class="tc-approval-btn primary" @click.stop="emitPermission('once')">允许一次</button>
            <button type="button" class="tc-approval-btn" @click.stop="emitPermission('always')">始终允许</button>
            <button type="button" class="tc-approval-btn danger" @click.stop="emitPermission('reject')">拒绝</button>
          </div>
        </div>
      </div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import DiffViewer from './DiffViewer.vue'

const props = defineProps({
  call: { type: Object, required: true }
})

const emit = defineEmits(['permission'])

const expanded = ref(props.call.status === 'error' || props.call.status === 'waiting_approval')

const toolMap = {
  read_file: '读取文件', edit_file: '编辑文件', write_file: '写入文件',
  apply_patch: '应用补丁', list_files: '列出文件', glob: '搜索文件',
  grep: '搜索内容', search_code: '搜索代码', bash: '执行命令',
  run_command: '执行命令', execute_code: '执行代码', run_tests: '运行测试',
  create_plan: '创建计划', plan: '计划', todo_write: '更新待办',
  retrieve_context: '检索上下文', question: '提问',
  web_search: '网络搜索', web_fetch: '获取网页',
  lsp_symbols: 'LSP符号', project_overview: '项目概览',
  skill: '加载技能', task: '子任务', repo_clone: '克隆仓库',
  external_directory: '外部目录'
}
const toolLabel = computed(() => toolMap[props.call.name] || props.call.name)
const statusColor = computed(() => {
  if (props.call.status === 'running') return '#3b82f6'
  if (props.call.status === 'error') return '#ef4444'
  if (props.call.status === 'waiting_approval') return '#f59e0b'
  return '#10b981'
})
const isPermissionAsk = computed(() => props.call.status === 'waiting_approval' && !!props.call.permissionRequest)

const isEditTool = computed(() => ['edit_file', 'write_file', 'apply_patch'].includes(props.call.name))
const isShellTool = computed(() => ['bash', 'run_command', 'execute_code', 'run_tests'].includes(props.call.name))
const isReadTool = computed(() => ['read_file', 'retrieve_context'].includes(props.call.name))
const isSearchTool = computed(() => ['list_files', 'glob', 'grep', 'search_code', 'lsp_symbols'].includes(props.call.name))

const argsObj = computed(() => {
  if (typeof props.call.args === 'string') {
    try { return JSON.parse(props.call.args) } catch { return {} }
  }
  return props.call.args || {}
})

const hasDiff = computed(() => {
  const r = props.call.result || ''
  return r.includes('---') && r.includes('+++') && r.includes('@@')
})

function extractDiff(text) {
  const match = text.match(/((?:---.*\n\+\+\+.*\n[\s\S]*?(?=---|\Z))|(?:diff[\s\S]*?(?=diff|\Z)))/)
  return match ? match[0] : text
}

function formatJson(obj) {
  if (typeof obj === 'string') return obj
  try { return JSON.stringify(obj, null, 2) } catch { return String(obj) }
}

function truncate(text, max) {
  if (!text) return ''
  text = String(text)
  return text.length > max ? text.slice(0, max) + '...' : text
}

function emitPermission(action) {
  emit('permission', { call: props.call, action })
}
</script>

<style scoped>
.tc-card {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  margin: 6px 0;
  overflow: hidden;
  transition: border-color 0.15s;
}
.tc-card.tc-running { border-color: #93c5fd; }
.tc-card.tc-error { border-color: #fca5a5; }
.tc-card.tc-waiting_approval { border-color: #fbbf24; }
.tc-header {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 10px;
  cursor: pointer;
  user-select: none;
  transition: background 0.1s;
}
.tc-header:hover { background: #f9fafb; }
.tc-icon-wrap {
  width: 22px;
  height: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}
.tc-spin { animation: tcSpin 1s linear infinite; }
@keyframes tcSpin { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }
.tc-info {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 1px;
}
.tc-name {
  font-size: 12px;
  font-weight: 600;
  color: #374151;
}
.tc-summary {
  font-size: 11px;
  color: #6b7280;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.tc-toggle { flex-shrink: 0; }
.tc-body {
  border-top: 1px solid #f0f0f0;
  padding: 8px 10px;
}
.tc-section { margin-bottom: 8px; }
.tc-section:last-child { margin-bottom: 0; }
.tc-section-label {
  font-size: 10px;
  font-weight: 600;
  color: #9ca3af;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 4px;
}
.tc-arg-row {
  display: flex;
  align-items: flex-start;
  gap: 8px;
  margin-bottom: 4px;
}
.tc-arg-key {
  font-size: 11px;
  font-weight: 600;
  color: #6b7280;
  min-width: 32px;
  flex-shrink: 0;
  padding-top: 2px;
}
.tc-arg-val {
  font-size: 12px;
  color: #374151;
  word-break: break-all;
}
.tc-arg-file {
  font-family: 'JetBrains Mono', monospace;
  color: #6366f1;
  font-size: 11px;
}
.tc-arg-code {
  font-family: 'JetBrains Mono', monospace;
  font-size: 11px;
  background: #f3f4f6;
  padding: 4px 8px;
  border-radius: 4px;
  margin: 0;
  white-space: pre-wrap;
  word-break: break-all;
  max-height: 120px;
  overflow-y: auto;
  flex: 1;
}
.tc-arg-cmd {
  font-family: 'JetBrains Mono', monospace;
  font-size: 12px;
  background: #1e293b;
  color: #e2e8f0;
  padding: 4px 8px;
  border-radius: 4px;
  display: inline-block;
}
.tc-args-json {
  font-family: 'JetBrains Mono', monospace;
  font-size: 11px;
  background: #f3f4f6;
  padding: 6px 8px;
  border-radius: 4px;
  margin: 0;
  max-height: 200px;
  overflow-y: auto;
  white-space: pre-wrap;
  word-break: break-all;
}
.tc-shell-output pre,
.tc-result-text pre {
  font-family: 'JetBrains Mono', monospace;
  font-size: 11px;
  background: #1e293b;
  color: #e2e8f0;
  padding: 8px 10px;
  border-radius: 6px;
  margin: 0;
  max-height: 300px;
  overflow-y: auto;
  white-space: pre-wrap;
  word-break: break-all;
}
.tc-diff-wrap { margin-top: 4px; }

.tc-approval {
  margin-top: 10px;
  padding: 10px;
  border-radius: 8px;
  background: #fff8e6;
  border: 1px solid #fde68a;
}

.tc-approval-title {
  font-size: 12px;
  font-weight: 600;
  color: #92400e;
  margin-bottom: 8px;
}

.tc-approval-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.tc-approval-btn {
  height: 28px;
  border: 1px solid #d1d5db;
  border-radius: 7px;
  background: #fff;
  color: #374151;
  font-size: 12px;
  cursor: pointer;
  padding: 0 10px;
}

.tc-approval-btn.primary {
  background: #111827;
  border-color: #111827;
  color: #fff;
}

.tc-approval-btn.danger {
  color: #b91c1c;
  border-color: #fecaca;
  background: #fff5f5;
}

.tc-slide-enter-active { transition: all 0.2s ease; }
.tc-slide-leave-active { transition: all 0.15s ease; }
.tc-slide-enter-from, .tc-slide-leave-to { opacity: 0; max-height: 0; }
</style>
