package myproject.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import myproject.common.query.Query;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
    import java.util.Date;

/**
* 活动信息查询
*
*/
@Data
@EqualsAndHashCode(callSuper = false)
@Schema(description = "活动信息查询")
@JsonIgnoreProperties(ignoreUnknown = true)
public class ActivityinformationQuery extends Query {
    @Schema(description = "主键")
    private Long id;

    @Schema(description = "活动名称")
    private String name;

    @Schema(description = "活动类型")
    private String classify;

    @Schema(description = "活动主题")
    private String activitytheme;

    @Schema(description = "主办部门")
    private String sponsoringdepartment;

    @Schema(description = "活动时间")
    private String activitytime;

    @Schema(description = "活动地点")
    private String venue;

    @Schema(description = "活动状态")
    private String activestate;

    @Schema(description = "活动规则")
    private String activityrules;

    @Schema(description = "简介")
    private String introduction;

    @Schema(description = "封面")
    private String photo;

    @Schema(description = "详情图")
    private String photos;

    @Schema(description = "详细信息")
    private String details;

    @Schema(description = "创建人id")
    private Long adduserid;

    @Schema(description = "创建人名称")
    private String addusername;

    @Schema(description = "创建时间")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] addtime;

}