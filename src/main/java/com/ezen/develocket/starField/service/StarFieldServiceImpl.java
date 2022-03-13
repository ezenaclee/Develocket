package com.ezen.develocket.starField.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ezen.develocket.review.vo.ReviewVO;
import com.ezen.develocket.starInfo.vo.CategoryVO;
import com.ezen.develocket.starInfo.vo.StarInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.develocket.inquiry.vo.InquiryImgVO;
import com.ezen.develocket.starField.dao.StarFieldDAO;
import com.ezen.develocket.starField.vo.CareerImgVO;
import com.ezen.develocket.starField.vo.PreviewVO;
import com.ezen.develocket.starField.vo.StarFieldVO;
import com.ezen.develocket.starField.vo.StarLineUpVO;

@Service("starFieldService")
@Transactional(propagation = Propagation.REQUIRED)
public class StarFieldServiceImpl implements StarFieldService {

	@Autowired
	private StarFieldDAO starFieldDAO;

	@Override
	public String joinStarField(Map<String, String> starFieldMap) throws DataAccessException {

		String star_field_cd = starFieldDAO.insertStarField(starFieldMap);

		return star_field_cd;
	}

	@Override
	public Map<String, Object> viewStarField(String star_field_cd) {

		StarFieldVO starFieldVO = starFieldDAO.selectStarField(star_field_cd);
		List<CareerImgVO> imageFileList = starFieldDAO.selectImageFileList(star_field_cd);
		StarInfoVO starInfoVO = starFieldDAO.selectStarInfo(star_field_cd);
		CategoryVO categoryVO = starFieldDAO.selectCategory(star_field_cd);
		List<ReviewVO> reviewVOList = starFieldDAO.selectReview(star_field_cd);

		Map<String, Object> starFieldMap = new HashMap<>();
		starFieldMap.put("starFieldVO", starFieldVO);
		starFieldMap.put("imageFileList", imageFileList);
		starFieldMap.put("starInfoVO", starInfoVO);
		starFieldMap.put("categoryVO", categoryVO);
		starFieldMap.put("reviewVOList", reviewVOList);

		return starFieldMap;
	}

	@Override
	public Map<String, Object> viewStarFieldModify(String star_field_cd) throws DataAccessException {

		StarFieldVO starFieldVO = starFieldDAO.selectStarField(star_field_cd);
		List<CareerImgVO> imageFileList = starFieldDAO.selectImageFileList(star_field_cd);

		Map<String, Object> starFieldMap = new HashMap<>();
		starFieldMap.put("starFieldVO", starFieldVO);
		starFieldMap.put("imageFileList", imageFileList);

		return starFieldMap;
	}

	@Override
	public List<CareerImgVO> selectImageFileList(String star_field_cd) throws DataAccessException {
		
		return starFieldDAO.selectImageFileList(star_field_cd);
	}

	@Override
	public void modifyStarField(Map<String, Object> starFieldMap) throws DataAccessException {

		starFieldDAO.updateStarField(starFieldMap);

		List<CareerImgVO> imageFileList = (List<CareerImgVO>) starFieldMap.get("imageFileList");
		List<CareerImgVO> modAddImageFileList = (List<CareerImgVO>) starFieldMap.get("modAddImageFileList");

		if (imageFileList != null && imageFileList.size() != 0) {
			int added_img_num = Integer.parseInt((String) starFieldMap.get("added_img_num"));
			int pre_img_num = Integer.parseInt((String) starFieldMap.get("pre_img_num"));

			if (pre_img_num < added_img_num) { // 기존 이미지도 수정하고 새 이미지도 추가한 경우
				starFieldDAO.updateImageFile(starFieldMap); // 기존 이미지 수정
				starFieldDAO.insertModNewImage(starFieldMap); // 새 이미지 추가
			} else { // 기존의 이미지만 수정한 경우
				starFieldDAO.updateImageFile(starFieldMap);
			}
		}
		// 새 이미지만 추가한 경우 (기존이미지 수정 안함)
		else if (modAddImageFileList != null && modAddImageFileList.size() != 0) {
			starFieldDAO.insertModNewImage(starFieldMap); // 새 이미지 추가
		}
	}

	@Override
	public void removeModImage(CareerImgVO careerImgVO) throws DataAccessException {

		starFieldDAO.deleteModImage(careerImgVO);
	}

	@Override
	public List<PreviewVO> selectPopularStar() throws DataAccessException {
		
		List<PreviewVO> star_field_cd = starFieldDAO.selectPopularStar();
		List<PreviewVO> previewVO = null;
		
		if(!(star_field_cd.isEmpty())) {
			previewVO = starFieldDAO.selectPopularStarInfo(star_field_cd);
			
		}
		
		return previewVO;
	}
	

	@Override
	public String selectOwnerRocketCD(String star_field_cd) throws DataAccessException {

		return starFieldDAO.selectOwnerRocketCD(star_field_cd);
	}

	@Override
	public void removeExistImage(String star_field_cd, String item) throws DataAccessException {

		starFieldDAO.removeExistImage(star_field_cd, item);
	}
	
	@Override
	public void deleteProfile(int star_field_cd) throws DataAccessException {
		starFieldDAO.deleteProfile(star_field_cd);
		
	}
	
	@Override
	public List<PreviewVO> selectRandomStarM(String cate_m) throws DataAccessException {
		return starFieldDAO.selectRandomStarM(cate_m);
	}

	@Override
	public List<PreviewVO> selectRandomStarS(String cate_s) throws DataAccessException {
		return starFieldDAO.selectRandomStarS(cate_s);
	}

	@Override
	public List<PreviewVO> selectRandomStarMA(Map<String, String> cateMap) throws DataAccessException {
		return starFieldDAO.selectRandomStarMA(cateMap);
	}

	@Override
	public List<PreviewVO> selectRandomStarSA(Map<String, String> cateMap) throws DataAccessException {
		return starFieldDAO.selectRandomStarSA(cateMap);
	}

	@Override
	public List<StarLineUpVO> selectLineUpStarMA(Map<String, String> cateMap) throws DataAccessException {
		return starFieldDAO.selectLineUpStarMA(cateMap);
	}

	@Override
	public List<StarLineUpVO> selectLineUpStarM(Map<String, String> cateMap) throws DataAccessException {
		return starFieldDAO.selectLineUpStarM(cateMap);
	}

	@Override
	public List<StarLineUpVO> selectLineUpStarSA(Map<String, String> cateMap) throws DataAccessException {
		return starFieldDAO.selectLineUpStarSA(cateMap);
	}

	@Override
	public List<StarLineUpVO> selectLineUpStarS(Map<String, String> cateMap) throws DataAccessException {
		return starFieldDAO.selectLineUpStarS(cateMap);
	}

}








