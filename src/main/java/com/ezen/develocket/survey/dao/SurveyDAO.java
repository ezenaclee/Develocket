package com.ezen.develocket.survey.dao;

import java.util.List;

import com.ezen.develocket.starInfo.vo.CategoryVO;
import org.springframework.dao.DataAccessException;

import com.ezen.develocket.survey.vo.ContractVO;
import com.ezen.develocket.survey.vo.SurveyInfoVO;
import com.ezen.develocket.survey.vo.ViewCheckVO;

public interface SurveyDAO {

	public CategoryVO selectCategoryVO(String star_field_cd) throws DataAccessException;

	public int selectActiveStar() throws DataAccessException;

	public int selectTotalSurvey() throws DataAccessException;

	public String insertNewContract(ContractVO contractVO) throws DataAccessException;

	public String insertNewSurveyInfo(SurveyInfoVO surveyInfoVO) throws DataAccessException;

	public List<ViewCheckVO> selectViewCheckInRocket(String rocket_cd) throws DataAccessException;

	public List<ViewCheckVO> selectViewCheckInStar(String star_cd) throws DataAccessException;

}
