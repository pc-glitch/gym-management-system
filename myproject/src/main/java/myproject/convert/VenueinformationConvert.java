package myproject.convert;

import myproject.entity.VenueinformationEntity;
import myproject.vo.VenueinformationVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
* 场地信息
*
*/
@Mapper
public interface VenueinformationConvert {
    VenueinformationConvert INSTANCE = Mappers.getMapper(VenueinformationConvert.class);

    VenueinformationEntity convert(VenueinformationVO vo);

    VenueinformationVO convert(VenueinformationEntity entity);

    List<VenueinformationVO> convertList(List<VenueinformationEntity> list);

    List<VenueinformationEntity> convertEntityList(List<VenueinformationVO> list);
}