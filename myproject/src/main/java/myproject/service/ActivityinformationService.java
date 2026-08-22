package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.ActivityinformationVO;
import myproject.query.ActivityinformationQuery;
import myproject.entity.ActivityinformationEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 活动信息
*
*/
public interface ActivityinformationService extends BaseService<ActivityinformationEntity> {

    PageResult<ActivityinformationVO> page(ActivityinformationQuery query);

    List<ActivityinformationVO> queryList(ActivityinformationQuery query);

    void save(ActivityinformationVO vo);

    void update(ActivityinformationVO vo);

    void delete(List<Long> idList);

    void export(ActivityinformationQuery query);

    void importactivityinformation(File importFile);
                
    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<ActivityinformationEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<ActivityinformationEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<ActivityinformationEntity> wrapper);
}