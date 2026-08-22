package myproject.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.io.Serializable;
import myproject.common.utils.DateUtils;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
    import java.util.Date;

/**
* 后台管理用户表
*
*/
@Data
@Schema(description = "后台管理用户表")
@JsonIgnoreProperties(ignoreUnknown = true)
public class AdminVO implements Serializable {
private static final long serialVersionUID = 1L;

        @Schema(description = "主键")
        @ExcelIgnore
    private Long id;

        @Schema(description = "用户账号")
        @ExcelProperty("用户账号")
    private String username;

        @Schema(description = "密码")
        @ExcelProperty("密码")
    private String password;

        @Schema(description = "用户姓名")
        @ExcelProperty("用户姓名")
    private String name;

        @Schema(description = "性别")
        @ExcelProperty("性别")
    private String gender;

        @Schema(description = "联系方式")
        @ExcelProperty("联系方式")
    private String phone;

        @Schema(description = "头像")
        @ExcelProperty("头像")
    private String avatarurl;

        @Schema(description = "邮箱")
        @ExcelProperty("邮箱")
    private String email;

        @Schema(description = "权限")
        @ExcelProperty("权限")
    private String role;

        @Schema(description = "创建时间")
        @JsonFormat(pattern = DateUtils.DATE_PATTERN)
        @ExcelProperty("创建时间")
    private Date addtime;


}