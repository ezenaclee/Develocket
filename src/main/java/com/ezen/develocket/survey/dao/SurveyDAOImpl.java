package com.ezen.develocket.survey.dao;

import java.util.List;

import com.ezen.develocket.starInfo.vo.CategoryVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.ezen.develocket.survey.vo.ContractVO;
import com.ezen.develocket.survey.vo.SurveyInfoVO;
import com.ezen.develocket.survey.vo.ViewCheckVO;

@Repository("surveyDAO")
public class SurveyDAOImpl implements SurveyDAO {
	
	@Autowired
	private SqlSession sqlSession;

	
	@Override
	public CategoryVO selectCategoryVO(String star_field_cd) throws DataAccessException {

		CategoryVO categoryVO = sqlSession.selectOne("mapper.surveyInfo.selectCategoryVO", star_field_cd);
		
		return categoryVO;
	}

	@Override
	public int selectActiveStar() throws DataAccessException {

		int active_star_num = sqlSession.selectOne("mapper.surveyInfo.selectActiveStar");

		return active_star_num;
	}

	@Override
	public int selectTotalSurvey() throws DataAccessException {

		int total_survey = sqlSession.selectOne("mapper.surveyInfo.selectTotalSurvey");

		return total_survey;
	}


	@Override
	public String insertNewContract(ContractVO contractVO) throws DataAccessException {

		String contract_cd = selectMaxContractCD();
		contractVO.setContract_cd(contract_cd);
		
		sqlSession.insert("mapper.surveyInfo.insertNewContract", contractVO);
		
		return contract_cd;
	}
	
	public String selectMaxContractCD() throws DataAccessException {

		String contract_cd = sqlSession.selectOne("mapper.surveyInfo.selectMaxContractCD");
		
		return contract_cd;
	}
	


	@Override
	public String insertNewSurveyInfo(SurveyInfoVO surveyInfoVO) throws DataAccessException {

		String survey_cd = selectMaxSurveyCD();
		surveyInfoVO.setSurvey_cd(survey_cd);
		
		sqlSession.insert("mapper.surveyInfo.insertNewSurveyInfo", surveyInfoVO);
		
		return survey_cd;
	}
	
	public String selectMaxSurveyCD() throws DataAccessException {

		String survey_cd = sqlSession.selectOne("mapper.surveyInfo.selectMaxSurveyCD");
		
		return survey_cd;
	}


	@Override
	public List<ViewCheckVO> selectViewCheckInRocket(String rocket_cd) throws DataAccessException {

		List<ViewCheckVO> inRocketList = sqlSession.selectList("mapper.surveyInfo.selectViewCheckInRocket", rocket_cd);

		return inRocketList;
	}


	@Override
	public List<ViewCheckVO> selectViewCheckInStar(String star_cd) throws DataAccessException {

		List<ViewCheckVO> inStarList = sqlSession.selectList("mapper.surveyInfo.selectViewCheckInStar", star_cd);
		
		return inStarList;
	}

}
