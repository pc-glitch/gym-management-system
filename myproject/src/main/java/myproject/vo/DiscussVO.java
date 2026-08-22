package myproject.vo;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import myproject.common.utils.DateUtils;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 评论表
 */
@Data
@Schema(description = "评论表")
@JsonIgnoreProperties(ignoreUnknown = true)
public class DiscussVO implements Serializable {
	private static final long serialVersionUID = 1L;

	@ExcelIgnore
	private Long id;

	@Schema(description = "关联表id")
	@ExcelProperty("关联表id")
	private Long refid;

	@Schema(description = "用户id")
	@ExcelProperty("用户id")
	private Long userid;

	@Schema(description = "头像")
	@ExcelProperty("头像")
	private String avatarurl;

	@Schema(description = "用户名")
	@ExcelProperty("用户名")
	private String nickname;

	@Schema(description = "评论内容")
	@ExcelProperty("评论内容")
	private String content;

	@Schema(description = "父id")
	@ExcelProperty("父id")
	private Long parentId;

	@Schema(description = "点赞数量")
	@ExcelProperty("点赞数量")
	private Integer likesCount;

	@Schema(description = "创建时间")
	@JsonFormat(pattern = DateUtils.DATE_PATTERN)
	@ExcelProperty("创建时间")
	private Date createTime;

	@Schema(description = "图片")
	@ExcelProperty("图片")
	private String picture;

	@Schema(description = "星级")
	@ExcelProperty("星级")
	private String star;

	@Schema(description = "是否显示")
	@ExcelProperty("是否显示")
	private String display;

	@Schema(description = "视频")
	@ExcelProperty("视频")
	private String video;


	@Schema(description = "子评论")
	private List<DiscussVO> children;
	private Boolean isLike;
	private Long refuserid;
}