package com.ezen.develocket.request.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.ezen.develocket.request.vo.EstimateVO;
import com.ezen.develocket.request.vo.PopupRequestVO;
import com.ezen.develocket.request.vo.ReceiveEstimateVO;
import com.ezen.develocket.request.vo.ReceiveRequestVO;
import com.ezen.develocket.request.vo.RequestVO;


@Repository("requestDAO")
public class RequestDAOImpl implements RequestDAO {

	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public void insertNewRequest(RequestVO requestVO) throws DataAccessException {

		sqlSession.insert("mapper.request.insertNewRequest", requestVO);
	}


	@Override
	public List<ReceiveEstimateVO> selectAllEstimate(String rocket_cd) throws DataAccessException {

		List<ReceiveEstimateVO> estimateList = sqlSession.selectList("mapper.request.selectAllEstimate", rocket_cd);
		
		return estimateList;
	}
	
	@Override
	public EstimateVO selectOneEstimate(String contract_cd) throws DataAccessException {

		EstimateVO estimateVO = sqlSession.selectOne("mapper.request.selectOneEstimate", contract_cd);

		return estimateVO;
	}


	@Override
	public List<ReceiveRequestVO> selectAllRequest(String star_cd) throws DataAccessException {

		List<ReceiveRequestVO> requestList = sqlSession.selectList("mapper.request.selectAllRequest", star_cd);
		
		return requestList;
	}
	
	@Override
	public PopupRequestVO selectOnePopupReqeust(String contract_cd) throws DataAccessException {

		PopupRequestVO popupRequestVO = sqlSession.selectOne("mapper.request.selectOnePopupReqeust", contract_cd);
		
		return popupRequestVO;
	}
	
	@Override
	public RequestVO selectOneRequestVO(String contract_cd) throws DataAccessException {

		RequestVO requestVO = sqlSession.selectOne("mapper.request.selectOneRequestVO", contract_cd);
		
		return requestVO;
	}


	@Override
	public void updateRequest(RequestVO requestVO) throws DataAccessException {

		sqlSession.update("mapper.request.updateRequest", requestVO);
	}


	@Override
	public void updateContract2(String contract_cd) throws DataAccessException {

		sqlSession.update("mapper.request.updateContract2", contract_cd);
	}


	@Override
	public void updateContract3(String contract_cd) throws DataAccessException {

		sqlSession.update("mapper.request.updateContract3", contract_cd);
	}


	@Override
	public void updateRefuseContract(String contract_cd) throws DataAccessException {

		sqlSession.update("mapper.request.updateRefuseContract", contract_cd);
	}


	@Override
	public void updateContract4(String contract_cd) throws DataAccessException {

		sqlSession.update("mapper.request.updateContract4", contract_cd);
	}


	@Override
	public void updateContract5(String contract_cd) throws DataAccessException {

		sqlSession.update("mapper.request.updateContract5", contract_cd);
	}


	@Override
	public void updateInvisibleContract(Map<String, String> contractMap) throws DataAccessException {

		String contract_cd = contractMap.get("contract_cd");
		String status_info = checkStatusInfo(contract_cd);
		
		if (status_info.equals("0")) {
			sqlSession.update("mapper.request.updateInvisibleContract", contractMap);
		}
		else {
			contractMap.put("status_info", "-3");
			sqlSession.update("mapper.request.updateInvisibleContract", contractMap);
		}
	}

	private String checkStatusInfo(String contract_cd) throws DataAccessException {
		
		String status_info = sqlSession.selectOne("mapper.request.checkStatusInfo", contract_cd);
		
		return status_info;
	}

	// hide_check 가 '0'이면 가져온 정보로 수정하고 아니면 원래 있던 정보에 더해서 수정함
	@Override
	public void updateHideCheck(Map<String, String> hideCheckMap) throws DataAccessException {

		String contract_cd = hideCheckMap.get("contract_cd");
		String hide_check = selectOneHideCheck(contract_cd);

		if (hide_check.equals("0")) {
			sqlSession.update("mapper.request.updateHideCheck", hideCheckMap);
		}
		else {
			String add_word = hideCheckMap.get("hide_check");
			String new_hide_check = hide_check + add_word;
			hideCheckMap.put("hide_check", new_hide_check);

			sqlSession.update("mapper.request.updateHideCheck", hideCheckMap);
		}
	}

	// 현재 contract_cd에 따른 hide_check 정보 출력
	private String selectOneHideCheck(String contract_cd) throws DataAccessException {

		String hide_check = sqlSession.selectOne("mapper.request.selectOneHideCheck", contract_cd);

		return hide_check;
	}


	@Override
	public void updateViewCheck(String contract_cd) throws DataAccessException {

		sqlSession.update("mapper.request.updateViewCheck", contract_cd);
	}

}
