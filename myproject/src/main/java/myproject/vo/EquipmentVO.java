package myproject.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.io.Serializable;
import myproject.common.utils.DateUtils;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
    import java.util.Date;

/**
* 器材信息
*
*/
@Data
@Schema(description = "器材信息")
@JsonIgnoreProperties(ignoreUnknown = true)
public class EquipmentVO implements Serializable {
private static final long serialVersionUID = 1L;

        @Schema(description = "主键")
        @ExcelIgnore
    private Long id;

        @Schema(description = "器材名称")
        @ExcelProperty("器材名称")
    private String name;

        @Schema(description = "器材分类")
        @ExcelProperty("器材分类")
    private String classify;

        @Schema(description = "器材编号")
        @ExcelProperty("器材编号")
    private String equipmentno;

        @Schema(description = "品牌")
        @ExcelProperty("品牌")
    private String brand;

        @Schema(description = "型号")
        @ExcelProperty("型号")
    private String model;

        @Schema(description = "购买日期")
        @JsonFormat(pattern = DateUtils.DATE_PATTERN)
        @ExcelProperty("购买日期")
    private Date purchasedate;

        @Schema(description = "保修截止日期")
        @JsonFormat(pattern = DateUtils.DATE_PATTERN)
        @ExcelProperty("保修截止日期")
    private Date warrantyenddate;

        @Schema(description = "器材状态")
        @ExcelProperty("器材状态")
    private String status;

        @Schema(description = "存放位置")
        @ExcelProperty("存放位置")
    private String location;

        @Schema(description = "单价")
        @ExcelProperty("单价")
    private Double price;

        @Schema(description = "数量")
        @ExcelProperty("数量")
    private Integer quantity;

        @Schema(description = "已借数量")
        @ExcelProperty("已借数量")
    private Integer borrowedquantity;

        @Schema(description = "剩余数量")
        @ExcelProperty("剩余数量")
    private Integer remainingquantity;

        @Schema(description = "器材描述")
        @ExcelProperty("器材描述")
    private String description;

        @Schema(description = "封面图片")
        @ExcelProperty("封面图片")
    private String photo;

        @Schema(description = "创建人id")
        @ExcelProperty("创建人id")
    private Long adduserid;

        @Schema(description = "创建人名称")
        @ExcelProperty("创建人名称")
    private String addusername;

        @Schema(description = "创建时间")
        @JsonFormat(pattern = DateUtils.DATE_TIME_PATTERN)
        @ExcelProperty("创建时间")
    private Date addtime;


}