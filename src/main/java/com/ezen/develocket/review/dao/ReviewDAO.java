package com.ezen.develocket.review.dao;

import org.springframework.dao.DataAccessException;

import com.ezen.develocket.review.vo.ReviewVO;

public interface ReviewDAO {

	public void insertNewReview(ReviewVO reviewVO) throws DataAccessException;

}
