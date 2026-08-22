package myproject.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import myproject.common.query.Query;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
    import java.util.Date;

/**
* 器材信息查询
*
*/
@Data
@EqualsAndHashCode(callSuper = false)
@Schema(description = "器材信息查询")
@JsonIgnoreProperties(ignoreUnknown = true)
public class EquipmentQuery extends Query {
    @Schema(description = "主键")
    private Long id;

    @Schema(description = "器材名称")
    private String name;

    @Schema(description = "器材分类")
    private String classify;

    @Schema(description = "器材编号")
    private String equipmentno;

    @Schema(description = "品牌")
    private String brand;

    @Schema(description = "型号")
    private String model;

    @Schema(description = "购买日期")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] purchasedate;

    @Schema(description = "保修截止日期")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] warrantyenddate;

    @Schema(description = "器材状态")
    private String status;

    @Schema(description = "存放位置")
    private String location;

    @Schema(description = "单价")
    private Double price;

    @Schema(description = "数量")
    private Integer quantity;

    @Schema(description = "已借数量")
    private Integer borrowedquantity;

    @Schema(description = "剩余数量")
    private Integer remainingquantity;

    @Schema(description = "器材描述")
    private String description;

    @Schema(description = "封面图片")
    private String photo;

    @Schema(description = "创建人id")
    private Long adduserid;

    @Schema(description = "创建人名称")
    private String addusername;

    @Schema(description = "创建时间")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] addtime;

}