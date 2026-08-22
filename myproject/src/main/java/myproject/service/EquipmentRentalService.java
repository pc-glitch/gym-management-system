package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.EquipmentRentalVO;
import myproject.query.EquipmentRentalQuery;
import myproject.entity.EquipmentRentalEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 器材租借
*
*/
public interface EquipmentRentalService extends BaseService<EquipmentRentalEntity> {

    PageResult<EquipmentRentalVO> page(EquipmentRentalQuery query);

    List<EquipmentRentalVO> queryList(EquipmentRentalQuery query);

    void save(EquipmentRentalVO vo);

    void update(EquipmentRentalVO vo);

    void delete(List<Long> idList);

    void export(EquipmentRentalQuery query);

    void importEquipmentRental(File importFile);

    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<EquipmentRentalEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<EquipmentRentalEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<EquipmentRentalEntity> wrapper);
    
    /**
     * 器材归还
     */
    void returnEquipment(Long id);
    
    /**
     * 租借器材
     */
    void rentEquipment(EquipmentRentalVO vo);
    
    /**
     * 审批租借
     */
    void approveRental(Long id, String approvalStatus, String approvalremark);
}
