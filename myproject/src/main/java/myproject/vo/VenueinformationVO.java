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
* 场地信息
*
*/
@Data
@Schema(description = "场地信息")
@JsonIgnoreProperties(ignoreUnknown = true)
public class VenueinformationVO implements Serializable {
private static final long serialVersionUID = 1L;

        @Schema(description = "主键")
        @ExcelIgnore
    private Long id;

        @Schema(description = "场地名称")
        @ExcelProperty("场地名称")
    private String name;

        @Schema(description = "俱乐部名称")
        @ExcelProperty("俱乐部名称")
    private String clubname;

        @Schema(description = "用途类型")
        @ExcelProperty("用途类型")
    private String classify;

        @Schema(description = "场地状态")
        @ExcelProperty("场地状态")
    private String yardstate;

        @Schema(description = "场地规格")
        @ExcelProperty("场地规格")
    private String venuespecifications;

        @Schema(description = " 配套设施")
        @ExcelProperty(" 配套设施")
    private String supportingfacilities;

        @Schema(description = "服务信息")
        @ExcelProperty("服务信息")
    private String serviceinformation;

        @Schema(description = "简介")
        @ExcelProperty("简介")
    private String introduction;

        @Schema(description = "封面")
        @ExcelProperty("封面")
    private String photo;

        @Schema(description = "详情图")
        @ExcelProperty("详情图")
    private String photos;

        @Schema(description = "详细信息")
        @ExcelProperty("详细信息")
    private String details;

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