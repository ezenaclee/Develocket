package com.ezen.develocket.mypage.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.ezen.develocket.mypage.vo.MypageVO;
import com.ezen.develocket.request.vo.ReceiveEstimateVO;
import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;

public interface MypageService {

	public MypageVO selectMyPageVO(String rocket_cd) throws DataAccessException;
	public RocketInfoVO selectRocketInfo(String rocket_cd) throws DataAccessException;

	public MypageVO reCheckPwd(MypageVO mypageVO) throws DataAccessException;

	public void ModifyRocketInfo(MypageVO mypageVO) throws DataAccessException;

	public void DeleteRocketInfo(MypageVO mypageVO) throws DataAccessException;

    public void modifyProfileImage(Map<String, Object> myPageMap) throws DataAccessException;

    public void removeExistImage(String rocket_cd) throws DataAccessException;

    public String checkStarCD (String rocket_cd) throws DataAccessException;
}
