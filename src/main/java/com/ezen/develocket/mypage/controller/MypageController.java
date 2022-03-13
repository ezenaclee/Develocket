package com.ezen.develocket.mypage.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.develocket.mypage.vo.MypageVO;
import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;

public interface MypageController {

	public ModelAndView moveMyPage(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception;

	public ModelAndView moverecheckPwd(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public ResponseEntity rechkPwd(@RequestParam(value = "password", required = false) String password,
								   @RequestParam(value = "check", required = false) String check,
								   HttpServletRequest request, HttpServletResponse response) throws Exception;

	public ResponseEntity ModifyRocketInfo(@RequestParam(value = "password", required = false) String password, 
			 @RequestParam(value = "originPassword", required = false) String originPassword,
			HttpServletRequest request, HttpServletResponse response) throws DataAccessException;
	
	public ModelAndView DeleteRocketInfo(HttpServletRequest request, HttpServletResponse response) throws DataAccessException;

	public ResponseEntity modifyProfileImg(MultipartHttpServletRequest multipartRequest,
										  HttpServletResponse response) throws Exception;

	public void removeExistImage(@RequestParam(value = "rocket_cd", required = false) String rocket_cd,
								 @RequestParam(value = "profile_img", required = false) String profile_img,
								 HttpServletRequest request,
								 HttpServletResponse response) throws Exception;

	public String checkStarCD (HttpServletRequest request,
							 HttpServletResponse response) throws Exception;

}
