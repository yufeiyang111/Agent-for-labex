<template>
  <div class="course-list-page">
    <el-card>
      <template #header>
        <div class="card-header">
          <span class="title">课程管理</span>
          <el-button type="primary" :icon="Plus" @click="onCreate">新建课程</el-button>
        </div>
      </template>

      <el-table :data="courses" stripe v-loading="loading">
        <el-table-column prop="code" label="编号" width="120" />
        <el-table-column prop="nameCn" label="中文名" min-width="200" />
        <el-table-column prop="credit" label="学分" width="80" align="center" />
        <el-table-column prop="hours" label="学时" width="80" align="center" />
        <el-table-column prop="major" label="适用专业" width="140" />
        <el-table-column prop="department" label="开课系" width="140" />
        <el-table-column label="操作" width="380" fixed="right">
          <template #default="{ row }">
            <el-button size="small" @click="onEdit(row)">编辑</el-button>
            <el-button size="small" type="primary" @click="onSyllabus(row)">大纲</el-button>
            <el-button size="small" type="success" @click="onObjective(row)">目标</el-button>
            <el-button size="small" type="warning" @click="onOffering(row)">开课</el-button>
            <el-popconfirm :title="`确定删除「${row.nameCn}」?`" @confirm="onDelete(row)">
              <template #reference>
                <el-button size="small" type="danger">删除</el-button>
              </template>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!loading && !courses.length" description="还没有课程，点击右上角新建" />
    </el-card>

    <el-dialog v-model="dialogVisible" :title="form.courseId ? '编辑课程' : '新建课程'" width="780">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100">
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="课程编号" prop="code"><el-input v-model="form.code" placeholder="如 CS101" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="中文名" prop="nameCn"><el-input v-model="form.nameCn" /></el-form-item></el-col>
        </el-row>
        <el-form-item label="英文名"><el-input v-model="form.nameEn" /></el-form-item>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="学分" prop="credit">
              <el-input-number v-model="form.credit" :min="0.5" :max="10" :step="0.5" style="width:100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="总学时" prop="hours">
              <el-input-number v-model="form.hours" :min="1" :max="300" style="width:100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="理论学时">
              <el-input-number v-model="form.theoryHours" :min="0" :max="300" style="width:100%" @change="onSubHoursChange" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="实验学时">
              <el-input-number v-model="form.labHours" :min="0" :max="300" style="width:100%" @change="onSubHoursChange" />
            </el-form-item>
          </el-col>
        </el-row>
        <div class="hours-hint">
          <el-text size="small" type="info">
            提示：「总学时」为整门课课时（含讲授/实验/上机/实践等）；「理论」=讲授，「实验」=动手操作；总学时可大于或等于理论+实验之和。
          </el-text>
        </div>
        <el-form-item label="适用专业"><el-input v-model="form.major" /></el-form-item>
        <el-form-item label="先修课程"><el-input v-model="form.prerequisite" /></el-form-item>
        <el-form-item label="开课系"><el-input v-model="form.department" /></el-form-item>
        <el-form-item label="课程简介"><el-input v-model="form.intro" type="textarea" :rows="4" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="onSave">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
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
    const res = await courseApi.list()
    courses.value = res.data || []
  } finally {
    loading.value = false
  }
}
onMounted(fetch)

const onCreate = () => { form.value = newForm(); dialogVisible.value = true }
const onEdit = (row) => { form.value = { ...row }; dialogVisible.value = true }
const onSubHoursChange = () => {
  // 自动累加：当用户没主动设置总学时，或总学时 < (理论+实验)，则自动累加
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
    ElMessage.success('已创建，已自动生成空大纲')
  }
  dialogVisible.value = false
  fetch()
}
const onDelete = async (row) => { await courseApi.remove(row.courseId); ElMessage.success('已删除'); fetch() }
const onSyllabus = (row) => router.push(`/teacher/course/${row.courseId}/syllabus`)
const onObjective = (row) => router.push(`/teacher/objective/${row.courseId}`)
const onOffering = (row) => router.push(`/teacher/offering?courseId=${row.courseId}`)
</script>

<style scoped>
.course-list-page { padding: 20px; }
.card-header { display: flex; justify-content: space-between; align-items: center; }
.title { font-weight: 600; font-size: 16px; }
.hours-hint { padding-left: 100px; margin-bottom: 16px; line-height: 1.5; }
</style>
