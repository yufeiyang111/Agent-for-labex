// API接口统一管理
import request from '@/utils/request'

// 认证相关API
export const authApi = {
  // 登录
  login(data) {
    return request.post('/auth/login', data)
  },

  // 退出登录
  logout() {
    return request.post('/auth/logout')
  },

  // 刷新Token
  refreshToken() {
    return request.post('/auth/refresh')
  },

  // 获取用户信息
  getUserInfo() {
    return request.get('/auth/userinfo')
  },

  // 修改密码
  updatePassword(data) {
    return request.put('/auth/update-password', data)
  },

  // 上传头像
  uploadAvatar(file) {
    const formData = new FormData()
    formData.append('file', file)
    return request.post('/auth/avatar', formData, {
      headers: { 'Content-Type': 'multipart/form-data' }
    })
  },

  // 获取头像
  getAvatar() {
    return request.get('/auth/avatar', { responseType: 'blob' })
  }
}

// 教师模块API
export const teacherApi = {
  // 班级管理
  clazz: {
    list(params) {
      return request.get('/teacher/clazz/list', { params })
    },
    all() {
      return request.get('/teacher/clazz/all')
    },
    get(no) {
      return request.get(`/teacher/clazz/${no}`)
    },
    add(data) {
      return request.post('/teacher/clazz', data)
    },
    update(no, data) {
      return request.put(`/teacher/clazz/${no}`, data)
    },
    delete(no) {
      return request.delete(`/teacher/clazz/${no}`)
    },
    updateState(no, state) {
      return request.put(`/teacher/clazz/${no}/state`, null, { params: { state } })
    }
  },

  // 学生管理
  student: {
    list(params) {
      return request.get('/teacher/student/list', { params })
    },
    getByClazz(clazzNo) {
      return request.get(`/teacher/student/clazz/${clazzNo}`)
    },
    get(id) {
      return request.get(`/teacher/student/${id}`)
    },
    add(data) {
      return request.post('/teacher/student', data)
    },
    update(id, data) {
      return request.put(`/teacher/student/${id}`, data)
    },
    delete(id) {
      return request.delete(`/teacher/student/${id}`)
    },
    updateState(id, state) {
      return request.put(`/teacher/student/${id}/state`, null, { params: { state } })
    },
    resetPassword(id) {
      return request.put(`/teacher/student/${id}/reset-password`)
    },
    resetIp(id) {
      return request.put(`/teacher/student/${id}/reset-ip`)
    },
    import(file, clazzNo) {
      const formData = new FormData()
      formData.append('file', file)
      formData.append('clazzNo', clazzNo)
      return request.post('/teacher/student/import', formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      })
    }
  },

  // 实验管理
  experiment: {
    list(params) {
      return request.get('/teacher/experiment/list', { params })
    },
    getEnabled() {
      return request.get('/teacher/experiment/enabled')
    },
    get(id) {
      return request.get(`/teacher/experiment/${id}`)
    },
    add(data) {
      return request.post('/teacher/experiment', data)
    },
    update(id, data) {
      return request.put(`/teacher/experiment/${id}`, data)
    },
    delete(id) {
      return request.delete(`/teacher/experiment/${id}`)
    },
    updateState(id, state) {
      return request.put(`/teacher/experiment/${id}/state`, null, { params: { state } })
    }
  },

  // 实验题目管理
  experimentItem: {
    list(params) {
      return request.get('/teacher/experiment-item/list', { params })
    },
    listByExperiment(experimentId) {
      return request.get(`/teacher/experiment-item/experiment/${experimentId}`)
    },
    get(id) {
      return request.get(`/teacher/experiment-item/${id}`)
    },
    add(data) {
      return request.post('/teacher/experiment-item', data)
    },
    update(id, data) {
      return request.put(`/teacher/experiment-item/${id}`, data)
    },
    delete(id) {
      return request.delete(`/teacher/experiment-item/${id}`)
    },
    batchDelete(ids) {
      return request.delete('/teacher/experiment-item/batch', { data: ids })
    }
  },

  // 讲义管理
  lecture: {
    list(params) {
      return request.get('/teacher/lecture/list', { params })
    },
    getAll() {
      return request.get('/teacher/lecture/all')
    },
    get(id) {
      return request.get(`/teacher/lecture/${id}`)
    },
    add(data) {
      return request.post('/teacher/lecture', data)
    },
    update(id, data) {
      return request.put(`/teacher/lecture/${id}`, data)
    },
    delete(id) {
      return request.delete(`/teacher/lecture/${id}`)
    },
    upload(file) {
      const formData = new FormData()
      formData.append('file', file)
      return request.post('/teacher/lecture/upload', formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      })
    },
    categories() {
      return request.get('/teacher/lecture/categories')
    }
  },

  // 成绩管理
  score: {
    getStudentAnswers(experimentId) {
      return request.get(`/teacher/score/experiment/${experimentId}/students`)
    },
    getStudentDetail(studentId, experimentId) {
      return request.get(`/teacher/score/student/${studentId}/experiment/${experimentId}`)
    },
    scoreItem(itemId, score) {
      return request.put(`/teacher/score/item/${itemId}`, null, { params: { score } })
    },
    batchScore(items) {
      return request.put('/teacher/score/batch', items)
    },
    export(experimentId) {
      return request.get(`/teacher/score/export/${experimentId}`, {
        responseType: 'blob'
      })
    }
  },

  // 考试管理
  dashboard: {
    overview() {
      return request.get('/teacher/dashboard/overview')
    }
  },

  exam: {
    list(params) {
      return request.get('/teacher/exam/list', { params })
    },
    getAll() {
      return request.get('/teacher/exam/all')
    },
    getPapers() {
      return request.get('/teacher/exam/papers')
    },
    get(id) {
      return request.get(`/teacher/exam/${id}`)
    },
    add(data) {
      return request.post('/teacher/exam', data)
    },
    update(id, data) {
      return request.put(`/teacher/exam/${id}`, data)
    },
    delete(id) {
      return request.delete(`/teacher/exam/${id}`)
    }
  },

  // 试卷管理
  paper: {
    list(params) {
      return request.get('/teacher/paper/list', { params })
    },
    getAll() {
      return request.get('/teacher/paper/all')
    },
    get(id) {
      return request.get(`/teacher/paper/${id}`)
    },
    getQuestions(id) {
      return request.get(`/teacher/paper/${id}/questions`)
    },
    add(data) {
      return request.post('/teacher/paper', data)
    },
    update(id, data) {
      return request.put(`/teacher/paper/${id}`, data)
    },
    delete(id) {
      return request.delete(`/teacher/paper/${id}`)
    },
    addQuestions(id, questionIds) {
      return request.post(`/teacher/paper/${id}/questions`, { questionIds })
    }
  },

  // 题库管理
  question: {
    list(params) {
      return request.get('/teacher/question/list', { params })
    },
    getAll() {
      return request.get('/teacher/question/all')
    },
    get(id) {
      return request.get(`/teacher/question/${id}`)
    },
    add(data) {
      return request.post('/teacher/question/create', data)
    },
    update(id, data) {
      return request.put(`/teacher/question/${id}`, data)
    },
    delete(id) {
      return request.delete(`/teacher/question/${id}`)
    },
    getTestCases(id) {
      return request.get(`/teacher/question/${id}/test-cases`)
    },
    saveTestCases(id, testCases) {
      return request.post(`/teacher/question/${id}/test-cases`, testCases)
    },
    deleteTestCase(testCaseId) {
      return request.delete(`/teacher/question/test-case/${testCaseId}`)
    }
  },

  // 考试批改
  grading: {
    getPendingExams() {
      return request.get('/teacher/grading/pending-exams')
    },
    getPendingStudents(examId) {
      return request.get(`/teacher/grading/exam/${examId}/pending-students`)
    },
    getStudentQuestions(examId, studentId) {
      return request.get(`/teacher/grading/exam/${examId}/student/${studentId}/questions`)
    },
    submitAllGrades(examId, studentId, grades) {
      return request.post(`/teacher/grading/exam/${examId}/student/${studentId}/submit-grades`, grades)
    },
    gradeQuestion(examId, studentId, questionId, score) {
      return request.put(`/teacher/grading/exam/${examId}/student/${studentId}/question/${questionId}`, null, {
        params: { score }
      })
    },
    getInvigilationEvents(examId) {
      return request.get(`/teacher/grading/exam/${examId}/invigilation-events`)
    }
  },

  // 作业管理
  homework: {
    list(params) {
      return request.get('/teacher/homework/list', { params })
    },
    getAll() {
      return request.get('/teacher/homework/all')
    },
    get(id) {
      return request.get(`/teacher/homework/${id}`)
    },
    add(data) {
      return request.post('/teacher/homework', data)
    },
    update(id, data) {
      return request.put(`/teacher/homework/${id}`, data)
    },
    delete(id) {
      return request.delete(`/teacher/homework/${id}`)
    },
    upload(file) {
      const formData = new FormData()
      formData.append('file', file)
      return request.post('/teacher/homework/upload', formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      })
    },
    getSubmissions(id) {
      return request.get(`/teacher/homework/${id}/submissions`)
    },
    scoreSubmission(id, data) {
      return request.put(`/teacher/homework/submission/${id}`, data)
    },
    getQuestions(id) {
      return request.get(`/teacher/homework/${id}/questions`)
    },
    addQuestions(id, questionIds) {
      return request.post(`/teacher/homework/${id}/questions`, questionIds)
    },
    removeQuestion(homeworkId, questionId) {
      return request.delete(`/teacher/homework/${homeworkId}/question/${questionId}`)
    },
    getAvailableQuestions(params) {
      return request.get('/teacher/homework/available-questions', { params })
    },
    getStudentAnswers(homeworkId, studentId) {
      return request.get(`/teacher/homework/${homeworkId}/student/${studentId}/answers`)
    },
    scoreStudentQuestion(homeworkId, studentId, questionId, score) {
      return request.put(`/teacher/homework/${homeworkId}/student/${studentId}/question/${questionId}/score`, null, {
        params: { score }
      })
    }
  }
}

// 学生模块API
export const studentApi = {
  // 实验相关
  experiments() {
    return request.get('/student/experiments')
  },

  // 获取讲义列表
  lectures() {
    return request.get('/student/lectures')
  },

  // 获取讲义详情
  getLecture(id) {
    return request.get(`/student/lecture/${id}`)
  },

  // 获取实验题目列表
  getExperimentItems(experimentId) {
    return request.get(`/teacher/experiment-item/experiment/${experimentId}`)
  },

  // 获取已保存的答题记录
  getProgress(experimentId) {
    return request.get(`/student/experiment/${experimentId}/progress`)
  },

  // 保存答案
  saveAnswer(experimentId, itemId, content) {
    return request.post(`/student/experiment/${experimentId}/item/${itemId}/save`, null, {
      params: { content }
    })
  },

  // 提交实验答案
  submitAnswer(experimentId, answers) {
    return request.post(`/student/experiment/${experimentId}/submit`, answers)
  },

  // 讲义相关
  lectures() {
    return request.get('/student/lectures')
  },

  getLecture(id) {
    return request.get(`/student/lecture/${id}`)
  },

  // 成绩查询
  scores() {
    return request.get('/student/scores')
  },

  // 学习统计
  stats() {
    return request.get('/student/stats')
  },

  // 考试相关
  exam: {
    list(params) {
      return request.get('/student/exam/list', { params })
    },
    getDetail(id) {
      return request.get(`/student/exam/${id}`)
    },
    getMyAnswers(examId) {
      return request.get(`/student/exam/${examId}/my-answers`)
    },
    saveAnswer(examId, questionId, myAnswer) {
      return request.post(`/student/exam/${examId}/question/${questionId}/save`, null, {
        params: { myAnswer }
      })
    },
    submit(examId) {
      return request.post(`/student/exam/${examId}/submit`)
    },
    runCode(code, language) {
      return request.post('/student/exam/run-code', null, {
        params: { code, language }
      })
    },
    runProgrammingTests(examId, questionId, code, language) {
      return request.post(`/student/exam/${examId}/question/${questionId}/run-tests`, null, {
        params: { code, language }
      })
    },
    reportMonitorEvent(examId, data) {
      return request.post(`/student/exam/${examId}/monitor-event`, data)
    },
    getHistory(params) {
      return request.get('/student/exam/history', { params })
    }
  },

  // 作业相关
  homework: {
    list(params) {
      return request.get('/student/homework/list', { params })
    },
    getDetail(id) {
      return request.get(`/student/homework/${id}`)
    },
    getQuestions(id) {
      return request.get(`/student/homework/${id}/questions`)
    },
    getMyAnswers(id) {
      return request.get(`/student/homework/${id}/my-answers`)
    },
    getMySubmission(id) {
      return request.get(`/student/homework/${id}/my-submission`)
    },
    getMyList(params) {
      return request.get('/student/homework/my-list', { params })
    },
    submitText(id, content) {
      return request.post(`/student/homework/${id}/submit-text`, { content })
    },
    submitFile(id, file) {
      const formData = new FormData()
      formData.append('file', file)
      return request.post(`/student/homework/${id}/submit-file`, formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      })
    },
    getHistory(params) {
      return request.get('/student/homework/history', { params })
    },
    saveAnswer(homeworkId, questionId, myAnswer) {
      return request.post(`/student/homework/${homeworkId}/question/${questionId}/save`, null, {
        params: { myAnswer }
      })
    },
    runProgrammingTests(homeworkId, questionId, code, language) {
      return request.post(`/student/homework/${homeworkId}/question/${questionId}/run-tests`, null, {
        params: { code, language }
      })
    },
    submitAnswers(homeworkId) {
      return request.post(`/student/homework/${homeworkId}/submit`)
    }
  }
}

// 管理员模块API
export const adminApi = {
  // 教师管理
  teacher: {
    list(params) {
      return request.get('/admin/teacher/list', { params })
    },
    all() {
      return request.get('/admin/teacher/all')
    },
    get(id) {
      return request.get(`/admin/teacher/${id}`)
    },
    add(data) {
      return request.post('/admin/teacher', data)
    },
    update(id, data) {
      return request.put(`/admin/teacher/${id}`, data)
    },
    delete(id) {
      return request.delete(`/admin/teacher/${id}`)
    },
    updateState(id, state) {
      return request.put(`/admin/teacher/${id}/state`, null, { params: { state } })
    },
    resetPassword(id) {
      return request.put(`/admin/teacher/${id}/reset-password`)
    }
  },

  // 学生管理
  student: {
    list(params) {
      return request.get('/admin/student/list', { params })
    },
    all() {
      return request.get('/admin/student/all')
    },
    get(id) {
      return request.get(`/admin/student/${id}`)
    },
    add(data) {
      return request.post('/admin/student', data)
    },
    update(id, data) {
      return request.put(`/admin/student/${id}`, data)
    },
    delete(id) {
      return request.delete(`/admin/student/${id}`)
    },
    updateState(id, state) {
      return request.put(`/admin/student/${id}/state`, null, { params: { state } })
    },
    resetPassword(id) {
      return request.put(`/admin/student/${id}/reset-password`)
    },
    resetIp(id) {
      return request.put(`/admin/student/${id}/reset-ip`)
    },
    import(file, clazzNo) {
      const formData = new FormData()
      formData.append('file', file)
      formData.append('clazzNo', clazzNo)
      return request.post('/admin/student/import', formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      })
    }
  },

  // 班级管理
  clazz: {
    list(params) {
      return request.get('/admin/clazz/list', { params })
    },
    all() {
      return request.get('/admin/clazz/all')
    },
    get(no) {
      return request.get(`/admin/clazz/${no}`)
    },
    add(data) {
      return request.post('/admin/clazz', data)
    },
    update(no, data) {
      return request.put(`/admin/clazz/${no}`, data)
    },
    delete(no) {
      return request.delete(`/admin/clazz/${no}`)
    },
    updateState(no, state) {
      return request.put(`/admin/clazz/${no}/state`, null, { params: { state } })
    }
  },

  // 统计信息
  stats() {
    return request.get('/admin/stats')
  }
}

// RAG知识库模块API
export const ragApi = {
  // 初始化知识库
  init() {
    return request.post('/rag/init')
  },

  // 创建会话
  createSession(title) {
    return request.post('/rag/session/create', null, { params: { title } })
  },

  // 获取用户的所有会话
  getSessions() {
    return request.get('/rag/sessions')
  },

  // 获取单个会话
  getSession(sessionId) {
    return request.get(`/rag/session/${sessionId}`)
  },

  // 删除会话
  deleteSession(sessionId) {
    return request.delete(`/rag/session/${sessionId}`)
  },

  // 更新会话标题
  updateSessionTitle(sessionId, title) {
    return request.put(`/rag/session/${sessionId}/title`, null, { params: { title } })
  },

  // 知识问答
  query(data) {
    return request.post('/rag/query', data)
  },

  // 获取会话历史
  getHistory(sessionId) {
    return request.get(`/rag/history/${sessionId}`)
  },

  // 清空会话历史
  clearHistory(sessionId) {
    return request.delete(`/rag/history/${sessionId}`)
  },

  // 获取文档列表
  listDocuments() {
    return request.get('/rag/documents')
  },

  // 获取知识库状态
  getStatus() {
    return request.get('/rag/status')
  },

  // 获取讲义内容（RAG预览，不校验教师归属）
  getLecture(id) {
    return request.get(`/rag/lecture/${id}`)
  }
}

// 知识图谱API
export const kgApi = {
  // 从讲义提取知识点
  extract(data) {
    return request.post('/kg/extract', data)
  },
  // 知识点列表
  getPoints(params) {
    return request.get('/kg/points', { params })
  },
  // 知识点详情
  getPoint(id) {
    return request.get(`/kg/points/${id}`)
  },
  // 手动创建知识点
  createPoint(data) {
    return request.post('/kg/points', data)
  },
  // 删除知识点
  deletePoint(id) {
    return request.delete(`/kg/points/${id}`)
  },
  // 批量关联题目到知识点
  linkQuestions(data) {
    return request.post('/kg/link-questions', data)
  },
  // 主题列表
  getTopics() {
    return request.get('/kg/topics')
  },
  // 创建主题
  createTopic(data) {
    return request.post('/kg/topics', data)
  },
  // 更新主题
  updateTopic(id, data) {
    return request.put(`/kg/topics/${id}`, data)
  },
  // 删除主题
  deleteTopic(id) {
    return request.delete(`/kg/topics/${id}`)
  },
  // 知识图谱统计
  getStats() {
    return request.get('/kg/stats')
  },
}

// 习题推荐API
export const recommendationApi = {
  // 个性化推荐（弱项强化）
  forMe(params) {
    return request.get('/recommendation/for-me', { params })
  },
  // 按知识点推荐
  byKnowledge(params) {
    return request.get('/recommendation/by-knowledge', { params })
  },
  // 相似题目推荐
  similar(params) {
    return request.get('/recommendation/similar', { params })
  },
}

// 题目训练模块API
export const trainingApi = {
  // 教师端
  teacher: {
    list(params) {
      return request.get('/teacher/training-set/list', { params })
    },
    all() {
      return request.get('/teacher/training-set/all')
    },
    get(id) {
      return request.get(`/teacher/training-set/${id}`)
    },
    add(data) {
      return request.post('/teacher/training-set', data)
    },
    update(id, data) {
      return request.put(`/teacher/training-set/${id}`, data)
    },
    delete(id) {
      return request.delete(`/teacher/training-set/${id}`)
    },
    getQuestions(id) {
      return request.get(`/teacher/training-set/${id}/questions`)
    },
    addQuestions(id, questionIds) {
      return request.post(`/teacher/training-set/${id}/questions`, questionIds)
    },
    removeQuestion(trainingSetId, questionId) {
      return request.delete(`/teacher/training-set/${trainingSetId}/question/${questionId}`)
    },
    getAvailableQuestions(params) {
      return request.get('/teacher/training-set/available-questions', { params })
    },
    getStudentRecords(id) {
      return request.get(`/teacher/training-set/${id}/student-records`)
    },
    getStudentDetail(trainingSetId, studentId, attemptId) {
      return request.get(`/teacher/training-set/${trainingSetId}/student/${studentId}/detail`, { params: { attemptId } })
    }
  },

  // 学生端
  student: {
    list() {
      return request.get('/student/training/list')
    },
    get(id) {
      return request.get(`/student/training/${id}`)
    },
    getQuestions(id) {
      return request.get(`/student/training/${id}/questions`)
    },
    myRecords(id) {
      return request.get(`/student/training/${id}/my-records`)
    },
    saveAnswer(id, questionId, myAnswer) {
      return request.post(`/student/training/${id}/question/${questionId}/save`, null, {
        params: { myAnswer }
      })
    },
    submit(id) {
      return request.post(`/student/training/${id}/submit`)
    },
    retry(id) {
      return request.post(`/student/training/${id}/retry`)
    },
    getResult(id, attemptId) {
      return request.get(`/student/training/${id}/result/${attemptId}`)
    }
  }
}

// 学生能力画像API
export const masteryApi = {
  // 我的能力画像
  myState() {
    return request.get('/mastery/my-state')
  },
  // 查看指定学生画像（教师）
  studentState(studentId) {
    return request.get(`/mastery/student/${studentId}`)
  },
}
