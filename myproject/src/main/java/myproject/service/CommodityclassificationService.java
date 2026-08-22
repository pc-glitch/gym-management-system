package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.CommodityclassificationVO;
import myproject.query.CommodityclassificationQuery;
import myproject.entity.CommodityclassificationEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 商品分类
*
*/
public interface CommodityclassificationService extends BaseService<CommodityclassificationEntity> {

    PageResult<CommodityclassificationVO> page(CommodityclassificationQuery query);

    List<CommodityclassificationVO> queryList(CommodityclassificationQuery query);

    void save(CommodityclassificationVO vo);

    void update(CommodityclassificationVO vo);

    void delete(List<Long> idList);

    void export(CommodityclassificationQuery query);

    void importcommodityclassification(File importFile);
                
    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<CommodityclassificationEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<CommodityclassificationEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<CommodityclassificationEntity> wrapper);
}