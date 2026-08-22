package myproject.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import myproject.common.query.Query;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
    import java.util.Date;

/**
* 活动报名查询
*
*/
@Data
@EqualsAndHashCode(callSuper = false)
@Schema(description = "活动报名查询")
@JsonIgnoreProperties(ignoreUnknown = true)
public class ActivityregistrationQuery extends Query {
    @Schema(description = "主键")
    private Long id;

    @Schema(description = "活动名称")
    private String name;

    @Schema(description = "活动id")
    private Long shenheid;

    @Schema(description = "报名人id")
    private Long userid;

    @Schema(description = "报名人")
    private String username;

    @Schema(description = "审核")
    private String shenhe;

    @Schema(description = "封面")
    private String photo;

    @Schema(description = "报名信息")
    private String registrationinformation;

    @Schema(description = "审核人id")
    private Long adduserid;

    @Schema(description = "审核人")
    private String addusername;

    @Schema(description = "审核回复")
    private String shenhehuifu;

    @Schema(description = "创建时间")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] addtime;

}
