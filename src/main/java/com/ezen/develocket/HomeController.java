package com.ezen.develocket;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.develocket.starField.service.StarFieldService;
import com.ezen.develocket.starField.vo.PreviewVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private StarFieldService starFieldService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(HttpServletRequest request, Locale locale, Model model) {
		
		request.getAttribute("viewName");
		List<PreviewVO> previewVOList = starFieldService.selectPopularStar();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("common/main");
		mav.addObject("previewVOList", previewVOList);
		
		return mav;
	}

	@RequestMapping(value = "/faq/faq*.do", method = RequestMethod.GET)
	public ModelAndView moveFaq(HttpServletRequest request) {

		String viewName = (String) request.getParameter("viewName");

		ModelAndView mav = new ModelAndView(viewName);

		return mav;
	}

	@RequestMapping(value = "/notice/notice*.do", method = RequestMethod.GET)
	public ModelAndView moveNotice(HttpServletRequest request) {

		String viewName = (String) request.getParameter("viewName");

		ModelAndView mav = new ModelAndView(viewName);

		return mav;
	}

	@RequestMapping(value = "/board/useGuide.do", method = RequestMethod.GET)
	public ModelAndView moveUseGuide(HttpServletRequest request) {

		String viewName = (String) request.getParameter("viewName");

		ModelAndView mav = new ModelAndView(viewName);

		return mav;
	}

	@RequestMapping(value = "/board/intro.do", method = RequestMethod.GET)
	public ModelAndView moveIntro(HttpServletRequest request) {

		String viewName = (String) request.getParameter("viewName");

		ModelAndView mav = new ModelAndView(viewName);

		return mav;
	}
	
}
