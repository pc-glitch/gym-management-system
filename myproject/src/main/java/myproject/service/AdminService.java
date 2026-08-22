package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.AdminVO;
import myproject.query.AdminQuery;
import myproject.entity.AdminEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 后台管理用户表
*
*/
public interface AdminService extends BaseService<AdminEntity> {

    PageResult<AdminVO> page(AdminQuery query);

    List<AdminVO> queryList(AdminQuery query);

    void save(AdminVO vo);

    void update(AdminVO vo);

    void delete(List<Long> idList);

    void export(AdminQuery query);

    void importadmin(File importFile);
                
    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<AdminEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<AdminEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<AdminEntity> wrapper);
}