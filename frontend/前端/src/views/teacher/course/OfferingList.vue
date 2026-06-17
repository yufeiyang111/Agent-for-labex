<template>
  <div class="offering-list-page wabi-page">
    <div class="wabi-body">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-left">
          <h2 class="page-title">
            开课管理
            <span v-if="filterCourse" class="filter-tag">- {{ filterCourse.nameCn }}</span>
          </h2>
        </div>
        <el-button type="primary" :icon="Plus" @click="onCreate" class="wabi-btn-primary">
          新建开课
        </el-button>
      </div>

      <!-- 列表容器 -->
      <div class="list-container">
        <div class="list-content" v-loading="loading">
          <div v-if="!loading && !offerings.length" class="list-empty">
            <el-empty description="还没有开课" />
          </div>
          <div v-else class="offering-grid">
            <div v-for="offering in offerings" :key="offering.offeringId" class="offering-item">
              <div class="offering-info">
                <div class="offering-header">
                  <span class="offering-course">
                    {{ courseMap[offering.courseId]?.nameCn || offering.courseId }}
                  </span>
                  <span class="wabi-tag" :class="statusClass(offering.status)">
                    {{ statusText(offering.status) }}
                  </span>
                </div>
                <div class="offering-meta">
                  <span>{{ offering.clazzNo }}</span>
                  <span>{{ offering.semester }}</span>
                  <span>{{ offering.studentCount || 0 }} 名学生</span>
                </div>
              </div>
              <div class="offering-actions">
                <el-button size="small" text @click="onEdit(offering)" class="wabi-btn-text">
                  编辑
                </el-button>
                <el-button size="small" text @click="$router.push(`/teacher/scoring/${offering.offeringId}`)" class="wabi-btn-text">
                  评分项
                </el-button>
                <el-button size="small" text @click="$router.push(`/teacher/grade-v2/${offering.offeringId}`)" class="wabi-btn-text">
                  成绩
                </el-button>
                <el-button size="small" text @click="$router.push(`/teacher/achievement/${offering.offeringId}`)" class="wabi-btn-text">
                  达成度
                </el-button>
                <el-button size="small" text @click="$router.push(`/teacher/quality/${offering.offeringId}`)" class="wabi-btn-text">
                  评价
                </el-button>
                <el-button
                  v-if="offering.status === 'active'"
                  size="small"
                  type="warning"
                  text
                  @click="onFinish(offering)"
                  class="wabi-btn-text"
                >
                  结课
                </el-button>
                <el-button
                  v-if="offering.status === 'finished'"
                  size="small"
                  type="success"
                  text
                  @click="onArchive(offering)"
                  class="wabi-btn-text"
                >
                  归档
                </el-button>
                <el-popconfirm title="确定删除?" @confirm="onDelete(offering)">
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

    <!-- 新建/编辑开课弹窗 -->
    <el-dialog v-model="dialogVisible" :title="isEdit ? '编辑开课' : '新建开课'" width="560" class="wabi-dialog">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100" class="wabi-form">
        <el-form-item label="选择课程" prop="courseId">
          <el-select v-model="form.courseId" placeholder="请选择" style="width: 100%" filterable :disabled="isEdit">
            <el-option v-for="c in courses" :key="c.courseId" :label="`${c.code} - ${c.nameCn}`" :value="c.courseId" />
          </el-select>
        </el-form-item>
        <el-form-item label="选择班级" prop="clazzNos">
          <el-select
            v-model="form.clazzNos"
            placeholder="请选择班级（可多选）"
            style="width: 100%"
            multiple
            filterable
            :disabled="isEdit && (form.status === 'finished' || form.status === 'archived')"
          >
            <el-option
              v-for="clazz in clazzList"
              :key="clazz.no"
              :label="clazz.memo ? `${clazz.no} - ${clazz.memo}` : clazz.no"
              :value="clazz.no"
              :disabled="isEdit && form.existingClazzNos && form.existingClazzNos.includes(clazz.no)"
            />
          </el-select>
          <div v-if="!isEdit" class="form-tip">选择多个班级将批量创建开课实例</div>
          <div v-if="isEdit && form.status === 'active'" class="form-tip">开课中状态：灰色班级已有开课记录，不可重复添加</div>
          <div v-if="isEdit && (form.status === 'finished' || form.status === 'archived')" class="form-tip">已结束/归档状态，不可修改班级</div>
        </el-form-item>
        <el-form-item label="学期" prop="semester">
          <el-input v-model="form.semester" placeholder="如 2024-2025-1" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false" class="wabi-btn-ghost">取消</el-button>
        <el-button type="primary" @click="onSave" class="wabi-btn-primary">{{ isEdit ? '保存' : '创建' }}</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { offeringApi, courseApi, teacherApi } from '@/api'

const route = useRoute()
const offerings = ref([])
const courses = ref([])
const courseMap = ref({})
const clazzList = ref([])
const loading = ref(false)
const dialogVisible = ref(false)
const isEdit = ref(false)
const editingId = ref(null)
const formRef = ref()
const form = ref({})

const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const rules = {
  courseId: [{ required: true, message: '请选择课程' }],
  clazzNos: [{ required: true, message: '请选择班级', type: 'array', min: 1 }],
  semester: [{ required: true, message: '请输入学期' }]
}

const filterCourse = computed(() => {
  const id = Number(route.query.courseId)
  if (!id) return null
  return courseMap.value[id]
})

const statusText = (s) => ({
  draft: '草稿',
  active: '开课中',
  finished: '已结束',
  archived: '已归档'
}[s] || s)

const statusClass = (s) => ({
  draft: '',
  active: 'wabi-tag-accent',
  finished: '',
  archived: 'wabi-tag-warning'
}[s] || '')

const fetch = async () => {
  loading.value = true
  try {
    const params = {
      pageNum: pagination.page,
      pageSize: pagination.pageSize
    }
    if (route.query.courseId) {
      params.courseId = Number(route.query.courseId)
    }
    const [cRes, oRes, clRes] = await Promise.all([
      courseApi.all(),
      offeringApi.list(params),
      teacherApi.clazz.all()
    ])
    courses.value = cRes.data || []
    courseMap.value = Object.fromEntries(courses.value.map(c => [c.courseId, c]))
    clazzList.value = clRes.data || []
    if (oRes.data?.list) {
      offerings.value = oRes.data.list
      pagination.total = oRes.data.total || 0
    } else {
      offerings.value = oRes.data || []
      pagination.total = offerings.value.length
    }
  } finally {
    loading.value = false
  }
}
onMounted(fetch)

const onCreate = () => {
  isEdit.value = false
  editingId.value = null
  form.value = {
    courseId: route.query.courseId ? Number(route.query.courseId) : null,
    clazzNos: [],
    semester: new Date().getFullYear() + '-' + (new Date().getFullYear() + 1) + '-1'
  }
  dialogVisible.value = true
}

const onEdit = (offering) => {
  isEdit.value = true
  editingId.value = offering.offeringId
  // 获取该课程在当前学期已有的所有班级（包括自己）
  const existingClazzNos = offerings.value
    .filter(o => o.courseId === offering.courseId && o.semester === offering.semester)
    .map(o => o.clazzNo)
  // 确保源班级在已有班级列表中
  if (!existingClazzNos.includes(offering.clazzNo)) {
    existingClazzNos.push(offering.clazzNo)
  }
  console.log('编辑开课:', offering.clazzNo, '已有班级:', existingClazzNos)
  form.value = {
    courseId: offering.courseId,
    clazzNos: [offering.clazzNo],
    originalClazzNos: [offering.clazzNo],
    existingClazzNos: existingClazzNos,
    semester: offering.semester,
    status: offering.status
  }
  dialogVisible.value = true
}

const onSave = async () => {
  await formRef.value.validate()
  if (isEdit.value) {
    const { clazzNos, existingClazzNos, semester, status } = form.value

    // 更新学期
    await offeringApi.update(editingId.value, { semester })

    // 草稿状态：可以自由修改班级（这里简化为更新单个班级）
    if (status === 'draft' && clazzNos.length > 0) {
      await offeringApi.update(editingId.value, { clazzNo: clazzNos[0] })
    }

    // 开课中状态：只能添加新班级，不能删除已有班级，使用clone接口复制配置
    if (status === 'active') {
      // 过滤掉已存在开课的班级
      const newClazzNos = clazzNos.filter(no => !existingClazzNos.includes(no))
      console.log('当前选择:', clazzNos, '已有班级:', existingClazzNos, '新增班级:', newClazzNos)
      if (newClazzNos.length > 0) {
        await offeringApi.cloneToClass(editingId.value, newClazzNos)
        ElMessage.success(`已添加 ${newClazzNos.length} 个新班级（含评分项配置）`)
      } else {
        ElMessage.success('已更新')
      }
    } else {
      ElMessage.success('已更新')
    }
  } else {
    // 新建模式：批量创建
    const { courseId, clazzNos, semester } = form.value
    for (const clazzNo of clazzNos) {
      await offeringApi.create({ courseId, clazzNo, semester })
    }
    ElMessage.success(`已创建 ${clazzNos.length} 个开课实例`)
  }
  dialogVisible.value = false
  fetch()
}

const onDelete = async (row) => {
  await offeringApi.remove(row.offeringId)
  ElMessage.success('已删除')
  fetch()
}

const onFinish = async (row) => {
  await ElMessageBox.confirm('确定要结课吗？结课后学生可以进行课程评价。', '确认结课', { type: 'warning' })
  await offeringApi.updateStatus(row.offeringId, 'finished')
  ElMessage.success('已结课')
  fetch()
}

const onArchive = async (row) => {
  await ElMessageBox.confirm('确定要归档吗？', '确认归档', { type: 'warning' })
  await offeringApi.updateStatus(row.offeringId, 'archived')
  ElMessage.success('已归档')
  fetch()
}
</script>

<style scoped>
.offering-list-page {
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

.filter-tag {
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
  font-weight: 400;
  margin-left: 8px;
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

/* 开课列表 */
.offering-grid {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.offering-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: var(--wabi-surface, #fff);
  border: 1px solid var(--wabi-border, #e8e4df);
  border-radius: 6px;
  transition: all 0.2s ease;
}

.offering-item:hover {
  border-color: var(--wabi-accent, #7a8b6f);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.offering-info {
  flex: 1;
}

.offering-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.offering-course {
  font-size: 15px;
  font-weight: 500;
  color: var(--wabi-text, #2c2c2c);
}

.offering-meta {
  display: flex;
  gap: 16px;
  font-size: 13px;
  color: var(--wabi-text-secondary, #8a8580);
}

.offering-actions {
  display: flex;
  gap: 4px;
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

.wabi-tag-accent {
  background: var(--wabi-accent-light, #e8ede5);
  color: var(--wabi-accent, #7a8b6f);
}

.wabi-tag-warning {
  background: #f5efe4;
  color: #a0937d;
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

/* 表单提示 */
.form-tip {
  font-size: 12px;
  color: var(--wabi-text-secondary, #8a8580);
  margin-top: 4px;
}

/* 响应式 */
@media (max-width: 768px) {
  .wabi-body {
    padding: 16px;
  }

  .offering-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }

  .offering-actions {
    width: 100%;
    justify-content: flex-end;
  }
}
</style>
