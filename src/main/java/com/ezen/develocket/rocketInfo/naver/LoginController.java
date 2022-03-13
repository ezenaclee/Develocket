package com.ezen.develocket.rocketInfo.naver;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
//import org.springframework.social.google.connect.GoogleConnectionFactory;
//import org.springframework.social.oauth2.GrantType;
//import org.springframework.social.oauth2.OAuth2Operations;
//import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.develocket.rocketInfo.service.RocketInfoService;
import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;
import com.ezen.develocket.starField.service.StarFieldService;
import com.ezen.develocket.starField.vo.PreviewVO;
import com.ezen.develocket.survey.service.SurveyService;
import com.github.scribejava.core.model.OAuth2AccessToken;

/**
 * Handles requests for the application home page.
 */
@Controller 
public class LoginController {

	@Autowired
	private RocketInfoService rocketInfoService;
	@Autowired
	private StarFieldService starFieldService;
	@Autowired
	private SurveyService surveyService;
	@Autowired
	private RocketInfoVO rocketInfoVO;
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	/*
	 * //로그인 첫 화면 요청 메소드
	 * 
	 * @RequestMapping(value = "/rocketInfo/NaverLogin.do", method = {
	 * RequestMethod.GET, RequestMethod.POST }) public String login(Model model,
	 * HttpSession session, HttpServletRequest request) {
	 * 
	 * 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 String
	 * naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
	 * 
	 * //https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***
	 * ************&
	 * //redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&
	 * state=e68c269c-5ba9-4c31-85da-54c16c658125 System.out.println("네이버:" +
	 * naverAuthUrl);
	 * 
	 * //네이버 model.addAttribute("url", naverAuthUrl);
	 * 
	 * 생성한 인증 URL을 View로 전달 return "/rocketInfo/loginForm"; }
	 */

	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity callback(Model model, @RequestParam String code, @RequestParam String state,
			HttpSession session, HttpServletRequest request) throws IOException {

		String message = "";
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-type", "text/html; charset=utf-8");

		System.out.println("여기는 callback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		model.addAttribute("result", apiResult);

		JSONParser parser = new JSONParser();

		org.json.simple.JSONObject jsonSimpleObject = null;
		try {
			jsonSimpleObject = (org.json.simple.JSONObject) parser.parse(apiResult);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// json파일을 String 형식으로 변환함
		JSONObject jsonObject = new JSONObject(jsonSimpleObject.toJSONString());

		System.out.println("apiResult" + jsonObject.get("response"));
		JSONObject jsonObject2 = (JSONObject) jsonObject.get("response");
		String id = (String) jsonObject2.get("id");
		String name = (String) jsonObject2.get("name");
		String email = (String) jsonObject2.get("email");
		String phone_number = (String) jsonObject2.get("mobile");
		/* 네이버 로그인 성공 페이지 View 호출 */
		
		//NAVER 신규/회원/일반가입자 나누기 02.23
		int emailcount = rocketInfoService.SearchNaverID(email);
		String password = rocketInfoService.SearchNaverPwd(email);
				
		try {
			if(emailcount == 0) {
				//Insert
				rocketInfoVO.setId(id.substring(0,9));
				rocketInfoVO.setName(name);
				rocketInfoVO.setPassword("Naver");
				rocketInfoVO.setEmail(email);
				rocketInfoVO.setPhone_number(phone_number);
				
				rocketInfoService.InsertNaverInfo(rocketInfoVO);
				System.out.println("네이버 회원가입 완료");
				
				message += "<script>";
				message += "alert('로켓이 되신 걸 환영합니다! 로그인 화면으로 이동합니다.');";
				message += "location.href = '" + request.getContextPath() + "/rocketInfo/loginForm.do';";
				message += "</script>";
				
				resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
				
			}else if(emailcount == 1) {
				if(password.equals("Naver")) {
					System.out.println("네이버가입자 로그인시켜주기");
					
					rocketInfoVO.setEmail(email);
					rocketInfoVO.setId(id.substring(0,9));
					
					rocketInfoVO =  rocketInfoService.loginByNaver(rocketInfoVO);
					session.setAttribute("rocketInfoVO", rocketInfoVO);
					
					message += "<script>";
//					message += "alert('디벨로켓에 오신 걸 환영합니다.');";
					message += "location.href = '" + request.getContextPath() + "/rocketInfo/NaverLogin.do';";
					message += "</script>";
					
					resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
				}
				else {
					System.out.println("일반가입자");
					message += "<script>";
					message += "alert('이미 가입된 회원입니다! ID찾기를 이용해 주세요.');";
					message += "location.href = '" + request.getContextPath() + "/rocketInfo/searchIDPasswordForm.do';";
					message += "</script>";
					
					resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
				}
			}else {
				System.out.println("로그인에러");
				message += "<script>";
				message += "alert('로그인에러입니다. 잠시 후 다시 이용해 주시길 바랍니다.');";
				message += "window.history.back();";
				message += "</script>";
				
				resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
				
			}
		} catch (Exception e) {
			System.out.println("에러입니다");
			
			message += "<script>";
			message += "alert('에러입니다. 잠시 후 다시 이용해 주시길 바랍니다.');";
			message += "location.href = '" + request.getContextPath() + "/';";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
		}
		
		return resEnt;
	}
	
	@RequestMapping(value = "/rocketInfo/NaverLogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView login(@ModelAttribute("_rocketInfoVO") RocketInfoVO _rocketInfoVO, 
							  RedirectAttributes rAttr, 
							  HttpServletRequest request,
							  HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		session.getAttribute("rocketInfoVO");
		ModelAndView mav = new ModelAndView();

		
		rocketInfoVO = rocketInfoService.loginByNaver(rocketInfoVO);

		if (this.rocketInfoVO != null) {
			String rocket_cd = rocketInfoVO.getRocket_cd();
			List<String> starFieldCDList = rocketInfoService.selectAllStarFieldCD(rocket_cd);
			List<PreviewVO> previewVOList = starFieldService.selectPopularStar();

			Map<String, String> viewCheckMap = surveyService.selectAllViewCheck(rocket_cd);

			session = request.getSession();
			session.setAttribute("rocketInfoVO", rocketInfoVO);
			session.setAttribute("isLogOn", true);
			session.setAttribute("starFieldCDList", starFieldCDList);
			session.setAttribute("viewCheckMap", viewCheckMap);


			String action = (String) session.getAttribute("action");
			session.removeAttribute("action");

			if (action != null) {
				// 댓글인지 게시글인지 나누는 조건
				if (action.equals("/inquiry/inquiryReplyForm.do")) {	// 댓글을 작성할 경우
					mav.setViewName("redirect:" + action);
				}
				else if (action.equals("/inquiry/inquiryForm.do")) {	// 게시글 작성인 경우
					mav.setViewName("redirect:" + action);
				}
				// 스타프로필로 이동하는 조건
				else if (action.equals("/starField/starFieldView.do")) {
					mav.setViewName("redirect:" + action);
				}
			}
			else {
				mav.addObject("previewVOList", previewVOList);
				mav.setViewName("common/main");
			}
		}
		else {
			System.out.println("로그인 실패!");
			rAttr.addAttribute("result", "loginFailed");
			mav.setViewName("redirect:/rocketInfo/loginForm.do");
		}

		return mav;
	}	
}
