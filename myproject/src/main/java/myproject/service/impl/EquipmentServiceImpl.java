package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.EquipmentConvert;
import myproject.entity.EquipmentEntity;
import myproject.query.EquipmentQuery;
import myproject.vo.EquipmentVO;
import myproject.dao.EquipmentDao;
import myproject.service.EquipmentService;
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
* 器材信息
*
*/
@Service
@AllArgsConstructor
public class EquipmentServiceImpl extends BaseServiceImpl<EquipmentDao, EquipmentEntity> implements EquipmentService {

    @Override
    public PageResult<EquipmentVO> page(EquipmentQuery query) {
        IPage<EquipmentEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        return new PageResult<>(EquipmentConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
    }

    @Override
    public List<EquipmentVO> queryList(EquipmentQuery query) {
        return EquipmentConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<EquipmentEntity> getWrapper(EquipmentQuery query){
        LambdaQueryWrapper<EquipmentEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), EquipmentEntity::getId, query.getId());
                    wrapper.eq(StringUtils.isNotEmpty(query.getName()), EquipmentEntity::getName, query.getName());
                    wrapper.eq(StringUtils.isNotEmpty(query.getClassify()), EquipmentEntity::getClassify, query.getClassify());
                    wrapper.eq(StringUtils.isNotEmpty(query.getEquipmentno()), EquipmentEntity::getEquipmentno, query.getEquipmentno());
                    wrapper.eq(StringUtils.isNotEmpty(query.getBrand()), EquipmentEntity::getBrand, query.getBrand());
                    wrapper.eq(StringUtils.isNotEmpty(query.getModel()), EquipmentEntity::getModel, query.getModel());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getPurchasedate()), EquipmentEntity::getPurchasedate, ArrayUtils.isNotEmpty(query.getPurchasedate()) ? query.getPurchasedate()[0] : null, ArrayUtils.isNotEmpty(query.getPurchasedate()) ? query.getPurchasedate()[1] : null);
                    wrapper.between(ArrayUtils.isNotEmpty(query.getWarrantyenddate()), EquipmentEntity::getWarrantyenddate, ArrayUtils.isNotEmpty(query.getWarrantyenddate()) ? query.getWarrantyenddate()[0] : null, ArrayUtils.isNotEmpty(query.getWarrantyenddate()) ? query.getWarrantyenddate()[1] : null);
                    wrapper.eq(StringUtils.isNotEmpty(query.getStatus()), EquipmentEntity::getStatus, query.getStatus());
                    wrapper.eq(StringUtils.isNotEmpty(query.getLocation()), EquipmentEntity::getLocation, query.getLocation());
                    wrapper.eq(null!=query.getPrice(), EquipmentEntity::getPrice, query.getPrice());
                    wrapper.eq(null!=query.getQuantity(), EquipmentEntity::getQuantity, query.getQuantity());
                    wrapper.eq(null!=query.getBorrowedquantity(), EquipmentEntity::getBorrowedquantity, query.getBorrowedquantity());
                    wrapper.eq(null!=query.getRemainingquantity(), EquipmentEntity::getRemainingquantity, query.getRemainingquantity());
                    wrapper.eq(StringUtils.isNotEmpty(query.getDescription()), EquipmentEntity::getDescription, query.getDescription());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhoto()), EquipmentEntity::getPhoto, query.getPhoto());
                    wrapper.eq(null!=query.getAdduserid(), EquipmentEntity::getAdduserid, query.getAdduserid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getAddusername()), EquipmentEntity::getAddusername, query.getAddusername());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), EquipmentEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(EquipmentVO vo) {
        EquipmentEntity entity = EquipmentConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(EquipmentVO vo) {
        EquipmentEntity entity = EquipmentConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }

    @Override
    @SneakyThrows
    public void export(EquipmentQuery query) {
        List<EquipmentVO> list = EquipmentConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        ExcelUtils.excelExport(EquipmentVO.class, "器材信息" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importEquipment(File file) {
        ExcelUtils.readAnalysis(file, EquipmentVO.class, new ExcelFinishCallBack<EquipmentVO>() {
            @Override
            public void doAfterAllAnalysed(List<EquipmentVO> result) {
                saveEquipments(result);
            }

            @Override
            public void doSaveBatch(List<EquipmentVO> result) {
                saveEquipments(result);
            }

            private void saveEquipments(List<EquipmentVO> result) {
                List<EquipmentEntity> EquipmentEntities = EquipmentConvert.INSTANCE.convertEntityList(result);
                saveBatch(EquipmentEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<EquipmentEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<EquipmentEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<EquipmentEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }
}