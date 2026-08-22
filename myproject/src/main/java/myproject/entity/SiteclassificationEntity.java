package myproject.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
    import java.util.Date;

/**
* 场地分类
*
*/

@Data
@TableName("siteclassification")
public class SiteclassificationEntity {
        /**
        * 主键
        */
        @TableId
        private Long id;

        /**
        * 分类名称
        */
        private String name;

        /**
        * 创建时间
        */
        @TableField(fill = FieldFill.INSERT)
        private Date addtime;

}