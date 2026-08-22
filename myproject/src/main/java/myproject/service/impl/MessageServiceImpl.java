package myproject.service.impl;

import myproject.common.entity.Message;
import myproject.common.utils.GloabUtils;
import myproject.common.utils.Result;
import myproject.dao.MessageDao;
import myproject.entity.ImageContentEntity;
import myproject.entity.SysAttachmentEntity;
import myproject.entity.TextContentEntity;
import myproject.service.ImageContentService;
import myproject.service.MessageService;
import myproject.service.SysAttachmentService;
import myproject.service.TextContentService;
import myproject.vo.MessageVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class MessageServiceImpl implements MessageService {
	@Resource
	MessageDao messageDao;
	@Resource
	TextContentService textContentService;
	@Resource
	ImageContentService imageContentService;
	@Resource
	SysAttachmentService sysAttachmentService;

	@Override
	public Result loadMessage(Integer type, Date updateTime, Long toId, Integer count, Long userId) {
		List<Message> messages = this.messageDao.listMessage(type, updateTime, userId, toId, count);
		List<Map<String, Object>> collections = new ArrayList<>();
		for (Message message : messages) {
			Map<String, Object> dataMap = new HashMap<>();
			dataMap.put("id", message.getId());
			dataMap.put("fromId", message.getFromId());
			dataMap.put("toId", message.getToId());
			dataMap.put("adminId", message.getAdminId());
			dataMap.put("userId", message.getUserId());
			dataMap.put("name", message.getUsername());
			dataMap.put("avatarurl", message.getAvatarurl());
			dataMap.put("updateTime", message.getUpdateTime());
			dataMap.put("contentType", message.getContentType());
			String content = "";
			if (message.getContentType() == 0) {
				TextContentEntity textContent = textContentService.getById(message.getContentId());
				content = textContent != null ? textContent.getContent() : "";
			} else if (message.getContentType() == 1) {
				ImageContentEntity imageContent = imageContentService.getById(message.getContentId());
				content = imageContent != null ? imageContent.getPath() : "";
			} else {
				SysAttachmentEntity sysAttachment = sysAttachmentService.getById(message.getContentId());
				content = sysAttachment != null ? sysAttachment.getName() : "";
			}
			dataMap.put("content", content);
			String url = null;
			if (message.getContentType() == 2) {
				SysAttachmentEntity sysAttachment = sysAttachmentService.getById(message.getContentId());
				url = sysAttachment != null ? sysAttachment.getUrl() : null;
			}
			dataMap.put("url", url);
			collections.add(dataMap);
		}
		return Result.ok(collections);
	}

	@Override
	public Result<List<MessageVO>> historyUserID(Long userId) {
		return Result.ok(messageDao.historyUserID(userId));
	}
}
