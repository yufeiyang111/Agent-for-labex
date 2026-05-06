package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

/**
 * 习题类型实体类
 */
@Data
@TableName("t_question_type")
public class QuestionType {

    @TableId(value = "type_id")
    private Integer typeId;

    @TableField("type_name")
    private String typeName;
}
