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
* 场地预约
*
*/
@Data
@Schema(description = "场地预约")
@JsonIgnoreProperties(ignoreUnknown = true)
public class VenuereservationVO implements Serializable {
private static final long serialVersionUID = 1L;

        @Schema(description = "主键")
        @ExcelIgnore
    private Long id;

        @Schema(description = "场地名称")
        @ExcelProperty("场地名称")
    private String name;

        @Schema(description = "预约开始时间")
        @JsonFormat(pattern = DateUtils.DATE_TIME_PATTERN)
        @ExcelProperty("预约开始时间")
    private Date thereservationstarttime;

        @Schema(description = "预约结束时间")
        @JsonFormat(pattern = DateUtils.DATE_TIME_PATTERN)
        @ExcelProperty("预约结束时间")
    private Date appointmentendtime;

        @Schema(description = "封面")
        @ExcelProperty("封面")
    private String photo;

        @Schema(description = "备注信息")
        @ExcelProperty("备注信息")
    private String remarkinformation;

        @Schema(description = "预约人id")
        @ExcelProperty("预约人id")
    private Long reservationpersonid;

        @Schema(description = "预约人")
        @ExcelProperty("预约人")
    private String reservationpersonname;

        @Schema(description = "审核人id")
        @ExcelProperty("审核人id")
    private Long adduserid;

        @Schema(description = "审核人")
        @ExcelProperty("审核人")
    private String addusername;

        @Schema(description = "审核")
        @ExcelProperty("审核")
    private String shenhe;

        @Schema(description = "场地id")
        @ExcelProperty("场地id")
    private Long shenheid;

        @Schema(description = "审核回复")
        @ExcelProperty("审核回复")
    private String shenhehuifu;

        @Schema(description = "用户id")
        @ExcelProperty("用户id")
    private Long userid;

        @Schema(description = "用户名称")
        @ExcelProperty("用户名称")
    private String username;

        @Schema(description = "创建时间")
        @JsonFormat(pattern = DateUtils.DATE_TIME_PATTERN)
        @ExcelProperty("创建时间")
    private Date addtime;


}