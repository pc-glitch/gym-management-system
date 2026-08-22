package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.EquipmentVO;
import myproject.query.EquipmentQuery;
import myproject.entity.EquipmentEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 器材信息
*
*/
public interface EquipmentService extends BaseService<EquipmentEntity> {

    PageResult<EquipmentVO> page(EquipmentQuery query);

    List<EquipmentVO> queryList(EquipmentQuery query);

    void save(EquipmentVO vo);

    void update(EquipmentVO vo);

    void delete(List<Long> idList);

    void export(EquipmentQuery query);

    void importEquipment(File importFile);

    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<EquipmentEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<EquipmentEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<EquipmentEntity> wrapper);
}