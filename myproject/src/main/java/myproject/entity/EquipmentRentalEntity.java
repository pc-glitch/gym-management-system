package myproject.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
    import java.util.Date;

/**
* 器材租借
*
*/

@Data
@EqualsAndHashCode(callSuper = false)
@TableName("equipment_rental")
public class EquipmentRentalEntity {
        /**
        * 主键
        */
        @TableId
        private Long id;

        /**
        * 器材id
        */
        private Long equipmentid;

        /**
        * 器材名称
        */
        private String equipmentname;

        /**
        * 租借人id
        */
        private Long userid;

        /**
        * 租借人名称
        */
        private String username;

        /**
        * 租借数量
        */
        private Integer quantity;

        /**
        * 租借时间
        */
        private Date rentaltime;

        /**
        * 预计归还时间
        */
        private Date expectedreturntime;

        /**
        * 实际归还时间
        */
        private Date actualreturntime;

        /**
        * 租借状态
        */
        private String status;

        /**
        * 审批状态
        */
        private String approvalstatus;

        /**
        * 审批回复
        */
        private String approvalremark;

        /**
        * 备注
        */
        private String remark;

      

        /**
        * 创建时间
        */
        @TableField(fill = FieldFill.INSERT)
        private Date addtime;

}