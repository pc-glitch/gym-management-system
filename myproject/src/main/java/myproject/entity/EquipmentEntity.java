package myproject.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
    import java.util.Date;

/**
* 器材信息
*
*/

@Data
@EqualsAndHashCode(callSuper = false)
@TableName("equipment")
public class EquipmentEntity {
        /**
        * 主键
        */
        @TableId
        private Long id;

        /**
        * 器材名称
        */
        private String name;

        /**
        * 器材分类
        */
        private String classify;

        /**
        * 器材编号
        */
        private String equipmentno;

        /**
        * 品牌
        */
        private String brand;

        /**
        * 型号
        */
        private String model;

        /**
        * 购买日期
        */
        private Date purchasedate;

        /**
        * 保修截止日期
        */
        private Date warrantyenddate;

        /**
        * 器材状态
        */
        private String status;

        /**
        * 存放位置
        */
        private String location;

        /**
        * 单价
        */
        private Double price;

        /**
        * 数量
        */
        private Integer quantity;

        /**
        * 已借数量
        */
        private Integer borrowedquantity;

        /**
        * 剩余数量
        */
        private Integer remainingquantity;

        /**
        * 器材描述
        */
        private String description;

        /**
        * 封面图片
        */
        private String photo;

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