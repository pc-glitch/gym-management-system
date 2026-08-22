package myproject.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import myproject.common.query.Query;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
    import java.util.Date;

/**
* 场地预约查询
*
*/
@Data
@EqualsAndHashCode(callSuper = false)
@Schema(description = "场地预约查询")
@JsonIgnoreProperties(ignoreUnknown = true)
public class VenuereservationQuery extends Query {
    @Schema(description = "主键")
    private Long id;

    @Schema(description = "场地名称")
    private String name;

    @Schema(description = "预约开始时间")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] thereservationstarttime;

    @Schema(description = "预约结束时间")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] appointmentendtime;

    @Schema(description = "封面")
    private String photo;

    @Schema(description = "备注信息")
    private String remarkinformation;

    @Schema(description = "预约人id")
    private Long reservationpersonid;

    @Schema(description = "预约人")
    private String reservationpersonname;

    @Schema(description = "审核人id")
    private Long adduserid;

    @Schema(description = "审核人")
    private String addusername;

    @Schema(description = "审核")
    private String shenhe;

    @Schema(description = "场地id")
    private Long shenheid;

    @Schema(description = "审核回复")
    private String shenhehuifu;

    @Schema(description = "用户id")
    private Long userid;

    @Schema(description = "用户名称")
    private String username;

    @Schema(description = "创建时间")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] addtime;

}