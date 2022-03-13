package com.ezen.develocket.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller("fileDownloadController")
public class FileDownloadController {
	
	private static final String CURR_IMAGE_REPO_PATH = "C:\\develocket_repo\\inquiry";
	private static final String STAR_FIELD_IMAGE_REPO = "C:\\develocket_repo\\starField";
	private static final String ROCKET_INFO_IMAGE_REPO = "C:\\develocket_repo\\rocketInfo";

	// @RequestParam 다운로드될 이미지 파일 이름을 전달함
	@RequestMapping(value = "/download.do", method = RequestMethod.GET)
	public void download(@RequestParam("imageFileName") String imageFileName,
						 @RequestParam("inquiry_cd") String inquiry_cd,
						 HttpServletRequest request,
						 HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		OutputStream out = response.getOutputStream();
		
		// 글번호와 파일 이름으로 다운로드할 파일 경로를 설정함
		String downFilePath = CURR_IMAGE_REPO_PATH + "\\" + inquiry_cd + "\\" + imageFileName;
 		
		// 다운로드될 파일 객체 생성
		File file = new File(downFilePath);
		
		// 다운로드를 위한 기본 설정들
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName=" + imageFileName);
		
		FileInputStream in = new FileInputStream(file);
		byte[] buffer = new byte[1024 * 8]; // 8키로바이트
		// 버퍼를 이용해 한번에 8kbyte씩 브라우저로 전송함
		while(true) {
			// 파일을 모두 읽어들이면 -1이 됨
			int count = in.read(buffer);
			if (count == -1) break;
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}
	
	// @RequestParam 다운로드될 이미지 파일 이름을 전달함
	@RequestMapping(value = "/starField/download.do", method = RequestMethod.GET)
	public void downloadStarField(@RequestParam("imageFileName") String imageFileName,
								  @RequestParam("star_field_cd") String star_field_cd,
								  HttpServletRequest request,
								  HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");

		OutputStream out = response.getOutputStream();

		// 글번호와 파일 이름으로 다운로드할 파일 경로를 설정함
		String downFilePath = STAR_FIELD_IMAGE_REPO + "\\" + star_field_cd + "\\" + imageFileName;

		// 다운로드될 파일 객체 생성
		File file = new File(downFilePath);

		// 다운로드를 위한 기본 설정들
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName=" + imageFileName);

		FileInputStream in = new FileInputStream(file);
		byte[] buffer = new byte[1024 * 8]; // 8키로바이트
		// 버퍼를 이용해 한번에 8kbyte씩 브라우저로 전송함
		while(true) {
			// 파일을 모두 읽어들이면 -1이 됨
			int count = in.read(buffer);
			if (count == -1) break;
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}

	@RequestMapping(value = "/rocketInfo/download.do", method = RequestMethod.GET)
	public void downloadRocketInfo(@RequestParam("imageFileName") String imageFileName,
								  @RequestParam("rocket_cd") String rocket_cd,
								  HttpServletRequest request,
								  HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");

		OutputStream out = response.getOutputStream();

		// 글번호와 파일 이름으로 다운로드할 파일 경로를 설정함
		String downFilePath = ROCKET_INFO_IMAGE_REPO + "\\" + rocket_cd + "\\" + imageFileName;

		// 다운로드될 파일 객체 생성
		File file = new File(downFilePath);

		// 다운로드를 위한 기본 설정들
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName=" + imageFileName);

		FileInputStream in = new FileInputStream(file);
		byte[] buffer = new byte[1024 * 8]; // 8키로바이트
		// 버퍼를 이용해 한번에 8kbyte씩 브라우저로 전송함
		while(true) {
			// 파일을 모두 읽어들이면 -1이 됨
			int count = in.read(buffer);
			if (count == -1) break;
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}

}
