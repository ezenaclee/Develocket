package com.ezen.develocket.inquiry.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.ezen.develocket.inquiry.vo.InquiryImgVO;
import com.ezen.develocket.inquiry.vo.InquiryVO;

public interface InquiryDAO {

	public List<InquiryVO> selectAllInquiryList(Map<String, Integer> pagingMap) throws DataAccessException;

	public int selectTotalInquiry() throws DataAccessException;

	public String insertNewInquiry(Map<String, Object> inquiryMap) throws DataAccessException;

	public void insertNewImage(Map<String, Object> inquiryMap) throws DataAccessException;

	public InquiryVO selectInquiry(String inquiry_cd) throws DataAccessException;

	public List<InquiryImgVO> selectImageFileList(String inquiry_cd) throws DataAccessException;

	public void updateInquiry(Map<String, Object> inquiryMap) throws DataAccessException;

	public void insertModNewImage(Map<String, Object> inquiryMap) throws DataAccessException;

	public void deleteInquiry(String inquiry_cd) throws DataAccessException;

	public void deleteExistImage(InquiryImgVO inquiryImgVO) throws DataAccessException;

}
