package com.ezen.develocket.inquiry.service;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.ezen.develocket.inquiry.vo.InquiryImgVO;

public interface InquiryService {

	public Map<String, Object> inquiryList(Map<String, Integer> pagingMap) throws DataAccessException;

	public String addNewInquiry(Map<String, Object> inquiryMap) throws DataAccessException;

	public Map<String, Object> viewInquiry(String inquiry_cd) throws DataAccessException;

	public void modifyInquiry(Map<String, Object> inquiryMap) throws DataAccessException;

	public void removeInquiry(String inquiry_cd) throws DataAccessException;

	public void removeExistImage(InquiryImgVO inquiryImgVO) throws DataAccessException;

}
