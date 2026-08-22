package myproject.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
    import java.util.Date;

/**
* 活动报名
*
*/

@Data
@TableName("activityregistration")
public class ActivityregistrationEntity {
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
        * 活动id
        */
        private Long shenheid;

        /**
        * 报名人id
        */
        private Long userid;

        /**
        * 报名人
        */
        private String username;

        /**
        * 审核
        */
        private String shenhe;

        /**
        * 封面
        */
        private String photo;

        /**
        * 报名信息
        */
        private String registrationinformation;

        /**
        * 审核人id
        */
        private Long adduserid;

        /**
        * 审核人
        */
        private String addusername;

        /**
        * 审核回复
        */
        private String shenhehuifu;

        /**
        * 创建时间
        */
        @TableField(fill = FieldFill.INSERT)
        private Date addtime;

}
