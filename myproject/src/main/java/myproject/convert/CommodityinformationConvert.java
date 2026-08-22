package myproject.convert;

import myproject.entity.CommodityinformationEntity;
import myproject.vo.CommodityinformationVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
* 商品信息
*
*/
@Mapper
public interface CommodityinformationConvert {
    CommodityinformationConvert INSTANCE = Mappers.getMapper(CommodityinformationConvert.class);

    CommodityinformationEntity convert(CommodityinformationVO vo);

    CommodityinformationVO convert(CommodityinformationEntity entity);

    List<CommodityinformationVO> convertList(List<CommodityinformationEntity> list);

    List<CommodityinformationEntity> convertEntityList(List<CommodityinformationVO> list);
}