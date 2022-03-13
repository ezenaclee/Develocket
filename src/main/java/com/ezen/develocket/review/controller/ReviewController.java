package com.ezen.develocket.review.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.develocket.review.vo.ReviewVO;

public interface ReviewController {

	public ModelAndView moveReviewForm(@RequestParam(value = "rocket_cd", required = false) String rocket_cd,
									   @RequestParam(value = "star_field_cd", required = false) String star_field_cd,
									   @RequestParam(value = "contract_cd", required = false) String contract_cd,
									   HttpServletRequest request, 
							 		   HttpServletResponse response) throws Exception;
	
	public ResponseEntity joinReivew(@ModelAttribute(value = "reviewVO") ReviewVO reviewVO,
									 @RequestParam(value = "contract_cd", required = false) String contract_cd,
								     HttpServletRequest request, 
						 		     HttpServletResponse response) throws Exception;
}
