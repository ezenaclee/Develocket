package com.ezen.develocket.mypage.dao;

import java.util.Map;

import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.ezen.develocket.mypage.vo.MypageVO;
import com.ezen.develocket.request.vo.ReceiveEstimateVO;

@Repository("mypageDAO")
public class MypageDAOImpl implements MypageDAO {

	///
	@Autowired
	private SqlSession sqlSession;

	@Override
	public MypageVO selectMyPageVO(String rocket_cd) throws DataAccessException {

		MypageVO mypageVO = sqlSession.selectOne("mapper.mypageInfo.selectMyPageVO",rocket_cd);

		return mypageVO;
	}

	@Override
	public RocketInfoVO selectRocketInfo(String rocket_cd) throws DataAccessException {
		RocketInfoVO rocketInfoVO = sqlSession.selectOne("mapper.mypageInfo.selectRocketInfo",rocket_cd);

		return rocketInfoVO;
	}
	
	@Override
	public MypageVO reCheckPwd(MypageVO mypageVO) throws DataAccessException {		
		 return sqlSession.selectOne("mapper.mypageInfo.reCheckPwd", mypageVO);	

	}
	
	@Override
	public void ModifyRocketInfo(MypageVO mypageVO) throws DataAccessException {
		sqlSession.update("mapper.mypageInfo.modifyRocketInfo", mypageVO);
	}

	@Override
	public void DeleteRocketInfo(MypageVO mypageVO) throws DataAccessException {
		sqlSession.update("mapper.mypageInfo.deleteRocketInfo", mypageVO);
	}

	@Override
	public void updateProfileImage(Map<String, Object> myPageMap) throws DataAccessException {
		sqlSession.update("mapper.mypageInfo.updateProfileImage", myPageMap);
	}

	@Override
	public void updateRemoveProfile(String rocket_cd) throws DataAccessException {
		sqlSession.update("mapper.mypageInfo.updateRemoveProfile", rocket_cd);
	}

	@Override
	public String checkStarCD(String rocket_cd) throws DataAccessException {

		String star_cd = sqlSession.selectOne("mapper.mypageInfo.checkStarCD", rocket_cd);

		return star_cd;
	}
}
