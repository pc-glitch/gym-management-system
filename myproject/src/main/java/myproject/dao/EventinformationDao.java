package myproject.dao;

import myproject.common.utils.BaseDao;
import myproject.entity.EventinformationEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import java.util.List;
import java.util.Map;
/**
* 赛事信息
*
*/
@Mapper
public interface EventinformationDao extends BaseDao<EventinformationEntity> {
    List<Map<String, Object>> selectValue(@Param("params") Map<String, Object> params, @Param(Constants.WRAPPER) LambdaQueryWrapper<EventinformationEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(@Param("params") Map<String, Object> params, @Param(Constants.WRAPPER) LambdaQueryWrapper<EventinformationEntity> wrapper);

    List<Map<String, Object>> selectGroup(@Param("params") Map<String, Object> params, @Param(Constants.WRAPPER) LambdaQueryWrapper<EventinformationEntity> wrapper);
}