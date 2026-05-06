/**
 * 题目类型枚举
 */
export const QUESTION_TYPES = {
  FILL_BLANK: 1,      // 填空
  SINGLE_CHOICE: 2,   // 单选
  MULTIPLE_CHOICE: 3, // 多选
  TRUE_FALSE: 4,      // 判断
  SHORT_ANSWER: 5,    // 简答
  PROGRAMMING: 6,     // 编程
  COMPREHENSIVE: 7    // 综合
}

/**
 * 获取题目类型名称
 * @param {number} type
 */
export function getQuestionTypeName(type) {
  const typeMap = {
    1: '填空题',
    2: '单选题',
    3: '多选题',
    4: '判断题',
    5: '简答题',
    6: '编程题',
    7: '综合题'
  }
  return typeMap[type] || '未知题型'
}

/**
 * 学生状态枚举
 */
export const STUDENT_STATE = {
  NORMAL: 0,  // 正常
  DISABLED: 1 // 禁用
}

/**
 * 实验状态枚举
 */
export const EXPERIMENT_STATE = {
  DISABLED: 0, // 禁用
  ENABLED: 1   // 启用
}
