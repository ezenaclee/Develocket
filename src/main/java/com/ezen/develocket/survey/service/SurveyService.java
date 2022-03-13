package com.ezen.develocket.survey.service;

import java.util.List;
import java.util.Map;

import com.ezen.develocket.starInfo.vo.CategoryVO;
import org.springframework.dao.DataAccessException;

import com.ezen.develocket.survey.vo.ContractVO;
import com.ezen.develocket.survey.vo.SurveyInfoVO;
import com.ezen.develocket.survey.vo.ViewCheckVO;

public interface SurveyService {

	public CategoryVO selectCategoryVO(String star_field_cd) throws DataAccessException;

	public int countActiveStar() throws DataAccessException;

	public int countTotalSurvey() throws DataAccessException;

	public String insertNewContract(ContractVO contractVO) throws DataAccessException;

	public String insertNewSurveyInfo(SurveyInfoVO surveyInfoVO) throws DataAccessException;

	public Map<String, String> selectAllViewCheck(String rocket_cd) throws DataAccessException;

}
