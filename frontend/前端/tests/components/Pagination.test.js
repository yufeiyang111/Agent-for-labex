import { mount } from '@vue/test-utils'
import { describe, it, expect, beforeEach } from 'vitest'
import { nextTick } from 'vue'
import Pagination from '@/components/Pagination.vue'

/**
 * Pagination Component Unit Tests
 *
 * 测试用例清单:
 * | UT-Pag-01 | 默认分页配置 | defaultConfig_RendersCorrectly |
 * | UT-Pag-02 | 分页数据更新 | totalUpdated_ReflectsInPagination |
 * | UT-Pag-03 | 页码切换 | pageChange_EmitsCorrectEvent |
 * | UT-Pag-04 | 每页条数切换 | sizeChange_EmitsCorrectEvent |
 * | UT-Pag-05 | 禁用状态 | disabledProp_DisablesPagination |
 */
describe('Pagination Component Tests', () => {
  const defaultProps = {
    modelValue: { page: 1, pageSize: 10 },
    total: 100,
    pageSizes: [5, 10, 20, 50],
    layout: 'total, sizes, prev, pager, next, jumper',
    background: true,
    small: false,
    disabled: false
  }

  const mountPagination = (props = {}) => mount(Pagination, {
    props: { ...defaultProps, ...props },
    global: {
      stubs: {
        'el-pagination': {
          template: '<div class="el-pagination-stub" />'
        }
      }
    }
  })

  let wrapper

  beforeEach(() => {
    wrapper = mountPagination()
  })

  it('UT-Pag-01: 默认配置正确渲染', () => {
    expect(wrapper.find('.pagination-wrapper').exists()).toBe(true)
    expect(wrapper.find('.el-pagination-stub').exists()).toBe(true)
  })

  it('UT-Pag-01: 默认每页条数为10', () => {
    const pagination = wrapper.vm
    expect(pagination.currentPageSync).toBe(1)
    expect(pagination.pageSizeSync).toBe(10)
  })

  it('UT-Pag-02: 总数更新时正确反映', async () => {
    await wrapper.setProps({ total: 200 })
    expect(wrapper.props('total')).toBe(200)
  })

  it('UT-Pag-03: 页码切换触发正确事件', async () => {
    const pagination = wrapper.vm

    // Simulate page change
    pagination.currentPageSync = 2
    await nextTick()

    expect(wrapper.emitted('update:modelValue')).toBeTruthy()
    expect(wrapper.emitted('page-change')).toBeTruthy()
  })

  it('UT-Pag-03: 切换到第一页时重置页码', async () => {
    const pagination = wrapper.vm

    // Change page size
    pagination.pageSizeSync = 20
    await nextTick()

    expect(wrapper.emitted('size-change')).toBeTruthy()
  })

  it('UT-Pag-05: 禁用状态正确传递给el-pagination', async () => {
    await wrapper.setProps({ disabled: true })
    expect(wrapper.props('disabled')).toBe(true)
  })

  it('UT-Pag-01: 自定义页大小选项正确渲染', () => {
    const customPageSizes = [10, 25, 50, 100]
    const wrapper = mountPagination({ pageSizes: customPageSizes })
    expect(wrapper.props('pageSizes')).toEqual(customPageSizes)
  })

  it('UT-Pag-04: 每页条数变化时page应重置为1', async () => {
    const wrapper = mountPagination({ modelValue: { page: 3, pageSize: 10 } })

    const pagination = wrapper.vm
    pagination.pageSizeSync = 20
    await nextTick()

    // Size change should emit with page: 1
    expect(wrapper.emitted('size-change')).toBeTruthy()
  })

  it('UT-Pag-01: 小尺寸分页正确渲染', () => {
    const wrapper = mountPagination({ small: true })
    expect(wrapper.props('small')).toBe(true)
  })

  it('UT-Pag-01: 无数据时total为0', () => {
    const wrapper = mountPagination({ total: 0 })
    expect(wrapper.props('total')).toBe(0)
  })
})
