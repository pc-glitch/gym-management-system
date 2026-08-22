package myproject.dao;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import myproject.common.utils.BaseDao;
import myproject.entity.DiscussEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 评论表
 */
@Mapper
public interface DiscussDao extends BaseDao<DiscussEntity> {
	List<Map<String, Object>> selectValue(@Param("params") Map<String, Object> params, @Param(Constants.WRAPPER) LambdaQueryWrapper<DiscussEntity> wrapper);

	List<Map<String, Object>> selectTimeStatValue(@Param("params") Map<String, Object> params, @Param(Constants.WRAPPER) LambdaQueryWrapper<DiscussEntity> wrapper);

	List<Map<String, Object>> selectGroup(@Param("params") Map<String, Object> params, @Param(Constants.WRAPPER) LambdaQueryWrapper<DiscussEntity> wrapper);

	void like(Long id);

	void unlike(Long id);
}