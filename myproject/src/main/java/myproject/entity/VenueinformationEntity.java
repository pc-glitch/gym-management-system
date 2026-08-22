package myproject.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
    import java.util.Date;

/**
* 场地信息
*
*/

@Data
@TableName("venueinformation")
public class VenueinformationEntity {
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
        * 俱乐部名称
        */
        private String clubname;

        /**
        * 用途类型
        */
        private String classify;

        /**
        * 场地状态
        */
        private String yardstate;

        /**
        * 场地规格
        */
        private String venuespecifications;

        /**
        *  配套设施
        */
        private String supportingfacilities;

        /**
        * 服务信息
        */
        private String serviceinformation;

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