package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.EventinformationVO;
import myproject.query.EventinformationQuery;
import myproject.entity.EventinformationEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 赛事信息
*
*/
public interface EventinformationService extends BaseService<EventinformationEntity> {

    PageResult<EventinformationVO> page(EventinformationQuery query);

    List<EventinformationVO> queryList(EventinformationQuery query);

    void save(EventinformationVO vo);

    void update(EventinformationVO vo);

    void delete(List<Long> idList);

    void export(EventinformationQuery query);

    void importeventinformation(File importFile);
                
    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<EventinformationEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<EventinformationEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<EventinformationEntity> wrapper);
}