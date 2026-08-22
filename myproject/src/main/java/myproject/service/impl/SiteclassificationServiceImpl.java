package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.SiteclassificationConvert;
import myproject.entity.SiteclassificationEntity;
import myproject.query.SiteclassificationQuery;
import myproject.vo.SiteclassificationVO;
import myproject.dao.SiteclassificationDao;
import myproject.service.SiteclassificationService;
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
* 场地分类
*
*/
@Service
@AllArgsConstructor
public class SiteclassificationServiceImpl extends BaseServiceImpl<SiteclassificationDao, SiteclassificationEntity> implements SiteclassificationService {
    @Override
    public PageResult<SiteclassificationVO> page(SiteclassificationQuery query) {
        IPage<SiteclassificationEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        return new PageResult<>(SiteclassificationConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
    }

    @Override
    public List<SiteclassificationVO> queryList(SiteclassificationQuery query) {
        return SiteclassificationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<SiteclassificationEntity> getWrapper(SiteclassificationQuery query){
        LambdaQueryWrapper<SiteclassificationEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), SiteclassificationEntity::getId, query.getId());
                    wrapper.eq(StringUtils.isNotEmpty(query.getName()), SiteclassificationEntity::getName, query.getName());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), SiteclassificationEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(SiteclassificationVO vo) {
        SiteclassificationEntity entity = SiteclassificationConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(SiteclassificationVO vo) {
        SiteclassificationEntity entity = SiteclassificationConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }


    @Override
    @SneakyThrows
    public void export(SiteclassificationQuery query) {
        List<SiteclassificationVO> list = SiteclassificationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        // 写到浏览器打开
        ExcelUtils.excelExport(SiteclassificationVO.class, "场地分类" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importsiteclassification(File file) {
        ExcelUtils.readAnalysis(file, SiteclassificationVO.class, new ExcelFinishCallBack<SiteclassificationVO>() {
            @Override
            public void doAfterAllAnalysed(List<SiteclassificationVO> result) {
                saveSiteclassifications(result);
            }

            @Override
            public void doSaveBatch(List<SiteclassificationVO> result) {
                saveSiteclassifications(result);
            }

            private void saveSiteclassifications(List<SiteclassificationVO> result) {
                List<SiteclassificationEntity> SiteclassificationEntities = SiteclassificationConvert.INSTANCE.convertEntityList(result);
                saveBatch(SiteclassificationEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<SiteclassificationEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<SiteclassificationEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<SiteclassificationEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }
}