package myproject.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
    import java.util.Date;

/**
* 活动信息
*
*/

@Data
@TableName("activityinformation")
public class ActivityinformationEntity {
        /**
        * 主键
        */
        @TableId
        private Long id;

        /**
        * 活动名称
        */
        private String name;

        /**
        * 活动类型
        */
        private String classify;

        /**
        * 活动主题
        */
        private String activitytheme;

        /**
        * 主办部门
        */
        private String sponsoringdepartment;

        /**
        * 活动时间
        */
        private String activitytime;

        /**
        * 活动地点
        */
        private String venue;

        /**
        * 活动状态
        */
        private String activestate;

        /**
        * 活动规则
        */
        private String activityrules;

        /**
        * 简介
        */
        private String introduction;

        /**
        * 封面
        */
        private String photo;

        /**
        * 详情图
        */
        private String photos;

        /**
        * 详细信息
        */
        private String details;

        /**
        * 创建人id
        */
        private Long adduserid;

        /**
        * 创建人名称
        */
        private String addusername;

        /**
        * 创建时间
        */
        @TableField(fill = FieldFill.INSERT)
        private Date addtime;

}