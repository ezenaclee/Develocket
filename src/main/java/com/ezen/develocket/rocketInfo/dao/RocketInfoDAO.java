package com.ezen.develocket.rocketInfo.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;

public interface RocketInfoDAO {

	public void insertRocketInfo(RocketInfoVO rocketInfoVO) throws DataAccessException;

	public RocketInfoVO loginByID(RocketInfoVO rocketInfoVO) throws DataAccessException;

	public List<String> selectAllStarFieldCD(String rocket_cd) throws DataAccessException;

	public String searchID(String email) throws DataAccessException;
	
	public int idEmailCheck(RocketInfoVO rocketInfoVO) throws DataAccessException;
	
	public void updatePassword(RocketInfoVO rocketInfoVO) throws DataAccessException;
	
	public int IdCheck(String id) throws DataAccessException;

	public int PhoneCheck(String phone_number) throws DataAccessException;

	public int EmailCheck(String email) throws DataAccessException;
	
	public RocketInfoVO loginByIDSS(String inputId) throws DataAccessException;
	
	//02.23	
	public void InsertNaverInfo(RocketInfoVO rocketInfoVO) throws DataAccessException;
	
	public int SearchNaverID(String email) throws DataAccessException;

	public String SearchNaverPwd(String email) throws DataAccessException;

	public RocketInfoVO loginByNaver(RocketInfoVO rocketInfoVO) throws DataAccessException;

}
