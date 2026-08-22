package myproject.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
    import java.util.Date;

/**
* 商品信息
*
*/

@Data
@TableName("commodityinformation")
public class CommodityinformationEntity {
        /**
        * 主键
        */
        @TableId
        private Long id;

        /**
        * 商品名称
        */
        private String name;

        /**
        * 所属分类
        */
        private String classify;

        /**
        * 品牌
        */
        private String brand;

        /**
        * 单位
        */
        private String units;

        /**
        * 规格详情
        */
        private String specificationsdetails;

        /**
        * 描述
        */
        private String description;

        /**
        * 价格
        */
        private Integer price;

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
        * 发布人id
        */
        private Long adduserid;

        /**
        * 发布人
        */
        private String addusername;

        /**
        * 创建时间
        */
        @TableField(fill = FieldFill.INSERT)
        private Date addtime;

}