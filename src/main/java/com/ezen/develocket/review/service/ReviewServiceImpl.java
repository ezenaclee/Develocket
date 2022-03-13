package com.ezen.develocket.review.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.ezen.develocket.review.dao.ReviewDAO;
import com.ezen.develocket.review.vo.ReviewVO;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("reviewService")
@Transactional(propagation = Propagation.REQUIRED)
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDAO reviewDAO;

	
	@Override
	public void insertNewReview(ReviewVO reviewVO) throws DataAccessException {

		reviewDAO.insertNewReview(reviewVO);
	}
	
}






















