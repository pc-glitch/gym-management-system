package myproject.convert;

import myproject.entity.EventinformationEntity;
import myproject.vo.EventinformationVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
* 赛事信息
*
*/
@Mapper
public interface EventinformationConvert {
    EventinformationConvert INSTANCE = Mappers.getMapper(EventinformationConvert.class);

    EventinformationEntity convert(EventinformationVO vo);

    EventinformationVO convert(EventinformationEntity entity);

    List<EventinformationVO> convertList(List<EventinformationEntity> list);

    List<EventinformationEntity> convertEntityList(List<EventinformationVO> list);
}