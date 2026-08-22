package myproject.convert;

import myproject.entity.VenuereservationEntity;
import myproject.vo.VenuereservationVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
* 场地预约
*
*/
@Mapper
public interface VenuereservationConvert {
    VenuereservationConvert INSTANCE = Mappers.getMapper(VenuereservationConvert.class);

    VenuereservationEntity convert(VenuereservationVO vo);

    VenuereservationVO convert(VenuereservationEntity entity);

    List<VenuereservationVO> convertList(List<VenuereservationEntity> list);

    List<VenuereservationEntity> convertEntityList(List<VenuereservationVO> list);
}