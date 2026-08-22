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
* 赛事报名
*
*/
@Data
@Schema(description = "赛事报名")
@JsonIgnoreProperties(ignoreUnknown = true)
public class EventregistrationVO implements Serializable {
private static final long serialVersionUID = 1L;

        @Schema(description = "主键")
        @ExcelIgnore
    private Long id;

        @Schema(description = "赛事名称")
        @ExcelProperty("赛事名称")
    private String name;

        @Schema(description = "赛事id")
        @ExcelProperty("赛事id")
    private Long shenheid;

        @Schema(description = "报名人id")
        @ExcelProperty("报名人id")
    private Long userid;

        @Schema(description = "报名人")
        @ExcelProperty("报名人")
    private String username;

        @Schema(description = "审核")
        @ExcelProperty("审核")
    private String shenhe;

        @Schema(description = "封面")
        @ExcelProperty("封面")
    private String photo;

        @Schema(description = "报名信息")
        @ExcelProperty("报名信息")
    private String registrationinformation;

        @Schema(description = "审核人id")
        @ExcelProperty("审核人id")
    private Long adduserid;

        @Schema(description = "审核人")
        @ExcelProperty("审核人")
    private String addusername;

        @Schema(description = "审核回复")
        @ExcelProperty("审核回复")
    private String shenhehuifu;

        @Schema(description = "创建时间")
        @JsonFormat(pattern = DateUtils.DATE_TIME_PATTERN)
        @ExcelProperty("创建时间")
    private Date addtime;


}