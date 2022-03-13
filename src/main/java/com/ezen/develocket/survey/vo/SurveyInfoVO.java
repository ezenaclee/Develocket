package com.ezen.develocket.survey.vo;

import org.springframework.stereotype.Component;

@Component("surveyInfoVO")
public class SurveyInfoVO {

	private String survey_cd;
	private String level_a;
	private String period_a;
	private String times_a;
	private String add_comments_a;
	private String contract_cd;

	public SurveyInfoVO() {
		// TODO Auto-generated constructor stub
	}

	public String getSurvey_cd() {
		return survey_cd;
	}

	public void setSurvey_cd(String survey_cd) {
		this.survey_cd = survey_cd;
	}

	public String getLevel_a() {
		return level_a;
	}

	public void setLevel_a(String level_a) {
		this.level_a = level_a;
	}

	public String getPeriod_a() {
		return period_a;
	}

	public void setPeriod_a(String period_a) {
		this.period_a = period_a;
	}

	public String getTimes_a() {
		return times_a;
	}

	public void setTimes_a(String times_a) {
		this.times_a = times_a;
	}

	public String getAdd_comments_a() {
		return add_comments_a;
	}

	public void setAdd_comments_a(String add_comments_a) {
		this.add_comments_a = add_comments_a;
	}

	public String getContract_cd() {
		return contract_cd;
	}

	public void setContract_cd(String contract_cd) {
		this.contract_cd = contract_cd;
	}

}
