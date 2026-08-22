package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.ActivityregistrationConvert;
import myproject.entity.ActivityregistrationEntity;
import myproject.query.ActivityregistrationQuery;
import myproject.vo.ActivityregistrationVO;
import myproject.dao.ActivityregistrationDao;
import myproject.service.ActivityregistrationService;
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
* 活动报名
*
*/
@Service
@AllArgsConstructor
public class ActivityregistrationServiceImpl extends BaseServiceImpl<ActivityregistrationDao, ActivityregistrationEntity> implements ActivityregistrationService {
    @Override
    public PageResult<ActivityregistrationVO> page(ActivityregistrationQuery query) {
        IPage<ActivityregistrationEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        return new PageResult<>(ActivityregistrationConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
    }

    @Override
    public List<ActivityregistrationVO> queryList(ActivityregistrationQuery query) {
        return ActivityregistrationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<ActivityregistrationEntity> getWrapper(ActivityregistrationQuery query){
        LambdaQueryWrapper<ActivityregistrationEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), ActivityregistrationEntity::getId, query.getId());
                    wrapper.eq(StringUtils.isNotEmpty(query.getName()), ActivityregistrationEntity::getName, query.getName());
                    wrapper.eq(null!=query.getShenheid(), ActivityregistrationEntity::getShenheid, query.getShenheid());
                    wrapper.eq(null!=query.getUserid(), ActivityregistrationEntity::getUserid, query.getUserid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getUsername()), ActivityregistrationEntity::getUsername, query.getUsername());
                    wrapper.eq(StringUtils.isNotEmpty(query.getShenhe()), ActivityregistrationEntity::getShenhe, query.getShenhe());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhoto()), ActivityregistrationEntity::getPhoto, query.getPhoto());
                    wrapper.eq(StringUtils.isNotEmpty(query.getRegistrationinformation()), ActivityregistrationEntity::getRegistrationinformation, query.getRegistrationinformation());
                    wrapper.eq(null!=query.getAdduserid(), ActivityregistrationEntity::getAdduserid, query.getAdduserid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getAddusername()), ActivityregistrationEntity::getAddusername, query.getAddusername());
                    wrapper.eq(StringUtils.isNotEmpty(query.getShenhehuifu()), ActivityregistrationEntity::getShenhehuifu, query.getShenhehuifu());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), ActivityregistrationEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(ActivityregistrationVO vo) {
        ActivityregistrationEntity entity = ActivityregistrationConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(ActivityregistrationVO vo) {
        ActivityregistrationEntity entity = ActivityregistrationConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }


    @Override
    @SneakyThrows
    public void export(ActivityregistrationQuery query) {
        List<ActivityregistrationVO> list = ActivityregistrationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        // 写到浏览器打开
        ExcelUtils.excelExport(ActivityregistrationVO.class, "活动报名" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importactivityregistration(File file) {
        ExcelUtils.readAnalysis(file, ActivityregistrationVO.class, new ExcelFinishCallBack<ActivityregistrationVO>() {
            @Override
            public void doAfterAllAnalysed(List<ActivityregistrationVO> result) {
                saveActivityregistrations(result);
            }

            @Override
            public void doSaveBatch(List<ActivityregistrationVO> result) {
                saveActivityregistrations(result);
            }

            private void saveActivityregistrations(List<ActivityregistrationVO> result) {
                List<ActivityregistrationEntity> ActivityregistrationEntities = ActivityregistrationConvert.INSTANCE.convertEntityList(result);
                saveBatch(ActivityregistrationEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<ActivityregistrationEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<ActivityregistrationEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<ActivityregistrationEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }
}
