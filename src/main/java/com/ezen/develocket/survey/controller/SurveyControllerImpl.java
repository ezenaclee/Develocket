package com.ezen.develocket.survey.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ezen.develocket.starInfo.vo.CategoryVO;
import org.apache.ibatis.session.SqlSession;
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

import com.ezen.develocket.request.service.RequestService;
import com.ezen.develocket.request.vo.RequestVO;
import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;
import com.ezen.develocket.survey.service.SurveyService;
import com.ezen.develocket.survey.vo.ContractVO;
import com.ezen.develocket.survey.vo.SurveyInfoVO;

@Controller("surveyController")
public class SurveyControllerImpl implements SurveyController {
	
	@Autowired
	private SurveyService surveyService;
	@Autowired
	private RequestService requestService;
	

	@Override
	@RequestMapping(value = "/survey/surveyView.do", method = RequestMethod.POST)
	public ModelAndView surveyView(@RequestParam(value = "star_field_cd", required = false) String star_field_cd,
								   HttpServletRequest request,
								   HttpServletResponse response) throws Exception {

		String viewName = (String) request.getAttribute("viewName");

		CategoryVO categoryVO = surveyService.selectCategoryVO(star_field_cd);
		int active_star_num = surveyService.countActiveStar();
		int total_survey = surveyService.countTotalSurvey();
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("star_field_cd", star_field_cd);
		mav.addObject("categoryVO", categoryVO);
		mav.addObject("active_star_num", active_star_num);
		mav.addObject("total_survey", total_survey);
		
		return mav;
	}


	@Override
	@RequestMapping(value = "/survey/joinSurvey.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity joinSurvey(@ModelAttribute(value = "surveyInfoVO") SurveyInfoVO surveyInfoVO,
		   	 						 @RequestParam(value = "star_field_cd", required = false) String star_field_cd,
		   	 						 HttpServletRequest request,
		   	 						 HttpServletResponse response) throws Exception {

		
		System.out.println("!!SurveyController star_field_cd: " + star_field_cd);
		
		response.setContentType("text/html; charset=utf-8");
		
		HttpSession session = request.getSession();
		RocketInfoVO rocketInfoVO = (RocketInfoVO) session.getAttribute("rocketInfoVO");
		String rocket_cd = rocketInfoVO.getRocket_cd();
		
		String message = "";
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-type", "text/html; charset=utf-8");
		
		try {
			ContractVO contractVO = new ContractVO();
			contractVO.setRocket_cd(rocket_cd);
			contractVO.setStar_field_cd(star_field_cd);
			contractVO.setStatus_info("1");
			
			String contract_cd = surveyService.insertNewContract(contractVO);
			surveyInfoVO.setContract_cd(contract_cd);
			
			String survey_cd = surveyService.insertNewSurveyInfo(surveyInfoVO);
			
			RequestVO requestVO = new RequestVO();
			requestVO.setSurvey_cd(survey_cd);
			
			requestService.insertNewRequest(requestVO);
			
			
			message = "<script>";
			message += "alert('견적 요청이 완료되었습니다.');";
			message += "location.href = '"+ request.getContextPath() + "/request/receiveEstimateList.do';";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
		} catch (Exception e) {
			message = "<script>";
			message += "alert('오류가 발생했습니다.');";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
			e.printStackTrace();
		}
		
		return resEnt;
	}
}
