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
* 活动信息
*
*/
@Data
@Schema(description = "活动信息")
@JsonIgnoreProperties(ignoreUnknown = true)
public class ActivityinformationVO implements Serializable {
private static final long serialVersionUID = 1L;

        @Schema(description = "主键")
        @ExcelIgnore
    private Long id;

        @Schema(description = "活动名称")
        @ExcelProperty("活动名称")
    private String name;

        @Schema(description = "活动类型")
        @ExcelProperty("活动类型")
    private String classify;

        @Schema(description = "活动主题")
        @ExcelProperty("活动主题")
    private String activitytheme;

        @Schema(description = "主办部门")
        @ExcelProperty("主办部门")
    private String sponsoringdepartment;

        @Schema(description = "活动时间")
        @ExcelProperty("活动时间")
    private String activitytime;

        @Schema(description = "活动地点")
        @ExcelProperty("活动地点")
    private String venue;

        @Schema(description = "活动状态")
        @ExcelProperty("活动状态")
    private String activestate;

        @Schema(description = "活动规则")
        @ExcelProperty("活动规则")
    private String activityrules;

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