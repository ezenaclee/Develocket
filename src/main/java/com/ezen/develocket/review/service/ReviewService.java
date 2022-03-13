package com.ezen.develocket.review.service;

import org.springframework.dao.DataAccessException;

import com.ezen.develocket.review.vo.ReviewVO;

public interface ReviewService {

	public void insertNewReview(ReviewVO reviewVO) throws DataAccessException;

}
