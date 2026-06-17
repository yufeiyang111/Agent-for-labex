<template>
  <div class="course-list-page wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <h2 class="page-title">课程管理</h2>
        <el-button type="primary" :icon="Plus" @click="onCreate" class="wabi-btn-primary">
          新建课程
        </el-button>
      </div>

      <!-- 列表容器 -->
      <div class="list-container">
        <div class="list-content" v-loading="loading">
          <div v-if="!loading && !courses.length" class="list-empty">
            <el-empty description="还没有课程">
              <el-button type="primary" @click="onCreate" class="wabi-btn-primary">新建课程</el-button>
            </el-empty>
          </div>
          <div v-else class="course-grid">
            <div v-for="course in courses" :key="course.courseId" class="course-card">
              <div class="course-header">
                <span class="course-code">{{ course.code }}</span>
                <span class="wabi-tag">{{ course.credit }} 学分</span>
              </div>
              <h3 class="course-name">{{ course.nameCn }}</h3>
              <div class="course-meta">
                <span>{{ course.hours }} 学时</span>
                <span>{{ course.major }}</span>
              </div>
              <div class="course-actions">
                <el-button size="small" text @click="onEdit(course)" class="wabi-btn-text">编辑</el-button>
                <el-button size="small" text @click="onSyllabus(course)" class="wabi-btn-text">大纲</el-button>
                <el-button size="small" text @click="onObjective(course)" class="wabi-btn-text">目标</el-button>
                <el-button size="small" text @click="onOffering(course)" class="wabi-btn-text">开课</el-button>
                <el-popconfirm :title="`确定删除「${course.nameCn}」?`" @confirm="onDelete(course)">
                  <template #reference>
                    <el-button size="small" text type="danger" class="wabi-btn-text wabi-btn-danger">删除</el-button>
                  </template>
                </el-popconfirm>
              </div>
            </div>
          </div>
        </div>

        <!-- 分页 -->
        <div class="list-pagination" v-if="pagination.total > 0">
          <el-pagination
            v-model:current-page="pagination.page"
            v-model:page-size="pagination.pageSize"
            :page-sizes="[20, 40, 60, 100]"
            :total="pagination.total"
            layout="total, sizes, prev, pager, next, jumper"
            @size-change="fetch"
            @current-change="fetch"
          />
        </div>
      </div>
    </div>

    <!-- 新建/编辑课程弹窗 -->
    <el-dialog v-model="dialogVisible" :title="form.courseId ? '编辑课程' : '新建课程'" width="600" class="wabi-dialog">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100" class="wabi-form">
        <el-form-item label="课程编号" prop="code">
          <el-input v-model="form.code" placeholder="如 CS101" />
        </el-form-item>
        <el-form-item label="中文名" prop="nameCn">
          <el-input v-model="form.nameCn" />
        </el-form-item>
        <el-form-item label="英文名">
          <el-input v-model="form.nameEn" />
        </el-form-item>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="学分" prop="credit">
              <el-input-number v-model="form.credit" :min="0.5" :max="10" :step="0.5" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="总学时" prop="hours">
              <el-input-number v-model="form.hours" :min="1" :max="300" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="理论学时">
              <el-input-number v-model="form.theoryHours" :min="0" :max="300" style="width: 100%" @change="onSubHoursChange" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="实验学时">
              <el-input-number v-model="form.labHours" :min="0" :max="300" style="width: 100%" @change="onSubHoursChange" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="适用专业">
          <el-input v-model="form.major" />
        </el-form-item>
        <el-form-item label="先修课程">
          <el-input v-model="form.prerequisite" />
        </el-form-item>
        <el-form-item label="开课系">
          <el-input v-model="form.department" />
        </el-form-item>
        <el-form-item label="课程简介">
          <el-input v-model="form.intro" type="textarea" :rows="4" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="onSave" class="wabi-btn-primary">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { courseApi } from '@/api'

const router = useRouter()
const courses = ref([])
const loading = ref(false)
const dialogVisible = ref(false)
const formRef = ref()
const form = ref({})

const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const rules = {
  code: [{ required: true, message: '请输入课程编号', trigger: 'blur' }],
  nameCn: [{ required: true, message: '请输入中文名', trigger: 'blur' }],
  credit: [{ required: true, message: '请输入学分', trigger: 'change' }],
  hours: [{ required: true, message: '请输入总学时', trigger: 'change' }]
}

const newForm = () => ({
  code: '', nameCn: '', nameEn: '', credit: 2, hours: 32,
  theoryHours: 24, labHours: 8, major: '软件工程',
  prerequisite: '', department: '软件工程', intro: ''
})

const fetch = async () => {
  loading.value = true
  try {
    const res = await courseApi.list({
      pageNum: pagination.page,
      pageSize: pagination.pageSize
    })
    if (res.data?.list) {
      courses.value = res.data.list
      pagination.total = res.data.total || 0
    } else {
      courses.value = res.data || []
      pagination.total = courses.value.length
    }
  } finally {
    loading.value = false
  }
}
onMounted(fetch)

const onCreate = () => {
  form.value = newForm()
  dialogVisible.value = true
}

const onEdit = (row) => {
  form.value = { ...row }
  dialogVisible.value = true
}

const onSubHoursChange = () => {
  const sum = Number(form.value.theoryHours || 0) + Number(form.value.labHours || 0)
  if (!form.value.hours || form.value.hours < sum) {
    form.value.hours = sum
  }
}

const onSave = async () => {
  await formRef.value.validate()
  if (form.value.courseId) {
    await courseApi.update(form.value.courseId, form.value)
    ElMessage.success('已更新')
  } else {
    await courseApi.create(form.value)
    ElMessage.success('已创建')
  }
  dialogVisible.value = false
  fetch()
}

const onDelete = async (row) => {
  await courseApi.remove(row.courseId)
  ElMessage.success('已删除')
  fetch()
}

const onSyllabus = (row) => router.push(`/teacher/course/${row.courseId}/syllabus`)
const onObjective = (row) => router.push(`/teacher/objective/${row.courseId}`)
const onOffering = (row) => router.push(`/teacher/offering?courseId=${row.courseId}`)
</script>

<style scoped>
.course-list-page {
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
}

.page-title {
  font-size: 18px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0;
}

/* 列表容器 */
.list-container {
  flex: 1;
  min-height: 0;
  display: flex;
  flex-direction: column;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: var(--wabi-radius, 3px);
  overflow: hidden;
}

.list-content {
  flex: 1;
  min-height: 0;
  overflow-y: auto;
  padding: 20px;
}

.list-empty {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  min-height: 200px;
}

/* 分页 */
.list-pagination {
  flex-shrink: 0;
  display: flex;
  justify-content: center;
  padding: 16px 20px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
  background: var(--wabi-surface-warm, #faf9f7);
}

/* 课程网格 */
.course-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 16px;
}

.course-card {
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  padding: 20px;
  transition: all 0.2s ease;
}

.course-card:hover {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  border-color: var(--wabi-accent, #7a8b6f);
}

.course-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.course-code {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  font-family: monospace;
}

.course-name {
  font-size: 16px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
  margin: 0 0 8px 0;
  line-height: 1.4;
}

.course-meta {
  display: flex;
  gap: 12px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-bottom: 16px;
}

.course-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 4px;
  border-top: 1px solid var(--wabi-border, #e8e4df);
  padding-top: 12px;
}

/* 标签 */
.wabi-tag {
  display: inline-block;
  padding: 2px 8px;
  background: var(--wabi-border-light, #f0ece8);
  color: var(--wabi-text-secondary, #8a8580);
  font-size: 12px;
  border-radius: 2px;
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

.wabi-btn-danger:hover {
  color: #c47c7c;
}

/* 响应式 */
@media (max-width: 768px) {
  .wabi-body {
    padding: 16px;
  }

  .course-grid {
    grid-template-columns: 1fr;
  }
}
</style>
