package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.EventregistrationVO;
import myproject.query.EventregistrationQuery;
import myproject.entity.EventregistrationEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 赛事报名
*
*/
public interface EventregistrationService extends BaseService<EventregistrationEntity> {

    PageResult<EventregistrationVO> page(EventregistrationQuery query);

    List<EventregistrationVO> queryList(EventregistrationQuery query);

    void save(EventregistrationVO vo);

    void update(EventregistrationVO vo);

    void delete(List<Long> idList);

    void export(EventregistrationQuery query);

    void importeventregistration(File importFile);
                
    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<EventregistrationEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<EventregistrationEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<EventregistrationEntity> wrapper);
}