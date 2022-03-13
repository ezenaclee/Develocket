package com.ezen.develocket.request.vo;

import org.springframework.stereotype.Component;

@Component("requestVO")
public class RequestVO {

	private String request_cd;
	private String price;
	private String estimate_comments;
	private String survey_cd;

	public RequestVO() {
		// TODO Auto-generated constructor stub
	}

	public String getRequest_cd() {
		return request_cd;
	}

	public void setRequest_cd(String request_cd) {
		this.request_cd = request_cd;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getEstimate_comments() {
		return estimate_comments;
	}

	public void setEstimate_comments(String estimate_comments) {
		this.estimate_comments = estimate_comments;
	}

	public String getSurvey_cd() {
		return survey_cd;
	}

	public void setSurvey_cd(String survey_cd) {
		this.survey_cd = survey_cd;
	}

}
