package com.ezen.develocket.request.controller;

import java.io.PrintWriter;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.develocket.chat.service.ChatService;
import com.ezen.develocket.chat.vo.ChatContentVO;
import com.ezen.develocket.request.service.RequestService;
import com.ezen.develocket.request.vo.EstimateVO;
import com.ezen.develocket.request.vo.PopupRequestVO;
import com.ezen.develocket.request.vo.ReceiveEstimateVO;
import com.ezen.develocket.request.vo.ReceiveRequestVO;
import com.ezen.develocket.request.vo.RequestVO;
import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;
import com.ezen.develocket.starInfo.service.StarInfoService;
import com.ezen.develocket.survey.vo.SurveyInfoVO;

@Controller("requestController")
public class RequestControllerImpl implements RequestController {

	@Autowired
	private RequestService requestService;
	@Autowired
	private StarInfoService starInfoService;
	@Autowired
	private ChatService chatService;
	
	
	// 받은 견적
	@Override
	@RequestMapping(value = "/request/receiveEstimateList.do", method = RequestMethod.GET)
	public ModelAndView moveReceiveEstimateList(HttpServletRequest request, 
												HttpServletResponse response) throws Exception {
		
		String viewName = (String) request.getAttribute("viewName");
		
		HttpSession session = request.getSession();
		RocketInfoVO rocketInfoVO = (RocketInfoVO) session.getAttribute("rocketInfoVO");
		String rocket_cd = rocketInfoVO.getRocket_cd();
		
		List<ReceiveEstimateVO> receiveEstimateVOList = requestService.selectAllEstimate(rocket_cd);

		String view_check_all = "1";
		for (ReceiveEstimateVO vo : receiveEstimateVOList) {
			if (vo.getView_check().equals("0") && vo.getStatus_info().equals("2")) {
				view_check_all = "0";
				break;
			}
		}
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("receiveEstimateVOList", receiveEstimateVOList);
		mav.addObject("view_check_all", view_check_all);
		
		return mav;
	}
	
	@Override
	@RequestMapping(value = "/request/receiveEstimate.do", method = RequestMethod.GET)
	public ModelAndView moveReceiveEstimate(@RequestParam(value = "contract_cd", required = false) String contract_cd,
			   								@RequestParam(value = "status_info", required = false) String status_info,
			   								@RequestParam(value = "view_check", required = false) String view_check,
			   								HttpServletRequest request,
			   								HttpServletResponse response) throws Exception {

		// 처음 보는 요청서면 view_check를 '1'로 수정
		if (view_check.equals("0")) {
			requestService.updateViewCheck(contract_cd);
		}
		
		EstimateVO estimateVO = requestService.selectOneEstimate(contract_cd);
		
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("estimateVO", estimateVO);
		
		
		return mav;
		
	}
	
	// 받은 요청
	@Override
	@RequestMapping(value = "/request/receiveRequestList.do", method = RequestMethod.GET)
	public ModelAndView moveReceiveRequestList(HttpServletRequest request, 
											   HttpServletResponse response) throws Exception {

		String viewName = (String) request.getAttribute("viewName");
		
		HttpSession session = request.getSession();
		RocketInfoVO rocketInfoVO = (RocketInfoVO) session.getAttribute("rocketInfoVO");
		String rocket_cd = rocketInfoVO.getRocket_cd();
		 
		String star_cd = starInfoService.matchStarCD(rocket_cd);
		
		List<ReceiveRequestVO> receiveRequestVOList = new ArrayList<>();
		
		if (star_cd.equals("0")) {
			receiveRequestVOList = null;
		}
		else {
			receiveRequestVOList = requestService.selectAllRequest(star_cd);
		}

		String view_check_all = "1";
		if (receiveRequestVOList != null) {
			for (ReceiveRequestVO vo : receiveRequestVOList) {
				if (vo.getView_check().equals("0") && vo.getStatus_info().equals("1")) {
					view_check_all = "0";
					break;
				}
			}
		}
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("star_cd", star_cd);
		mav.addObject("receiveRequestVOList", receiveRequestVOList);
		mav.addObject("view_check_all", view_check_all);
		
		return mav;
	}


	@Override
	@RequestMapping(value = "/request/receiveRequest.do", method = RequestMethod.GET)
	public ModelAndView moveReceiveRequest(@RequestParam(value = "contract_cd", required = false) String contract_cd,
										   @RequestParam(value = "status_info", required = false) String status_info,
										   @RequestParam(value = "view_check", required = false) String view_check,
										   HttpServletRequest request, 
										   HttpServletResponse response) throws Exception {

		// 처음 보는 요청서면 view_check를 '1'로 수정
		if (view_check.equals("0")) {
			requestService.updateViewCheck(contract_cd);
		}
		
		PopupRequestVO popupRequestVO = requestService.selectOnePopupReqeust(contract_cd);
		
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("popupRequestVO", popupRequestVO);
		
		if (!status_info.equals("1")) {
			RequestVO requestVO = requestService.selectOneRequestVO(contract_cd);
			
			mav.addObject("requestVO", requestVO);
		}
		
		return mav;
	}


	@Override
	@RequestMapping(value = "/request/agreeRequest.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity agreeRequest(@ModelAttribute(value = "requestVO") RequestVO requestVO,
									   @RequestParam(value = "contract_cd", required = false) String contract_cd,
									   HttpServletRequest request, 
									   HttpServletResponse response) throws Exception {

		String message = "";
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-type", "text/html; charset=utf-8");
		
		System.out.println("!!requestVO = " + requestVO);
		
		try {
			// requestVO를 입력받은 값으로 수정함
			requestService.updateRequest(requestVO);
			// status_info와 date2를 갱신, view_check는 '0'으로
			requestService.updateContract2(contract_cd);
			
			
			message = "<script>";
			message += "alert('로켓에게 견적을 전송하였습니다.');";
			message += "opener.parent.location.reload();";
			message += "window.close();";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
		} catch (Exception e) {
			message = "<script>";
			message += "alert('오류가 발생했습니다. 다시 시도해주세요.');";
			message += "opener.parent.location.reload();";
			message += "window.close();";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
			e.printStackTrace();
		}

		return resEnt;
	}

	@Override
	@RequestMapping(value = "/request/agreeEstimate.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity agreeEstimate(@RequestParam(value = "contract_cd", required = false) String contract_cd, 
									    HttpServletRequest request, 
									    HttpServletResponse response) throws Exception {

		String message = "";
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-type", "text/html; charset=utf-8");
		
		ChatContentVO chatContentVO = new ChatContentVO();
		chatContentVO.setChat_sn("1");
		chatContentVO.setSender_id("admin");
		chatContentVO.setMessage("채팅방이 활성화되었습니다!");
		chatContentVO.setContract_cd(contract_cd);
		
		
		try {
			requestService.updateContract3(contract_cd);
			
			// 채팅방 활성화
			chatService.insertNewChatContent(chatContentVO);
			
			message = "<script>";
			message += "alert('계약이 성립되었습니다. 채팅방이 활성화됩니다.');";
			message += "opener.parent.location.reload();";
			message += "window.close();";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		} catch (Exception e) {
			message = "<script>";
			message += "alert('오류가 발생했습니다. 다시 시도해주세요.');";
			message += "opener.parent.location.reload();";
			message += "window.close();";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
			e.printStackTrace();
		}
		
		return resEnt;
	}

	@Override
	@RequestMapping(value = "/request/refuseContract.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity refuseContract(@RequestParam(value = "contract_cd", required = false) String contract_cd, 
										 HttpServletRequest request, 
										 HttpServletResponse response) throws Exception {

		String message = "";
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-type", "text/html; charset=utf-8");
		
		try {
			requestService.updateRefuseContract(contract_cd);
			
			message = "<script>";
			message += "alert('거절을 완료했습니다.');";
			message += "opener.parent.location.reload();";
			message += "window.close();";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		} catch (Exception e) {
			message = "<script>";
			message += "alert('오류가 발생했습니다. 다시 시도해주세요.');";
			message += "opener.parent.location.reload();";
			message += "window.close();";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
			e.printStackTrace();
		}
		
		return resEnt;
	}

	@Override
	@RequestMapping(value = "/request/makeInvisibleRefuse.do", method = RequestMethod.POST)
	public void makeInvisibleRefuse(@RequestParam(value = "contract_cd", required = false) String contract_cd,
							  @RequestParam(value = "status_info", required = false) String status_info, 
							  HttpServletRequest request, 
							  HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		Map<String, String> contractMap = new HashMap<>();
		contractMap.put("contract_cd", contract_cd);
		contractMap.put("status_info", status_info);
		
		try {
			requestService.updateInvisibleContract(contractMap);

			out.print("success");
			
		} catch (Exception e) {
			out.print("fail");
			e.printStackTrace();
		}
	}

	@Override
	@RequestMapping(value = "/request/makeInvisibleEnd.do", method = RequestMethod.POST)
	public void makeInvisibleEnd(@RequestParam(value = "contract_cd", required = false) String contract_cd,
								 @RequestParam(value = "hide_check", required = false) String hide_check,
								 HttpServletRequest request,
								 HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		Map<String, String> hideCheckMap = new HashMap<>();
		hideCheckMap.put("contract_cd", contract_cd);
		hideCheckMap.put("hide_check", hide_check);

		try {
			requestService.updateHideCheck(hideCheckMap);

			out.print("success");

		} catch (Exception e) {
			out.print("fail");
			e.printStackTrace();
		}
	}

	@Override
	@RequestMapping(value = "/request/readAll.do", method = RequestMethod.POST)
	public void readAll(@RequestParam(value = "star_cd", required = false) String star_cd,
						HttpServletRequest request,
						HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		HttpSession session = request.getSession();
		RocketInfoVO rocketInfoVO = (RocketInfoVO) session.getAttribute("rocketInfoVO");
		String rocket_cd = rocketInfoVO.getRocket_cd();

		try {
			if (star_cd.equals("r")) {
				List<ReceiveEstimateVO> receiveEstimateVOList = requestService.selectAllEstimate(rocket_cd);

				for (ReceiveEstimateVO vo : receiveEstimateVOList) {
					if (vo.getView_check().equals("0") && vo.getStatus_info().equals("2")) {
						String contract_cd = vo.getContract_cd();
						requestService.updateViewCheck(contract_cd);
					}
				}
			}
			else if (!star_cd.equals("0")) {
				List<ReceiveRequestVO> receiveRequestVOList = requestService.selectAllRequest(star_cd);

				for (ReceiveRequestVO vo : receiveRequestVOList) {
					if (vo.getView_check().equals("0") && vo.getStatus_info().equals("1")) {
						String contract_cd = vo.getContract_cd();
						requestService.updateViewCheck(contract_cd);
					}
				}
			}
			out.print("success");

		} catch (Exception e) {
			out.print("fail");
			e.printStackTrace();
		}
	}

}
