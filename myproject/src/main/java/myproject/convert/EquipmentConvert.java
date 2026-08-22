package myproject.convert;

import myproject.entity.EquipmentEntity;
import myproject.vo.EquipmentVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
* 器材信息
*
*/
@Mapper
public interface EquipmentConvert {
    EquipmentConvert INSTANCE = Mappers.getMapper(EquipmentConvert.class);

    EquipmentEntity convert(EquipmentVO vo);

    EquipmentVO convert(EquipmentEntity entity);

    List<EquipmentVO> convertList(List<EquipmentEntity> list);

    List<EquipmentEntity> convertEntityList(List<EquipmentVO> list);
}