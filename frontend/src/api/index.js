// API鎺ュ彛缁熶竴绠＄悊
import request from '@/utils/request'

// 璁よ瘉鐩稿叧API
export const authApi = {
  // 鐧诲綍
  login(data) {
    return request.post('/auth/login', data)
  },

  // 学生注册
  register(data) {
    return request.post('/auth/register', data)
  },

  // 閫€鍑虹櫥褰?
  logout() {
    return request.post('/auth/logout')
  },

  // 鍒锋柊Token
  refreshToken() {
    return request.post('/auth/refresh')
  },

  // 鑾峰彇鐢ㄦ埛淇℃伅
  getUserInfo() {
    return request.get('/auth/userinfo')
  },

  // 淇敼瀵嗙爜
  updatePassword(data) {
    return request.put('/auth/update-password', data)
  },

  // 涓婁紶澶村儚
  uploadAvatar(file) {
    const formData = new FormData()
    formData.append('file', file)
    return request.post('/auth/avatar', formData, {
      headers: { 'Content-Type': 'multipart/form-data' }
    })
  },

  // 鑾峰彇澶村儚
  getAvatar() {
    return request.get('/auth/avatar', { responseType: 'blob' })
  }
}

// 鏁欏笀妯″潡API
export const teacherApi = {
  // 鐝骇绠＄悊
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

  // 瀛︾敓绠＄悊
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

  // 瀹為獙绠＄悊
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

  // 瀹為獙棰樼洰绠＄悊
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

  // 璁蹭箟绠＄悊
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

  // 鎴愮哗绠＄悊
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

  // 鑰冭瘯绠＄悊
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

  // 璇曞嵎绠＄悊
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

  // 棰樺簱绠＄悊
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

  // 鑰冭瘯鎵规敼
  grading: {
    getPendingExams() {
      return request.get('/teacher/grading/pending-exams')
    },
    getPendingStudents(examId) {
      return request.get(`/teacher/grading/exam/${examId}/pending-students`)
    },
    getGradedStudents(examId) {
      return request.get(`/teacher/grading/exam/${examId}/graded-students`)
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

  // 浣滀笟绠＄悊
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

// 瀛︾敓妯″潡API
export const studentApi = {
  // 瀹為獙鐩稿叧
  experiments() {
    return request.get('/student/experiments')
  },

  // 鑾峰彇璁蹭箟鍒楄〃
  lectures() {
    return request.get('/student/lectures')
  },

  // 鑾峰彇璁蹭箟璇︽儏
  getLecture(id) {
    return request.get(`/student/lecture/${id}`)
  },

  // 鑾峰彇瀹為獙棰樼洰鍒楄〃
  getExperimentItems(experimentId) {
    return request.get(`/teacher/experiment-item/experiment/${experimentId}`)
  },

  // 鑾峰彇宸蹭繚瀛樼殑绛旈璁板綍
  getProgress(experimentId) {
    return request.get(`/student/experiment/${experimentId}/progress`)
  },

  // 淇濆瓨绛旀
  saveAnswer(experimentId, itemId, content) {
    return request.post(`/student/experiment/${experimentId}/item/${itemId}/save`, null, {
      params: { content }
    })
  },

  // 鎻愪氦瀹為獙绛旀
  submitAnswer(experimentId, answers) {
    return request.post(`/student/experiment/${experimentId}/submit`, answers)
  },

  // 璁蹭箟鐩稿叧
  lectures() {
    return request.get('/student/lectures')
  },

  getLecture(id) {
    return request.get(`/student/lecture/${id}`)
  },

  // 鎴愮哗鏌ヨ
  scores() {
    return request.get('/student/scores')
  },

  // 瀛︿範缁熻
  stats() {
    return request.get('/student/stats')
  },

  // 鑰冭瘯鐩稿叧
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

  // 浣滀笟鐩稿叧
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

// 绠＄悊鍛樻ā鍧桝PI
export const adminApi = {
  // 鏁欏笀绠＄悊
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

  // 瀛︾敓绠＄悊
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

  // 鐝骇绠＄悊
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

  // 缁熻淇℃伅
  stats() {
    return request.get('/admin/stats')
  }
}

// RAG鐭ヨ瘑搴撴ā鍧桝PI
export const ragApi = {
  // 鍒濆鍖栫煡璇嗗簱
  init() {
    return request.post('/rag/init')
  },

  // 鍒涘缓浼氳瘽
  createSession(title) {
    return request.post('/rag/session/create', null, { params: { title } })
  },

  // 鑾峰彇鐢ㄦ埛鐨勬墍鏈変細璇?
  getSessions() {
    return request.get('/rag/sessions')
  },

  // 鑾峰彇鍗曚釜浼氳瘽
  getSession(sessionId) {
    return request.get(`/rag/session/${sessionId}`)
  },

  // 鍒犻櫎浼氳瘽
  deleteSession(sessionId) {
    return request.delete(`/rag/session/${sessionId}`)
  },

  // 鏇存柊浼氳瘽鏍囬
  updateSessionTitle(sessionId, title) {
    return request.put(`/rag/session/${sessionId}/title`, null, { params: { title } })
  },

  // 鐭ヨ瘑闂瓟
  query(data) {
    return request.post('/rag/query', data)
  },

  // 鑾峰彇浼氳瘽鍘嗗彶
  getHistory(sessionId) {
    return request.get(`/rag/history/${sessionId}`)
  },

  // 娓呯┖浼氳瘽鍘嗗彶
  clearHistory(sessionId) {
    return request.delete(`/rag/history/${sessionId}`)
  },

  // 鑾峰彇鏂囨。鍒楄〃
  listDocuments() {
    return request.get('/rag/documents')
  },

  // 鑾峰彇鐭ヨ瘑搴撶姸鎬?
  getStatus() {
    return request.get('/rag/status')
  },

  // 鑾峰彇璁蹭箟鍐呭锛圧AG棰勮锛屼笉鏍￠獙鏁欏笀褰掑睘锛?
  getLecture(id) {
    return request.get(`/rag/lecture/${id}`)
  }
}

// 鐭ヨ瘑鍥捐氨API
export const kgApi = {
  // 浠庤涔夋彁鍙栫煡璇嗙偣
  extract(data) {
    return request.post('/kg/extract', data)
  },
  // 鐭ヨ瘑鐐瑰垪琛?
  getPoints(params) {
    return request.get('/kg/points', { params })
  },
  // 鐭ヨ瘑鐐硅鎯?
  getPoint(id) {
    return request.get(`/kg/points/${id}`)
  },
  // 鎵嬪姩鍒涘缓鐭ヨ瘑鐐?
  createPoint(data) {
    return request.post('/kg/points', data)
  },
  // 鍒犻櫎鐭ヨ瘑鐐?
  deletePoint(id) {
    return request.delete(`/kg/points/${id}`)
  },
  // 鎵归噺鍏宠仈棰樼洰鍒扮煡璇嗙偣 (LLM - 鎱?)
  linkQuestions(data) {
    return request.post('/kg/link-questions', data)
  },
  // 蹇€熷叧鑱旈鐩? Embedding - 蹇?)
  linkQuestionsFast(data) {
    return request.post('/kg/link-questions-fast', data)
  },
  // 涓婚鍒楄〃
  getTopics() {
    return request.get('/kg/topics')
  },
  // 鍒涘缓涓婚
  createTopic(data) {
    return request.post('/kg/topics', data)
  },
  // 鏇存柊涓婚
  updateTopic(id, data) {
    return request.put(`/kg/topics/${id}`, data)
  },
  // 鍒犻櫎涓婚
  deleteTopic(id) {
    return request.delete(`/kg/topics/${id}`)
  },
  // 鐭ヨ瘑鍥捐氨缁熻
  getStats() {
    return request.get('/kg/stats')
  },
  // 获取图谱可视化数据
  getGraphData(params) {
    return request.get('/kg/graph-data', { params })
  },
  // 获取图谱统计信息
  getGraphStats() {
    return request.get('/kg/graph-stats')
  },
  // 获取节点详情
  getNodeDetail(type, id) {
    return request.get(`/kg/node-detail/${type}/${id}`)
  },
}

// 涔犻鎺ㄨ崘API
export const recommendationApi = {
  // 涓€у寲鎺ㄨ崘锛堝急椤瑰己鍖栵級
  forMe(params) {
    return request.get('/recommendation/for-me', { params })
  },
  // 鎸夌煡璇嗙偣鎺ㄨ崘
  byKnowledge(params) {
    return request.get('/recommendation/by-knowledge', { params })
  },
  // 鐩镐技棰樼洰鎺ㄨ崘
  similar(params) {
    return request.get('/recommendation/similar', { params })
  },
}

// 棰樼洰璁粌妯″潡API
// Student mastery API
export const masteryApi = {
  myState() {
    return request.get('/mastery/my-state')
  },
  studentState(studentId) {
    return request.get('/mastery/student/' + studentId)
  }
}

export const trainingApi = {
  // 鏁欏笀绔?
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

  // 瀛︾敓绔?
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
    runCode(code, language) {
      return request.post('/student/training/run-code', null, { params: { code, language } })
    },
    runProgrammingTests(trainingSetId, questionId, code, language) {
      return request.post(`/student/training/${trainingSetId}/question/${questionId}/run-tests`, null, {
        params: { code, language }
      })
    },
    getResult(id, attemptId) {
      return request.get(`/student/training/${id}/result/${attemptId}`)
    }
  }
}

// 瀛︾敓鑳藉姏鐢诲儚API

// 浜戜唬鐮佺┖闂碅PI
export const projectApi = {
  // Agent ask
  askAgent(projectId, data) {
    return request.post('/student/projects/' + projectId + '/agent-ask', data)
  },
  optimizePrompt(projectId, data) {
    return request.post('/student/projects/' + projectId + '/agent/prompt/optimize', data)
  },
  agentInterrupt(projectId, sessionId) {
    return request.post('/student/projects/' + projectId + '/agent/interrupt', { sessionId })
  },
  agentConversations(projectId) {
    return request.get('/student/projects/' + projectId + '/agent/conversations')
  },
  agentMessages(projectId, conversationId) {
    return request.get('/student/projects/' + projectId + '/agent/conversations/' + conversationId + '/messages')
  },
  agentDeleteConversation(projectId, conversationId) {
    return request.delete('/student/projects/' + projectId + '/agent/conversations/' + conversationId)
  },
  agentForkConversation(projectId, conversationId, messageId) {
    return request.post('/student/projects/' + projectId + '/agent/conversations/' + conversationId + '/fork', { messageId: messageId || null })
  },
  agentCompactConversation(projectId, conversationId) {
    return request.post('/student/projects/' + projectId + '/agent/conversations/' + conversationId + '/compact')
  },
  agentConversationMemory(projectId, conversationId) {
    return request.get('/student/projects/' + projectId + '/agent/conversations/' + conversationId + '/memory')
  },
  agentApprovePermission(projectId, data) {
    return request.post('/student/projects/' + projectId + '/agent/permission/approve', data)
  },
  agentTokenStats(projectId, conversationId) {
    return request.get('/student/projects/' + projectId + '/agent/tokens/' + conversationId)
  },
  agentTokenSummary(projectId) {
    return request.get('/student/projects/' + projectId + '/agent/tokens/student/summary')
  },
  terminalRun(projectId, command, timeoutSeconds) {
    return request.post('/student/projects/' + projectId + '/terminal/run', { command, timeoutSeconds: timeoutSeconds || 60 })
  },
  terminalCreateSession(projectId) {
    return request.post('/student/projects/' + projectId + '/terminal/sessions', {})
  },
  terminalRunSession(projectId, sessionId, command, timeoutSeconds) {
    return request.post('/student/projects/' + projectId + '/terminal/sessions/' + sessionId + '/run', { command, timeoutSeconds: timeoutSeconds || 60 })
  },
  terminalGetSession(projectId, sessionId) {
    return request.get('/student/projects/' + projectId + '/terminal/sessions/' + sessionId)
  },
  terminalStopSession(projectId, sessionId) {
    return request.post('/student/projects/' + projectId + '/terminal/sessions/' + sessionId + '/stop')
  },
  terminalDeleteSession(projectId, sessionId) {
    return request.delete('/student/projects/' + projectId + '/terminal/sessions/' + sessionId)
  },
  agentChanges(projectId) {
    return request.get('/student/projects/' + projectId + '/agent/changes')
  },
  agentDiff(projectId, changeId) {
    return request.get('/student/projects/' + projectId + '/agent/diff/' + changeId)
  },
  agentApplyDiff(projectId, changeId) {
    return request.post('/student/projects/' + projectId + '/agent/diff/' + changeId + '/apply')
  },
  agentRejectDiff(projectId, changeId) {
    return request.post('/student/projects/' + projectId + '/agent/diff/' + changeId + '/reject')
  },
  agentUndoDiff(projectId, changeId) {
    return request.post('/student/projects/' + projectId + '/agent/diff/' + changeId + '/undo')
  },
  // 原有方法
  list() {
    return request.get('/student/projects')
  },
  createEmpty(name) {
    return request.post('/student/projects/empty', null, { params: { name } })
  },
  upload(file, name) {
    const fd = new FormData()
    fd.append('file', file)
    if (name) fd.append('projectName', name)
    return request.post('/student/projects/upload', fd, { headers: { 'Content-Type': 'multipart/form-data' } })
  },
  detail(id) {
    return request.get('/student/projects/' + id)
  },
  delete(id) {
    return request.delete('/student/projects/' + id)
  },
  getTree(id, path) {
    return request.get('/student/projects/' + id + '/tree', { params: { path: path || '' } })
  },
  readFile(id, path) {
    return request.get('/student/projects/' + id + '/files', { params: { path } })
  },
  saveFile(id, path, content) {
    return request.put('/student/projects/' + id + '/files', { content }, { params: { path } })
  },
  createWithTemplate(name, templateKey) {
    return request.post('/student/projects/template', null, { params: { name, templateKey } })
  },
  renameItem(id, path, newName) {
    return request.put('/student/projects/' + id + '/files/item', { path, newName })
  },
  createItem(projectId, parentPath, name, type) {
    return request.post('/student/projects/' + projectId + '/files/item', { parentPath, name, type })
  },
  deleteItem(projectId, path) {
    return request.delete('/student/projects/' + projectId + '/files/item', { params: { path } })
  },
  exportProject(projectId) {
    return request.get('/student/projects/' + projectId + '/export', { responseType: 'blob' })
  },
  renameProject(projectId, name) {
    return request.put('/student/projects/' + projectId + '/rename', { name })
  }
}

export const modelConfigApi = {
  list() {
    return request.get('/student/model-configs')
  },
  get(configId) {
    return request.get('/student/model-configs/' + configId)
  },
  create(data) {
    return request.post('/student/model-configs', data)
  },
  update(configId, data) {
    return request.put('/student/model-configs/' + configId, data)
  },
  delete(configId) {
    return request.delete('/student/model-configs/' + configId)
  },
  getDefault() {
    return request.get('/student/model-configs/default')
  },
  getProviders() {
    return request.get('/student/model-configs/providers')
  },
  testConnection(configId) {
    return request.post('/student/model-configs/' + configId + '/test')
  }
}

export const agentExtensionApi = {
  listSkills() {
    return request.get('/student/agent/extensions/skills')
  },
  createSkill(data) {
    return request.post('/student/agent/extensions/skills', data)
  },
  updateSkill(skillId, data) {
    return request.put('/student/agent/extensions/skills/' + skillId, data)
  },
  deleteSkill(skillId) {
    return request.delete('/student/agent/extensions/skills/' + skillId)
  },
  listMcpServers() {
    return request.get('/student/agent/extensions/mcp')
  },
  createMcpServer(data) {
    return request.post('/student/agent/extensions/mcp', data)
  },
  updateMcpServer(serverId, data) {
    return request.put('/student/agent/extensions/mcp/' + serverId, data)
  },
  deleteMcpServer(serverId) {
    return request.delete('/student/agent/extensions/mcp/' + serverId)
  }
}

// AI题目生成API
export const aiQuestionApi = {
  // 异步生成题目
  generate(data) {
    return request.post('/teacher/ai-question/generate', data)
  },

  // 同步生成题目（等待完成）
  generateSync(data) {
    return request.post('/teacher/ai-question/generate-sync', data)
  },

  // 获取生成批次状态
  getBatch(batchId) {
    return request.get('/teacher/ai-question/batch/' + batchId)
  },

  // 获取教师的所有生成批次
  getBatches() {
    return request.get('/teacher/ai-question/batches')
  },

  // 获取批次统计信息
  getBatchStatistics(batchId) {
    return request.get('/teacher/ai-question/batch/' + batchId + '/statistics')
  },

  // 获取批次的所有题目
  getBatchQuestions(batchId) {
    return request.get('/teacher/ai-question/batch/' + batchId + '/questions')
  },

  // 获取单个题目详情
  getQuestion(tempId) {
    return request.get('/teacher/ai-question/question/' + tempId)
  },

  // 批准题目
  approveQuestion(tempId) {
    return request.post('/teacher/ai-question/question/' + tempId + '/approve')
  },

  // 拒绝题目
  rejectQuestion(tempId) {
    return request.post('/teacher/ai-question/question/' + tempId + '/reject')
  },

  // 修改题目内容
  updateQuestion(tempId, updates) {
    return request.put('/teacher/ai-question/question/' + tempId, updates)
  },

  // 重新生成题目
  regenerateQuestion(tempId, requirements) {
    return request.post('/teacher/ai-question/question/' + tempId + '/regenerate', { requirements })
  },

  // 持久化单个题目到数据库
  persistQuestion(tempId) {
    return request.post('/teacher/ai-question/question/' + tempId + '/persist')
  },

  // 批量持久化题目到数据库
  batchPersistQuestions(batchId, tempIds) {
    return request.post('/teacher/ai-question/batch/' + batchId + '/persist', tempIds)
  },

  // 删除生成批次
  deleteBatch(batchId) {
    return request.delete('/teacher/ai-question/batch/' + batchId)
  },

  // 获取批次剩余过期时间
  getBatchTTL(batchId) {
    return request.get('/teacher/ai-question/batch/' + batchId + '/ttl')
  }
}

