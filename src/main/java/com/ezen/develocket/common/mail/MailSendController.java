package com.ezen.develocket.common.mail;

import java.io.PrintWriter;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@EnableAsync /*@EnableAsync를 지정해서 메서드 호출할 경우 => 비동기로 동작하게 하는 @Async 애너테이션 기능 사용 가능*/
public class MailSendController {

	//mail-context.xml에서 설정한 빈을 자동으로 주입함
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value = "/email/mailCheck", method = RequestMethod.POST) 
	@ResponseBody 
	public String mailCheck(@RequestParam("email") String email) throws Exception{ 
		int serti = (int)((Math.random()* (99999 - 10000 + 1)) + 10000); 
		String from = "develocket@naver.com";
		System.out.println("email:!!!!!!! "+ email);
		//보내는 이 메일주소 
		String to = email; 
		String title = "회원가입시 필요한 인증번호 입니다."; 
		String content = "[인증번호] "+ serti +" 입니다. <br/> 인증번호 확인란에 기입해주십시오."; 
		String num = ""; 
		try { 
			MimeMessage mail = mailSender.createMimeMessage(); 
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8"); 
			mailHelper.setFrom(from); 
			mailHelper.setTo(to); 
			mailHelper.setSubject(title); 
			mailHelper.setText(content, true); 
			mailSender.send(mail); 
			num = Integer.toString(serti); 
		} catch(Exception e) { 
			num = "error";
		 } 
		return num; 
	}

	@ResponseBody
	@RequestMapping(value = "/email/send_id", method = {RequestMethod.GET, RequestMethod.POST}) 
	public ModelAndView send_id(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		String email = (String) session.getAttribute("email");
		String status = "";
	
		System.out.println("메일 컨트롤러에서 받아온 email 값 : " + email);
		System.out.println("메일 컨트롤러에서 받아온 id 값 : " + id);
		
	    try { 
	    	if(id != null) {
	    		int half = id.length() / 2;
	    	    String pront = id.substring(0, half);
	    	    String send_id = pront;
	    	    for (int i = 0; i < id.length() - half; i++) {
	    	        send_id += "*";
	    	    }
	    	    
	    	    String from = "develocket@naver.com";
	    		//보내는 이메일주소 
	    		String to = email; 
	    		String title = "[디벨로켓] 아이디입니다."; 
	    		String content = "아이디는 "+ send_id +" 입니다.";
	    		
	    		MimeMessage mail = mailSender.createMimeMessage(); 
				MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8"); 
				mailHelper.setFrom(from); 
				mailHelper.setTo(to); 
				mailHelper.setSubject(title); 
				mailHelper.setText(content, true); 
				mailSender.send(mail); 
				
				session.invalidate();
				System.out.println("세션 초기화");
				mav.setViewName("redirect:/rocketInfo/searchIDPasswordForm.do");
				
			} else {
				status = "null";
				session.invalidate();
				System.out.println("세션 초기화");
				mav.setViewName("redirect:/rocketInfo/searchIDPasswordForm.do");
			}
			
			
		} catch(Exception e) { 
			e.printStackTrace();
		}
	    
		return mav; 
	}
	
	@ResponseBody
	@RequestMapping(value = "/email/send_pwd", method = {RequestMethod.GET, RequestMethod.POST}) 
	public ModelAndView send_pwd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		String password = (String) session.getAttribute("password");
		String email = (String) session.getAttribute("email");
	
		System.out.println("메일 컨트롤러에서 받아온 email 값 : " + email);
		System.out.println("메일 컨트롤러에서 받아온 password 값 : " + password);
		
	    try { 
	    	    
    	    String from = "develocket@naver.com";
    		//보내는 이메일주소 
    		String to = email; 
    		String title = "[디벨로켓] 임시 비밀번호"; 
    		String content = "임시 비밀번호는 " + password + "입니다. <br> 해당 비밀번호로 로그인 후 비밀번호를 변경해주시기 바랍니다.";
    		
    		MimeMessage mail = mailSender.createMimeMessage(); 
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8"); 
			mailHelper.setFrom(from); 
			mailHelper.setTo(to); 
			mailHelper.setSubject(title); 
			mailHelper.setText(content, true); 
			mailSender.send(mail); 
			
			session.invalidate();
			System.out.println("세션 초기화");
			mav.setViewName("redirect:/rocketInfo/searchIDPasswordForm.do");
			
			
		} catch(Exception e) { 
			e.printStackTrace();
			session.invalidate();
			System.out.println("세션 초기화");
			mav.setViewName("redirect:/rocketInfo/searchIDPasswordForm.do");
		}
	     
		return mav; 
	}

}

