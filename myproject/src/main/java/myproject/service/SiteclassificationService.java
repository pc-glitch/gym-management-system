package myproject.service;

import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.vo.SiteclassificationVO;
import myproject.query.SiteclassificationQuery;
import myproject.entity.SiteclassificationEntity;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Map;
import java.io.File;
/**
* 场地分类
*
*/
public interface SiteclassificationService extends BaseService<SiteclassificationEntity> {

    PageResult<SiteclassificationVO> page(SiteclassificationQuery query);

    List<SiteclassificationVO> queryList(SiteclassificationQuery query);

    void save(SiteclassificationVO vo);

    void update(SiteclassificationVO vo);

    void delete(List<Long> idList);

    void export(SiteclassificationQuery query);

    void importsiteclassification(File importFile);
                
    List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<SiteclassificationEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<SiteclassificationEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<SiteclassificationEntity> wrapper);
}