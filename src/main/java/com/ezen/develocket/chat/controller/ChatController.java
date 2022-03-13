package com.ezen.develocket.chat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface ChatController {

	public ModelAndView moveChatList(@RequestParam(value = "isStarChat", required = false, defaultValue = "no") String isStarChat,
									 HttpServletRequest request,
									 HttpServletResponse response) throws Exception;
	
	public ModelAndView openChattingRoom(@RequestParam(value = "contract_cd", required = false) String contract_cd,
										 @RequestParam(value = "user_cd", required = false) String user_cd,
										 @RequestParam(value = "view_check", required = false) String view_check,
										 @RequestParam(value = "isStarChat", required = false) String isStarChat,
										 HttpServletRequest request,
										 HttpServletResponse response) throws Exception;
	
	public void saveChattingMessage(@RequestParam(value = "contract_cd", required = false) String contract_cd,
									@RequestParam(value = "user_cd", required = false) String user_cd,
									@RequestParam(value = "message", required = false) String message,
									HttpServletRequest request,
									HttpServletResponse response) throws Exception;
	
	public void requestReview(@RequestParam(value = "contract_cd", required = false) String contract_cd,
							  @RequestParam(value = "message", required = false) String message,
							  HttpServletRequest request,
							  HttpServletResponse response) throws Exception;

	public ResponseEntity endContract(@RequestParam(value = "contract_cd", required = false) String contract_cd,
									  HttpServletRequest request,
									  HttpServletResponse response) throws Exception;

	public void readAll(@RequestParam(value = "isStar", required = false) String isStar,
						HttpServletRequest request,
						HttpServletResponse response) throws Exception;
}
