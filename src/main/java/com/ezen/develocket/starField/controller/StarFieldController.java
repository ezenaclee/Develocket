package com.ezen.develocket.starField.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.develocket.starField.vo.StarFieldVO;

public interface StarFieldController {
	
	public ModelAndView starFieldView(@RequestParam(value = "star_field_cd", required = false) String star_field_cd,
									  HttpServletRequest request,
									  HttpServletResponse response) throws Exception;
	
	public ModelAndView starFieldModify(@RequestParam(value = "star_field_cd", required = false) String star_field_cd,
									    HttpServletRequest request,
									    HttpServletResponse response) throws Exception;

	public ResponseEntity joinStarField(HttpServletRequest request,
									  HttpServletResponse response) throws Exception;
	
	public ResponseEntity modifyStarField(MultipartHttpServletRequest multipartRequest,
										  HttpServletResponse response) throws Exception;
	
	public ResponseEntity removeStarField(@RequestParam(value = "star_field_cd", required = false) String star_field_cd,
										HttpServletRequest request,
										HttpServletResponse response) throws Exception;

	public void removeModImage(HttpServletRequest request,
							   HttpServletResponse response) throws Exception;

	public void removeExistImage(@RequestParam(value = "star_field_cd", required = false) String star_field_cd,
								 @RequestParam(value = "image", required = false) String image,
								 @RequestParam(value = "item", required = false) String item,
								 HttpServletRequest request,
								 HttpServletResponse response) throws Exception;

	String deleteProfile(int star_field_cd, HttpServletRequest request, HttpServletResponse response) throws Exception;

}
