package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.CommodityinformationConvert;
import myproject.entity.CommodityinformationEntity;
import myproject.query.CommodityinformationQuery;
import myproject.vo.CommodityinformationVO;
import myproject.dao.CommodityinformationDao;
import myproject.service.CommodityinformationService;
import myproject.common.utils.DateUtils;
import myproject.common.excel.ExcelFinishCallBack;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import myproject.common.utils.ExcelUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.io.File;

/**
* 商品信息
*
*/
@Service
@AllArgsConstructor
public class CommodityinformationServiceImpl extends BaseServiceImpl<CommodityinformationDao, CommodityinformationEntity> implements CommodityinformationService {
    @Override
    public PageResult<CommodityinformationVO> page(CommodityinformationQuery query) {
        IPage<CommodityinformationEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        return new PageResult<>(CommodityinformationConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
    }

    @Override
    public List<CommodityinformationVO> queryList(CommodityinformationQuery query) {
        return CommodityinformationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<CommodityinformationEntity> getWrapper(CommodityinformationQuery query){
        LambdaQueryWrapper<CommodityinformationEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), CommodityinformationEntity::getId, query.getId());
                    wrapper.eq(StringUtils.isNotEmpty(query.getName()), CommodityinformationEntity::getName, query.getName());
                    wrapper.eq(StringUtils.isNotEmpty(query.getClassify()), CommodityinformationEntity::getClassify, query.getClassify());
                    wrapper.eq(StringUtils.isNotEmpty(query.getBrand()), CommodityinformationEntity::getBrand, query.getBrand());
                    wrapper.eq(StringUtils.isNotEmpty(query.getUnits()), CommodityinformationEntity::getUnits, query.getUnits());
                    wrapper.eq(StringUtils.isNotEmpty(query.getSpecificationsdetails()), CommodityinformationEntity::getSpecificationsdetails, query.getSpecificationsdetails());
                    wrapper.eq(StringUtils.isNotEmpty(query.getDescription()), CommodityinformationEntity::getDescription, query.getDescription());
                    wrapper.eq(null!=query.getPrice(), CommodityinformationEntity::getPrice, query.getPrice());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhoto()), CommodityinformationEntity::getPhoto, query.getPhoto());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhotos()), CommodityinformationEntity::getPhotos, query.getPhotos());
                    wrapper.eq(StringUtils.isNotEmpty(query.getDetails()), CommodityinformationEntity::getDetails, query.getDetails());
                    wrapper.eq(null!=query.getAdduserid(), CommodityinformationEntity::getAdduserid, query.getAdduserid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getAddusername()), CommodityinformationEntity::getAddusername, query.getAddusername());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), CommodityinformationEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(CommodityinformationVO vo) {
        CommodityinformationEntity entity = CommodityinformationConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(CommodityinformationVO vo) {
        CommodityinformationEntity entity = CommodityinformationConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }


    @Override
    @SneakyThrows
    public void export(CommodityinformationQuery query) {
        List<CommodityinformationVO> list = CommodityinformationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        // 写到浏览器打开
        ExcelUtils.excelExport(CommodityinformationVO.class, "商品信息" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importcommodityinformation(File file) {
        ExcelUtils.readAnalysis(file, CommodityinformationVO.class, new ExcelFinishCallBack<CommodityinformationVO>() {
            @Override
            public void doAfterAllAnalysed(List<CommodityinformationVO> result) {
                saveCommodityinformations(result);
            }

            @Override
            public void doSaveBatch(List<CommodityinformationVO> result) {
                saveCommodityinformations(result);
            }

            private void saveCommodityinformations(List<CommodityinformationVO> result) {
                List<CommodityinformationEntity> CommodityinformationEntities = CommodityinformationConvert.INSTANCE.convertEntityList(result);
                saveBatch(CommodityinformationEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<CommodityinformationEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<CommodityinformationEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<CommodityinformationEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }
}