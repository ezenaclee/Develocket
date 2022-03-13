package com.ezen.develocket.survey.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ezen.develocket.starInfo.vo.CategoryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.w3c.dom.CDATASection;

import com.ezen.develocket.starInfo.service.StarInfoService;
import com.ezen.develocket.survey.dao.SurveyDAO;
import com.ezen.develocket.survey.vo.ContractVO;
import com.ezen.develocket.survey.vo.SurveyInfoVO;
import com.ezen.develocket.survey.vo.ViewCheckVO;

@Service("surveyService")
@Transactional(propagation = Propagation.REQUIRED)
public class SurveyServiceImpl implements SurveyService {
	
	@Autowired
	private SurveyDAO surveyDAO;
	@Autowired
	private StarInfoService starInfoService;

	
	@Override
	public CategoryVO selectCategoryVO(String star_field_cd) throws DataAccessException {

		return surveyDAO.selectCategoryVO(star_field_cd);
	}

	@Override
	public int countActiveStar() throws DataAccessException {

		return surveyDAO.selectActiveStar();
	}

	@Override
	public int countTotalSurvey() throws DataAccessException {

		return surveyDAO.selectTotalSurvey();
	}


	@Override
	public String insertNewContract(ContractVO contractVO) throws DataAccessException {
		
		return surveyDAO.insertNewContract(contractVO);
	}


	@Override
	public String insertNewSurveyInfo(SurveyInfoVO surveyInfoVO) throws DataAccessException {
		
		return surveyDAO.insertNewSurveyInfo(surveyInfoVO);
	}


	@Override
	public Map<String, String> selectAllViewCheck(String rocket_cd) throws DataAccessException {

		Map<String, String> viewCheckMap = new HashMap<>();
		String viewCheck0Rocket = null;
		String viewCheck0Star = null;
		String viewCheck1 = null;
		String viewCheck2 = null;
		String viewCheck3Rocket = null;
		String viewCheck3Star = null;

		String star_cd = starInfoService.matchStarCD(rocket_cd);
		List<ViewCheckVO> inRocketList = surveyDAO.selectViewCheckInRocket(rocket_cd);
		List<ViewCheckVO> inStarList = surveyDAO.selectViewCheckInStar(star_cd);

		if (!inRocketList.isEmpty()) {
			for (ViewCheckVO vo : inRocketList) {
				if (vo.getStatus_info().equals("0") && viewCheck0Rocket == null) {
					viewCheck0Rocket = vo.getView_check();
				}
				else if (vo.getStatus_info().equals("2") && viewCheck2 == null) {
					viewCheck2 = vo.getView_check();
				}
				else if (vo.getStatus_info().equals("3") && viewCheck3Rocket == null) {
					viewCheck3Rocket = vo.getView_check();
				}
			}
		}

		if (!inStarList.isEmpty()) {
			for (ViewCheckVO vo : inStarList) {
				if (vo.getStatus_info().equals("0") && viewCheck0Star == null) {
					viewCheck0Star = vo.getView_check();
				}
				else if (vo.getStatus_info().equals("1") && viewCheck1 == null) {
					viewCheck1 = vo.getView_check();
				}
				else if (vo.getStatus_info().equals("3") && viewCheck3Star == null) {
					viewCheck3Star = vo.getView_check();
				}
			}
		}

		viewCheckMap.put("viewCheck0Rocket", viewCheck0Rocket);
		viewCheckMap.put("viewCheck0Star", viewCheck0Star);
		viewCheckMap.put("viewCheck1", viewCheck1);
		viewCheckMap.put("viewCheck2", viewCheck2);
		viewCheckMap.put("viewCheck3Rocket", viewCheck3Rocket);
		viewCheckMap.put("viewCheck3Star", viewCheck3Star);

		return viewCheckMap;
	}

}
