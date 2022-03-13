package com.ezen.develocket.starInfo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.ezen.develocket.starInfo.vo.StarInfoVO;

@Repository("starInfoDAO")
public class StarInfoDAOImpl implements StarInfoDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertStarInfo(Map<String, String> starInfoMap) throws DataAccessException {

		sqlSession.insert("mapper.starInfo.insertStarInfo", starInfoMap);
	}

	@Override
	public String selectMaxStarCD() throws DataAccessException {

		String star_cd = sqlSession.selectOne("mapper.starInfo.selectMaxStarCD");

		return star_cd;
	}

	@Override
	public String selectCateCD(String cate_s) throws DataAccessException {

		String cate_cd = sqlSession.selectOne("mapper.starInfo.selectCateCD", cate_s);
		
		System.out.println("11cate_s: " + cate_s);
		System.out.println("cate_cd: " + cate_cd);
		
		return cate_cd;
	}

	@Override
	public String selectStarCD(String rocket_cd) throws DataAccessException {

		String star_cd = sqlSession.selectOne("mapper.starInfo.selectStarCD", rocket_cd);
		
		return star_cd;
	}

	@Override
	public String selectArea(String star_cd) throws DataAccessException {

		String area = sqlSession.selectOne("mapper.starInfo.selectArea", star_cd);

		return area;
	}

	@Override
	public int selectCheckNickName(String star_nickname) throws DataAccessException {

		int count = sqlSession.selectOne("mapper.starInfo.selectCheckNickName", star_nickname);

		return count;
	}

	
	@Override
	public int nicknameCheck(String nickname) throws DataAccessException {
		
		int result = sqlSession.selectOne("mapper.starInfo.nicknameCheck", nickname);
		
		return result;
	}

	@Override
	public void nicknameUpdate(StarInfoVO starInfoVO) throws DataAccessException {
		sqlSession.update("mapper.starInfo.nicknameUpdate", starInfoVO);
	}

	@Override
	public void areaModify(StarInfoVO starInfoVO) throws DataAccessException {
		sqlSession.update("mapper.starInfo.areaModify", starInfoVO);
		
	}

	@Override
	public void deleteStar(String star_cd) throws DataAccessException {
		sqlSession.update("mapper.starInfo.deleteStarInfo", star_cd);
		
	}

	@Override
	public List<Integer> findStarFieldCd(String star_cd) throws DataAccessException {
		
		return sqlSession.selectList("mapper.starInfo.findStarFieldCd", star_cd);
	}

	@Override
	public void deleteProfile(Map<String, List<Integer>> starFieldCdMap) throws DataAccessException {
		sqlSession.update("mapper.starInfo.deleteProfile", starFieldCdMap);
		sqlSession.update("mapper.starInfo.deleteContract", starFieldCdMap);
		sqlSession.update("mapper.starInfo.deleteCareer", starFieldCdMap);
		
	}

	@Override
	public int checkPwd(Map<String, String> starInfo) throws DataAccessException {
		return sqlSession.selectOne("mapper.starInfo.checkPwd", starInfo);
		
		
	}

	@Override
	public String findRocketCd(String star_cd) throws DataAccessException {
		return sqlSession.selectOne("mapper.starInfo.findRocketCd", star_cd);
	}

	@Override
	public StarInfoVO viewStarInfo(String star_cd) throws DataAccessException {
		
		return sqlSession.selectOne("mapper.starInfo.selectStarInfo", star_cd);
	}
}
