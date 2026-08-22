package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.CommodityinformationVO;
import myproject.query.CommodityinformationQuery;
import myproject.entity.CommodityinformationEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 商品信息
*
*/
public interface CommodityinformationService extends BaseService<CommodityinformationEntity> {

    PageResult<CommodityinformationVO> page(CommodityinformationQuery query);

    List<CommodityinformationVO> queryList(CommodityinformationQuery query);

    void save(CommodityinformationVO vo);

    void update(CommodityinformationVO vo);

    void delete(List<Long> idList);

    void export(CommodityinformationQuery query);

    void importcommodityinformation(File importFile);
                
    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<CommodityinformationEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<CommodityinformationEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<CommodityinformationEntity> wrapper);
}