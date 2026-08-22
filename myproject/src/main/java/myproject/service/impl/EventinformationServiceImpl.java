package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.EventinformationConvert;
import myproject.entity.EventinformationEntity;
import myproject.query.EventinformationQuery;
import myproject.vo.EventinformationVO;
import myproject.dao.EventinformationDao;
import myproject.service.EventinformationService;
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
* 赛事信息
*
*/
@Service
@AllArgsConstructor
public class EventinformationServiceImpl extends BaseServiceImpl<EventinformationDao, EventinformationEntity> implements EventinformationService {
    @Override
    public PageResult<EventinformationVO> page(EventinformationQuery query) {
        IPage<EventinformationEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        return new PageResult<>(EventinformationConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
    }

    @Override
    public List<EventinformationVO> queryList(EventinformationQuery query) {
        return EventinformationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<EventinformationEntity> getWrapper(EventinformationQuery query){
        LambdaQueryWrapper<EventinformationEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), EventinformationEntity::getId, query.getId());
                    wrapper.eq(StringUtils.isNotEmpty(query.getName()), EventinformationEntity::getName, query.getName());
                    wrapper.eq(StringUtils.isNotEmpty(query.getClassify()), EventinformationEntity::getClassify, query.getClassify());
                    wrapper.eq(StringUtils.isNotEmpty(query.getTheleveloftheevent()), EventinformationEntity::getTheleveloftheevent, query.getTheleveloftheevent());
                    wrapper.eq(StringUtils.isNotEmpty(query.getVenue()), EventinformationEntity::getVenue, query.getVenue());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getHoldingdate()), EventinformationEntity::getHoldingdate, ArrayUtils.isNotEmpty(query.getHoldingdate()) ? query.getHoldingdate()[0] : null, ArrayUtils.isNotEmpty(query.getHoldingdate()) ? query.getHoldingdate()[1] : null);
                    wrapper.eq(StringUtils.isNotEmpty(query.getCompetitiontime()), EventinformationEntity::getCompetitiontime, query.getCompetitiontime());
                    wrapper.eq(StringUtils.isNotEmpty(query.getTotheschedule()), EventinformationEntity::getTotheschedule, query.getTotheschedule());
                    wrapper.eq(StringUtils.isNotEmpty(query.getRulesandbackground()), EventinformationEntity::getRulesandbackground, query.getRulesandbackground());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhoto()), EventinformationEntity::getPhoto, query.getPhoto());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhotos()), EventinformationEntity::getPhotos, query.getPhotos());
                    wrapper.eq(null!=query.getAdduserid(), EventinformationEntity::getAdduserid, query.getAdduserid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getAddusername()), EventinformationEntity::getAddusername, query.getAddusername());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), EventinformationEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(EventinformationVO vo) {
        EventinformationEntity entity = EventinformationConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(EventinformationVO vo) {
        EventinformationEntity entity = EventinformationConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }


    @Override
    @SneakyThrows
    public void export(EventinformationQuery query) {
        List<EventinformationVO> list = EventinformationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        // 写到浏览器打开
        ExcelUtils.excelExport(EventinformationVO.class, "赛事信息" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importeventinformation(File file) {
        ExcelUtils.readAnalysis(file, EventinformationVO.class, new ExcelFinishCallBack<EventinformationVO>() {
            @Override
            public void doAfterAllAnalysed(List<EventinformationVO> result) {
                saveEventinformations(result);
            }

            @Override
            public void doSaveBatch(List<EventinformationVO> result) {
                saveEventinformations(result);
            }

            private void saveEventinformations(List<EventinformationVO> result) {
                List<EventinformationEntity> EventinformationEntities = EventinformationConvert.INSTANCE.convertEntityList(result);
                saveBatch(EventinformationEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<EventinformationEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<EventinformationEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<EventinformationEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }
}