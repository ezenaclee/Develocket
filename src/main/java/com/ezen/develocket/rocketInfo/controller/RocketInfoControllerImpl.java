package com.ezen.develocket.rocketInfo.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.develocket.rocketInfo.naver.NaverLoginBO;
import com.ezen.develocket.rocketInfo.service.RocketInfoService;
import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;
import com.ezen.develocket.starField.service.StarFieldService;
import com.ezen.develocket.starField.vo.PreviewVO;
import com.ezen.develocket.survey.service.SurveyService;
import com.ezen.develocket.survey.vo.SurveyInfoVO;
import com.ezen.develocket.survey.vo.ViewCheckVO;


@Controller("rocketInfoController")
public class RocketInfoControllerImpl implements RocketInfoController {

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
	
	
	@RequestMapping(value = "/rocketInfo/*Form.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView form(Model model,
			 @RequestParam(value = "result", required = false) String result,
			 @RequestParam(value = "action", required = false) String action,
			 @RequestParam(value = "parent_cd", required = false) String parent_cd,
			 @RequestParam(value = "group_cd", required = false) String group_cd,
			 HttpServletRequest request, 
			 HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("네이버:" + naverAuthUrl);
		
		//네이버 
		model.addAttribute("url", naverAuthUrl);
		
		String viewName = (String) request.getAttribute("viewName");
		
		session.setAttribute("action", action);
		
		// 답글쓰기로 로그인 시
		if (parent_cd != null) {
		session.setAttribute("parent_cd", parent_cd);	// 답글쓰기 클릭시 부모글 번호를 세션에 저장
		}
		
		if (group_cd != null) {
		session.setAttribute("group_cd", group_cd);
		}
		
		if (request.getParameter("star_field_cd") != null) {
		String star_field_cd = request.getParameter("star_field_cd");
		session.setAttribute("star_field_cd", star_field_cd);
		}
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("result", result);
		
		return mav;
	}
	
	
	@Override
	@RequestMapping(value = "/rocketInfo/join.do", method = RequestMethod.POST)
	public ModelAndView join(@ModelAttribute("RocketInfoVO") RocketInfoVO rocketInfoVO,
							 HttpServletRequest request, 
							 HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");
		
		//
		//회원 비밀번호를 암호화 인코딩
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		//비밀번호를 암호화하여 다시 VO 객체에 저장
		String securePw = encoder.encode(rocketInfoVO.getPassword());
		//DB에 넘겨주기위해 암호화된 비밀번호를 VO객체에 저장
		rocketInfoVO.setPassword(securePw);
		//
		rocketInfoService.joinRocketInfo(rocketInfoVO);
		
		ModelAndView mav = new ModelAndView("redirect:/rocketInfo/loginForm.do");
		
		return mav;
	}


	@Override
	@RequestMapping(value = "/rocketInfo/login.do", method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("_rocketInfoVO") RocketInfoVO _rocketInfoVO,
							  RedirectAttributes rAttr,
							  HttpServletRequest request,
							  HttpServletResponse response) throws Exception {

		ModelAndView mav = new ModelAndView();

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

		String inputPwd = _rocketInfoVO.getPassword();   //JSP에서 입력받은 PASSWORD
		String inputId = _rocketInfoVO.getId();         //JSP에서 입력받은 ID
		//inputPwd = encoder.encode(_rocketInfoVO.getPassword());
		System.out.println(inputPwd);
		System.out.println(inputId);

		/*입력받은 Id로 비밀번호를 불러와서 저장*/
		rocketInfoVO = rocketInfoService.loginByIDSS(inputId);
		System.out.println(rocketInfoVO);

		if (rocketInfoVO != null) {
			if(encoder.matches(inputPwd,rocketInfoVO.getPassword())) {
				String rocket_cd = rocketInfoVO.getRocket_cd();
				System.out.println("!!!!!rocket_cd = " + rocket_cd);

				List<String> starFieldCDList = rocketInfoService.selectAllStarFieldCD(rocket_cd);
				List<PreviewVO> previewVOList = starFieldService.selectPopularStar();

				HttpSession session = request.getSession();
				session.setAttribute("rocketInfoVO", rocketInfoVO);
				session.setAttribute("isLogOn", true);
				session.setAttribute("starFieldCDList", starFieldCDList);

				String action = (String) session.getAttribute("action");
				session.removeAttribute("action");

				if (action != null) {
					// 댓글인지 게시글인지 나누는 조건
					if (action.equals("/inquiry/inquiryReplyForm.do")) {   // 댓글을 작성할 경우
						mav.setViewName("redirect:" + action);
					}
					else if (action.equals("/inquiry/inquiryForm.do")) {   // 게시글 작성인 경우
						mav.setViewName("redirect:" + action);
					}
					// 스타프로필로 이동하는 조건
					else if (action.equals("/starField/starFieldView.do")) {
						mav.setViewName("redirect:" + action);
					}
				} else {
					System.out.println("로그인 성공!!!!");
					mav.addObject("previewVOList", previewVOList);
					mav.setViewName("common/main");
				}
			} else {
				System.out.println("로그인 실패!");
				rAttr.addAttribute("result", "loginFailed");
				mav.setViewName("redirect:/rocketInfo/loginForm.do");
			}
		} else {
			System.out.println("비밀번호가 일치하지 않습니다.");
			rAttr.addAttribute("result", "loginFailed");
			mav.setViewName("redirect:/rocketInfo/loginForm.do");
		}

		return mav;
	}


	@Override
	@RequestMapping(value = "/rocketInfo/logout.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		session.removeAttribute("isLogOn");
		session.removeAttribute("rocketInfoVO");
		session.removeAttribute("starFieldCDList");
		session.removeAttribute("viewCheckMap");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		
		return mav;
	}
	
	
	@Override
	 @ResponseBody
	 @RequestMapping(value = "/rocketInfo/searchID.do", method = RequestMethod.POST)
	 public ResponseEntity searchID(@RequestParam(value = "email", required = false) String email, HttpServletRequest request, HttpServletResponse response) throws Exception {
		 HttpHeaders responseHeaders = new HttpHeaders();
		 responseHeaders.add("Content-Type", "text/html;charset=UTF-8");
		
		 String message = "";
		 ResponseEntity resEnt = null;
		 String status = "";
		
		 HttpSession session = request.getSession();
		 PrintWriter out = response.getWriter();
		
		
		 try {
			
			 String id = rocketInfoService.searchID(email);
			
			 if(id != null) {
				 session.setAttribute("id", id);
				 session.setAttribute("email", email);
				 out.print(id);

			 } else {
				 id = null;
				 out.print(id);

			 }
			
			
		 } catch (Exception e) {
			 resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			 e.printStackTrace();
		 }
		
		 return resEnt;
	 }


	 @Override
	 @ResponseBody
	 @RequestMapping(value = "/rocketInfo/updatePassword.do", method = RequestMethod.POST)
	 public int updatePassword(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		 HttpSession session = request.getSession();
		
		 int result = 0;
		 String id = (String) params.get("id");
		 String email = (String) params.get("email");
		 String password = "";
		
		 BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		 
		 try {
			
			 System.out.println("컨트롤러에서 받은 아이디 : " + id);
			 System.out.println("컨트롤러에서 받은 이메일 : " + email);
			
			 rocketInfoVO.setId(id);
			 rocketInfoVO.setEmail(email);
		
			 int check = rocketInfoService.idEmailCheck(rocketInfoVO);
			 System.out.println("체크 값 : " + check);
			
			 if(check == 1) {
				 for (int i = 0; i < 12; i++) {
					 password += (char) ((Math.random() * 26) + 97);
				 }
				
				 String SecuPwd = encoder.encode(password);
				 rocketInfoVO.setPassword(SecuPwd);
				 rocketInfoService.updatePassword(rocketInfoVO);
				
				 System.out.println("설정한 임시 비밀번호 : " + password);
				
				 session.setAttribute("password", password);
				 session.setAttribute("email", email);
				
				 System.out.println("현재 아이디 : " + id);
				 System.out.println("현재 이메일 : " + email);
				 System.out.println("현재 비밀번호 : " + password);
				
				 result = 1;
				
			 } else {
				 result = 0;
			 }
			
		 } catch (Exception e) {
			 e.printStackTrace();
			 result = 0;
		 }
		
		 return result;
	 }
	 
	 
	 @Override 
	 @ResponseBody
	 @RequestMapping(value = "/rocketInfo/checkid.do", method = RequestMethod.POST)
	 public int IdCheck(@RequestParam("id") String id) {
		 int count = rocketInfoService.IdCheck(id);
		 
		 System.out.println("!!count = " + count);
		 
		 return count;
	
	
	 }


		@Override
		@ResponseBody
		@RequestMapping(value = "/rocketInfo/checkphone.do", method = RequestMethod.POST)
		public int PhoneCheck(@RequestParam("phone_number") String phone_number) {
			int count = rocketInfoService.PhoneCheck(phone_number);
			return count;
		}


		@Override
		@ResponseBody
		@RequestMapping(value = "/rocketInfo/checkemail.do", method = RequestMethod.POST)
		public int EmailCheck(@RequestParam("email")String email)  {
			int count = rocketInfoService.EmailCheck(email);
			return count;
		}
	 

}
