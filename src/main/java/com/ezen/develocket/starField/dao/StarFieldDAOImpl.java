package com.ezen.develocket.starField.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.ezen.develocket.review.vo.ReviewVO;
import com.ezen.develocket.starInfo.vo.CategoryVO;
import com.ezen.develocket.starInfo.vo.StarInfoVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.ezen.develocket.starField.vo.CareerImgVO;
import com.ezen.develocket.starField.vo.PreviewVO;
import com.ezen.develocket.starField.vo.StarFieldVO;
import com.ezen.develocket.starField.vo.StarLineUpVO;

@Repository("StarFieldDAO")
public class StarFieldDAOImpl implements StarFieldDAO {

	@Autowired
	private SqlSession sqlSession;

	
	@Override
	public String insertStarField(Map<String, String> starFieldMap) throws DataAccessException {
		
		String star_field_cd = selectMaxStarFieldCD();
		starFieldMap.put("star_field_cd", star_field_cd);
		
		sqlSession.insert("mapper.starField.insertStarField", starFieldMap);
		
		return star_field_cd;
	}
	
	public String selectMaxStarFieldCD() throws DataAccessException {
		
		String star_field_cd = sqlSession.selectOne("mapper.starField.selectMaxStarFieldCD");
		
		return star_field_cd;
	}

	@Override
	public StarFieldVO selectStarField(String star_field_cd) {

		StarFieldVO starFieldVO = sqlSession.selectOne("mapper.starField.selectStarField", star_field_cd);
		
		return starFieldVO;
	}

	@Override
	public List<CareerImgVO> selectImageFileList(String star_field_cd) {

		List<CareerImgVO> imageFileList = sqlSession.selectList("mapper.starField.selectImageFileList", star_field_cd); 
		
		return imageFileList;
	}

	@Override
	public StarInfoVO selectStarInfo(String star_field_cd) throws DataAccessException {

		StarInfoVO starInfoVO = sqlSession.selectOne("mapper.starField.selectStarInfo", star_field_cd);

		return starInfoVO;
	}

	@Override
	public CategoryVO selectCategory(String star_field_cd) throws DataAccessException {

		CategoryVO categoryVO = sqlSession.selectOne("mapper.starField.selectCategory", star_field_cd);

		return categoryVO;
	}

	@Override
	public List<ReviewVO> selectReview(String star_field_cd) throws DataAccessException {

		List<ReviewVO> reviewVOList = sqlSession.selectList("mapper.starField.selectReview", star_field_cd);

		return reviewVOList;
	}

	@Override
	public void updateStarField(Map<String, Object> starFieldMap) throws DataAccessException {

		sqlSession.update("mapper.starField.updateStarField", starFieldMap);
		
	}

	@Override
	public void updateImageFile(Map<String, Object> starFieldMap) throws DataAccessException {

		List<CareerImgVO> imageFileList = (List<CareerImgVO>) starFieldMap.get("imageFileList");
		String star_field_cd = (String) starFieldMap.get("star_field_cd");
		
		for (int i = imageFileList.size() - 1; i >= 0; i--) {	// 수정을 하지 않은 이미지의 이름은 null
			CareerImgVO careerImgVO = imageFileList.get(i);
			String imageFileName = careerImgVO.getImageFileName();
			
			if (imageFileName == null) {	// 기존의 이미지를 수정하지 않는 경우 파일명이 null이므로 수정필요없음
				imageFileList.remove(i);
			}
			else {
				careerImgVO.setStar_field_cd(star_field_cd);
			}
		}
		
		if (imageFileList != null && imageFileList.size() != 0) {
			// 수정한 이미지만 갱신을 요청함
			sqlSession.update("mapper.starField.updateImageFile", imageFileList);
		}
	}

	@Override
	public void insertModNewImage(Map<String, Object> starFieldMap) throws DataAccessException {

		List<CareerImgVO> modAddImageFileList = (ArrayList) starFieldMap.get("modAddImageFileList");
		String star_field_cd = (String) starFieldMap.get("star_field_cd");
		
		int career_img_cd  = Integer.parseInt(selectNewCareerImgCD());
		
		if (modAddImageFileList != null && modAddImageFileList.size() != 0) {
			for (CareerImgVO careerImgVO : modAddImageFileList) {
				careerImgVO.setCareer_img_cd(++career_img_cd + "");
				careerImgVO.setStar_field_cd(star_field_cd);
			}
			
			sqlSession.insert("mapper.starField.insertModNewImage", modAddImageFileList);
		}
		
	}

	private String selectNewCareerImgCD() {

		return sqlSession.selectOne("mapper.starField.selectNewCareerImgCD");
	}

	@Override
	public void deleteModImage(CareerImgVO careerImgVO) throws DataAccessException {

		sqlSession.delete("mapper.starField.deleteModImage", careerImgVO);
	}

	@Override
	public List<PreviewVO> selectPopularStar() throws DataAccessException {

		List<PreviewVO> previewVO = sqlSession.selectList("mapper.starField.selectPopularStar");
		
		return previewVO;
	}

	@Override
	public List<PreviewVO> selectPopularStarInfo(List<PreviewVO> list) throws DataAccessException {
		
		List<PreviewVO> previewVO = sqlSession.selectList("mapper.starField.selectPopularStarInfo", list);
		
		return previewVO;
	}
	

	@Override
	public String selectOwnerRocketCD(String star_field_cd) throws DataAccessException {

		String rocket_cd = sqlSession.selectOne("mapper.starField.selectOwnerRocketCD", star_field_cd);
		
		return rocket_cd;
	}

	@Override
	public void removeExistImage(String star_field_cd, String item) throws DataAccessException {

		if (item.equals("profile")) {
			sqlSession.update("mapper.starField.updateProfileImage", star_field_cd);
		}
		else if (item.equals("business")) {
			sqlSession.update("mapper.starField.updateBusinessImage", star_field_cd);
		}
	}
	
	@Override
	public void deleteProfile(int star_field_cd) throws DataAccessException {
		sqlSession.update("mapper.starField.deleteProfile", star_field_cd);
		sqlSession.update("mapper.starField.deleteContract", star_field_cd);
		sqlSession.update("mapper.starField.deleteCareer", star_field_cd);
	}

	
	@Override
	public List<PreviewVO> selectRandomStarM(String cate_m) throws DataAccessException {
		
		return sqlSession.selectList("mapper.starField.selectRandomStarM", cate_m);
	}

	@Override
	public List<PreviewVO> selectRandomStarS(String cate_s) throws DataAccessException {
		return sqlSession.selectList("mapper.starField.selectRandomStarS", cate_s);
	}

	@Override
	public List<PreviewVO> selectRandomStarMA(Map<String, String> cateMap) throws DataAccessException {
		return sqlSession.selectList("mapper.starField.selectRandomStarMA", cateMap);
	}

	@Override
	public List<PreviewVO> selectRandomStarSA(Map<String, String> cateMap) throws DataAccessException {
		return sqlSession.selectList("mapper.starField.selectRandomStarSA", cateMap);
	}


	@Override
	public List<StarLineUpVO> selectLineUpStarMA(Map<String, String> cateMap) throws DataAccessException {
		
		List<StarLineUpVO> selectLineupStar = new ArrayList<>();
		List<StarLineUpVO> starList = new ArrayList<>();
		
		if(cateMap.get("lineup").equals("review")) {
			starList = sqlSession.selectList("mapper.starField.selectLineUpStarReviewMA", cateMap);
			
				if(starList.isEmpty()) {
					return null;
				} else {
					for (StarLineUpVO starLineUpVO : starList) {
						String star_field_cd = starLineUpVO.getStar_field_cd();
						StarLineUpVO starReview = sqlSession.selectOne("mapper.starField.selectLineUpStarInfoLee", star_field_cd);
						selectLineupStar.add(starReview);
					}
				}
				
		} else if(cateMap.get("lineup").equals("rating")) {
			starList = sqlSession.selectList("mapper.starField.selectLineUpStarRatingMA", cateMap);
			
				if(starList.isEmpty()) {
					return null;
				} else {
					for (StarLineUpVO starLineUpVO : starList) {
						String star_field_cd = starLineUpVO.getStar_field_cd();
						StarLineUpVO starReview = sqlSession.selectOne("mapper.starField.selectLineUpStarInfoLee", star_field_cd);
						selectLineupStar.add(starReview);
					}
				}
				
		} else if(cateMap.get("lineup").equals("request")) {
			starList = sqlSession.selectList("mapper.starField.selectLineUpStarRequestMA", cateMap);
			
				if(starList.isEmpty()) {
					return null;
				} else {
					for (StarLineUpVO starLineUpVO : starList) {
						String star_field_cd = starLineUpVO.getStar_field_cd();
						StarLineUpVO starReview = sqlSession.selectOne("mapper.starField.selectLineUpStarInfoLee", star_field_cd);
						selectLineupStar.add(starReview);
					}
				}
				
		}
		
		return selectLineupStar;
	}

	@Override
	public List<StarLineUpVO> selectLineUpStarM(Map<String, String> cateMap) throws DataAccessException {

		List<StarLineUpVO> selectLineupStar = new ArrayList<>();
		List<StarLineUpVO> starList = new ArrayList<>();
		
		if(cateMap.get("lineup").equals("review")) {
			starList = sqlSession.selectList("mapper.starField.selectLineUpStarReviewM", cateMap);
			
				if(starList.isEmpty()) {
					return null;
				}
				else {
					for (StarLineUpVO starLineUpVO : starList) {
						String star_field_cd = starLineUpVO.getStar_field_cd();
						StarLineUpVO starReview = sqlSession.selectOne("mapper.starField.selectLineUpStarInfoLee", star_field_cd);
						selectLineupStar.add(starReview);
					}
				}
				
		} else if(cateMap.get("lineup").equals("rating")) {
			starList = sqlSession.selectList("mapper.starField.selectLineUpStarRatingM", cateMap);
			
				if(starList.isEmpty()) {
					return null;
				} else {
					for (StarLineUpVO starLineUpVO : starList) {
						String star_field_cd = starLineUpVO.getStar_field_cd();
						StarLineUpVO starRating = sqlSession.selectOne("mapper.starField.selectLineUpStarInfoLee", star_field_cd);
						selectLineupStar.add(starRating);
					}
				}
				
		} else if(cateMap.get("lineup").equals("request")) {
			starList = sqlSession.selectList("mapper.starField.selectLineUpStarRequestM", cateMap);
			
				if(starList.isEmpty()) {
					return null;
				} else {
					for (StarLineUpVO starLineUpVO : starList) {
						String star_field_cd = starLineUpVO.getStar_field_cd();
						StarLineUpVO starRating = sqlSession.selectOne("mapper.starField.selectLineUpStarInfoLee", star_field_cd);
						selectLineupStar.add(starRating);
					}
				}
				
		}
		
		return selectLineupStar;
	}

	@Override
	public List<StarLineUpVO> selectLineUpStarSA(Map<String, String> cateMap) throws DataAccessException {

		List<StarLineUpVO> selectLineupStar = new ArrayList<>();
		List<StarLineUpVO> starList = new ArrayList<>();
		
		if(cateMap.get("lineup").equals("review")) {
			starList = sqlSession.selectList("mapper.starField.selectLineUpStarReviewSA", cateMap);
			
				if(starList.isEmpty()) {
					return null;
				} else {
					for (StarLineUpVO starLineUpVO : starList) {
						String star_field_cd = starLineUpVO.getStar_field_cd();
						StarLineUpVO starRating = sqlSession.selectOne("mapper.starField.selectLineUpStarInfoLee", star_field_cd);
						selectLineupStar.add(starRating);
					}
				}
				
		} else if(cateMap.get("lineup").equals("rating")) {
			starList = sqlSession.selectList("mapper.starField.selectLineUpStarRatingSA", cateMap);
			
				if(starList.isEmpty()) {
					return null;
				} else {
					for (StarLineUpVO starLineUpVO : starList) {
						String star_field_cd = starLineUpVO.getStar_field_cd();
						StarLineUpVO starRating = sqlSession.selectOne("mapper.starField.selectLineUpStarInfoLee", star_field_cd);
						selectLineupStar.add(starRating);
					}
				}
				
		} else if(cateMap.get("lineup").equals("request")) {
			starList = sqlSession.selectList("mapper.starField.selectLineUpStarRequestSA", cateMap);
			
				if(starList.isEmpty()) {
					return null;
				} else {
					for (StarLineUpVO starLineUpVO : starList) {
						String star_field_cd = starLineUpVO.getStar_field_cd();
						StarLineUpVO starRating = sqlSession.selectOne("mapper.starField.selectLineUpStarInfoLee", star_field_cd);
						selectLineupStar.add(starRating);
					}
				}
		}
		
		return selectLineupStar;
	}

	@Override
	public List<StarLineUpVO> selectLineUpStarS(Map<String, String> cateMap) throws DataAccessException {

		List<StarLineUpVO> selectLineupStar = new ArrayList<>();
		List<StarLineUpVO> starList = new ArrayList<>();
		
		if(cateMap.get("lineup").equals("review")) {
			starList = sqlSession.selectList("mapper.starField.selectLineUpStarReviewS", cateMap);
			
				if(starList.isEmpty()) {
					return null;
				} else {
					for (StarLineUpVO starLineUpVO : starList) {
						String star_field_cd = starLineUpVO.getStar_field_cd();
						StarLineUpVO starRating = sqlSession.selectOne("mapper.starField.selectLineUpStarInfoLee", star_field_cd);
						selectLineupStar.add(starRating);
					}
				}
				
		} else if(cateMap.get("lineup").equals("rating")) {
			starList = sqlSession.selectList("mapper.starField.selectLineUpStarRatingS", cateMap);
			
				if(starList.isEmpty()) {
					return null;
				} else {
					for (StarLineUpVO starLineUpVO : starList) {
						String star_field_cd = starLineUpVO.getStar_field_cd();
						StarLineUpVO starRating = sqlSession.selectOne("mapper.starField.selectLineUpStarInfoLee", star_field_cd);
						selectLineupStar.add(starRating);
					}
				}
				
		} else if(cateMap.get("lineup").equals("request")) {
			starList = sqlSession.selectList("mapper.starField.selectLineUpStarRequestS", cateMap);
			
				if(starList.isEmpty()) {
					return null;
				} else {
					for (StarLineUpVO starLineUpVO : starList) {
						String star_field_cd = starLineUpVO.getStar_field_cd();
						StarLineUpVO starRating = sqlSession.selectOne("mapper.starField.selectLineUpStarInfoLee", star_field_cd);
						selectLineupStar.add(starRating);
					}
				}
				
		}
		
		return selectLineupStar;
	}
}
