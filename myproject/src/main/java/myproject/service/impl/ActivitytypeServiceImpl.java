package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.ActivitytypeConvert;
import myproject.entity.ActivitytypeEntity;
import myproject.query.ActivitytypeQuery;
import myproject.vo.ActivitytypeVO;
import myproject.dao.ActivitytypeDao;
import myproject.service.ActivitytypeService;
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
* 活动类型
*
*/
@Service
@AllArgsConstructor
public class ActivitytypeServiceImpl extends BaseServiceImpl<ActivitytypeDao, ActivitytypeEntity> implements ActivitytypeService {
    @Override
    public PageResult<ActivitytypeVO> page(ActivitytypeQuery query) {
        IPage<ActivitytypeEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        return new PageResult<>(ActivitytypeConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
    }

    @Override
    public List<ActivitytypeVO> queryList(ActivitytypeQuery query) {
        return ActivitytypeConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<ActivitytypeEntity> getWrapper(ActivitytypeQuery query){
        LambdaQueryWrapper<ActivitytypeEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), ActivitytypeEntity::getId, query.getId());
                    wrapper.eq(StringUtils.isNotEmpty(query.getName()), ActivitytypeEntity::getName, query.getName());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), ActivitytypeEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(ActivitytypeVO vo) {
        ActivitytypeEntity entity = ActivitytypeConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(ActivitytypeVO vo) {
        ActivitytypeEntity entity = ActivitytypeConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }


    @Override
    @SneakyThrows
    public void export(ActivitytypeQuery query) {
        List<ActivitytypeVO> list = ActivitytypeConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        // 写到浏览器打开
        ExcelUtils.excelExport(ActivitytypeVO.class, "活动类型" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importactivitytype(File file) {
        ExcelUtils.readAnalysis(file, ActivitytypeVO.class, new ExcelFinishCallBack<ActivitytypeVO>() {
            @Override
            public void doAfterAllAnalysed(List<ActivitytypeVO> result) {
                saveActivitytypes(result);
            }

            @Override
            public void doSaveBatch(List<ActivitytypeVO> result) {
                saveActivitytypes(result);
            }

            private void saveActivitytypes(List<ActivitytypeVO> result) {
                List<ActivitytypeEntity> ActivitytypeEntities = ActivitytypeConvert.INSTANCE.convertEntityList(result);
                saveBatch(ActivitytypeEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<ActivitytypeEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<ActivitytypeEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<ActivitytypeEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }
}