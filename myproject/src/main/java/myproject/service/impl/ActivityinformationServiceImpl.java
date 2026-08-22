package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.ActivityinformationConvert;
import myproject.entity.ActivityinformationEntity;
import myproject.query.ActivityinformationQuery;
import myproject.vo.ActivityinformationVO;
import myproject.dao.ActivityinformationDao;
import myproject.service.ActivityinformationService;
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
* 活动信息
*
*/
@Service
@AllArgsConstructor
public class ActivityinformationServiceImpl extends BaseServiceImpl<ActivityinformationDao, ActivityinformationEntity> implements ActivityinformationService {
    @Override
    public PageResult<ActivityinformationVO> page(ActivityinformationQuery query) {
        IPage<ActivityinformationEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        return new PageResult<>(ActivityinformationConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
    }

    @Override
    public List<ActivityinformationVO> queryList(ActivityinformationQuery query) {
        return ActivityinformationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<ActivityinformationEntity> getWrapper(ActivityinformationQuery query){
        LambdaQueryWrapper<ActivityinformationEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), ActivityinformationEntity::getId, query.getId());
                    wrapper.eq(StringUtils.isNotEmpty(query.getName()), ActivityinformationEntity::getName, query.getName());
                    wrapper.eq(StringUtils.isNotEmpty(query.getClassify()), ActivityinformationEntity::getClassify, query.getClassify());
                    wrapper.eq(StringUtils.isNotEmpty(query.getActivitytheme()), ActivityinformationEntity::getActivitytheme, query.getActivitytheme());
                    wrapper.eq(StringUtils.isNotEmpty(query.getSponsoringdepartment()), ActivityinformationEntity::getSponsoringdepartment, query.getSponsoringdepartment());
                    wrapper.eq(StringUtils.isNotEmpty(query.getActivitytime()), ActivityinformationEntity::getActivitytime, query.getActivitytime());
                    wrapper.eq(StringUtils.isNotEmpty(query.getVenue()), ActivityinformationEntity::getVenue, query.getVenue());
                    wrapper.eq(StringUtils.isNotEmpty(query.getActivestate()), ActivityinformationEntity::getActivestate, query.getActivestate());
                    wrapper.eq(StringUtils.isNotEmpty(query.getActivityrules()), ActivityinformationEntity::getActivityrules, query.getActivityrules());
                    wrapper.eq(StringUtils.isNotEmpty(query.getIntroduction()), ActivityinformationEntity::getIntroduction, query.getIntroduction());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhoto()), ActivityinformationEntity::getPhoto, query.getPhoto());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhotos()), ActivityinformationEntity::getPhotos, query.getPhotos());
                    wrapper.eq(StringUtils.isNotEmpty(query.getDetails()), ActivityinformationEntity::getDetails, query.getDetails());
                    wrapper.eq(null!=query.getAdduserid(), ActivityinformationEntity::getAdduserid, query.getAdduserid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getAddusername()), ActivityinformationEntity::getAddusername, query.getAddusername());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), ActivityinformationEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(ActivityinformationVO vo) {
        ActivityinformationEntity entity = ActivityinformationConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(ActivityinformationVO vo) {
        ActivityinformationEntity entity = ActivityinformationConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }


    @Override
    @SneakyThrows
    public void export(ActivityinformationQuery query) {
        List<ActivityinformationVO> list = ActivityinformationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        // 写到浏览器打开
        ExcelUtils.excelExport(ActivityinformationVO.class, "活动信息" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importactivityinformation(File file) {
        ExcelUtils.readAnalysis(file, ActivityinformationVO.class, new ExcelFinishCallBack<ActivityinformationVO>() {
            @Override
            public void doAfterAllAnalysed(List<ActivityinformationVO> result) {
                saveActivityinformations(result);
            }

            @Override
            public void doSaveBatch(List<ActivityinformationVO> result) {
                saveActivityinformations(result);
            }

            private void saveActivityinformations(List<ActivityinformationVO> result) {
                List<ActivityinformationEntity> ActivityinformationEntities = ActivityinformationConvert.INSTANCE.convertEntityList(result);
                saveBatch(ActivityinformationEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<ActivityinformationEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<ActivityinformationEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<ActivityinformationEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }
}