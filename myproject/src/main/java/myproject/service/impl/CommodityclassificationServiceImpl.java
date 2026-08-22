package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.CommodityclassificationConvert;
import myproject.entity.CommodityclassificationEntity;
import myproject.query.CommodityclassificationQuery;
import myproject.vo.CommodityclassificationVO;
import myproject.dao.CommodityclassificationDao;
import myproject.service.CommodityclassificationService;
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
* 商品分类
*
*/
@Service
@AllArgsConstructor
public class CommodityclassificationServiceImpl extends BaseServiceImpl<CommodityclassificationDao, CommodityclassificationEntity> implements CommodityclassificationService {
    @Override
    public PageResult<CommodityclassificationVO> page(CommodityclassificationQuery query) {
        IPage<CommodityclassificationEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        return new PageResult<>(CommodityclassificationConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
    }

    @Override
    public List<CommodityclassificationVO> queryList(CommodityclassificationQuery query) {
        return CommodityclassificationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<CommodityclassificationEntity> getWrapper(CommodityclassificationQuery query){
        LambdaQueryWrapper<CommodityclassificationEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), CommodityclassificationEntity::getId, query.getId());
                    wrapper.eq(StringUtils.isNotEmpty(query.getName()), CommodityclassificationEntity::getName, query.getName());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), CommodityclassificationEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(CommodityclassificationVO vo) {
        CommodityclassificationEntity entity = CommodityclassificationConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(CommodityclassificationVO vo) {
        CommodityclassificationEntity entity = CommodityclassificationConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }


    @Override
    @SneakyThrows
    public void export(CommodityclassificationQuery query) {
        List<CommodityclassificationVO> list = CommodityclassificationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        // 写到浏览器打开
        ExcelUtils.excelExport(CommodityclassificationVO.class, "商品分类" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importcommodityclassification(File file) {
        ExcelUtils.readAnalysis(file, CommodityclassificationVO.class, new ExcelFinishCallBack<CommodityclassificationVO>() {
            @Override
            public void doAfterAllAnalysed(List<CommodityclassificationVO> result) {
                saveCommodityclassifications(result);
            }

            @Override
            public void doSaveBatch(List<CommodityclassificationVO> result) {
                saveCommodityclassifications(result);
            }

            private void saveCommodityclassifications(List<CommodityclassificationVO> result) {
                List<CommodityclassificationEntity> CommodityclassificationEntities = CommodityclassificationConvert.INSTANCE.convertEntityList(result);
                saveBatch(CommodityclassificationEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<CommodityclassificationEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<CommodityclassificationEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<CommodityclassificationEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }
}