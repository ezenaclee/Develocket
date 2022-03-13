package com.ezen.develocket.review.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.ezen.develocket.review.vo.ReviewVO;

@Repository("reviewDAO")
public class ReviewDAOImpl implements ReviewDAO {

	@Autowired
	private SqlSession sqlSession;
	

	@Override
	public void insertNewReview(ReviewVO reviewVO) throws DataAccessException {

		sqlSession.insert("mapper.review.insertNewReview", reviewVO);
	}
}























