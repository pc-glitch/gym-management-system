package myproject.convert;

import myproject.entity.ActivitytypeEntity;
import myproject.vo.ActivitytypeVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
* 活动类型
*
*/
@Mapper
public interface ActivitytypeConvert {
    ActivitytypeConvert INSTANCE = Mappers.getMapper(ActivitytypeConvert.class);

    ActivitytypeEntity convert(ActivitytypeVO vo);

    ActivitytypeVO convert(ActivitytypeEntity entity);

    List<ActivitytypeVO> convertList(List<ActivitytypeEntity> list);

    List<ActivitytypeEntity> convertEntityList(List<ActivitytypeVO> list);
}