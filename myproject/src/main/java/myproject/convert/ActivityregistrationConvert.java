package myproject.convert;

import myproject.entity.ActivityregistrationEntity;
import myproject.vo.ActivityregistrationVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
* 活动报名
*
*/
@Mapper
public interface ActivityregistrationConvert {
    ActivityregistrationConvert INSTANCE = Mappers.getMapper(ActivityregistrationConvert.class);

    ActivityregistrationEntity convert(ActivityregistrationVO vo);

    ActivityregistrationVO convert(ActivityregistrationEntity entity);

    List<ActivityregistrationVO> convertList(List<ActivityregistrationEntity> list);

    List<ActivityregistrationEntity> convertEntityList(List<ActivityregistrationVO> list);
}
