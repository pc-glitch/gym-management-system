package myproject.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import myproject.common.query.Query;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
    import java.util.Date;

/**
* 器材租借查询
*
*/
@Data
@EqualsAndHashCode(callSuper = false)
@Schema(description = "器材租借查询")
@JsonIgnoreProperties(ignoreUnknown = true)
public class EquipmentRentalQuery extends Query {
    @Schema(description = "主键")
    private Long id;

    @Schema(description = "器材id")
    private Long equipmentid;

    @Schema(description = "器材名称")
    private String equipmentname;

    @Schema(description = "租借人id")
    private Long userid;

    @Schema(description = "租借人名称")
    private String username;

    @Schema(description = "租借数量")
    private Integer quantity;

    @Schema(description = "租借时间")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] rentaltime;

    @Schema(description = "预计归还时间")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] expectedreturntime;

    @Schema(description = "实际归还时间")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] actualreturntime;

    @Schema(description = "租借状态")
    private String status;

    @Schema(description = "审批状态")
    private String approvalstatus;

    @Schema(description = "备注")
    private String remark;

    @Schema(description = "创建人id")
    private Long adduserid;

    @Schema(description = "创建人名称")
    private String addusername;

    @Schema(description = "创建时间")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] addtime;

}