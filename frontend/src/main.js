import { createApp } from 'vue'
import { createPinia } from 'pinia'
import ElementPlus from 'element-plus'
import { ElMessage } from 'element-plus'
import 'element-plus/dist/index.css'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import App from './App.vue'
import router from './router'
import Breadcrumb from './components/Breadcrumb.vue'
import '@/styles/global.scss'

const app = createApp(App)

// 重要：必须先安装 pinia，再安装 router
const pinia = createPinia()

// 注册所有Element Plus图标
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component)
}

// 注册全局组件
app.component('Breadcrumb', Breadcrumb)

// 安装顺序很重要：pinia 必须在 router 之前
app.use(pinia)
app.use(router)
app.use(ElementPlus)
app.use(ElMessage)

app.mount('#app')
