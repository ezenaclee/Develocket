package com.ezen.develocket.common.category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.develocket.starField.service.StarFieldService;
import com.ezen.develocket.starField.vo.PreviewVO;
import com.ezen.develocket.starField.vo.StarLineUpVO;

@Controller
public class CategoryController {
	
	@Autowired
	private StarFieldService starFieldService;
	
	@RequestMapping(value = "/starcategory/*.do", method = RequestMethod.GET)
	public ModelAndView moveStarcategory(HttpServletRequest request) {
	
		String viewName = (String) request.getParameter("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		
		return mav;
	}
	
	// 헤더 검색창에서 카테고리 이동 + 상세분야창에서 카테고리 이동
	@RequestMapping(value = "/starcategory/starcategory_detail.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView starcategory(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		try {
			String cate_m = request.getParameter("cate_m");
			String cate_s = request.getParameter("cate_s");
			String cate = request.getParameter("cate");
			String area = request.getParameter("area");
			String lineup = request.getParameter("lineup");
			
			System.out.println("cate_m : " + cate_m);
			System.out.println("cate_s : " + cate_s);
			System.out.println("area : " + area);
			System.out.println("lineup : " + lineup);
			
			// 중간분야로 진입
			if(cate_m != null) {
				if(area != null && area != "") {
					Map<String, String> cateMap = new HashMap<>();
					cateMap.put("cate_m", cate_m);
					cateMap.put("area", area);
					
					List<PreviewVO> previewVOList = starFieldService.selectRandomStarMA(cateMap);

					mav.addObject("previewVOList", previewVOList);
					
					if(lineup != null) {
						cateMap.put("lineup", lineup);
						List<StarLineUpVO> starLineUpVOList = starFieldService.selectLineUpStarMA(cateMap);
						mav.addObject("starLineUpVOList", starLineUpVOList);
						
					} else {
						// 정렬 선택 안하면 리뷰순이 기본
						lineup = "review";
						cateMap.put("lineup", lineup);
						List<StarLineUpVO> starLineUpVOList = starFieldService.selectLineUpStarMA(cateMap);
						mav.addObject("starLineUpVOList", starLineUpVOList);
					}
					
					
				} else if(area == null || area == "") {
					// cate_m에 해당하는 스타 리스트 가져오기 (지역X)
					List<PreviewVO> previewVOList = starFieldService.selectRandomStarM(cate_m);
					mav.addObject("previewVOList", previewVOList);

					Map<String, String> cateMap = new HashMap<>();
					cateMap.put("cate_m", cate_m);
					
					if(lineup != null) {
						cateMap.put("lineup", lineup);
						List<StarLineUpVO> starLineUpVOList = starFieldService.selectLineUpStarM(cateMap);
						mav.addObject("starLineUpVOList", starLineUpVOList);
					} else {
						// 정렬 선택 안하면 리뷰순이 기본
						lineup = "review";
						cateMap.put("lineup", lineup);
						List<StarLineUpVO> starLineUpVOList = starFieldService.selectLineUpStarM(cateMap);
						mav.addObject("starLineUpVOList", starLineUpVOList);

						for (StarLineUpVO starLineUpVO : starLineUpVOList) {
							System.out.println("!!!!!!!!! = " + starLineUpVO.getStar_nickname());
							System.out.println("!!!!!!!!! = " + starLineUpVO.getCate_l());
							System.out.println("!!!!!!!!! = " + starLineUpVO.getCate_m());
						}
					}
				}
			
			// 상세분야로 진입
			} else if(cate_s != null){
				if(area != null) {
					Map<String, String> cateMap = new HashMap<>();
					cateMap.put("cate_s", cate_s);
					cateMap.put("area", area);
					List<PreviewVO> previewVOList = starFieldService.selectRandomStarSA(cateMap);
					mav.addObject("previewVOList", previewVOList);
					
					if(lineup != null) {
						cateMap.put("lineup", lineup);
						List<StarLineUpVO> starLineUpVOList = starFieldService.selectLineUpStarSA(cateMap);
						mav.addObject("starLineUpVOList", starLineUpVOList);
						
					} else {
						// 정렬 선택 안하면 리뷰순이 기본
						lineup = "review";
						cateMap.put("lineup", lineup);
						List<StarLineUpVO> starLineUpVOList = starFieldService.selectLineUpStarSA(cateMap);
						mav.addObject("starLineUpVOList", starLineUpVOList);
					}
					
				} else if(area == null || area == "") {
					// cate_s에 해당하는 스타 리스트 가져오기
					List<PreviewVO> previewVOList = starFieldService.selectRandomStarS(cate_s);
					mav.addObject("previewVOList", previewVOList);
					
					Map<String, String> cateMap = new HashMap<>();
					cateMap.put("cate_s", cate_s);
					
					if(lineup != null) {
						cateMap.put("lineup", lineup);
						List<StarLineUpVO> starLineUpVOList = starFieldService.selectLineUpStarS(cateMap);
						mav.addObject("starLineUpVOList", starLineUpVOList);
						
						
					} else {
						// 정렬 선택 안하면 리뷰순이 기본
						lineup = "review";
						cateMap.put("lineup", lineup);
						List<StarLineUpVO> starLineUpVOList = starFieldService.selectLineUpStarS(cateMap);
						mav.addObject("starLineUpVOList", starLineUpVOList);
					}
				}

			}
			
			// 헤더에 있는 검색창에서 이동
			if(cate != null) {
				List<PreviewVO> previewVOList = starFieldService.selectRandomStarS(cate);
				mav.addObject("previewVOList", previewVOList);
				
				Map<String, String> cateMap = new HashMap<>();
				cateMap.put("cate_s", cate);
				
				// 정렬 선택 안하면 리뷰순이 기본
				lineup = "review";
				cateMap.put("lineup", lineup);
				List<StarLineUpVO> starLineUpVOList = starFieldService.selectLineUpStarS(cateMap);
				mav.addObject("starLineUpVOList", starLineUpVOList);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	
}
