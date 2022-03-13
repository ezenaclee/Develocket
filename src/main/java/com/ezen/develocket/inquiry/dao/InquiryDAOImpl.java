package com.ezen.develocket.inquiry.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.ezen.develocket.inquiry.vo.InquiryImgVO;
import com.ezen.develocket.inquiry.vo.InquiryVO;


@Repository("inquiryDAO")
public class InquiryDAOImpl implements InquiryDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<InquiryVO> selectAllInquiryList(Map<String, Integer> pagingMap) throws DataAccessException {

		List<InquiryVO> inquiryList = sqlSession.selectList("mapper.inquiry.selectAllInquiryList", pagingMap);

		return inquiryList;
	}

	@Override
	public int selectTotalInquiry() throws DataAccessException {

		int totalInquiry = sqlSession.selectOne("mapper.inquiry.selectTotalInquiry");
		
		return totalInquiry;
	}

	@Override
	public String insertNewInquiry(Map<String, Object> inquiryMap) throws DataAccessException {

		if (inquiryMap.get("group_cd") == "0") {
			String group_cd = selectNewGroupCD();
			inquiryMap.put("group_cd", group_cd);
		}
		
		String inquiry_cd = selectInquiryCD();
		inquiryMap.put("inquiry_cd", inquiry_cd);
		
		sqlSession.insert("mapper.inquiry.insertNewInquiry", inquiryMap);
		
		return inquiry_cd;
	}
	
	public String selectNewGroupCD() throws DataAccessException {
		
		String group_cd = sqlSession.selectOne("mapper.inquiry.selectNewGroupCD");
		
		return group_cd;
	}
	
	public String selectInquiryCD() throws DataAccessException {

		String inquiry_cd = sqlSession.selectOne("mapper.inquiry.selectInquiryCD");
		
		return inquiry_cd;
	}

	
	@Override
	public void insertNewImage(Map<String, Object> inquiryMap) throws DataAccessException {

		List<InquiryImgVO> imageFileList = (ArrayList) inquiryMap.get("imageFileList");
		String inquiry_cd = (String) inquiryMap.get("inquiry_cd");
		
		int inquiry_img_cd = Integer.parseInt(selectNewImageFileCD());
		
		if (imageFileList != null && imageFileList.size() != 0) {
			for (InquiryImgVO inquiryImgVO : imageFileList) {
				inquiryImgVO.setInquiry_img_cd(++inquiry_img_cd + "");
				inquiryImgVO.setInquiry_cd(inquiry_cd);
			}
			
			sqlSession.insert("mapper.inquiry.insertNewImage", imageFileList);
		}
	}
	
	public String selectNewImageFileCD() throws DataAccessException {

		String inquiry_img_cd = sqlSession.selectOne("mapper.inquiry.selectNewImageFileCD");
		
		return inquiry_img_cd;
	}

	@Override
	public InquiryVO selectInquiry(String inquiry_cd) throws DataAccessException {

		InquiryVO vo = sqlSession.selectOne("mapper.inquiry.selectInquiry", inquiry_cd);
		
		return vo;
	}

	@Override
	public List<InquiryImgVO> selectImageFileList(String inquiry_cd) throws DataAccessException {

		List<InquiryImgVO> imageFileList = sqlSession.selectList("mapper.inquiry.selectImageFileList", inquiry_cd);
		
		return imageFileList;
	}

	@Override
	public void updateInquiry(Map<String, Object> inquiryMap) throws DataAccessException {

		sqlSession.update("mapper.inquiry.updateInquiry", inquiryMap);
	}

	@Override
	public void insertModNewImage(Map<String, Object> inquiryMap) throws DataAccessException {

		List<InquiryImgVO> modAddImageFileList = (ArrayList) inquiryMap.get("modAddImageFileList");
		String inquiry_cd = (String) inquiryMap.get("inquiry_cd");
		
		int inquiry_img_cd  = Integer.parseInt(selectNewImageFileCD());
		
		if (modAddImageFileList != null && modAddImageFileList.size() != 0) {
			for (InquiryImgVO inquiryImgVO : modAddImageFileList) {
				inquiryImgVO.setInquiry_img_cd(++inquiry_img_cd + "");
				inquiryImgVO.setInquiry_cd(inquiry_cd);
			}
			
			sqlSession.insert("mapper.inquiry.insertModNewImage", modAddImageFileList);
		}	
	}

	@Override
	public void deleteInquiry(String inquiry_cd) throws DataAccessException {

		sqlSession.delete("mapper.inquiry.deleteInquiry", inquiry_cd);
	}

	@Override
	public void deleteExistImage(InquiryImgVO inquiryImgVO) throws DataAccessException {

		sqlSession.delete("mapper.inquiry.deleteExistImage", inquiryImgVO);
	}
	
}
