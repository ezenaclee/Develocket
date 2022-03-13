package com.ezen.develocket.request.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.develocket.request.dao.RequestDAO;
import com.ezen.develocket.request.vo.EstimateVO;
import com.ezen.develocket.request.vo.PopupRequestVO;
import com.ezen.develocket.request.vo.ReceiveEstimateVO;
import com.ezen.develocket.request.vo.ReceiveRequestVO;
import com.ezen.develocket.request.vo.RequestVO;
import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;
import com.ezen.develocket.survey.vo.SurveyInfoVO;

@Service("requestService")
@Transactional(propagation = Propagation.REQUIRED)
public class RequestServiceImpl implements RequestService {

	@Autowired
	private RequestDAO requestDAO;
	
	
	@Override
	public void insertNewRequest(RequestVO requestVO) throws DataAccessException {

		requestDAO.insertNewRequest(requestVO);
	}


	@Override
	public List<ReceiveEstimateVO> selectAllEstimate(String rocket_cd) throws DataAccessException {
		
		return requestDAO.selectAllEstimate(rocket_cd);
	}
	
	@Override
	public EstimateVO selectOneEstimate(String contract_cd) throws DataAccessException {

		return requestDAO.selectOneEstimate(contract_cd);
	}


	@Override
	public List<ReceiveRequestVO> selectAllRequest(String star_cd) throws DataAccessException {

		return requestDAO.selectAllRequest(star_cd);
	}
	
	@Override
	public PopupRequestVO selectOnePopupReqeust(String contract_cd) throws DataAccessException {

		return requestDAO.selectOnePopupReqeust(contract_cd);
	}
	
	@Override
	public RequestVO selectOneRequestVO(String contract_cd) throws DataAccessException {

		return requestDAO.selectOneRequestVO(contract_cd);
	}


	@Override
	public void updateRequest(RequestVO requestVO) throws DataAccessException {

		requestDAO.updateRequest(requestVO);
	}


	@Override
	public void updateContract2(String contract_cd) throws DataAccessException {

		requestDAO.updateContract2(contract_cd);
	}


	@Override
	public void updateContract3(String contract_cd) throws DataAccessException {

		requestDAO.updateContract3(contract_cd);
	}


	@Override
	public void updateRefuseContract(String contract_cd) throws DataAccessException {

		requestDAO.updateRefuseContract(contract_cd);
	}


	@Override
	public void updateContract4(String contract_cd) throws DataAccessException {

		requestDAO.updateContract4(contract_cd);
	}


	@Override
	public void updateContract5(String contract_cd) throws DataAccessException {

		requestDAO.updateContract5(contract_cd);
	}


	@Override
	public void updateInvisibleContract(Map<String, String> contractMap) throws DataAccessException {

		requestDAO.updateInvisibleContract(contractMap);
	}

	@Override
	public void updateHideCheck(Map<String, String> hideCheckMap) throws DataAccessException {

		requestDAO.updateHideCheck(hideCheckMap);
	}

	@Override
	public void updateViewCheck(String contract_cd) throws DataAccessException {

		requestDAO.updateViewCheck(contract_cd);
	}

}












