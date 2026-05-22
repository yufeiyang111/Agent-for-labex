import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { authApi } from '@/api'

export const useUserStore = defineStore('user', () => {
  // 状态
  const token = ref(localStorage.getItem('token') || '')
  const userInfo = ref(JSON.parse(localStorage.getItem('userInfo') || 'null'))
  const role = ref(localStorage.getItem('role') || '')

  // 计算属性：是否登录
  const isLoggedIn = computed(() => !!token.value)

  // 计算属性：是否为教师
  const isTeacher = computed(() => role.value === 'TEACHER')

  // 计算属性：是否为学生
  const isStudent = computed(() => role.value === 'STUDENT')

  // 计算属性：是否为管理员
  const isAdmin = computed(() => role.value === 'ADMIN')

  // 登录
  const login = async (loginForm) => {
    try {
      const res = await authApi.login(loginForm)
      token.value = res.data.token
      userInfo.value = res.data.userInfo
      role.value = res.data.userInfo.role

      // 存储到本地
      localStorage.setItem('token', token.value)
      localStorage.setItem('userInfo', JSON.stringify(userInfo.value))
      localStorage.setItem('role', role.value)

      // 登录成功后获取完整用户信息
      await getUserInfo()

      return { success: true }
    } catch (error) {
      return { success: false, message: error.message }
    }
  }

  // 退出登录
  const logout = () => {
    token.value = ''
    userInfo.value = null
    role.value = ''
    localStorage.removeItem('token')
    localStorage.removeItem('userInfo')
    localStorage.removeItem('role')
  }

  // 获取用户信息
  const getUserInfo = async () => {
    try {
      const res = await authApi.getUserInfo()
      userInfo.value = res.data
      role.value = res.data.role
      localStorage.setItem('userInfo', JSON.stringify(userInfo.value))
      localStorage.setItem('role', role.value)
      return { success: true, data: res.data }
    } catch (error) {
      return { success: false, message: error.message }
    }
  }

  // 设置Token（用于刷新）
  const setToken = (newToken) => {
    token.value = newToken
    localStorage.setItem('token', newToken)
  }

  return {
    token,
    userInfo,
    role,
    isLoggedIn,
    isTeacher,
    isStudent,
    isAdmin,
    login,
    logout,
    getUserInfo,
    setToken
  }
})
