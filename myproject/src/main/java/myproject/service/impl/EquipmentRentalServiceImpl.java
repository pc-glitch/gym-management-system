package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.EquipmentRentalConvert;
import myproject.entity.EquipmentRentalEntity;
import myproject.entity.EquipmentEntity;
import myproject.query.EquipmentRentalQuery;
import myproject.vo.EquipmentRentalVO;
import myproject.dao.EquipmentRentalDao;
import myproject.service.EquipmentRentalService;
import myproject.service.EquipmentService;
import myproject.service.UsersService;
import myproject.entity.UsersEntity;
import myproject.common.utils.DateUtils;
import myproject.common.excel.ExcelFinishCallBack;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import myproject.common.utils.ExcelUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.io.File;
import java.util.stream.Collectors;

/**
* 器材租借
*
*/
@Service
@AllArgsConstructor
public class EquipmentRentalServiceImpl extends BaseServiceImpl<EquipmentRentalDao, EquipmentRentalEntity> implements EquipmentRentalService {

    private final EquipmentService equipmentService;
    private final UsersService usersService;

    @Override
    public PageResult<EquipmentRentalVO> page(EquipmentRentalQuery query) {
        IPage<EquipmentRentalEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        List<EquipmentRentalVO> voList = EquipmentRentalConvert.INSTANCE.convertList(page.getRecords());
        // 关联用户表获取用户账号
        for (EquipmentRentalVO vo : voList) {
            if (vo.getUserid() != null) {
                UsersEntity user = usersService.getById(vo.getUserid());
                if (user != null) {
                    vo.setUserUsername(user.getUsername());
                }
            }
        }
        return new PageResult<>(voList, page.getTotal());
    }

    @Override
    public List<EquipmentRentalVO> queryList(EquipmentRentalQuery query) {
        return EquipmentRentalConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<EquipmentRentalEntity> getWrapper(EquipmentRentalQuery query){
        LambdaQueryWrapper<EquipmentRentalEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), EquipmentRentalEntity::getId, query.getId());
                    wrapper.eq(null!=query.getEquipmentid(), EquipmentRentalEntity::getEquipmentid, query.getEquipmentid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getEquipmentname()), EquipmentRentalEntity::getEquipmentname, query.getEquipmentname());
                    wrapper.eq(null!=query.getUserid(), EquipmentRentalEntity::getUserid, query.getUserid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getUsername()), EquipmentRentalEntity::getUsername, query.getUsername());
                    wrapper.eq(null!=query.getQuantity(), EquipmentRentalEntity::getQuantity, query.getQuantity());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getRentaltime()), EquipmentRentalEntity::getRentaltime, ArrayUtils.isNotEmpty(query.getRentaltime()) ? query.getRentaltime()[0] : null, ArrayUtils.isNotEmpty(query.getRentaltime()) ? query.getRentaltime()[1] : null);
                    wrapper.between(ArrayUtils.isNotEmpty(query.getExpectedreturntime()), EquipmentRentalEntity::getExpectedreturntime, ArrayUtils.isNotEmpty(query.getExpectedreturntime()) ? query.getExpectedreturntime()[0] : null, ArrayUtils.isNotEmpty(query.getExpectedreturntime()) ? query.getExpectedreturntime()[1] : null);
                    wrapper.between(ArrayUtils.isNotEmpty(query.getActualreturntime()), EquipmentRentalEntity::getActualreturntime, ArrayUtils.isNotEmpty(query.getActualreturntime()) ? query.getActualreturntime()[0] : null, ArrayUtils.isNotEmpty(query.getActualreturntime()) ? query.getActualreturntime()[1] : null);
                    wrapper.eq(StringUtils.isNotEmpty(query.getStatus()), EquipmentRentalEntity::getStatus, query.getStatus());
                    wrapper.eq(StringUtils.isNotEmpty(query.getApprovalstatus()), EquipmentRentalEntity::getApprovalstatus, query.getApprovalstatus());
                    wrapper.eq(StringUtils.isNotEmpty(query.getRemark()), EquipmentRentalEntity::getRemark, query.getRemark());

                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), EquipmentRentalEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(EquipmentRentalVO vo) {
        EquipmentRentalEntity entity = EquipmentRentalConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(EquipmentRentalVO vo) {
        EquipmentRentalEntity entity = EquipmentRentalConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }

    @Override
    @SneakyThrows
    public void export(EquipmentRentalQuery query) {
        List<EquipmentRentalVO> list = EquipmentRentalConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        ExcelUtils.excelExport(EquipmentRentalVO.class, "器材租借" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importEquipmentRental(File file) {
        ExcelUtils.readAnalysis(file, EquipmentRentalVO.class, new ExcelFinishCallBack<EquipmentRentalVO>() {
            @Override
            public void doAfterAllAnalysed(List<EquipmentRentalVO> result) {
                saveEquipmentRentals(result);
            }

            @Override
            public void doSaveBatch(List<EquipmentRentalVO> result) {
                saveEquipmentRentals(result);
            }

            private void saveEquipmentRentals(List<EquipmentRentalVO> result) {
                List<EquipmentRentalEntity> equipmentRentalEntities = EquipmentRentalConvert.INSTANCE.convertEntityList(result);
                saveBatch(equipmentRentalEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<EquipmentRentalEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<EquipmentRentalEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<EquipmentRentalEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void returnEquipment(Long id) {
        // 获取租借记录
        EquipmentRentalEntity rental = getById(id);
        if (rental == null) {
            throw new RuntimeException("租借记录不存在");
        }
        
        if (!"已借出".equals(rental.getStatus())) {
            throw new RuntimeException("该器材未借出，无法归还");
        }
        
        // 更新租借记录
        rental.setStatus("已归还");
        rental.setActualreturntime(new Date());
        updateById(rental);
        
        // 更新器材库存
        EquipmentEntity equipment = equipmentService.getById(rental.getEquipmentid());
        if (equipment != null) {
            equipment.setBorrowedquantity(equipment.getBorrowedquantity() - rental.getQuantity());
            equipment.setRemainingquantity(equipment.getRemainingquantity() + rental.getQuantity());
            equipmentService.updateById(equipment);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void rentEquipment(EquipmentRentalVO vo) {
        // 检查器材是否存在
        EquipmentEntity equipment = equipmentService.getById(vo.getEquipmentid());
        if (equipment == null) {
            throw new RuntimeException("器材不存在");
        }
        
        // 检查库存是否足够
        if (equipment.getRemainingquantity() < vo.getQuantity()) {
            throw new RuntimeException("器材库存不足");
        }
        
        // 创建租借记录
        EquipmentRentalEntity entity = EquipmentRentalConvert.INSTANCE.convert(vo);
        entity.setEquipmentname(equipment.getName());
        entity.setRentaltime(new Date());
        entity.setStatus("待审批");
        entity.setApprovalstatus("待审批");
        baseMapper.insert(entity);
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void approveRental(Long id, String approvalStatus, String approvalremark) {
        // 获取租借记录
        EquipmentRentalEntity rental = getById(id);
        if (rental == null) {
            throw new RuntimeException("租借记录不存在");
        }
        
        if (!"待审批".equals(rental.getApprovalstatus())) {
            throw new RuntimeException("该租借记录已经审批过");
        }
        
        // 更新审批状态和审批回复
        rental.setApprovalstatus(approvalStatus);
        rental.setApprovalremark(approvalremark);
        
        if ("已通过".equals(approvalStatus)) {
            // 审批通过，更新租借状态并扣减库存
            rental.setStatus("已借出");
            
            // 更新器材库存
            EquipmentEntity equipment = equipmentService.getById(rental.getEquipmentid());
            if (equipment != null) {
                equipment.setBorrowedquantity(equipment.getBorrowedquantity() + rental.getQuantity());
                equipment.setRemainingquantity(equipment.getRemainingquantity() - rental.getQuantity());
                equipmentService.updateById(equipment);
            }
        } else if ("已拒绝".equals(approvalStatus)) {
            // 审批拒绝，更新租借状态
            rental.setStatus("已拒绝");
        }
        
        updateById(rental);
    }
}
