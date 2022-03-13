package com.ezen.develocket.request.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.ezen.develocket.request.vo.EstimateVO;
import com.ezen.develocket.request.vo.PopupRequestVO;
import com.ezen.develocket.request.vo.ReceiveEstimateVO;
import com.ezen.develocket.request.vo.ReceiveRequestVO;
import com.ezen.develocket.request.vo.RequestVO;
import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;
import com.ezen.develocket.survey.vo.SurveyInfoVO;

public interface RequestService {

	public void insertNewRequest(RequestVO requestVO) throws DataAccessException;

	public List<ReceiveEstimateVO> selectAllEstimate(String rocket_cd) throws DataAccessException;
	
	public EstimateVO selectOneEstimate(String contract_cd) throws DataAccessException;

	public List<ReceiveRequestVO> selectAllRequest(String star_cd) throws DataAccessException;
	
	public PopupRequestVO selectOnePopupReqeust(String contract_cd) throws DataAccessException;
	
	public RequestVO selectOneRequestVO(String contract_cd) throws DataAccessException;

	public void updateRequest(RequestVO requestVO) throws DataAccessException;

	public void updateContract2(String contract_cd) throws DataAccessException;

	public void updateContract3(String contract_cd) throws DataAccessException;

	public void updateRefuseContract(String contract_cd) throws DataAccessException;

	public void updateContract4(String contract_cd) throws DataAccessException;

	public void updateContract5(String contract_cd) throws DataAccessException;

	public void updateInvisibleContract(Map<String, String> contractMap) throws DataAccessException;

	public void updateHideCheck(Map<String, String> hideCheckMap) throws DataAccessException;

	public void updateViewCheck(String contract_cd) throws DataAccessException;

}
