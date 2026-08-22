package myproject.convert;

import myproject.entity.ActivityinformationEntity;
import myproject.vo.ActivityinformationVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
* 活动信息
*
*/
@Mapper
public interface ActivityinformationConvert {
    ActivityinformationConvert INSTANCE = Mappers.getMapper(ActivityinformationConvert.class);

    ActivityinformationEntity convert(ActivityinformationVO vo);

    ActivityinformationVO convert(ActivityinformationEntity entity);

    List<ActivityinformationVO> convertList(List<ActivityinformationEntity> list);

    List<ActivityinformationEntity> convertEntityList(List<ActivityinformationVO> list);
}