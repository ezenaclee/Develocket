package com.ezen.develocket.starField.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ezen.develocket.review.vo.ReviewVO;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.develocket.rocketInfo.service.RocketInfoService;
import com.ezen.develocket.rocketInfo.vo.RocketInfoVO;
import com.ezen.develocket.starField.service.StarFieldService;
import com.ezen.develocket.starField.vo.CareerImgVO;
import com.ezen.develocket.starField.vo.StarFieldVO;

@Controller("starFieldController")
public class StarFieldControllerImpl implements StarFieldController {

	@Autowired
	private StarFieldService starFieldService;
	@Autowired
	private RocketInfoService rocketInfoService;
	@Autowired
	private StarFieldVO starFieldVO;
	
	private static String STAR_FIELD_IMAGE_REPO = "C:\\develocket_repo\\starField";
	
	
	@Override
	@RequestMapping(value = "/starField/starFieldView.do", method = RequestMethod.GET)
	public ModelAndView starFieldView(@RequestParam(value = "star_field_cd", required = false) String star_field_cd,
									  HttpServletRequest request,
									  HttpServletResponse response) throws Exception {
		
		String viewName = (String) request.getAttribute("viewName");
		
		Map<String, Object> starFieldMap;
		String rocket_cd;
		
		HttpSession session = request.getSession();
		// 스타프로필에서 견적보내기 누를 때 비로그인상태의 경우 로그인 완료 후 이 조건으로 넘어옴
		if (session.getAttribute("star_field_cd") != null) {
		    String _star_field_cd = (String) session.getAttribute("star_field_cd");
		    starFieldMap = starFieldService.viewStarField(_star_field_cd);
		    rocket_cd = starFieldService.selectOwnerRocketCD(_star_field_cd);
		    
		    session.removeAttribute("star_field_cd");
		}
		// 위 경우를 제외한 일반적으로 starFieldVeiw.jsp로 이동하는 경우
		else {
		    starFieldMap = starFieldService.viewStarField(star_field_cd);
		    rocket_cd = starFieldService.selectOwnerRocketCD(star_field_cd);
		}

		List<ReviewVO> reviewVOList = (List<ReviewVO>) starFieldMap.get("reviewVOList");
		float total_score = 0;
		int count = 0;
		for (ReviewVO reviewVO : reviewVOList) {
			int score = Integer.parseInt(reviewVO.getRating());
			total_score += score;
			count++;
		}
		float result = total_score / count;
		String average_rating = String.format("%.1f", result);

		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("starFieldMap", starFieldMap);
		mav.addObject("rocket_cd", rocket_cd);
		mav.addObject("average_rating", average_rating);
		mav.addObject("count", count);

		StarFieldVO starFieldVO = (StarFieldVO) starFieldMap.get("starFieldVO");
		String qna = starFieldVO.getQna();
		if (qna != null) {
			String[] qna_list = qna.split("/");
			String qna1 = qna_list[0];
			String qna2 = qna_list[1];
			String qna3 = qna_list[2];
			String qna4 = qna_list[3];

			mav.addObject("qna1", qna1);
			mav.addObject("qna2", qna2);
			mav.addObject("qna3", qna3);
			mav.addObject("qna4", qna4);
		}
		else {
			mav.addObject("qna1", null);
			mav.addObject("qna2", null);
			mav.addObject("qna3", null);
			mav.addObject("qna4", null);
		}
		
		return mav;
	}
	
	@Override
	@RequestMapping(value = "/starField/starFieldModify.do", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView starFieldModify(@RequestParam(value = "star_field_cd", required = false) String star_field_cd,
										HttpServletRequest request, 
										HttpServletResponse response) throws Exception {
		
		String viewName = (String) request.getAttribute("viewName");

		Map<String, Object> starFieldMap = starFieldService.viewStarFieldModify(star_field_cd);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("starFieldMap", starFieldMap);

		HttpSession session = request.getSession();
		Map<String, String> starInfoMap = (Map<String, String>) session.getAttribute("starInfoMap");
		if (starInfoMap != null && !starInfoMap.isEmpty()) {
			String star_nickname = starInfoMap.get("star_nickname");
			String area = starInfoMap.get("area");
			String small_category = starInfoMap.get("small_category");

			session.removeAttribute("starInfoMap");
			mav.addObject("star_nickname", star_nickname);
			mav.addObject("area", area);
			mav.addObject("small_category", small_category);
		}


		StarFieldVO starFieldVO = (StarFieldVO) starFieldMap.get("starFieldVO");
		String qna = starFieldVO.getQna();
		if (qna != null) {
			String[] qna_list = qna.split("/");
			String qna1 = qna_list[0];
			String qna2 = qna_list[1];
			String qna3 = qna_list[2];
			String qna4 = qna_list[3];

			mav.addObject("qna1", qna1);
			mav.addObject("qna2", qna2);
			mav.addObject("qna3", qna3);
			mav.addObject("qna4", qna4);
		}
		else {
			mav.addObject("qna1", null);
			mav.addObject("qna2", null);
			mav.addObject("qna3", null);
			mav.addObject("qna4", null);
		}
		
		return mav;
	}

	
	@Override
	@RequestMapping(value = "/starField/joinStarField.do", method = RequestMethod.GET)
	public ResponseEntity joinStarField(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		RocketInfoVO rocketInfoVO = (RocketInfoVO) session.getAttribute("rocketInfoVO");
		String rocket_cd = rocketInfoVO.getRocket_cd();
		
		String star_cd = request.getParameter("star_cd");
		String cate_cd = request.getParameter("cate_cd");
		
		Map<String, String> starFieldMap = new HashMap<>();
		starFieldMap.put("star_cd", star_cd);
		starFieldMap.put("cate_cd", cate_cd);
		
		String message = "";
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-type", "text/html; charset=utf-8");
		
		try {
			String star_field_cd = starFieldService.joinStarField(starFieldMap);
			
			List<String> starFieldCDList = rocketInfoService.selectAllStarFieldCD(rocket_cd);
			session.setAttribute("starFieldCDList", starFieldCDList);
			
			message += "<script>";
			message += "location.href = '"+ request.getContextPath() + "/starField/starFieldModify.do?star_field_cd=" + star_field_cd + "';";
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
	@RequestMapping(value = "/starField/modifyStarField.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity modifyStarField(MultipartHttpServletRequest multipartRequest,
										  HttpServletResponse response) throws Exception {

		multipartRequest.setCharacterEncoding("UTF-8");
		String message = "";
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-type", "text/html; charset=utf-8");
		
		Map<String, Object> starFieldMap = new HashMap<>();
		
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			
			if (name.equals("career_img_cd")) {
				String[] values = multipartRequest.getParameterValues(name);
				
				System.out.println("!!컨트롤러 career_img_cd:" + values[0] );
				
				starFieldMap.put(name, values);
			}
			else if (name.equals("oldFileName")) {
				String[] values = multipartRequest.getParameterValues(name);
				
				System.out.println("!!컨트롤러 oldFileName:" + values[0] );
				
				starFieldMap.put(name, values);
			}
			else {	// 새로 추가된 부분과 남은 부분
				String value = multipartRequest.getParameter(name);
				starFieldMap.put(name, value);
			}
		}

		String star_field_cd = (String) starFieldMap.get("star_field_cd");
		File temp = new File(STAR_FIELD_IMAGE_REPO + "\\temp");
		// 수정한 이미지 파일을 업로드함
		Map<String, Object> imageFileMap = uploadModImageFile(multipartRequest);
		String error = (String) imageFileMap.get("error");
		if (error != null && !error.equals("")) {
			if (error.equals("on")) {
				try {
					File[] file_list = temp.listFiles();
					for (int i = 0; i < file_list.length; i++) {
						file_list[i].delete();
					}
 				}
				catch (Exception e) {
					e.printStackTrace();
				}

				message = "<script>";
				message += "alert('중복 이미지는 불가합니다. 다시 시도해주세요.');";
				message += "location.href = '"+ multipartRequest.getContextPath() + "/starField/starFieldModify.do?star_field_cd=" + star_field_cd + "';";
				message += "</script>";

				resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
				return  resEnt;
			}
		}


		String profile_img = (String) imageFileMap.get("profile_img");
		String old_profile_img = (String) starFieldMap.get("old_profile_img");
		if (profile_img.equals("")) {		// 수정할 이미지 없는 경우
			if (old_profile_img != null) {	// 기존 이미지가 있는 상태
				starFieldMap.put("profile_img", old_profile_img);
			}
			else {							// 기존 이미지가 없는 상태
				starFieldMap.put("profile_img", profile_img);
			}
		}
		else {								// 수정할 이미지 있는 경우
			starFieldMap.put("profile_img", profile_img);
		}
	
		String business_img = (String) imageFileMap.get("business_img");
		String old_business_img = (String) starFieldMap.get("old_business_img");
		if (business_img.equals("")) {
			if (old_business_img != null) {
				starFieldMap.put("business_img", old_business_img);
			}
			else {
				starFieldMap.put("business_img", business_img);
			}
		}
		else {
			starFieldMap.put("business_img", business_img);
		}
		
		
		List<String> fileList = (List<String>) imageFileMap.get("fileList");

		// 수정시 새로 추가된 이미지 수
		int added_img_num = Integer.parseInt((String) starFieldMap.get("added_img_num"));
		// 기존 이미지 수
		int pre_img_num = Integer.parseInt((String) starFieldMap.get("pre_img_num"));

		
		List<CareerImgVO> imageFileList = new ArrayList<>();
		List<CareerImgVO> modAddImageFileList = new ArrayList<>();
		
		if (fileList != null && fileList.size() != 0) {
			String[] career_img_cd = (String[]) starFieldMap.get("career_img_cd");

			
			for (int i = 0; i < added_img_num; i++) {
				String fileName = fileList.get(i);
				CareerImgVO careerImgVO = new CareerImgVO();

				if (fileName != null && !fileName.equals("")) {
					if (i < pre_img_num) {	// 기존의 이미지를 수정해서 첨부한 이미지는 imageFileList에 추가됨
						if (career_img_cd[i] != null) {
							careerImgVO.setImageFileName(fileName);
							careerImgVO.setCareer_img_cd(career_img_cd[i]);

							imageFileList.add(careerImgVO);
							starFieldMap.put("imageFileList", imageFileList);
						}
					}
					else {	// 새로 추가한 이미지는 modAddImageFileList에 추가됨
						careerImgVO.setImageFileName(fileName);
						modAddImageFileList.add(careerImgVO);
						starFieldMap.put("modAddImageFileList", modAddImageFileList);
					}
				}
			}
		}

		// 질문답변 4가지를 하나로 묶어서 starFieldMap에 넣음
		String qna1 = (String) starFieldMap.get("qna1");
		String qna2 = (String) starFieldMap.get("qna2");
		String qna3 = (String) starFieldMap.get("qna3");
		String qna4 = (String) starFieldMap.get("qna4");

		if (qna1 == null || qna1.equals("") || qna1.isEmpty()) {
			qna1 = "null";
		}
		if (qna2 == null || qna2.equals("") || qna2.isEmpty()) {
			qna2 = "null";
		}
		if (qna3 == null || qna3.equals("") || qna3.isEmpty()) {
			qna3 = "null";
		}
		if (qna4 == null || qna4.equals("") || qna4.isEmpty()) {
			qna4 = "null";
		}

		String qna = qna1 + "/" + qna2 + "/" + qna3 + "/" + qna4;

		starFieldMap.remove("qna1");
		starFieldMap.remove("qna2");
		starFieldMap.remove("qna3");
		starFieldMap.remove("qna4");
		starFieldMap.put("qna", qna);

		try {
			starFieldService.modifyStarField(starFieldMap);
			
			if (!profile_img.equals("")) {
				// 이동시킬 파일 선택
				File srcFile = new File(STAR_FIELD_IMAGE_REPO + "\\temp\\" + profile_img);
				// 이동시킬 위치
				File destDir = new File(STAR_FIELD_IMAGE_REPO + "\\" + star_field_cd);
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
				
				if (old_profile_img != null) {
					File oldFile = new File(STAR_FIELD_IMAGE_REPO + "\\" + star_field_cd + "\\" + old_profile_img);
					oldFile.delete();
				}
			}
			
			if (!business_img.equals("")) {
				// 이동시킬 파일 선택
				File srcFile = new File(STAR_FIELD_IMAGE_REPO + "\\temp\\" + business_img);
				// 이동시킬 위치
				File destDir = new File(STAR_FIELD_IMAGE_REPO + "\\" + star_field_cd);
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
				
				if (old_business_img != null) {
					File oldFile = new File(STAR_FIELD_IMAGE_REPO + "\\" + star_field_cd + "\\" + old_business_img);
					oldFile.delete();
				}
			}
			
			if (fileList != null && fileList.size() != 0) {	// 수정한 파일들들 차례대로 업로드함(temp폴더에서 이동시킴)
				for (int i = 0; i < fileList.size(); i++) {
					String fileName = fileList.get(i);
					
					if (i < pre_img_num) {
						if (fileName != null && !fileName.equals("")) {
							// 이동시킬 파일 선택
							File srcFile = new File(STAR_FIELD_IMAGE_REPO + "\\temp\\" + fileName);
							// 이동시킬 위치
							File destDir = new File(STAR_FIELD_IMAGE_REPO + "\\" + star_field_cd);
							FileUtils.moveFileToDirectory(srcFile, destDir, true);
							
							
							String[] oldNames = (String[]) starFieldMap.get("oldFileName");
							String oldFileName = oldNames[i];

							if (oldFileName != null) {
								File oldFile = new File(STAR_FIELD_IMAGE_REPO + "\\" + star_field_cd + "\\" + oldFileName);
								oldFile.delete();
							}
						}
					}
					else {
						if (fileName != null && !fileName.equals("")) {
							// 이동시킬 파일 선택
							File srcFile = new File(STAR_FIELD_IMAGE_REPO + "\\temp\\" + fileName);
							// 이동시킬 위치
							File destDir = new File(STAR_FIELD_IMAGE_REPO + "\\" + star_field_cd);
							FileUtils.moveFileToDirectory(srcFile, destDir, true);
						}
					}
				}
			}
			
			message += "<script>";
			message += "alert('수정을 완료했습니다.');";
			message += "location.href = '"+ multipartRequest.getContextPath() + "/starField/starFieldView.do?star_field_cd=" + star_field_cd + "';";
			message += "</script>"; 
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
		} catch (Exception e) {

			File[] file_list = temp.listFiles();
			for (int i = 0; i < file_list.length; i++) {
				file_list[i].delete();
			}

			e.printStackTrace();
			
			message = "<script>";
			message += "alert('오류가 발생했습니다.');";
			message += "location.href = '"+ multipartRequest.getContextPath() + "/starField/starFieldView.do?star_field_cd=" + star_field_cd + "';";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		
		return resEnt;
	}
	
	// 수정시 다중 이미지 업로드하기
	private Map<String, Object> uploadModImageFile(MultipartHttpServletRequest multipartRequest) throws Exception {
		
		Map<String, Object> imageFileMap = new HashMap<>();
		List<String> fileList = new ArrayList<>();
		
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			
			if (originalFileName != "" && originalFileName != null) {
				if (fileName.equals("profile_img")) {
					imageFileMap.put("profile_img", originalFileName);
					System.out.println("!!profile_img1: " + originalFileName);
				}
				else if (fileName.equals("business_img")) {
					imageFileMap.put("business_img", originalFileName);
					System.out.println("!!business_img1: " + originalFileName);
				}
				else {
					fileList.add(originalFileName);
					System.out.println("!!이미지 파일 이름1: " + originalFileName);
				}


				File file = new File(STAR_FIELD_IMAGE_REPO + "\\" + fileName);
				if (mFile.getSize() != 0) {	// File Null Check
					if (!file.exists()) {	// 경로상에 존재하지 않는 경우
						file.getParentFile().mkdirs();	// 경로에 해당하는 디렉토리를 생성

						File duplicate_check = new File(STAR_FIELD_IMAGE_REPO + "\\temp\\" + originalFileName);
						if  (duplicate_check.exists()) {
							imageFileMap.put("error", "on");
						}

						// 임시 폴더로 mFile 이동
						mFile.transferTo(duplicate_check);
					}
				}

			}
			else {	// 첨부한 이미지가 없는 경우
				if (fileName.equals("profile_img")) {
					imageFileMap.put("profile_img", "");
					System.out.println("!!profile_img2: " + originalFileName);
				}
				else if (fileName.equals("business_img")) {
					imageFileMap.put("business_img", "");
					System.out.println("!!business_img2: " + originalFileName);
				}
				else {
					fileList.add("");
					System.out.println("!!이미지 파일 이름2: " + originalFileName);
				}
				

			}
			
			
		}
		
		imageFileMap.put("fileList", fileList);
		
		return imageFileMap;
	}

	@Override
	public ResponseEntity removeStarField(@RequestParam(value = "star_field_cd", required = false) String star_field_cd,
										  HttpServletRequest request,
										  HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@RequestMapping(value = "/starField/removeModImage.do", method = {RequestMethod.POST, RequestMethod.GET})
	public void removeModImage(HttpServletRequest request,
							   HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		try {
			String career_img_cd = request.getParameter("career_img_cd");
			String star_field_cd = request.getParameter("star_field_cd");
			String imageFileName = request.getParameter("imageFileName");
			
			CareerImgVO careerImgVO = new CareerImgVO();
			careerImgVO.setStar_field_cd(star_field_cd);
			careerImgVO.setCareer_img_cd(career_img_cd);
			
			starFieldService.removeModImage(careerImgVO);
			
			if (imageFileName != null) {
				
				File removeFile = new File(STAR_FIELD_IMAGE_REPO + "\\" + star_field_cd + "\\" + imageFileName);
				removeFile.delete();
			}
			
			out.print("success");
			
		} catch (Exception e) {
			out.print("fail");
			e.printStackTrace();
		}
	}

	@Override
	@RequestMapping(value = "/starField/removeExistImage.do", method = {RequestMethod.POST, RequestMethod.GET})
	public void removeExistImage(@RequestParam(value = "star_field_cd", required = false) String star_field_cd,
								 @RequestParam(value = "image", required = false) String image,
								 @RequestParam(value = "item", required = false) String item,
								 HttpServletRequest request,
								 HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		String profile_img = null;

		try {
			if (item.equals("profile")) {
				starFieldService.removeExistImage(star_field_cd, "profile");

				profile_img = image;
				if (profile_img != null) {

					File removeFile = new File(STAR_FIELD_IMAGE_REPO + "\\" + star_field_cd + "\\" + profile_img);
					removeFile.delete();
				}
			}
			else if (item.equals("business")) {
				starFieldService.removeExistImage(star_field_cd, "business");

				profile_img = image;
				if (profile_img != null) {

					File removeFile = new File(STAR_FIELD_IMAGE_REPO + "\\" + star_field_cd + "\\" + profile_img);
					removeFile.delete();
				}
			}

			out.print("success");

		} catch (Exception e) {
			out.print("fail");
			e.printStackTrace();
		}

	}
	
	@Override 
	@ResponseBody
	@RequestMapping(value = "/starField/deleteProfile.do", method = RequestMethod.POST)
	public String deleteProfile(@RequestParam int star_field_cd, HttpServletRequest request, HttpServletResponse response) {
		
		String result = "";
		
		System.out.println("star_field_cd : " + star_field_cd);
		
		try {
			// 스타 프로필 제거
			starFieldService.deleteProfile(star_field_cd);
			result = "success";
			
		} catch (Exception e) {
			e.printStackTrace();
			result = "failed";
		}

		return result;
	 }

}
