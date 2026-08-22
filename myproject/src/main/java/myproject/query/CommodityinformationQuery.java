package myproject.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import myproject.common.query.Query;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
    import java.util.Date;

/**
* 商品信息查询
*
*/
@Data
@EqualsAndHashCode(callSuper = false)
@Schema(description = "商品信息查询")
@JsonIgnoreProperties(ignoreUnknown = true)
public class CommodityinformationQuery extends Query {
    @Schema(description = "主键")
    private Long id;

    @Schema(description = "商品名称")
    private String name;

    @Schema(description = "所属分类")
    private String classify;

    @Schema(description = "品牌")
    private String brand;

    @Schema(description = "单位")
    private String units;

    @Schema(description = "规格详情")
    private String specificationsdetails;

    @Schema(description = "描述")
    private String description;

    @Schema(description = "价格")
    private Integer price;

    @Schema(description = "封面")
    private String photo;

    @Schema(description = "详情图")
    private String photos;

    @Schema(description = "详细信息")
    private String details;

    @Schema(description = "发布人id")
    private Long adduserid;

    @Schema(description = "发布人")
    private String addusername;

    @Schema(description = "创建时间")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date[] addtime;

}