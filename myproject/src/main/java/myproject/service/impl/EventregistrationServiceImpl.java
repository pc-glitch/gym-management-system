package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.EventregistrationConvert;
import myproject.entity.EventregistrationEntity;
import myproject.query.EventregistrationQuery;
import myproject.vo.EventregistrationVO;
import myproject.dao.EventregistrationDao;
import myproject.service.EventregistrationService;
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
* 赛事报名
*
*/
@Service
@AllArgsConstructor
public class EventregistrationServiceImpl extends BaseServiceImpl<EventregistrationDao, EventregistrationEntity> implements EventregistrationService {
    @Override
    public PageResult<EventregistrationVO> page(EventregistrationQuery query) {
        IPage<EventregistrationEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        return new PageResult<>(EventregistrationConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
    }

    @Override
    public List<EventregistrationVO> queryList(EventregistrationQuery query) {
        return EventregistrationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<EventregistrationEntity> getWrapper(EventregistrationQuery query){
        LambdaQueryWrapper<EventregistrationEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), EventregistrationEntity::getId, query.getId());
                    wrapper.eq(StringUtils.isNotEmpty(query.getName()), EventregistrationEntity::getName, query.getName());
                    wrapper.eq(null!=query.getShenheid(), EventregistrationEntity::getShenheid, query.getShenheid());
                    wrapper.eq(null!=query.getUserid(), EventregistrationEntity::getUserid, query.getUserid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getUsername()), EventregistrationEntity::getUsername, query.getUsername());
                    wrapper.eq(StringUtils.isNotEmpty(query.getShenhe()), EventregistrationEntity::getShenhe, query.getShenhe());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhoto()), EventregistrationEntity::getPhoto, query.getPhoto());
                    wrapper.eq(StringUtils.isNotEmpty(query.getRegistrationinformation()), EventregistrationEntity::getRegistrationinformation, query.getRegistrationinformation());
                    wrapper.eq(null!=query.getAdduserid(), EventregistrationEntity::getAdduserid, query.getAdduserid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getAddusername()), EventregistrationEntity::getAddusername, query.getAddusername());
                    wrapper.eq(StringUtils.isNotEmpty(query.getShenhehuifu()), EventregistrationEntity::getShenhehuifu, query.getShenhehuifu());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), EventregistrationEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(EventregistrationVO vo) {
        EventregistrationEntity entity = EventregistrationConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(EventregistrationVO vo) {
        EventregistrationEntity entity = EventregistrationConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }


    @Override
    @SneakyThrows
    public void export(EventregistrationQuery query) {
        List<EventregistrationVO> list = EventregistrationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        // 写到浏览器打开
        ExcelUtils.excelExport(EventregistrationVO.class, "赛事报名" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importeventregistration(File file) {
        ExcelUtils.readAnalysis(file, EventregistrationVO.class, new ExcelFinishCallBack<EventregistrationVO>() {
            @Override
            public void doAfterAllAnalysed(List<EventregistrationVO> result) {
                saveEventregistrations(result);
            }

            @Override
            public void doSaveBatch(List<EventregistrationVO> result) {
                saveEventregistrations(result);
            }

            private void saveEventregistrations(List<EventregistrationVO> result) {
                List<EventregistrationEntity> EventregistrationEntities = EventregistrationConvert.INSTANCE.convertEntityList(result);
                saveBatch(EventregistrationEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<EventregistrationEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<EventregistrationEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<EventregistrationEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }
}