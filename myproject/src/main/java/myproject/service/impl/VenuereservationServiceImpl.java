package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.VenuereservationConvert;
import myproject.entity.VenuereservationEntity;
import myproject.query.VenuereservationQuery;
import myproject.vo.VenuereservationVO;
import myproject.dao.VenuereservationDao;
import myproject.service.VenuereservationService;
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
* 场地预约
*
*/
@Service
@AllArgsConstructor
public class VenuereservationServiceImpl extends BaseServiceImpl<VenuereservationDao, VenuereservationEntity> implements VenuereservationService {
    @Override
    public PageResult<VenuereservationVO> page(VenuereservationQuery query) {
        IPage<VenuereservationEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        return new PageResult<>(VenuereservationConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
    }

    @Override
    public List<VenuereservationVO> queryList(VenuereservationQuery query) {
        return VenuereservationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<VenuereservationEntity> getWrapper(VenuereservationQuery query){
        LambdaQueryWrapper<VenuereservationEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), VenuereservationEntity::getId, query.getId());
                    wrapper.eq(StringUtils.isNotEmpty(query.getName()), VenuereservationEntity::getName, query.getName());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getThereservationstarttime()), VenuereservationEntity::getThereservationstarttime, ArrayUtils.isNotEmpty(query.getThereservationstarttime()) ? query.getThereservationstarttime()[0] : null, ArrayUtils.isNotEmpty(query.getThereservationstarttime()) ? query.getThereservationstarttime()[1] : null);
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAppointmentendtime()), VenuereservationEntity::getAppointmentendtime, ArrayUtils.isNotEmpty(query.getAppointmentendtime()) ? query.getAppointmentendtime()[0] : null, ArrayUtils.isNotEmpty(query.getAppointmentendtime()) ? query.getAppointmentendtime()[1] : null);
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhoto()), VenuereservationEntity::getPhoto, query.getPhoto());
                    wrapper.eq(StringUtils.isNotEmpty(query.getRemarkinformation()), VenuereservationEntity::getRemarkinformation, query.getRemarkinformation());
                    wrapper.eq(null!=query.getReservationpersonid(), VenuereservationEntity::getReservationpersonid, query.getReservationpersonid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getReservationpersonname()), VenuereservationEntity::getReservationpersonname, query.getReservationpersonname());
                    wrapper.eq(null!=query.getAdduserid(), VenuereservationEntity::getAdduserid, query.getAdduserid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getAddusername()), VenuereservationEntity::getAddusername, query.getAddusername());
                    wrapper.eq(StringUtils.isNotEmpty(query.getShenhe()), VenuereservationEntity::getShenhe, query.getShenhe());
                    wrapper.eq(null!=query.getShenheid(), VenuereservationEntity::getShenheid, query.getShenheid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getShenhehuifu()), VenuereservationEntity::getShenhehuifu, query.getShenhehuifu());
                    wrapper.eq(null!=query.getUserid(), VenuereservationEntity::getUserid, query.getUserid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getUsername()), VenuereservationEntity::getUsername, query.getUsername());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), VenuereservationEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(VenuereservationVO vo) {
        VenuereservationEntity entity = VenuereservationConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(VenuereservationVO vo) {
        VenuereservationEntity entity = VenuereservationConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }


    @Override
    @SneakyThrows
    public void export(VenuereservationQuery query) {
        List<VenuereservationVO> list = VenuereservationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        // 写到浏览器打开
        ExcelUtils.excelExport(VenuereservationVO.class, "场地预约" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importvenuereservation(File file) {
        ExcelUtils.readAnalysis(file, VenuereservationVO.class, new ExcelFinishCallBack<VenuereservationVO>() {
            @Override
            public void doAfterAllAnalysed(List<VenuereservationVO> result) {
                saveVenuereservations(result);
            }

            @Override
            public void doSaveBatch(List<VenuereservationVO> result) {
                saveVenuereservations(result);
            }

            private void saveVenuereservations(List<VenuereservationVO> result) {
                List<VenuereservationEntity> VenuereservationEntities = VenuereservationConvert.INSTANCE.convertEntityList(result);
                saveBatch(VenuereservationEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<VenuereservationEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<VenuereservationEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<VenuereservationEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }
}