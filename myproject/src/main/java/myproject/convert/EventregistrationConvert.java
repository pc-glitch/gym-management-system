package myproject.convert;

import myproject.entity.EventregistrationEntity;
import myproject.vo.EventregistrationVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
* 赛事报名
*
*/
@Mapper
public interface EventregistrationConvert {
    EventregistrationConvert INSTANCE = Mappers.getMapper(EventregistrationConvert.class);

    EventregistrationEntity convert(EventregistrationVO vo);

    EventregistrationVO convert(EventregistrationEntity entity);

    List<EventregistrationVO> convertList(List<EventregistrationEntity> list);

    List<EventregistrationEntity> convertEntityList(List<EventregistrationVO> list);
}