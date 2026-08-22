package myproject.service;


import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.entity.UsersEntity;
import myproject.query.UsersQuery;

import java.util.List;
import java.util.Map;


/**
 * 系统用户
 */
public interface UsersService extends BaseService<UsersEntity> {
	PageResult<UsersEntity> queryPage(UsersQuery user);

	List<UsersEntity> selectListView(Wrapper<UsersEntity> wrapper);

	UsersEntity getByUsername(String username);
	List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<UsersEntity> wrapper);

	List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<UsersEntity> wrapper);

	List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<UsersEntity> wrapper);

}
