package com.ezen.develocket.starInfo.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.ezen.develocket.starInfo.vo.StarInfoVO;

public interface StarInfoDAO {

	public void insertStarInfo(Map<String, String> starInfoMap) throws DataAccessException;

	public String selectMaxStarCD() throws DataAccessException;
	
	public String selectCateCD(String small_category) throws DataAccessException;

	public String selectStarCD(String rocket_cd) throws DataAccessException;

	public String selectArea(String star_cd) throws DataAccessException;

    public int selectCheckNickName(String star_nickname) throws DataAccessException;

    public int nicknameCheck(String nickname) throws DataAccessException;

	public void nicknameUpdate(StarInfoVO starInfoVO) throws DataAccessException;

	public void areaModify(StarInfoVO starInfoVO) throws DataAccessException;

	public void deleteStar(String star_cd) throws DataAccessException;

	public List<Integer> findStarFieldCd(String star_cd) throws DataAccessException;

	public void deleteProfile(Map<String, List<Integer>> starFieldCdMap) throws DataAccessException;

	public int checkPwd(Map<String, String> starInfo) throws DataAccessException;

	public String findRocketCd(String star_cd) throws DataAccessException;

	public StarInfoVO viewStarInfo(String star_cd) throws DataAccessException;
}
