package myproject.service.impl;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.excel.ExcelFinishCallBack;
import myproject.common.impl.BaseServiceImpl;
import myproject.common.page.PageResult;
import myproject.common.utils.*;
import myproject.convert.DiscussConvert;
import myproject.dao.DiscussDao;
import myproject.entity.DiscussEntity;
import myproject.query.DiscussQuery;
import myproject.service.DiscussService;
import myproject.vo.DiscussVO;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 评论表
 */
@Service
@AllArgsConstructor
public class DiscussServiceImpl extends BaseServiceImpl<DiscussDao, DiscussEntity> implements DiscussService {
	@Resource
	private RedisCache redisCache;

	@Override
	public PageResult<DiscussVO> page(DiscussQuery query) {
		IPage<DiscussEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
		return new PageResult<>(DiscussConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
	}

	@Override
	public List<DiscussVO> queryList(DiscussQuery query) {
		LambdaQueryWrapper<DiscussEntity> wrapper = Wrappers.lambdaQuery();
		wrapper.eq(null != query.getRefid(), DiscussEntity::getRefid, query.getRefid());
		wrapper.isNull(DiscussEntity::getParentId);
		wrapper.eq(query.getUserid() != null, DiscussEntity::getUserid, query.getUserid());
		//所有父评论
		List<DiscussEntity> discussEntities = baseMapper.selectList(wrapper);
		List<DiscussVO> discussVOS = DiscussConvert.INSTANCE.convertList(discussEntities);
		for (DiscussVO discussVO : discussVOS) {
			if (GloabUtils.getUserId() != null) {
				discussVO.setIsLike(redisCache.hasKey(GloabUtils.getUserId().toString() + discussVO.getId().toString()));
			}
			setChildren(discussVO);
		}
		return discussVOS;
	}

	private LambdaQueryWrapper<DiscussEntity> getWrapper(DiscussQuery query) {
		LambdaQueryWrapper<DiscussEntity> wrapper = Wrappers.lambdaQuery();
		wrapper.eq(null != query.getId(), DiscussEntity::getId, query.getId());
		wrapper.eq(null != query.getRefid(), DiscussEntity::getRefid, query.getRefid());
		wrapper.eq(null != query.getUserid(), DiscussEntity::getUserid, query.getUserid());
		wrapper.eq(null != query.getRefuserid(), DiscussEntity::getRefuserid, query.getRefuserid());
		wrapper.eq(StringUtils.isNotEmpty(query.getAvatarurl()), DiscussEntity::getAvatarurl, query.getAvatarurl());
		wrapper.eq(StringUtils.isNotEmpty(query.getNickname()), DiscussEntity::getNickname, query.getNickname());
		wrapper.eq(StringUtils.isNotEmpty(query.getContent()), DiscussEntity::getContent, query.getContent());
		wrapper.eq(null != query.getParentId(), DiscussEntity::getParentId, query.getParentId());
		wrapper.eq(null != query.getLikesCount(), DiscussEntity::getLikesCount, query.getLikesCount());
		wrapper.between(ArrayUtils.isNotEmpty(query.getCreateTime()), DiscussEntity::getCreateTime, ArrayUtils.isNotEmpty(query.getCreateTime()) ? query.getCreateTime()[0] : null, ArrayUtils.isNotEmpty(query.getCreateTime()) ? query.getCreateTime()[1] : null);
		wrapper.eq(StringUtils.isNotEmpty(query.getPicture()), DiscussEntity::getPicture, query.getPicture());
		wrapper.eq(StringUtils.isNotEmpty(query.getStar()), DiscussEntity::getStar, query.getStar());
		wrapper.eq(StringUtils.isNotEmpty(query.getDisplay()), DiscussEntity::getDisplay, query.getDisplay());
		wrapper.eq(StringUtils.isNotEmpty(query.getVideo()), DiscussEntity::getVideo, query.getVideo());
		return wrapper;
	}

	@Override
	public void save(DiscussVO vo) {
		DiscussEntity entity = DiscussConvert.INSTANCE.convert(vo);
		TokenEntity userInfo = GloabUtils.getUserInfo();
		entity.setUserid(userInfo.getUserid());
		entity.setAvatarurl(userInfo.getAvatarurl());
		entity.setNickname(userInfo.getName());
		entity.setCreateTime(DateUtil.date());
		entity.setDisplay(Boolean.TRUE.toString());
		entity.setLikesCount(0);
		baseMapper.insert(entity);
	}

	@Override
	public void update(DiscussVO vo) {
		DiscussEntity entity = DiscussConvert.INSTANCE.convert(vo);
		updateById(entity);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void delete(List<Long> idList) {
		for (Long id : idList) {
			deleteChildren(id);
		}
		removeByIds(idList);
	}

	@Transactional
	public boolean deleteChildren(Long id) {
		//根据父id查询子id列表
		LambdaQueryWrapper<DiscussEntity> lambdaQueryWrapper = new LambdaQueryWrapper<>();
		lambdaQueryWrapper.eq(DiscussEntity::getParentId, id);
		List<DiscussEntity> list = list(lambdaQueryWrapper);
		for (DiscussEntity comment : list) {
			this.removeById(id);
			deleteChildren(comment.getId());
		}
		return true;
	}

	@Override
	public void like(Long id) {
		if (redisCache.hasKey(GloabUtils.getUserId().toString() + id.toString())) {
			redisCache.deleteObject(GloabUtils.getUserId().toString() + id);
			baseMapper.unlike(id);
		} else {
			redisCache.setCacheObject(GloabUtils.getUserId().toString() + id, "1");
			baseMapper.like(id);
		}
	}

	@Override
	public List<DiscussVO> queryTree(DiscussQuery query) {
		LambdaQueryWrapper<DiscussEntity> wrapper = Wrappers.lambdaQuery();
		wrapper.eq(null != query.getId(), DiscussEntity::getParentId, query.getId());
		wrapper.eq(query.getUserid() != null, DiscussEntity::getUserid, query.getUserid());
		wrapper.eq(query.getRefid() != null, DiscussEntity::getRefid, query.getRefid());
		//所有父评论
		List<DiscussEntity> discussEntities = baseMapper.selectList(wrapper);
		List<DiscussVO> discussVOS = DiscussConvert.INSTANCE.convertList(discussEntities);
		for (DiscussVO discussVO : discussVOS) {
			if (GloabUtils.getUserId() != null) {
				discussVO.setIsLike(redisCache.hasKey(GloabUtils.getUserId().toString() + discussVO.getId().toString()));
			}
			setChildren(discussVO);
		}
		return discussVOS;
	}

	@Override
	public List<DiscussVO> MyList(DiscussQuery query) {
		List<DiscussVO> list = DiscussConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
		for (DiscussVO discussVO : list) {
			DiscussQuery discussQuery = new DiscussQuery();
			discussQuery.setId(discussVO.getId());
			discussQuery.setUserid(GloabUtils.getUserId());
			discussVO.setChildren(queryTree(discussQuery));
		}
		return list;
	}

	private void setChildren(DiscussVO discussVO) {
		LambdaQueryWrapper<DiscussEntity> rootCommentsWrapper = new LambdaQueryWrapper<>();
		rootCommentsWrapper.eq(DiscussEntity::getParentId, discussVO.getId());
		List<DiscussEntity> children = baseMapper.selectList(rootCommentsWrapper);
		List<DiscussVO> childrens = DiscussConvert.INSTANCE.convertList(children);
		//遍历子结点
		if (!children.isEmpty()) {
			discussVO.setChildren(childrens);
			for (DiscussVO child : childrens) {
				if (GloabUtils.getUserId() != null) {
					discussVO.setIsLike(redisCache.hasKey(GloabUtils.getUserId().toString() + discussVO.getId().toString()));
				}
				setChildren(child);
			}
		}
	}


	@Override
	@SneakyThrows
	public void export(DiscussQuery query) {
		List<DiscussVO> list = DiscussConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
		// 写到浏览器打开
		ExcelUtils.excelExport(DiscussVO.class, "评论表" + DateUtils.format(new Date()), null, list);
	}

	@Override
	@SneakyThrows
	public void importdiscuss(File file) {
		ExcelUtils.readAnalysis(file, DiscussVO.class, new ExcelFinishCallBack<DiscussVO>() {
			@Override
			public void doAfterAllAnalysed(List<DiscussVO> result) {
				saveDiscusss(result);
			}

			@Override
			public void doSaveBatch(List<DiscussVO> result) {
				saveDiscusss(result);
			}

			private void saveDiscusss(List<DiscussVO> result) {
				List<DiscussEntity> DiscussEntities = DiscussConvert.INSTANCE.convertEntityList(result);
				saveBatch(DiscussEntities);
			}
		});
	}

	@Override
	public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<DiscussEntity> wrapper) {
		return baseMapper.selectValue(params, wrapper);
	}

	@Override
	public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<DiscussEntity> wrapper) {
		return baseMapper.selectTimeStatValue(params, wrapper);
	}

	@Override
	public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<DiscussEntity> wrapper) {
		return baseMapper.selectGroup(params, wrapper);
	}
}