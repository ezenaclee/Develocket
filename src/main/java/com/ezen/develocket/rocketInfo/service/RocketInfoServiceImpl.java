package com.ezen.develocket.rocketInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.develocket.rocketInfo.dao.RocketInfoDAO;
import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;

@Service("rocketInfoService")
@Transactional(propagation = Propagation.REQUIRED)
public class RocketInfoServiceImpl implements RocketInfoService {

	@Autowired
	private RocketInfoDAO rocketInfoDAO;
	
	@Override
	public void joinRocketInfo(RocketInfoVO rocketInfoVO) throws DataAccessException {

		rocketInfoDAO.insertRocketInfo(rocketInfoVO);
	}

	@Override
	public RocketInfoVO loginRocket(RocketInfoVO rocketInfoVO) throws DataAccessException {

		return rocketInfoDAO.loginByID(rocketInfoVO);
	}

	@Override
	public List<String> selectAllStarFieldCD(String rocket_cd) throws DataAccessException {

		return rocketInfoDAO.selectAllStarFieldCD(rocket_cd);
	}
	
	@Override
	public String searchID(String email) throws DataAccessException {
		String id = rocketInfoDAO.searchID(email);
		return id;
	}

	@Override
	public int idEmailCheck(RocketInfoVO rocketInfoVO) throws DataAccessException {
		
		return rocketInfoDAO.idEmailCheck(rocketInfoVO);
	}

	@Override
	public void updatePassword(RocketInfoVO rocketInfoVO) throws DataAccessException {
		rocketInfoDAO.updatePassword(rocketInfoVO);
	}
	
	@Override
	public int IdCheck(String id) throws DataAccessException {
		int count = rocketInfoDAO.IdCheck(id);
		return count;
	}

	@Override
	public int PhoneCheck(String phone_number) throws DataAccessException {
		int count = rocketInfoDAO.PhoneCheck(phone_number);
		return count;
	}

	@Override
	public int EmailCheck(String email) throws DataAccessException {
		int count = rocketInfoDAO.EmailCheck(email);
		return count;
	}
	
	///
	@Override
	public RocketInfoVO loginByIDSS(String inputId) throws DataAccessException {

		return rocketInfoDAO.loginByIDSS(inputId);
	}

	//02.23	
	@Override
	public void InsertNaverInfo(RocketInfoVO rocketInfoVO) throws DataAccessException {
		
		rocketInfoDAO.InsertNaverInfo(rocketInfoVO);
	}
	
	@Override
	public int SearchNaverID(String email) throws DataAccessException {
		return rocketInfoDAO.SearchNaverID(email);
	}

	@Override
	public String SearchNaverPwd(String email) throws DataAccessException {
		return rocketInfoDAO.SearchNaverPwd(email);
	}

	@Override
	public RocketInfoVO loginByNaver(RocketInfoVO rocketInfoVO) throws DataAccessException {
		return rocketInfoDAO.loginByNaver(rocketInfoVO);
	}	
}