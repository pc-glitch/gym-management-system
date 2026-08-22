package myproject.convert;

import myproject.entity.SiteclassificationEntity;
import myproject.vo.SiteclassificationVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
* 场地分类
*
*/
@Mapper
public interface SiteclassificationConvert {
    SiteclassificationConvert INSTANCE = Mappers.getMapper(SiteclassificationConvert.class);

    SiteclassificationEntity convert(SiteclassificationVO vo);

    SiteclassificationVO convert(SiteclassificationEntity entity);

    List<SiteclassificationVO> convertList(List<SiteclassificationEntity> list);

    List<SiteclassificationEntity> convertEntityList(List<SiteclassificationVO> list);
}