package myproject.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
    import java.util.Date;

/**
* 场地预约
*
*/

@Data
@TableName("venuereservation")
public class VenuereservationEntity {
        /**
        * 主键
        */
        @TableId
        private Long id;

        /**
        * 场地名称
        */
        private String name;

        /**
        * 预约开始时间
        */
        private Date thereservationstarttime;

        /**
        * 预约结束时间
        */
        private Date appointmentendtime;

        /**
        * 封面
        */
        private String photo;

        /**
        * 备注信息
        */
        private String remarkinformation;

        /**
        * 预约人id
        */
        private Long reservationpersonid;

        /**
        * 预约人
        */
        private String reservationpersonname;

        /**
        * 审核人id
        */
        private Long adduserid;

        /**
        * 审核人
        */
        private String addusername;

        /**
        * 审核
        */
        private String shenhe;

        /**
        * 场地id
        */
        private Long shenheid;

        /**
        * 审核回复
        */
        private String shenhehuifu;

        /**
        * 用户id
        */
        private Long userid;

        /**
        * 用户名称
        */
        private String username;

        /**
        * 创建时间
        */
        @TableField(fill = FieldFill.INSERT)
        private Date addtime;

}