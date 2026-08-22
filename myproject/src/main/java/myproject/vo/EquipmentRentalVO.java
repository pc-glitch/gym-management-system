package myproject.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import java.io.Serializable;
import myproject.common.utils.DateUtils;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
    import java.util.Date;

/**
* 器材租借
*
*/
@Data
@Schema(description = "器材租借")
@JsonIgnoreProperties(ignoreUnknown = true)
public class EquipmentRentalVO implements Serializable {
private static final long serialVersionUID = 1L;

        @Schema(description = "主键")
        @ExcelIgnore
    private Long id;

        @Schema(description = "器材id")
        @ExcelProperty("器材id")
    private Long equipmentid;

        @Schema(description = "器材名称")
        @ExcelProperty("器材名称")
    private String equipmentname;

        @Schema(description = "租借人id")
        @ExcelProperty("租借人id")
    private Long userid;

        @Schema(description = "租借人名称")
        @ExcelProperty("租借人名称")
    private String username;

        @Schema(description = "用户账号")
        @ExcelProperty("用户账号")
    private String userUsername;

        @Schema(description = "租借数量")
        @ExcelProperty("租借数量")
    private Integer quantity;

        @Schema(description = "租借时间")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
        @ExcelProperty("租借时间")
    private Date rentaltime;

        @Schema(description = "预计归还时间")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
        @ExcelProperty("预计归还时间")
    private Date expectedreturntime;

        @Schema(description = "实际归还时间")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
        @ExcelProperty("实际归还时间")
    private Date actualreturntime;

        @Schema(description = "租借状态")
        @ExcelProperty("租借状态")
    private String status;

        @Schema(description = "审批状态")
        @ExcelProperty("审批状态")
        @JsonProperty("approvalStatus")
    private String approvalstatus;

        @Schema(description = "审批回复")
        @ExcelProperty("审批回复")
    private String approvalremark;

        @Schema(description = "备注")
        @ExcelProperty("备注")
    private String remark;

       

        @Schema(description = "创建时间")
        @JsonFormat(pattern = DateUtils.DATE_TIME_PATTERN)
        @ExcelProperty("创建时间")
    private Date addtime;


}