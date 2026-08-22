package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.ActivitytypeVO;
import myproject.query.ActivitytypeQuery;
import myproject.entity.ActivitytypeEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 活动类型
*
*/
public interface ActivitytypeService extends BaseService<ActivitytypeEntity> {

    PageResult<ActivitytypeVO> page(ActivitytypeQuery query);

    List<ActivitytypeVO> queryList(ActivitytypeQuery query);

    void save(ActivitytypeVO vo);

    void update(ActivitytypeVO vo);

    void delete(List<Long> idList);

    void export(ActivitytypeQuery query);

    void importactivitytype(File importFile);
                
    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<ActivitytypeEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<ActivitytypeEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<ActivitytypeEntity> wrapper);
}