<template>
  <div class="monaco-wrapper" :style="{ height: height }">
    <VueMonacoEditor
      :value="modelValue"
      @update:value="$emit('update:modelValue', $event)"
      :language="language"
      :theme="theme"
      :options="editorOptions"
      @mount="handleMount"
    />
  </div>
</template>

<script setup>
import { computed } from "vue"
import { VueMonacoEditor } from "@guolao/vue-monaco-editor"

const props = defineProps({
  modelValue: { type: String, default: "" },
  language: { type: String, default: "java" },
  height: { type: String, default: "400px" },
  readOnly: { type: Boolean, default: false },
  theme: { type: String, default: "vs" }
})

const emit = defineEmits(["update:modelValue", "mount"])

const editorOptions = computed(() => ({
  minimap: { enabled: false },
  lineNumbers: "on",
  scrollBeyondLastLine: false,
  automaticLayout: true,
  fontSize: 13,
  tabSize: 4,
  readOnly: props.readOnly,
  wordWrap: "on",
  padding: { top: 8 }
}))

function handleMount(editor) {
  emit("mount", editor)
}
</script>

<style scoped>
.monaco-wrapper {
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  overflow: hidden;
}
</style>