package com.ezen.develocket.survey.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.develocket.survey.vo.SurveyInfoVO;

public interface SurveyController {

	public ModelAndView surveyView(@RequestParam(value = "star_field_cd", required = false) String star_field_cd,
								   HttpServletRequest request,
								   HttpServletResponse response) throws Exception;
	
	public ResponseEntity joinSurvey(@ModelAttribute(value = "surveyInfoVO") SurveyInfoVO surveyInfoVO,
								   	 @RequestParam(value = "star_field_cd", required = false) String star_field_cd,
								   	 HttpServletRequest request,
								   	 HttpServletResponse response) throws Exception;
}
