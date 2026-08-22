package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.VenueinformationConvert;
import myproject.entity.VenueinformationEntity;
import myproject.query.VenueinformationQuery;
import myproject.vo.VenueinformationVO;
import myproject.dao.VenueinformationDao;
import myproject.service.VenueinformationService;
import myproject.common.utils.DateUtils;
import myproject.common.excel.ExcelFinishCallBack;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import myproject.common.utils.ExcelUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import myproject.common.recommend.RecommendService;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.io.File;
import java.util.stream.Collectors;

/**
* 场地信息
*
*/
@Service
@AllArgsConstructor
public class VenueinformationServiceImpl extends BaseServiceImpl<VenueinformationDao, VenueinformationEntity> implements VenueinformationService {
private final RecommendService recommendService;
    @Override
    public PageResult<VenueinformationVO> page(VenueinformationQuery query) {
        IPage<VenueinformationEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        return new PageResult<>(VenueinformationConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
    }

    @Override
    public List<VenueinformationVO> queryList(VenueinformationQuery query) {
        return VenueinformationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<VenueinformationEntity> getWrapper(VenueinformationQuery query){
        LambdaQueryWrapper<VenueinformationEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), VenueinformationEntity::getId, query.getId());
                    wrapper.eq(StringUtils.isNotEmpty(query.getName()), VenueinformationEntity::getName, query.getName());
                    wrapper.eq(StringUtils.isNotEmpty(query.getClubname()), VenueinformationEntity::getClubname, query.getClubname());
                    wrapper.eq(StringUtils.isNotEmpty(query.getClassify()), VenueinformationEntity::getClassify, query.getClassify());
                    wrapper.eq(StringUtils.isNotEmpty(query.getYardstate()), VenueinformationEntity::getYardstate, query.getYardstate());
                    wrapper.eq(StringUtils.isNotEmpty(query.getVenuespecifications()), VenueinformationEntity::getVenuespecifications, query.getVenuespecifications());
                    wrapper.eq(StringUtils.isNotEmpty(query.getSupportingfacilities()), VenueinformationEntity::getSupportingfacilities, query.getSupportingfacilities());
                    wrapper.eq(StringUtils.isNotEmpty(query.getServiceinformation()), VenueinformationEntity::getServiceinformation, query.getServiceinformation());
                    wrapper.eq(StringUtils.isNotEmpty(query.getIntroduction()), VenueinformationEntity::getIntroduction, query.getIntroduction());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhoto()), VenueinformationEntity::getPhoto, query.getPhoto());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhotos()), VenueinformationEntity::getPhotos, query.getPhotos());
                    wrapper.eq(StringUtils.isNotEmpty(query.getDetails()), VenueinformationEntity::getDetails, query.getDetails());
                    wrapper.eq(null!=query.getAdduserid(), VenueinformationEntity::getAdduserid, query.getAdduserid());
                    wrapper.eq(StringUtils.isNotEmpty(query.getAddusername()), VenueinformationEntity::getAddusername, query.getAddusername());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), VenueinformationEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(VenueinformationVO vo) {
        VenueinformationEntity entity = VenueinformationConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(VenueinformationVO vo) {
        VenueinformationEntity entity = VenueinformationConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }

/**
 * @title: userCFRecommend
 * @Description //根据用户行为推荐--基于用户行为
 * @Param [userId]
 **/
@Override
public List<VenueinformationVO> userCFRecommend(Long userId) {
    LambdaQueryWrapper<VenueinformationEntity> wrapper = Wrappers.lambdaQuery();
    wrapper.orderByDesc(VenueinformationEntity::getAddtime);
    List<Long> uIds = baseMapper.selectList(wrapper).stream().map(VenueinformationEntity::getId).collect(Collectors.toList());
    Collections.shuffle(uIds);
    List<Long> ids = recommendService.UserCFRecommend(userId, uIds, "venueinformation");
    if (ids.isEmpty()) {
        ids = uIds;
    }
    List<VenueinformationEntity> query = baseMapper.selectBatchIds(ids);
    return VenueinformationConvert.INSTANCE.convertList(query);
}

    @Override
    @SneakyThrows
    public void export(VenueinformationQuery query) {
        List<VenueinformationVO> list = VenueinformationConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        // 写到浏览器打开
        ExcelUtils.excelExport(VenueinformationVO.class, "场地信息" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importvenueinformation(File file) {
        ExcelUtils.readAnalysis(file, VenueinformationVO.class, new ExcelFinishCallBack<VenueinformationVO>() {
            @Override
            public void doAfterAllAnalysed(List<VenueinformationVO> result) {
                saveVenueinformations(result);
            }

            @Override
            public void doSaveBatch(List<VenueinformationVO> result) {
                saveVenueinformations(result);
            }

            private void saveVenueinformations(List<VenueinformationVO> result) {
                List<VenueinformationEntity> VenueinformationEntities = VenueinformationConvert.INSTANCE.convertEntityList(result);
                saveBatch(VenueinformationEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<VenueinformationEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<VenueinformationEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<VenueinformationEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }
}