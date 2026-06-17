package com.labex.kg.service;

import com.labex.kg.dto.KnowledgePointDTO;
import com.labex.kg.dto.TopicDTO;
import com.labex.kg.dto.GraphDataDTO;
import com.labex.kg.repository.KnowledgeGraphRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 知识图谱服务测试
 * 测试人员：周志文
 * 测试内容：知识点管理、知识图谱构建、知识图谱查询
 */
@ExtendWith(MockitoExtension.class)
public class KnowledgeGraphServiceTest {

    @InjectMocks
    private KnowledgeGraphService knowledgeGraphService;

    @Mock
    private KnowledgeGraphRepository knowledgeGraphRepository;

    /**
     * 测试创建知识点
     */
    @Test
    public void testCreateKnowledgePoint() {
        KnowledgePointDTO dto = new KnowledgePointDTO();
        dto.setName("Java多态");
        dto.setDescription("Java中多态的概念和实现");
        dto.setCourseId(1L);
        dto.setDifficulty(3);

        when(knowledgeGraphRepository.createKnowledgePoint(any(KnowledgePointDTO.class)))
                .thenReturn(dto);

        KnowledgePointDTO result = knowledgeGraphService.createKnowledgePoint(dto);

        assertNotNull(result);
        assertEquals("Java多态", result.getName());
        assertEquals("Java中多态的概念和实现", result.getDescription());
        verify(knowledgeGraphRepository).createKnowledgePoint(any(KnowledgePointDTO.class));
    }

    /**
     * 测试获取知识点详情
     */
    @Test
    public void testGetKnowledgePoint() {
        Long kpId = 1L;
        KnowledgePointDTO dto = new KnowledgePointDTO();
        dto.setId(kpId);
        dto.setName("Java多态");
        dto.setDescription("Java中多态的概念和实现");

        when(knowledgeGraphRepository.getKnowledgePoint(kpId)).thenReturn(dto);

        KnowledgePointDTO result = knowledgeGraphService.getKnowledgePoint(kpId);

        assertNotNull(result);
        assertEquals(kpId, result.getId());
        assertEquals("Java多态", result.getName());
        verify(knowledgeGraphRepository).getKnowledgePoint(kpId);
    }

    /**
     * 测试更新知识点
     */
    @Test
    public void testUpdateKnowledgePoint() {
        Long kpId = 1L;
        KnowledgePointDTO dto = new KnowledgePointDTO();
        dto.setId(kpId);
        dto.setName("更新知识点");
        dto.setDescription("更新描述");
        dto.setDifficulty(4);

        when(knowledgeGraphRepository.updateKnowledgePoint(any(KnowledgePointDTO.class)))
                .thenReturn(dto);

        KnowledgePointDTO result = knowledgeGraphService.updateKnowledgePoint(dto);

        assertNotNull(result);
        assertEquals("更新知识点", result.getName());
        assertEquals(4, result.getDifficulty());
        verify(knowledgeGraphRepository).updateKnowledgePoint(any(KnowledgePointDTO.class));
    }

    /**
     * 测试删除知识点
     */
    @Test
    public void testDeleteKnowledgePoint() {
        Long kpId = 1L;

        doNothing().when(knowledgeGraphRepository).deleteKnowledgePoint(kpId);

        knowledgeGraphService.deleteKnowledgePoint(kpId);

        verify(knowledgeGraphRepository).deleteKnowledgePoint(kpId);
    }

    /**
     * 测试获取知识点列表
     */
    @Test
    public void testGetKnowledgePointList() {
        Long courseId = 1L;
        List<KnowledgePointDTO> list = Arrays.asList(
                createKnowledgePointDTO(1L, "Java多态", 3),
                createKnowledgePointDTO(2L, "Java继承", 2),
                createKnowledgePointDTO(3L, "Java封装", 2)
        );

        when(knowledgeGraphRepository.getKnowledgePointList(courseId)).thenReturn(list);

        List<KnowledgePointDTO> result = knowledgeGraphService.getKnowledgePointList(courseId);

        assertNotNull(result);
        assertEquals(3, result.size());
        assertEquals("Java多态", result.get(0).getName());
        verify(knowledgeGraphRepository).getKnowledgePointList(courseId);
    }

    /**
     * 测试构建知识图谱
     */
    @Test
    public void testBuildKnowledgeGraph() {
        Long courseId = 1L;

        doNothing().when(knowledgeGraphRepository).buildKnowledgeGraph(courseId);

        knowledgeGraphService.buildKnowledgeGraph(courseId);

        verify(knowledgeGraphRepository).buildKnowledgeGraph(courseId);
    }

    /**
     * 测试获取知识图谱数据
     */
    @Test
    public void testGetKnowledgeGraph() {
        Long courseId = 1L;
        GraphDataDTO graphData = new GraphDataDTO();
        graphData.setNodes(Arrays.asList("Java多态", "Java继承", "Java封装"));
        graphData.setEdges(Arrays.asList("Java多态->Java继承", "Java继承->Java封装"));

        when(knowledgeGraphRepository.getKnowledgeGraph(courseId)).thenReturn(graphData);

        GraphDataDTO result = knowledgeGraphService.getKnowledgeGraph(courseId);

        assertNotNull(result);
        assertEquals(3, result.getNodes().size());
        assertEquals(2, result.getEdges().size());
        verify(knowledgeGraphRepository).getKnowledgeGraph(courseId);
    }

    /**
     * 测试创建主题
     */
    @Test
    public void testCreateTopic() {
        TopicDTO dto = new TopicDTO();
        dto.setName("面向对象编程");
        dto.setDescription("OOP基本概念");

        when(knowledgeGraphRepository.createTopic(any(TopicDTO.class))).thenReturn(dto);

        TopicDTO result = knowledgeGraphService.createTopic(dto);

        assertNotNull(result);
        assertEquals("面向对象编程", result.getName());
        verify(knowledgeGraphRepository).createTopic(any(TopicDTO.class));
    }

    /**
     * 测试获取主题列表
     */
    @Test
    public void testGetTopicList() {
        List<TopicDTO> list = Arrays.asList(
                createTopicDTO(1L, "面向对象编程"),
                createTopicDTO(2L, "数据结构"),
                createTopicDTO(3L, "算法")
        );

        when(knowledgeGraphRepository.getTopicList()).thenReturn(list);

        List<TopicDTO> result = knowledgeGraphService.getTopicList();

        assertNotNull(result);
        assertEquals(3, result.size());
        verify(knowledgeGraphRepository).getTopicList();
    }

    /**
     * 测试创建知识点关联关系
     */
    @Test
    public void testCreateKnowledgePointRelation() {
        Long sourceId = 1L;
        Long targetId = 2L;
        String relationType = "PREREQUISITE";

        doNothing().when(knowledgeGraphRepository).createRelation(sourceId, targetId, relationType);

        knowledgeGraphService.createKnowledgePointRelation(sourceId, targetId, relationType);

        verify(knowledgeGraphRepository).createRelation(sourceId, targetId, relationType);
    }

    /**
     * 测试删除知识点关联关系
     */
    @Test
    public void testDeleteKnowledgePointRelation() {
        Long relationId = 1L;

        doNothing().when(knowledgeGraphRepository).deleteRelation(relationId);

        knowledgeGraphService.deleteKnowledgePointRelation(relationId);

        verify(knowledgeGraphRepository).deleteRelation(relationId);
    }

    /**
     * 测试获取知识点关联关系
     */
    @Test
    public void testGetKnowledgePointRelations() {
        Long kpId = 1L;
        List<KnowledgePointDTO> relations = Arrays.asList(
                createKnowledgePointDTO(2L, "Java继承", 2),
                createKnowledgePointDTO(3L, "Java封装", 2)
        );

        when(knowledgeGraphRepository.getRelatedKnowledgePoints(kpId)).thenReturn(relations);

        List<KnowledgePointDTO> result = knowledgeGraphService.getKnowledgePointRelations(kpId);

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(knowledgeGraphRepository).getRelatedKnowledgePoints(kpId);
    }

    /**
     * 测试搜索知识点
     */
    @Test
    public void testSearchKnowledgePoints() {
        String keyword = "多态";
        Long courseId = 1L;
        List<KnowledgePointDTO> list = Arrays.asList(
                createKnowledgePointDTO(1L, "Java多态", 3)
        );

        when(knowledgeGraphRepository.searchKnowledgePoints(keyword, courseId)).thenReturn(list);

        List<KnowledgePointDTO> result = knowledgeGraphService.searchKnowledgePoints(keyword, courseId);

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("Java多态", result.get(0).getName());
        verify(knowledgeGraphRepository).searchKnowledgePoints(keyword, courseId);
    }

    // ==================== 辅助方法 ====================

    private KnowledgePointDTO createKnowledgePointDTO(Long id, String name, Integer difficulty) {
        KnowledgePointDTO dto = new KnowledgePointDTO();
        dto.setId(id);
        dto.setName(name);
        dto.setDifficulty(difficulty);
        return dto;
    }

    private TopicDTO createTopicDTO(Long id, String name) {
        TopicDTO dto = new TopicDTO();
        dto.setId(id);
        dto.setName(name);
        return dto;
    }
}
