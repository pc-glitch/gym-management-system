package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.VenueinformationVO;
import myproject.query.VenueinformationQuery;
import myproject.entity.VenueinformationEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 场地信息
*
*/
public interface VenueinformationService extends BaseService<VenueinformationEntity> {

    PageResult<VenueinformationVO> page(VenueinformationQuery query);

    List<VenueinformationVO> queryList(VenueinformationQuery query);

    void save(VenueinformationVO vo);

    void update(VenueinformationVO vo);

    void delete(List<Long> idList);

    void export(VenueinformationQuery query);

    void importvenueinformation(File importFile);
                
    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<VenueinformationEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<VenueinformationEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<VenueinformationEntity> wrapper);
List<VenueinformationVO> userCFRecommend(Long id);
}