package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.ActivityregistrationVO;
import myproject.query.ActivityregistrationQuery;
import myproject.entity.ActivityregistrationEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 活动报名
*
*/
public interface ActivityregistrationService extends BaseService<ActivityregistrationEntity> {

    PageResult<ActivityregistrationVO> page(ActivityregistrationQuery query);

    List<ActivityregistrationVO> queryList(ActivityregistrationQuery query);

    void save(ActivityregistrationVO vo);

    void update(ActivityregistrationVO vo);

    void delete(List<Long> idList);

    void export(ActivityregistrationQuery query);

    void importactivityregistration(File importFile);
                
    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<ActivityregistrationEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<ActivityregistrationEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<ActivityregistrationEntity> wrapper);
}
