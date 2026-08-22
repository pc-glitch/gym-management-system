package myproject.dao;

import myproject.common.entity.Message;
import myproject.common.utils.BaseDao;
import myproject.vo.MessageVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 *
 */
@Mapper
public interface MessageDao extends BaseDao<Message> {

    List<Message> listMessage(@Param("type") Integer type, @Param("updateTime") Date updateTime,
                              @Param("fromId") Long fromId, @Param("toId") Long toId, @Param("count") Integer count);

    List<MessageVO> historyUserID(@Param("userId") Long userId);
    
    void insertMessage(Message message);
}