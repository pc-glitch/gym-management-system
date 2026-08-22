package myproject.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
    import java.util.Date;

/**
* 赛事报名
*
*/

@Data
@TableName("eventregistration")
public class EventregistrationEntity {
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
        * 赛事id
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