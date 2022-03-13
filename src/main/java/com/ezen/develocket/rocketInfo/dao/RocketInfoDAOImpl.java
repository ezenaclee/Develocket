package com.ezen.develocket.rocketInfo.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;

@Repository("rocketInfoDAO")
public class RocketInfoDAOImpl implements RocketInfoDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertRocketInfo(RocketInfoVO rocketInfoVO) throws DataAccessException {
		
		sqlSession.insert("mapper.rocketInfo.insertRocketInfo", rocketInfoVO);
		
	}

	@Override
	public RocketInfoVO loginByID(RocketInfoVO rocketInfoVO) {

		RocketInfoVO vo = sqlSession.selectOne("mapper.rocketInfo.loginByID", rocketInfoVO);

		return vo;
	}

	@Override
	public List<String> selectAllStarFieldCD(String rocket_cd) throws DataAccessException {

		List<String> starFieldCDList = sqlSession.selectList("mapper.rocketInfo.selectAllStarFieldCD", rocket_cd);
		
		return starFieldCDList;
	}
	
	@Override
	public String searchID(String email) throws DataAccessException {
		String result = sqlSession.selectOne("mapper.rocketInfo.searchID", email);
		return result;
	}

	@Override
	public int idEmailCheck(RocketInfoVO rocketInfoVO) throws DataAccessException {
		
		int result = sqlSession.selectOne("mapper.rocketInfo.idEmailCheck", rocketInfoVO);
		
		return result;
	}

	@Override
	public void updatePassword(RocketInfoVO rocketInfoVO) throws DataAccessException {
		sqlSession.selectOne("mapper.rocketInfo.updatePwd", rocketInfoVO);
		
	}
	
	@Override
	public int IdCheck(String id) throws DataAccessException {
	
		int result = sqlSession.selectOne("mapper.rocketInfo.IdCheck", id);
		return result;

	}

	@Override
	public int PhoneCheck(String phone_number) throws DataAccessException {
		int result = sqlSession.selectOne("mapper.rocketInfo.PhoneCheck", phone_number);
		return result;
	}

	@Override
	public int EmailCheck(String email) throws DataAccessException {
		int result = sqlSession.selectOne("mapper.rocketInfo.EmailCheck", email);
		return result;
	}
	
	///////
	@Override
	public RocketInfoVO loginByIDSS(String inputId) {

		RocketInfoVO vo = sqlSession.selectOne("mapper.rocketInfo.loginByIDSS", inputId);

		return vo;
	}

	//02.23
	@Override
	public void InsertNaverInfo(RocketInfoVO rocketInfoVO) throws DataAccessException {
		
		sqlSession.insert("mapper.rocketInfo.insertNaverInfo",rocketInfoVO);
	}
	
	@Override
	public int SearchNaverID(String email) throws DataAccessException {
		return sqlSession.selectOne("mapper.rocketInfo.searchNaverID",email);
	}

	@Override
	public String SearchNaverPwd(String email) throws DataAccessException {
		return sqlSession.selectOne("mapper.rocketInfo.searchNaverPwd", email);
	}

	@Override
	public RocketInfoVO loginByNaver(RocketInfoVO rocketInfoVO) throws DataAccessException {
		return sqlSession.selectOne("mapper.rocketInfo.loginByNaver", rocketInfoVO);

	}
}
