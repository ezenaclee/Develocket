package com.ezen.develocket.starInfo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;
import com.ezen.develocket.starInfo.service.StarInfoService;
import com.ezen.develocket.starInfo.vo.StarInfoVO;

@Controller("starInfoController")
public class StarInfoControllerImpl implements StarInfoController {

	@Autowired
	StarInfoService starInfoService;
	@Autowired
	private StarInfoVO starInfoVO;
	
	@RequestMapping(value = "/starInfo/*Form.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView form(HttpServletRequest request, 
							 HttpServletResponse response) throws Exception {
		
		String viewName = (String) request.getAttribute("viewName");
		
		HttpSession session = request.getSession();
		RocketInfoVO rocketInfoVO = (RocketInfoVO) session.getAttribute("rocketInfoVO");
		String rocket_cd = rocketInfoVO.getRocket_cd();
		
		String star_cd = starInfoService.matchStarCD(rocket_cd);
		/*String deleted_area = starInfoService.selectArea(star_cd);*/
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("star_cd", star_cd);
		
		return mav;
	}

	@Override
	@RequestMapping(value = "/starInfo/join.do*", method = RequestMethod.POST)
	public ResponseEntity join(HttpServletRequest request,
							   HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		RocketInfoVO rocketInfoVO = (RocketInfoVO) session.getAttribute("rocketInfoVO");
		String rocket_cd = rocketInfoVO.getRocket_cd();
		
		System.out.println("join:" + rocket_cd);
		
		String small_category = request.getParameter("small_category");
		String star_nickname = request.getParameter("star_nickname");
		
		String area = request.getParameter("area"); 
		
		Map<String, String> starInfoMap = new HashMap<>();
		starInfoMap.put("rocket_cd", rocket_cd);
		starInfoMap.put("star_nickname", star_nickname);
		starInfoMap.put("area", area);
		starInfoMap.put("small_category", small_category);
		
		String message = "";
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-type", "text/html; charset=utf-8");
		
		try {
			Map<String, String> codeMap = starInfoService.joinStarInfo(starInfoMap);
			String star_cd = codeMap.get("star_cd");
			String cate_cd = codeMap.get("cate_cd");

			session.setAttribute("starInfoMap", starInfoMap);
			
			message += "<script>";
			message += "alert('스타등록을 완료하였습니다. 프로필을 수정해주세요.');";
			message += "location.href = '"+ request.getContextPath() + "/starField/joinStarField.do?star_cd=" + star_cd + "&cate_cd=" + cate_cd + "';";
			message += "</script>"; 
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
			
		} catch (Exception e) {
			
			message = "<script>";
			message += "alert('오류가 발생했습니다. 다시 입력해주세요.');";
			message += "location.href = '"+ request.getContextPath() + "/starInfo/joinStarForm.do';";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
			e.printStackTrace();
		}
		
		return resEnt;
	}

	@Override
	@RequestMapping(value = "/starInfo/joinExtra.do", method = RequestMethod.POST)
	public ResponseEntity joinExtra(@RequestParam(value = "cate_s", required = false) String cate_s,
									@RequestParam(value = "star_cd", required = false) String star_cd,
									HttpServletRequest request,
									HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		RocketInfoVO rocketInfoVO = (RocketInfoVO) session.getAttribute("rocketInfoVO");
		String rocket_cd = rocketInfoVO.getRocket_cd();
		
		String message = "";
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-type", "text/html; charset=utf-8");
		
		try {
			String cate_cd = starInfoService.selectCateCD(cate_s);
			
			message += "<script>";
			message += "alert('스타등록을 완료하였습니다. 프로필을 수정해주세요.');";
			message += "location.href = '"+ request.getContextPath() + "/starField/joinStarField.do?star_cd=" + star_cd + "&cate_cd=" + cate_cd + "';";
			message += "</script>"; 
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
		} catch (Exception e) {

			message = "<script>";
			message += "alert('오류가 발생했습니다. 다시 입력해주세요.');";
			message += "location.href = '"+ request.getContextPath() + "/starInfo/joinStarForm.do';";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
			e.printStackTrace();
		}
		
		
		return resEnt;
	}

	@Override
	@RequestMapping(value = "/starInfo/duplicateCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public int nicknameCheck(@RequestParam(value = "star_nickname", required = false) String star_nickname)
			throws Exception {

		int count = starInfoService.duplicateCheckNickName(star_nickname);

		return count;
	}
	
	/* 마이페이지에 */
	@RequestMapping(value = "/mypage/*Form.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView starInfoForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String viewName = (String) request.getAttribute("viewName");
		HttpSession session = request.getSession();
		RocketInfoVO rocketInfoVO = (RocketInfoVO) session.getAttribute("rocketInfoVO");
		String rocket_cd = rocketInfoVO.getRocket_cd();
		System.out.println("rocket_cd!!!:" + rocket_cd);
		
		String star_cd = starInfoService.matchStarCD(rocket_cd);
		System.out.println("star_cd : " + star_cd);

		ModelAndView mav = new ModelAndView(viewName);

		if (star_cd.equals("0")) {
			mav.addObject("star_cd", star_cd);
		}
		else {
			StarInfoVO starInfo = starInfoService.viewStarInfo(star_cd);
			System.out.println("nickname : " + starInfo.getStar_nickname());
			System.out.println("area : " + starInfo.getArea());

			mav.addObject("star_cd", star_cd);
			mav.addObject("starInfo", starInfo);
		}
		
		return mav;
	}
	
	@Override 
	@ResponseBody
	@RequestMapping(value = "/mypage/checkNickname.do", method = RequestMethod.POST)
	public int nicknameModify(@RequestParam Map<String, String> starInfo, HttpServletRequest request, HttpServletResponse response) {
		int count = 0;
		String star_nickname = (String) starInfo.get("nickname");
		String star_cd = (String) starInfo.get("star_cd");
		
		try {
			// 닉네임 중복체크
			count = starInfoService.nicknameCheck(star_nickname);
			
			starInfoVO.setStar_cd(star_cd);
			starInfoVO.setStar_nickname(star_nickname);
			 
			System.out.println("닉네임 : " + star_nickname);
			System.out.println("star_cd : " + star_cd);
			
			// 닉네임 업데이트
			if(count == 0) {
				starInfoService.nicknameUpdate(starInfoVO);
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
			count = 1;
		}
		
		 
		return count;
	}
	
	@Override 
	@ResponseBody
	@RequestMapping(value = "/mypage/areaModify.do", method = RequestMethod.POST)
	public int areaModify(@RequestParam Map<String, String> starInfo, HttpServletRequest request, HttpServletResponse response) {
		
		int result = 0;
		
		String area = (String) starInfo.get("area");
		String star_cd = (String) starInfo.get("star_cd");
		
		starInfoVO.setStar_cd(star_cd);
		starInfoVO.setArea(area);
		 
		System.out.println("지역 : " + area);
		System.out.println("star_cd : " + star_cd);
		
		try {
			// 지역 업데이트
			starInfoService.areaModify(starInfoVO);
			
		} catch (Exception e) {
			e.printStackTrace();
			result = 1;
		}
		
		 
		return result;
	 }
	
	@Override 
	@ResponseBody
	@RequestMapping(value = "/mypage/checkPwd.do", method = RequestMethod.POST)
	public String checkPwd(@RequestParam String star_cd, @RequestParam String password, HttpServletRequest request, HttpServletResponse response) {
		String result = "";
		
		// 전달받은 star_cd
		System.out.println("star_cd : " + star_cd);
		
		// 전달받은 password
		System.out.println("password : " + password);
		
		try {
			
			Map<String, String> starInfo = new HashMap<>();
			starInfo.put("star_cd", star_cd);
			starInfo.put("password", password);
			
			// rocket_cd 찾아오기
			String rocket_cd = starInfoService.findRocketCd(star_cd);
			starInfo.put("rocket_cd", rocket_cd);
			System.out.println("rocket_cd : " + rocket_cd);
			
			// rocket_cd, password 일치 확인
			int check = starInfoService.checkPwd(starInfo);
			System.out.println("일치 하면 1 : " + check);
			
			if(check == 1) {
				result = "ok";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result = "failed";
		}
		
		return result;
	}
	
	@Override 
	@ResponseBody
	@RequestMapping(value = "/mypage/deleteStar.do", method = RequestMethod.POST)
	public String deleteStar(@RequestParam String star_cd, HttpServletRequest request, HttpServletResponse response) {
		
		String result = "";
		
		// 전달받은 star_cd
		System.out.println("star_cd : " + star_cd);
		
		try {
			// star__field_cd 찾아오기
			List<Integer> star_field_cd = new ArrayList<Integer>();
			star_field_cd = starInfoService.findStarFieldCd(star_cd);
			
			Map<String, List<Integer>> starFieldCdMap = new HashMap<String, List<Integer>>();
			starFieldCdMap.put("star_field_cd", star_field_cd);
			System.out.println("star_field_cd : " + star_field_cd);
			
			// 스타 프로필 제거
			starInfoService.deleteProfile(starFieldCdMap);
			
			// 스타 제거
			starInfoService.deleteStar(star_cd);
			
			result = "success";
			
		} catch (Exception e) {
			e.printStackTrace();
			result = "failed";
		}
		
		 
		return result;
	 }
	
}
