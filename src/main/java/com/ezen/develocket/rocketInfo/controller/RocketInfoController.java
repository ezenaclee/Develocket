package com.ezen.develocket.rocketInfo.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;


public interface RocketInfoController {

	public ModelAndView join(@ModelAttribute("RocketInfoVO") RocketInfoVO rocketInfoVO ,
			 				 HttpServletRequest request,
			 				 HttpServletResponse response) throws Exception;
	
	public ModelAndView login(@ModelAttribute("_rocketInfoVO") RocketInfoVO _rocketInfoVO,
							  RedirectAttributes rAttr,
							  HttpServletRequest request,
							  HttpServletResponse response) throws Exception;

	public ModelAndView logout(HttpServletRequest request,
			   				   HttpServletResponse response) throws Exception;

	public ResponseEntity searchID(@RequestParam(value = "email", required = false) String email, 
								   HttpServletRequest request,
								   HttpServletResponse response) throws Exception;
	
	public int updatePassword(@RequestParam Map<String, Object> params, 
							  HttpServletRequest request, 
							  HttpServletResponse response) throws Exception;
	
	public int IdCheck(String id) throws Exception;
	
	public int PhoneCheck(String phone_number) throws Exception;

	public int EmailCheck(String email) throws Exception;

}
