package com.ezen.develocket.starField.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.ezen.develocket.starField.vo.CareerImgVO;
import com.ezen.develocket.starField.vo.PreviewVO;
import com.ezen.develocket.starField.vo.StarLineUpVO;

public interface StarFieldService {

	public String joinStarField(Map<String, String> starFieldMap) throws DataAccessException;

	public Map<String, Object> viewStarField(String star_field_cd) throws DataAccessException;

	public Map<String, Object> viewStarFieldModify(String star_field_cd) throws DataAccessException;

	public List<CareerImgVO> selectImageFileList(String star_field_cd) throws DataAccessException;

	public void modifyStarField(Map<String, Object> starFieldMap) throws DataAccessException;

	public void removeModImage(CareerImgVO careerImgVO) throws DataAccessException;

	public List<PreviewVO> selectPopularStar() throws DataAccessException;

	public String selectOwnerRocketCD(String star_field_cd) throws DataAccessException;

    void removeExistImage(String star_field_cd, String item) throws DataAccessException;

	void deleteProfile(int star_field_cd) throws DataAccessException;
	
	public List<PreviewVO> selectRandomStarM(String cate_m) throws DataAccessException;

	public List<PreviewVO> selectRandomStarS(String cate_s) throws DataAccessException;

	public List<PreviewVO> selectRandomStarMA(Map<String, String> cateMap) throws DataAccessException;

	public List<PreviewVO> selectRandomStarSA(Map<String, String> cateMap) throws DataAccessException;

	public List<StarLineUpVO> selectLineUpStarMA(Map<String, String> cateMap) throws DataAccessException;

	public List<StarLineUpVO> selectLineUpStarM(Map<String, String> cateMap) throws DataAccessException;

	public List<StarLineUpVO> selectLineUpStarSA(Map<String, String> cateMap) throws DataAccessException;

	public List<StarLineUpVO> selectLineUpStarS(Map<String, String> cateMap) throws DataAccessException;
}
