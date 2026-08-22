package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.VenuereservationVO;
import myproject.query.VenuereservationQuery;
import myproject.entity.VenuereservationEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 场地预约
*
*/
public interface VenuereservationService extends BaseService<VenuereservationEntity> {

    PageResult<VenuereservationVO> page(VenuereservationQuery query);

    List<VenuereservationVO> queryList(VenuereservationQuery query);

    void save(VenuereservationVO vo);

    void update(VenuereservationVO vo);

    void delete(List<Long> idList);

    void export(VenuereservationQuery query);

    void importvenuereservation(File importFile);
                
    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<VenuereservationEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<VenuereservationEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<VenuereservationEntity> wrapper);
}