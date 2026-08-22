package myproject.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
    import java.util.Date;

/**
* 赛事信息
*
*/

@Data
@TableName("eventinformation")
public class EventinformationEntity {
        /**
        * 主键
        */
        @TableId
        private Long id;

        /**
        * 赛事名称
        */
        private String name;

        /**
        * 赛事类型
        */
        private String classify;

        /**
        * 赛事级别
        */
        private String theleveloftheevent;

        /**
        * 举办地点
        */
        private String venue;

        /**
        * 举办日期
        */
        private Date holdingdate;

        /**
        * 比赛时间
        */
        private String competitiontime;

        /**
        * 赛程安排
        */
        private String totheschedule;

        /**
        * 规则与背景
        */
        private String rulesandbackground;

        /**
        * 封面
        */
        private String photo;

        /**
        * 详情图
        */
        private String photos;

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