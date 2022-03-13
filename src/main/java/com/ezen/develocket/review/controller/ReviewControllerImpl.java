package com.ezen.develocket.review.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.develocket.chat.service.ChatService;
import com.ezen.develocket.chat.vo.ChatContentVO;
import com.ezen.develocket.request.service.RequestService;
import com.ezen.develocket.review.service.ReviewService;
import com.ezen.develocket.review.vo.ReviewVO;

@Controller("reviewController")
public class ReviewControllerImpl implements ReviewController {

	@Autowired
	private ReviewService reviewService;
	@Autowired
	private RequestService requestService;

	
	@Override
	@RequestMapping(value = "/review/reviewForm.do", method = RequestMethod.GET)
	public ModelAndView moveReviewForm(@RequestParam(value = "rocket_cd", required = false) String rocket_cd,
									   @RequestParam(value = "star_field_cd", required = false) String star_field_cd,
									   @RequestParam(value = "contract_cd", required = false) String contract_cd,
									   HttpServletRequest request, 
									   HttpServletResponse response) throws Exception {

		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("rocket_cd", rocket_cd);
		mav.addObject("star_field_cd", star_field_cd);
		mav.addObject("contract_cd", contract_cd);
		
		return mav;
	}


	@Override
	@RequestMapping(value = "/review/joinReview.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity joinReivew(@ModelAttribute(value = "reviewVO") ReviewVO reviewVO, 
									 @RequestParam(value = "contract_cd", required = false) String contract_cd,
								     HttpServletRequest request, 
								     HttpServletResponse response) throws Exception {

		response.setContentType("text/html; charset=utf-8");
		
		String message = "";
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-type", "text/html; charset=utf-8");
		

		try {
			reviewService.insertNewReview(reviewVO);
			
			// 리뷰작성 완료 후 status_info를 '5'로 수정
			requestService.updateContract5(contract_cd);
			
			String star_field_cd = reviewVO.getStar_field_cd();
			
			message = "<script>";
			message += "alert('리뷰를 등록하였습니다.');";
			message += "window.opener.location.href='" + request.getContextPath() + "/starField/starFieldView.do?star_field_cd=" + star_field_cd + "';";
			message += "window.close();";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
		} catch (Exception e) {
			message = "<script>";
			message += "alert('오류가 발생했습니다. 다시 시도해 주세요.');";
			message += "history.back()";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
			e.printStackTrace();
		}
		
		return  resEnt;
	}
	
	
	
	
}
