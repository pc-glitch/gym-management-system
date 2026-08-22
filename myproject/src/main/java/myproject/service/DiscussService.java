package myproject.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import myproject.common.page.PageResult;
import myproject.common.utils.BaseService;
import myproject.entity.DiscussEntity;
import myproject.query.DiscussQuery;
import myproject.vo.DiscussVO;

import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * 评论表
 */
public interface DiscussService extends BaseService<DiscussEntity> {

	PageResult<DiscussVO> page(DiscussQuery query);

	List<DiscussVO> queryList(DiscussQuery query);

	void save(DiscussVO vo);

	void update(DiscussVO vo);

	void delete(List<Long> idList);

	void export(DiscussQuery query);

	void importdiscuss(File importFile);

	List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<DiscussEntity> wrapper);

	List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<DiscussEntity> wrapper);

	List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<DiscussEntity> wrapper);

	void like(Long id);

	List<DiscussVO> queryTree(DiscussQuery query);

	List<DiscussVO> MyList(DiscussQuery query);
}