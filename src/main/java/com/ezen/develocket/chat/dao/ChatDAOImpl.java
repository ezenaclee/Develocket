package com.ezen.develocket.chat.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.ezen.develocket.chat.vo.ChatContentVO;
import com.ezen.develocket.chat.vo.ChatRoomVO;
import com.ezen.develocket.chat.vo.RocketChatVO;
import com.ezen.develocket.chat.vo.StarChatVO;

@Repository("chatDAO")
public class ChatDAOImpl implements ChatDAO {

	@Autowired
	private SqlSession sqlSession;

	
	@Override
	public void insertNewChatContent(ChatContentVO chatContentVO) throws DataAccessException {

		sqlSession.insert("mapper.chatContent.insertNewChatContent", chatContentVO);
	}


	@Override
	public List<RocketChatVO> selectAllRocketChatList(String rocket_cd) throws DataAccessException {

		List<String> contractCDList = selectRocketContract3(rocket_cd);
		
		List<RocketChatVO> rocketChatVOList = new ArrayList<>();
		
		for (String contract_cd : contractCDList) {
			Map<String, String> rocketChatMap = new HashMap<>();
			rocketChatMap.put("rocket_cd", rocket_cd);
			rocketChatMap.put("contract_cd", contract_cd);
			
			RocketChatVO rocketChatListVO = sqlSession.selectOne("mapper.chatContent.selectAllRocketChatList", rocketChatMap);
			rocketChatVOList.add(rocketChatListVO);
		}
		
		return rocketChatVOList;
	}
	
	// 본인이 로켓인 상태에서 status_info가 '3'이상인 모든 contract_cd
	private List<String> selectRocketContract3(String rocket_cd) throws DataAccessException {
		
		List<String> contractCDList = sqlSession.selectList("mapper.chatContent.selectRocketContract3", rocket_cd);
		
		return contractCDList;
	}


	@Override
	public List<StarChatVO> selectAllStarChatList(String star_cd) throws DataAccessException {

		List<String> contractCDList = selectStarContract3(star_cd);
		
		List<StarChatVO> starChatVOList = new ArrayList<>();
		
		for (String contract_cd : contractCDList) {
			Map<String, String> starChatMap = new HashMap<>();
			starChatMap.put("star_cd", star_cd);
			starChatMap.put("contract_cd", contract_cd);
			
			StarChatVO starChatVO = sqlSession.selectOne("mapper.chatContent.selectAllStarChatList", starChatMap);
			starChatVOList.add(starChatVO);
		}
		
		return starChatVOList;
	}
	
	// 본인이 스타인 상태에서 status_info가 '3'이상인 모든 contract_cd
	private List<String> selectStarContract3(String star_cd) throws DataAccessException {
		
		List<String> contractCDList = sqlSession.selectList("mapper.chatContent.selectStarContract3", star_cd);
		
		return contractCDList;
	}


	@Override
	public List<ChatContentVO> selectAllChatContent(String contract_cd) throws DataAccessException {

		List<ChatContentVO> chatContentVOList = sqlSession.selectList("mapper.chatContent.selectAllChatContent", contract_cd);

		return chatContentVOList;
	}
	
	@Override
	public ChatRoomVO selectChatRoomVO(String contract_cd) throws DataAccessException {

		ChatRoomVO chatRoomVO = sqlSession.selectOne("mapper.chatContent.selectChatRoomVO", contract_cd);
		
		return chatRoomVO;
	}

	@Override
	public void insertNewMessage(ChatContentVO chatContentVO) throws DataAccessException {

		String contract_cd = chatContentVO.getContract_cd();
		String chat_sn = selectMaxChatSN(contract_cd);
		
		chatContentVO.setChat_sn(chat_sn);
		
		sqlSession.insert("mapper.chatContent.insertNewMessage", chatContentVO);	
	}
	
	// 각 채팅창의 채팅순번 찾기
	private String selectMaxChatSN(String contract_cd) {
		
		String chat_sn = sqlSession.selectOne("mapper.chatContent.selectMaxChatSN", contract_cd);
		
		return chat_sn;
	}


	@Override
	public void updateViewCheck(Map<String, String> viewCheckMap) throws DataAccessException {

		sqlSession.update("mapper.chatContent.updateViewCheck", viewCheckMap);
	}

	@Override
	public void updateContract6(String contract_cd) throws DataAccessException {

		sqlSession.update("mapper.chatContent.updateContract6", contract_cd);
	}

}
