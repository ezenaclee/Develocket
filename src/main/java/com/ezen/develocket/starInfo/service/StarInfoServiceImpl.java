package com.ezen.develocket.starInfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.develocket.starInfo.dao.StarInfoDAO;
import com.ezen.develocket.starInfo.vo.StarInfoVO;

@Service("starInfoService")
@Transactional(propagation = Propagation.REQUIRED)
public class StarInfoServiceImpl implements StarInfoService {

	@Autowired
	StarInfoDAO starInfoDAO;
	
	@Override
	public Map<String, String> joinStarInfo(Map<String, String> starInfoMap) throws DataAccessException {

		String small_category = starInfoMap.get("small_category");
		starInfoMap.remove("small_category");
		
		String cate_cd = starInfoDAO.selectCateCD(small_category);
		String star_cd = starInfoDAO.selectMaxStarCD();
		starInfoMap.put("star_cd", star_cd);
		
		starInfoDAO.insertStarInfo(starInfoMap);
		
		Map<String, String> codeMap = new HashMap<>();
		codeMap.put("star_cd", star_cd);
		codeMap.put("cate_cd", cate_cd);
		
		return codeMap;
	}

	@Override
	public String matchStarCD(String rocket_cd) throws DataAccessException {

		String star_cd = starInfoDAO.selectStarCD(rocket_cd);

		return star_cd;
	}

	@Override
	public String selectCateCD(String cate_s) throws DataAccessException {

		String cate_cd = starInfoDAO.selectCateCD(cate_s);

		return cate_cd;
	}

	@Override
	public String selectArea(String star_cd) throws DataAccessException {

		return starInfoDAO.selectArea(star_cd);
	}

	@Override
	public int duplicateCheckNickName(String star_nickname) throws DataAccessException {

		return starInfoDAO.selectCheckNickName(star_nickname);
	}
	
	@Override
	public List<Integer> findStarFieldCd(String star_cd) throws DataAccessException {
		
		return starInfoDAO.findStarFieldCd(star_cd);
	}

	@Override
	public void deleteProfile(Map<String, List<Integer>> starFieldCdMap) throws DataAccessException {
		starInfoDAO.deleteProfile(starFieldCdMap);
		
	}

	@Override
	public int checkPwd(Map<String, String> starInfo) throws DataAccessException {
		return starInfoDAO.checkPwd(starInfo);
	}

	@Override
	public String findRocketCd(String star_cd) throws DataAccessException {
		return starInfoDAO.findRocketCd(star_cd);
	}
	
	@Override
	public int nicknameCheck(String nickname) throws DataAccessException {
		return starInfoDAO.nicknameCheck(nickname);
	}

	@Override
	public void nicknameUpdate(StarInfoVO starInfoVO) throws DataAccessException {
		starInfoDAO.nicknameUpdate(starInfoVO);
	}

	@Override
	public void areaModify(StarInfoVO starInfoVO) throws DataAccessException {
		starInfoDAO.areaModify(starInfoVO);
		
	}

	@Override
	public void deleteStar(String star_cd) throws DataAccessException {
		starInfoDAO.deleteStar(star_cd);
		
	}
	
	@Override
	public StarInfoVO viewStarInfo(String star_cd) throws DataAccessException {
		
		StarInfoVO starInfo = starInfoDAO.viewStarInfo(star_cd);
		
		return starInfo;
	}
	
	

}
