package myproject.convert;

import myproject.entity.EquipmentRentalEntity;
import myproject.vo.EquipmentRentalVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
* 器材租借
*
*/
@Mapper
public interface EquipmentRentalConvert {
    EquipmentRentalConvert INSTANCE = Mappers.getMapper(EquipmentRentalConvert.class);

    EquipmentRentalEntity convert(EquipmentRentalVO vo);

    EquipmentRentalVO convert(EquipmentRentalEntity entity);

    List<EquipmentRentalVO> convertList(List<EquipmentRentalEntity> list);

    List<EquipmentRentalEntity> convertEntityList(List<EquipmentRentalVO> list);
}