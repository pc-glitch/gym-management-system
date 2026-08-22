package myproject.query;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import myproject.common.query.Query;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 评论表查询
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Schema(description = "评论表查询")
@JsonIgnoreProperties(ignoreUnknown = true)
public class DiscussQuery extends Query {
	private Long id;

	@Schema(description = "关联表id")
	private Long refid;

	@Schema(description = "用户id")
	private Long userid;

	@Schema(description = "头像")
	private String avatarurl;

	@Schema(description = "用户名")
	private String nickname;

	@Schema(description = "评论内容")
	private String content;

	@Schema(description = "父id")
	private Long parentId;

	@Schema(description = "点赞数量")
	private Integer likesCount;

	@Schema(description = "创建时间")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date[] createTime;

	@Schema(description = "图片")
	private String picture;

	@Schema(description = "星级")
	private String star;

	@Schema(description = "是否显示")
	private String display;

	@Schema(description = "视频")
	private String video;

	@Schema(description = "关联用户id")
	private Long refuserid;
}