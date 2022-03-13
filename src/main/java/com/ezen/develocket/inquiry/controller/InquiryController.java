package com.ezen.develocket.inquiry.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface InquiryController {

	public ModelAndView inquiryList(HttpServletRequest request,
				 					HttpServletResponse response) throws Exception;
	
	public ResponseEntity addNewInquiry(MultipartHttpServletRequest multipartRequest,
	   									HttpServletResponse response) throws Exception;
	
	public ModelAndView inquiryVeiw(@RequestParam("inquiry_cd") String inquiry_cd,
									@RequestParam(value = "removeCompleted", required = false) String removeCompleted,
									HttpServletRequest request,
									HttpServletResponse response) throws Exception;
	
	public ResponseEntity modifyInquiry(MultipartHttpServletRequest multipartRequest,
				 					    HttpServletResponse response) throws Exception;
	
	public ResponseEntity removeInquiry(@RequestParam("inquiry_cd") String inquiry_cd,
										HttpServletRequest request,
										HttpServletResponse response) throws Exception;
	
	public void removeExistImage(HttpServletRequest request,
			   				   HttpServletResponse response) throws Exception;
	
}
