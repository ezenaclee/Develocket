package com.ezen.develocket.chat.controller;

import java.io.PrintWriter;
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

import com.ezen.develocket.chat.service.ChatService;
import com.ezen.develocket.chat.vo.ChatContentVO;
import com.ezen.develocket.chat.vo.ChatRoomVO;
import com.ezen.develocket.chat.vo.RocketChatVO;
import com.ezen.develocket.chat.vo.StarChatVO;
import com.ezen.develocket.request.service.RequestService;
import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;
import com.ezen.develocket.starInfo.service.StarInfoService;


@Controller("chatController")
public class ChatControllerImpl implements ChatController {

	@Autowired
	private ChatService chatService;
	@Autowired
	private StarInfoService starInfoService;
	@Autowired
	private RequestService requestService;
	

	@Override
	@RequestMapping(value = "/chat/chatList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView moveChatList(@RequestParam(value = "isStarChat", required = false , defaultValue = "no") String isStarChat,
									 HttpServletRequest request, 
									 HttpServletResponse response) throws Exception {

		String viewName = (String) request.getAttribute("viewName");
		
		HttpSession session = request.getSession();
		RocketInfoVO rocketInfoVO = (RocketInfoVO) session.getAttribute("rocketInfoVO");
		String rocket_cd = rocketInfoVO.getRocket_cd();
		String star_cd = starInfoService.matchStarCD(rocket_cd);
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("rocket_cd", rocket_cd);
		mav.addObject("star_cd", star_cd);

		System.out.println("!!isStarChat = " + isStarChat);
		System.out.println("!!rocket_cd = " + rocket_cd);
		System.out.println("!!star_cd = " + star_cd);
		
		
		if (isStarChat.equals("no")) {	// 본인이 로켓인 상태의 채팅리스트
			List<RocketChatVO> rocketChatVOList = chatService.selectAllRocketChatList(rocket_cd);
			System.out.println("!!rocketChatVOList = " + rocketChatVOList.toString());

			String view_check_all_rocket = "1";
			for (RocketChatVO vo : rocketChatVOList) {
				if (vo != null) {
					if (vo.getView_check().equals("0") && vo.getStatus_info().equals("3")) {
						view_check_all_rocket = "0";
						break;
					}
				}
			}

			mav.addObject("rocketChatVOList", rocketChatVOList);
			mav.addObject("isStarChat", isStarChat);
			mav.addObject("view_check_all_rocket", view_check_all_rocket);
		}
		else {							// 본인이 스타인 상태의 채팅리스트
			List<StarChatVO> starChatVOList = chatService.selectAllStarChatList(star_cd);
			System.out.println("!!starChatVOList = " + starChatVOList.toString());

			String view_check_all_star = "1";
			for (StarChatVO vo : starChatVOList) {
				if (vo != null) {
					if (vo.getView_check().equals("0") && vo.getStatus_info().equals("3")) {
						view_check_all_star = "0";
						break;
					}
				}
			}
			
			mav.addObject("starChatVOList", starChatVOList);
			mav.addObject("isStarChat", isStarChat);
			mav.addObject("view_check_all_star", view_check_all_star);
		}
		
		return mav;
	}

	@Override
	@RequestMapping(value = "/chat/chatRoom.do", method = RequestMethod.GET)
	public ModelAndView openChattingRoom(@RequestParam(value = "contract_cd", required = false) String contract_cd,
			 							 @RequestParam(value = "user_cd", required = false) String user_cd,
			 							 @RequestParam(value = "view_check", required = false) String view_check,
			 							 @RequestParam(value = "isStarChat", required = false) String isStarChat,
			 							 HttpServletRequest request, 
			 							 HttpServletResponse response) throws Exception {		
		
		Map<String, String> viewCheckMap = new HashMap<>();
		viewCheckMap.put("contract_cd", contract_cd);
		
		if (view_check.equals("1")) {

		}
		else {
			if (isStarChat.equals("no")) {
				if (view_check.equals("0")) {
					viewCheckMap.put("view_check", "1r");
					chatService.updateViewCheck(viewCheckMap);
				}
				else if (view_check.equals("1s")) {
					viewCheckMap.put("view_check", "1");
					chatService.updateViewCheck(viewCheckMap);
				}
			}
			else {
				if (view_check.equals("0")) {
					viewCheckMap.put("view_check", "1s");
					chatService.updateViewCheck(viewCheckMap);
				}
				else if (view_check.equals("1r")) {
					viewCheckMap.put("view_check", "1");
					chatService.updateViewCheck(viewCheckMap);
				}
			}
		}
		
		
		List<ChatContentVO> chatContentVOList = chatService.selectChattingData(contract_cd);
		ChatRoomVO chatRoomVO = chatService.selectChatRoomVO(contract_cd);
		
		System.out.println("!!user_cd = " + user_cd);
		
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("chatContentVOList", chatContentVOList);
		mav.addObject("chatRoomVO", chatRoomVO);
		// user_cd: 로그인한 사람의 로켓코드 or 스타코드
		mav.addObject("user_cd", user_cd);
		mav.addObject("contract_cd", contract_cd);
		
		return mav;
		
	}

	@Override
	@RequestMapping(value = "/chat/saveChattingMessage.do", method = RequestMethod.POST)
	public void saveChattingMessage(@RequestParam(value = "contract_cd", required = false) String contract_cd,
			 						@RequestParam(value = "user_cd", required = false) String user_cd,
			 						@RequestParam(value = "message", required = false) String message,
			 						HttpServletRequest request, 
			 						HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		System.out.println("!!메시지 저장 contract_cd = " + contract_cd);
		System.out.println("!!메시지 저장 user_cd = " + user_cd);
		
		ChatContentVO chatContentVO = new ChatContentVO();
		chatContentVO.setContract_cd(contract_cd);
		chatContentVO.setSender_id(user_cd);
		chatContentVO.setMessage(message);
		
		try {
			chatService.insertNewMessage(chatContentVO);
			
			out.print("success");
			
		} catch (Exception e) {
			out.print("fail");
			e.printStackTrace();
		}
		
	}

	@Override
	@RequestMapping(value = "/chat/requestReview.do", method = RequestMethod.POST)
	public void requestReview(@RequestParam(value = "contract_cd", required = false) String contract_cd, 
							  @RequestParam(value = "message", required = false) String message, 
							  HttpServletRequest request,
							  HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		ChatContentVO chatContentVO = new ChatContentVO();
		chatContentVO.setContract_cd(contract_cd);
		chatContentVO.setSender_id("review");
		chatContentVO.setMessage(message);
		
		try {
			chatService.insertNewMessage(chatContentVO);
			
			requestService.updateContract4(contract_cd);
			
			out.print("success");
			
		} catch (Exception e) {
			out.print("fiailed");
			e.printStackTrace();
		}
	}

	@Override
	@RequestMapping(value = "/chat/endContract.do", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity endContract(@RequestParam(value = "contract_cd", required = false) String contract_cd,
									  HttpServletRequest request,
									  HttpServletResponse response) throws Exception {

		String message = "";
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-type", "text/html; charset=utf-8");

		try {
			chatService.updateContract6(contract_cd);

			message = "<script>";
			message += "alert('거래가 종료되었습니다. 이용해주셔서 감사합니다.');";
			message += "opener.parent.location.reload();";
			message += "window.close();";
			message += "</script>";

			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		} catch (Exception e) {
			message = "<script>";
			message += "alert('오류가 발생했습니다. 다시 시도해주세요.');";
			message += "</script>";

			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

			e.printStackTrace();
		}

		return resEnt;
	}

	@Override
	@RequestMapping(value = "/chat/readAll.do", method = RequestMethod.POST)
	public void readAll(@RequestParam(value = "isStar", required = false) String isStar,
						HttpServletRequest request,
						HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		HttpSession session = request.getSession();
		RocketInfoVO rocketInfoVO = (RocketInfoVO) session.getAttribute("rocketInfoVO");
		String rocket_cd = rocketInfoVO.getRocket_cd();


		try {
			Map<String, String> viewCheckMap = new HashMap<>();

			if (isStar.equals("no")) {
				List<RocketChatVO> rocketChatVOList = chatService.selectAllRocketChatList(rocket_cd);

				for (RocketChatVO vo : rocketChatVOList) {
					if (vo != null) {
						if (vo.getView_check().equals("0") && vo.getStatus_info().equals("3")) {
							viewCheckMap.put("contract_cd", vo.getContract_cd());
							viewCheckMap.put("view_check", "1r");

							chatService.updateViewCheck(viewCheckMap);
						}
						else if (vo.getView_check().equals("1s") && vo.getStatus_info().equals("3")) {
							viewCheckMap.put("contract_cd", vo.getContract_cd());
							viewCheckMap.put("view_check", "1");

							chatService.updateViewCheck(viewCheckMap);
						}
					}
				}

			}
			else if (isStar.equals("yes")) {
				String star_cd = starInfoService.matchStarCD(rocket_cd);
				List<StarChatVO> starChatVOList = chatService.selectAllStarChatList(star_cd);

				for (StarChatVO vo : starChatVOList) {
					if (vo != null) {
						if (vo.getView_check().equals("0") && vo.getStatus_info().equals("3")) {
							viewCheckMap.put("contract_cd", vo.getContract_cd());
							viewCheckMap.put("view_check", "1s");

							chatService.updateViewCheck(viewCheckMap);

						}
						else if (vo.getView_check().equals("1r") && vo.getStatus_info().equals("3")) {
							viewCheckMap.put("contract_cd", vo.getContract_cd());
							viewCheckMap.put("view_check", "1");

							chatService.updateViewCheck(viewCheckMap);
						}
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
