package myproject.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import myproject.common.query.Query;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
    import java.util.Date;

/**
* 场地信息查询
*
*/
@Data
@EqualsAndHashCode(callSuper = false)
@Schema(description = "场地信息查询")
@JsonIgnoreProperties(ignoreUnknown = true)
public class VenueinformationQuery extends Query {
    @Schema(description = "主键")
    private Long id;

    @Schema(description = "场地名称")
    private String name;

    @Schema(description = "俱乐部名称")
    private String clubname;

    @Schema(description = "用途类型")
    private String classify;

    @Schema(description = "场地状态")
    private String yardstate;

    @Schema(description = "场地规格")
    private String venuespecifications;

    @Schema(description = " 配套设施")
    private String supportingfacilities;

    @Schema(description = "服务信息")
    private String serviceinformation;

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