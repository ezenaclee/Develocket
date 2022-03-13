package com.ezen.develocket.chat.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.ezen.develocket.chat.dao.ChatDAO;
import com.ezen.develocket.chat.vo.ChatContentVO;
import com.ezen.develocket.chat.vo.ChatRoomVO;
import com.ezen.develocket.chat.vo.RocketChatVO;
import com.ezen.develocket.chat.vo.StarChatVO;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("chatService")
@Transactional(propagation = Propagation.REQUIRED)
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDAO chatDAO;

	
	@Override
	public void insertNewChatContent(ChatContentVO chatContentVO) throws DataAccessException {

		chatDAO.insertNewChatContent(chatContentVO);
	}


	@Override
	public List<RocketChatVO> selectAllRocketChatList(String rocket_cd) throws DataAccessException {
		
		return chatDAO.selectAllRocketChatList(rocket_cd);
	}


	@Override
	public List<StarChatVO> selectAllStarChatList(String star_cd) throws DataAccessException {

		return chatDAO.selectAllStarChatList(star_cd);
	}


	@Override
	public List<ChatContentVO> selectChattingData(String contract_cd) throws DataAccessException {

		return chatDAO.selectAllChatContent(contract_cd);
	}
	
	@Override
	public ChatRoomVO selectChatRoomVO(String contract_cd) throws DataAccessException {

		return chatDAO.selectChatRoomVO(contract_cd);
	}

	@Override
	public void insertNewMessage(ChatContentVO chatContentVO) throws DataAccessException {

		chatDAO.insertNewMessage(chatContentVO);
	}


	@Override
	public void updateViewCheck(Map<String, String> viewCheckMap) throws DataAccessException {

		chatDAO.updateViewCheck(viewCheckMap);
	}

	@Override
	public void updateContract6(String contract_cd) throws DataAccessException {

		chatDAO.updateContract6(contract_cd);
	}


}
