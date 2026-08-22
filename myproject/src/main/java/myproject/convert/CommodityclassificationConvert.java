package myproject.convert;

import myproject.entity.CommodityclassificationEntity;
import myproject.vo.CommodityclassificationVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
* 商品分类
*
*/
@Mapper
public interface CommodityclassificationConvert {
    CommodityclassificationConvert INSTANCE = Mappers.getMapper(CommodityclassificationConvert.class);

    CommodityclassificationEntity convert(CommodityclassificationVO vo);

    CommodityclassificationVO convert(CommodityclassificationEntity entity);

    List<CommodityclassificationVO> convertList(List<CommodityclassificationEntity> list);

    List<CommodityclassificationEntity> convertEntityList(List<CommodityclassificationVO> list);
}