package com.ezen.develocket.starField.dao;

import java.util.List;
import java.util.Map;

import com.ezen.develocket.review.vo.ReviewVO;
import com.ezen.develocket.starInfo.vo.CategoryVO;
import com.ezen.develocket.starInfo.vo.StarInfoVO;
import org.springframework.dao.DataAccessException;

import com.ezen.develocket.starField.vo.CareerImgVO;
import com.ezen.develocket.starField.vo.PreviewVO;
import com.ezen.develocket.starField.vo.StarFieldVO;
import com.ezen.develocket.starField.vo.StarLineUpVO;

public interface StarFieldDAO {

	public String insertStarField(Map<String, String> starFieldMap) throws DataAccessException;

	public StarFieldVO selectStarField(String star_field_cd) throws DataAccessException;

	public List<CareerImgVO> selectImageFileList(String star_field_cd) throws DataAccessException;

	public StarInfoVO selectStarInfo(String star_field_cd) throws DataAccessException;

	public CategoryVO selectCategory(String star_field_cd) throws DataAccessException;

	public List<ReviewVO> selectReview(String star_field_cd) throws DataAccessException;

	public void updateStarField(Map<String, Object> starFieldMap) throws DataAccessException;

	public void updateImageFile(Map<String, Object> starFieldMap) throws DataAccessException;

	public void insertModNewImage(Map<String, Object> starFieldMap) throws DataAccessException;

	public void deleteModImage(CareerImgVO careerImgVO) throws DataAccessException;

	public List<PreviewVO> selectPopularStar() throws DataAccessException;
	
	public List<PreviewVO> selectPopularStarInfo(List<PreviewVO> list);

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
