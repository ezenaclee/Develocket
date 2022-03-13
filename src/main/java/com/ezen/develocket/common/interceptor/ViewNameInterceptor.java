package com.ezen.develocket.common.interceptor;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;
import com.ezen.develocket.survey.service.SurveyService;
import com.ezen.develocket.survey.vo.ViewCheckVO;

public class ViewNameInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	private SurveyService surveyService;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request,
							 HttpServletResponse response,
							 Object handler) {

		/*
		 * 요청명: http://localhost:8080/ezen07/member/listMembers.do
		 * 뷰이름: /member/listMembers
		 */
		
		try {
			String viewName = getViewName(request);		// 브라우저의 요청명에서 뷰이름 가져옴
			request.setAttribute("viewName", viewName);
			
		} catch (Exception e) {
			System.out.println("getViewName() 오류");
			e.printStackTrace();
		}
		
		return true;
	}
	
	private String getViewName(HttpServletRequest request) throws Exception {
		
		String contextPath = request.getContextPath();
		System.out.println("context: " + contextPath);
		
		int begin = 0;
		if(!((contextPath == null) || ("".equals(contextPath)))) {
			begin = contextPath.length();	// 전체 요청명의 길이값
		}
		
		int end;
		
		String uri = (String) request.getAttribute("javax.servlet.include.request_uri");
		if (uri == null || uri.trim().equals("")) {
			uri = request.getRequestURI();
		}
		
		System.out.println("uri:" + uri);
		StringBuffer url = request.getRequestURL();
		System.out.println("url: " + url.toString());
		
		if (uri.indexOf(";") != -1) {
			end = uri.indexOf(";");
		}
		else if (uri.indexOf("?") != -1) {
			end = uri.indexOf("?");
		}
		else {
			end = uri.length();
		}
		
		String fileName = uri.substring(begin, end);
		if (fileName.indexOf(".") != -1) {
			fileName = fileName.substring(0, fileName.lastIndexOf("."));
		}
		
		if (fileName.lastIndexOf("/") != -1) {
			fileName = fileName.substring(fileName.lastIndexOf("/", 1), fileName.length());
		}
		
		System.out.println("fileName: " + fileName);
		
		HttpSession session = request.getSession();
		RocketInfoVO rocketInfoVO = (RocketInfoVO) session.getAttribute("rocketInfoVO");
		
		if (rocketInfoVO != null) {
			String rocket_cd = rocketInfoVO.getRocket_cd();

			Map<String, String> viewCheckMap = surveyService.selectAllViewCheck(rocket_cd);
			session.setAttribute("viewCheckMap", viewCheckMap);

		}
		
		return fileName;
	}

}
