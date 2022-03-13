package com.ezen.develocket.chat.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.ezen.develocket.chat.vo.ChatContentVO;
import com.ezen.develocket.chat.vo.ChatRoomVO;
import com.ezen.develocket.chat.vo.RocketChatVO;
import com.ezen.develocket.chat.vo.StarChatVO;

public interface ChatDAO {

	public void insertNewChatContent(ChatContentVO chatContentVO) throws DataAccessException;

	public List<RocketChatVO> selectAllRocketChatList(String rocket_cd) throws DataAccessException;

	public List<StarChatVO> selectAllStarChatList(String star_cd) throws DataAccessException;

	public List<ChatContentVO> selectAllChatContent(String contract_cd) throws DataAccessException;

	public ChatRoomVO selectChatRoomVO(String contract_cd) throws DataAccessException;

	public void insertNewMessage(ChatContentVO chatContentVO) throws DataAccessException;

	public void updateViewCheck(Map<String, String> viewCheckMap) throws DataAccessException;

	void updateContract6(String contract_cd) throws  DataAccessException;
}
