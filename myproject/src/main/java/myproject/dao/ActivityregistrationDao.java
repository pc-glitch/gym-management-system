package myproject.dao;

import myproject.common.utils.BaseDao;
import myproject.entity.ActivityregistrationEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import java.util.List;
import java.util.Map;
/**
* 活动报名
*
*/
@Mapper
public interface ActivityregistrationDao extends BaseDao<ActivityregistrationEntity> {
    List<Map<String, Object>> selectValue(@Param("params") Map<String, Object> params, @Param(Constants.WRAPPER) LambdaQueryWrapper<ActivityregistrationEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(@Param("params") Map<String, Object> params, @Param(Constants.WRAPPER) LambdaQueryWrapper<ActivityregistrationEntity> wrapper);

    List<Map<String, Object>> selectGroup(@Param("params") Map<String, Object> params, @Param(Constants.WRAPPER) LambdaQueryWrapper<ActivityregistrationEntity> wrapper);
}
