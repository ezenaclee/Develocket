package com.ezen.develocket.starInfo.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;



public interface StarInfoController {

	public ResponseEntity join(HttpServletRequest request,
							   HttpServletResponse response) throws Exception;
	
	public ResponseEntity joinExtra(@RequestParam(value = "cate_s", required = false) String cate_s,
									@RequestParam(value = "star_cd", required = false) String star_cd,
									HttpServletRequest request,
			   						HttpServletResponse response) throws Exception;

	public int nicknameCheck(@RequestParam(value = "star_nickname", required = false) String star_nickname)
			throws Exception;

	public String deleteStar(String star_cd, HttpServletRequest request, HttpServletResponse response) throws Exception;

	public int nicknameModify(Map<String, String> starInfo, HttpServletRequest request, HttpServletResponse response) throws Exception;

	public int areaModify(Map<String, String> starInfo, HttpServletRequest request, HttpServletResponse response) throws Exception;

	public String checkPwd(String star_cd, String password, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
}
