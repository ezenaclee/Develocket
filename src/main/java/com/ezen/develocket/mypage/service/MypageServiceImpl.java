package com.ezen.develocket.mypage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.develocket.mypage.dao.MypageDAO;
import com.ezen.develocket.mypage.vo.MypageVO;
import com.ezen.develocket.request.vo.ReceiveEstimateVO;
import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;

@Service("mypageService")
@Transactional(propagation = Propagation.REQUIRED)
public class MypageServiceImpl implements MypageService{

	@Autowired
	MypageDAO mypageDAO;

	@Override
	public MypageVO selectMyPageVO(String rocket_cd) throws DataAccessException {
		return mypageDAO.selectMyPageVO(rocket_cd);
	}

	@Override
	public RocketInfoVO selectRocketInfo(String rocket_cd) throws DataAccessException {
		return mypageDAO.selectRocketInfo(rocket_cd);
	}
 
	@Override
	public MypageVO reCheckPwd(MypageVO mypageVO) throws DataAccessException {
		return mypageDAO.reCheckPwd(mypageVO);	
	}
	
	@Override
	public void ModifyRocketInfo(MypageVO mypageVO) throws DataAccessException {
		mypageDAO.ModifyRocketInfo(mypageVO);
	}
	
	@Override
	public void DeleteRocketInfo(MypageVO mypageVO) throws DataAccessException {
		mypageDAO.DeleteRocketInfo(mypageVO);
	}

	@Override
	public void modifyProfileImage(Map<String, Object> myPageMap) throws DataAccessException {
		mypageDAO.updateProfileImage(myPageMap);
	}

	@Override
	public void removeExistImage(String rocket_cd) throws DataAccessException {
		mypageDAO.updateRemoveProfile(rocket_cd);
	}

	@Override
	public String checkStarCD(String rocket_cd) {

		return mypageDAO.checkStarCD(rocket_cd);
	}

}
