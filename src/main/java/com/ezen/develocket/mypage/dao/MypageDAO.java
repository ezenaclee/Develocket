package com.ezen.develocket.mypage.dao;

import java.util.List;
import java.util.Map;

import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;
import org.springframework.dao.DataAccessException;

import com.ezen.develocket.mypage.vo.MypageVO;
import com.ezen.develocket.request.vo.ReceiveEstimateVO;

public interface MypageDAO {

	public MypageVO selectMyPageVO(String rocket_cd) throws DataAccessException;

	public RocketInfoVO selectRocketInfo(String rocket_cd) throws DataAccessException;

	public MypageVO reCheckPwd(MypageVO mypageVO) throws DataAccessException;
	
	public void ModifyRocketInfo(MypageVO mypageVO) throws DataAccessException;

	public void DeleteRocketInfo(MypageVO mypageVO) throws DataAccessException;

    public void updateProfileImage(Map<String, Object> myPageMap) throws DataAccessException;

	public void updateRemoveProfile(String rocket_cd) throws DataAccessException;

    public String checkStarCD(String rocket_cd) throws DataAccessException;
}
