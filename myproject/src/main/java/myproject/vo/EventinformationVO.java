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
* 赛事信息
*
*/
@Data
@Schema(description = "赛事信息")
@JsonIgnoreProperties(ignoreUnknown = true)
public class EventinformationVO implements Serializable {
private static final long serialVersionUID = 1L;

        @Schema(description = "主键")
        @ExcelIgnore
    private Long id;

        @Schema(description = "赛事名称")
        @ExcelProperty("赛事名称")
    private String name;

        @Schema(description = "赛事类型")
        @ExcelProperty("赛事类型")
    private String classify;

        @Schema(description = "赛事级别")
        @ExcelProperty("赛事级别")
    private String theleveloftheevent;

        @Schema(description = "举办地点")
        @ExcelProperty("举办地点")
    private String venue;

        @Schema(description = "举办日期")
        @JsonFormat(pattern = DateUtils.DATE_TIME_PATTERN)
        @ExcelProperty("举办日期")
    private Date holdingdate;

        @Schema(description = "比赛时间")
        @ExcelProperty("比赛时间")
    private String competitiontime;

        @Schema(description = "赛程安排")
        @ExcelProperty("赛程安排")
    private String totheschedule;

        @Schema(description = "规则与背景")
        @ExcelProperty("规则与背景")
    private String rulesandbackground;

        @Schema(description = "封面")
        @ExcelProperty("封面")
    private String photo;

        @Schema(description = "详情图")
        @ExcelProperty("详情图")
    private String photos;

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