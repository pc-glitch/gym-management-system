package myproject.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import myproject.common.query.Query;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
    import java.util.Date;

/**
* 赛事信息查询
*
*/
@Data
@EqualsAndHashCode(callSuper = false)
@Schema(description = "赛事信息查询")
@JsonIgnoreProperties(ignoreUnknown = true)
public class EventinformationQuery extends Query {
    @Schema(description = "主键")
    private Long id;

    @Schema(description = "赛事名称")
    private String name;

    @Schema(description = "赛事类型")
    private String classify;

    @Schema(description = "赛事级别")
    private String theleveloftheevent;

    @Schema(description = "举办地点")
    private String venue;

    @Schema(description = "举办日期")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] holdingdate;

    @Schema(description = "比赛时间")
    private String competitiontime;

    @Schema(description = "赛程安排")
    private String totheschedule;

    @Schema(description = "规则与背景")
    private String rulesandbackground;

    @Schema(description = "封面")
    private String photo;

    @Schema(description = "详情图")
    private String photos;

    @Schema(description = "创建人id")
    private Long adduserid;

    @Schema(description = "创建人名称")
    private String addusername;

    @Schema(description = "创建时间")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] addtime;

}