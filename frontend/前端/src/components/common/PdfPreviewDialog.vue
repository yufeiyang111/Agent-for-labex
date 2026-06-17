<template>
  <el-dialog
    v-model="visible"
    :title="title"
    width="80%"
    top="5vh"
    :close-on-click-modal="false"
    @closed="cleanup"
  >
    <div v-loading="loading" class="preview-container">
      <iframe v-if="blobUrl" :src="blobUrl" class="preview-frame" />
      <el-empty v-else-if="!loading" :description="errorMsg || '暂无内容'" />
    </div>
    <template #footer>
      <el-button @click="visible = false">关闭</el-button>
      <el-button type="primary" :loading="loading" @click="load">刷新</el-button>
      <el-button type="success" :disabled="!blobUrl" @click="download">下载</el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, watch } from 'vue'
import { ElMessage } from 'element-plus'

const props = defineProps({
  modelValue: { type: Boolean, default: false },
  title: { type: String, default: '预览' },
  /** 后端完整 API 路径（不带 /api 前缀，fetch 时会自带 /api） */
  url: { type: String, required: true },
  /** 触发下载时的文件名 */
  downloadName: { type: String, default: 'download.bin' }
})
const emit = defineEmits(['update:modelValue'])

const visible = ref(false)
const loading = ref(false)
const blobUrl = ref('')
const errorMsg = ref('')

watch(() => props.modelValue, (v) => { visible.value = v; if (v) load() })
watch(visible, (v) => emit('update:modelValue', v))

function cleanup() {
  if (blobUrl.value) {
    URL.revokeObjectURL(blobUrl.value)
    blobUrl.value = ''
  }
  errorMsg.value = ''
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
    blobUrl.value = URL.createObjectURL(blob)
  } catch (e) {
    console.error('Preview load error', e)
    errorMsg.value = e.message || '加载失败'
    ElMessage.error(errorMsg.value)
  } finally {
    loading.value = false
  }
}

function download() {
  if (!blobUrl.value) return
  const a = document.createElement('a')
  a.href = blobUrl.value
  a.download = props.downloadName
  document.body.appendChild(a)
  a.click()
  document.body.removeChild(a)
}
</script>

<style scoped>
.preview-container { min-height: 60vh; }
.preview-frame {
  width: 100%;
  height: 70vh;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  background: #fff;
}
</style>
