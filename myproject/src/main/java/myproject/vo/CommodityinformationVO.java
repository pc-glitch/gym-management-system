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
* 商品信息
*
*/
@Data
@Schema(description = "商品信息")
@JsonIgnoreProperties(ignoreUnknown = true)
public class CommodityinformationVO implements Serializable {
private static final long serialVersionUID = 1L;

        @Schema(description = "主键")
        @ExcelIgnore
    private Long id;

        @Schema(description = "商品名称")
        @ExcelProperty("商品名称")
    private String name;

        @Schema(description = "所属分类")
        @ExcelProperty("所属分类")
    private String classify;

        @Schema(description = "品牌")
        @ExcelProperty("品牌")
    private String brand;

        @Schema(description = "单位")
        @ExcelProperty("单位")
    private String units;

        @Schema(description = "规格详情")
        @ExcelProperty("规格详情")
    private String specificationsdetails;

        @Schema(description = "描述")
        @ExcelProperty("描述")
    private String description;

        @Schema(description = "价格")
        @ExcelProperty("价格")
    private Integer price;

        @Schema(description = "封面")
        @ExcelProperty("封面")
    private String photo;

        @Schema(description = "详情图")
        @ExcelProperty("详情图")
    private String photos;

        @Schema(description = "详细信息")
        @ExcelProperty("详细信息")
    private String details;

        @Schema(description = "发布人id")
        @ExcelProperty("发布人id")
    private Long adduserid;

        @Schema(description = "发布人")
        @ExcelProperty("发布人")
    private String addusername;

        @Schema(description = "创建时间")
        @JsonFormat(pattern = DateUtils.DATE_TIME_PATTERN)
        @ExcelProperty("创建时间")
    private Date addtime;


}