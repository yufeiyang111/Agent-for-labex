<template>
  <div class="offering-list-page">
    <el-card>
      <template #header>
        <div class="card-header">
          <span class="title">开课管理 <span v-if="filterCourse" class="filter-tag">- 课程: {{ filterCourse.nameCn }}</span></span>
          <el-button type="primary" :icon="Plus" @click="onCreate">新建开课</el-button>
        </div>
      </template>

      <el-table :data="offerings" stripe v-loading="loading">
        <el-table-column prop="offeringId" label="ID" width="80" />
        <el-table-column prop="courseId" label="课程">
          <template #default="{ row }">
            <span>{{ courseMap[row.courseId]?.nameCn || row.courseId }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="clazzNo" label="班级" width="120" />
        <el-table-column prop="semester" label="学期" width="140" />
        <el-table-column prop="studentCount" label="学生数" width="100" align="center" />
        <el-table-column prop="status" label="状态" width="100" align="center">
          <template #default="{ row }">
            <el-tag :type="statusType(row.status)">{{ statusText(row.status) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="380" fixed="right">
          <template #default="{ row }">
            <el-button size="small" type="primary" @click="$router.push(`/teacher/scoring/${row.offeringId}`)">评分项</el-button>
            <el-button size="small" type="success" @click="$router.push(`/teacher/grade-v2/${row.offeringId}`)">成绩</el-button>
            <el-button size="small" type="warning" @click="$router.push(`/teacher/achievement/${row.offeringId}`)">达成度</el-button>
            <el-button size="small" @click="$router.push(`/teacher/quality/${row.offeringId}`)">评价</el-button>
            <el-popconfirm title="确定删除?" @confirm="onDelete(row)">
              <template #reference><el-button size="small" type="danger">删除</el-button></template>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!loading && !offerings.length" description="还没有开课" />
    </el-card>

    <el-dialog v-model="dialogVisible" title="新建开课" width="600">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="120">
        <el-form-item label="选择课程" prop="courseId">
          <el-select v-model="form.courseId" placeholder="请选择" style="width:100%" filterable>
            <el-option v-for="c in courses" :key="c.courseId" :label="`${c.code} - ${c.nameCn}`" :value="c.courseId" />
          </el-select>
        </el-form-item>
        <el-form-item label="班级编号" prop="clazzNo">
          <el-input v-model="form.clazzNo" placeholder="如 23-SE-1" />
        </el-form-item>
        <el-form-item label="学期" prop="semester">
          <el-input v-model="form.semester" placeholder="如 2024-2025-1" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="onSave">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { offeringApi, courseApi } from '@/api'

const route = useRoute()
const offerings = ref([])
const courses = ref([])
const courseMap = ref({})
const loading = ref(false)
const dialogVisible = ref(false)
const formRef = ref()
const form = ref({})
const rules = {
  courseId: [{ required: true, message: '请选择课程' }],
  clazzNo: [{ required: true, message: '请输入班级编号' }],
  semester: [{ required: true, message: '请输入学期' }]
}

const filterCourse = computed(() => {
  const id = Number(route.query.courseId)
  if (!id) return null
  return courseMap.value[id]
})

const statusText = (s) => ({ draft: '草稿', active: '开课中', finished: '已结束', archived: '已归档' }[s] || s)
const statusType = (s) => ({ draft: 'info', active: 'success', finished: '', archived: 'warning' }[s] || '')

const fetch = async () => {
  loading.value = true
  try {
    const [cRes, oRes] = await Promise.all([
      courseApi.list(),
      offeringApi.list(route.query.courseId ? Number(route.query.courseId) : undefined)
    ])
    courses.value = cRes.data || []
    courseMap.value = Object.fromEntries(courses.value.map(c => [c.courseId, c]))
    offerings.value = oRes.data || []
  } finally {
    loading.value = false
  }
}
onMounted(fetch)

const onCreate = () => {
  form.value = {
    courseId: route.query.courseId ? Number(route.query.courseId) : null,
    clazzNo: '',
    semester: new Date().getFullYear() + '-' + (new Date().getFullYear() + 1) + '-1'
  }
  dialogVisible.value = true
}
const onSave = async () => {
  await formRef.value.validate()
  await offeringApi.create(form.value)
  ElMessage.success('已创建')
  dialogVisible.value = false
  fetch()
}
const onDelete = async (row) => { await offeringApi.remove(row.offeringId); ElMessage.success('已删除'); fetch() }
</script>

<style scoped>
.offering-list-page { padding: 20px; }
.card-header { display: flex; justify-content: space-between; align-items: center; }
.title { font-weight: 600; font-size: 16px; }
.filter-tag { color: #909399; font-size: 13px; font-weight: normal; margin-left: 6px; }
</style>
