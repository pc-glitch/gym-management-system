package myproject.service;

import myproject.common.utils.Result;
import myproject.vo.MessageVO;

import java.util.Date;
import java.util.List;

public interface MessageService {
	/**
	 * 加载历史消息
	 *
	 * @param type
	 * @param updateTime
	 * @param toId
	 * @param count
	 * @param userId
	 * @return
	 */
	Result loadMessage(Integer type, Date updateTime, Long toId, Integer count, Long userId);

	Result<List<MessageVO>> historyUserID(Long userId);
}
