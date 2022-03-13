package com.ezen.develocket.request.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.develocket.request.vo.RequestVO;

public interface RequestController {

	public ModelAndView moveReceiveEstimateList(HttpServletRequest request,
			   								 	HttpServletResponse response) throws Exception;
	
	public ModelAndView moveReceiveEstimate(@RequestParam(value = "contract_cd", required = false) String contract_cd,
										    @RequestParam(value = "status_info", required = false) String status_info,
										    @RequestParam(value = "view_check", required = false) String view_check,
										    HttpServletRequest request,
										    HttpServletResponse response) throws Exception;
	
	public ModelAndView moveReceiveRequestList(HttpServletRequest request,
			 	 							   HttpServletResponse response) throws Exception;
	
	public ModelAndView moveReceiveRequest(@RequestParam(value = "contract_cd", required = false) String contract_cd,
										   @RequestParam(value = "status_info", required = false) String status_info,
										   @RequestParam(value = "view_check", required = false) String view_check,
										   HttpServletRequest request,
			   							   HttpServletResponse response) throws Exception;

	public ResponseEntity agreeRequest(@ModelAttribute(value = "requestVO") RequestVO requestVO,
									   @RequestParam(value = "contract_cd", required = false) String contract_cd,
									   HttpServletRequest request,
			   						   HttpServletResponse response) throws Exception;
	
	public ResponseEntity agreeEstimate(@RequestParam(value = "contract_cd", required = false) String contract_cd,
			   							HttpServletRequest request,
			   							HttpServletResponse response) throws Exception;
	
	public ResponseEntity refuseContract(@RequestParam(value = "contract_cd", required = false) String contract_cd,
										 HttpServletRequest request,
										 HttpServletResponse response) throws Exception;
	
	public void makeInvisibleRefuse(@RequestParam(value = "contract_cd", required = false) String contract_cd,
							  @RequestParam(value = "status_info", required = false) String status_info,
							  HttpServletRequest request,
							  HttpServletResponse response) throws Exception;

	public void makeInvisibleEnd(@RequestParam(value = "contract_cd", required = false) String contract_cd,
								 @RequestParam(value = "hide_check", required = false) String hide_check,
								 HttpServletRequest request,
								 HttpServletResponse response) throws Exception;

	public void readAll(@RequestParam(value = "star_cd", required = false) String star_cd,
						HttpServletRequest request,
						HttpServletResponse response) throws Exception;
	
}
