package com.ezen.develocket.request.vo;

import org.springframework.stereotype.Component;

@Component("popupRequestVO")
public class PopupRequestVO {

	private String cate_cd;
	private String cate_l;
	private String cate_m;
	private String cate_s;
	private String rocket_cd;
	private String profile_img;
	private String name;
	private String survey_cd;
	private String level_a;
	private String period_a;
	private String times_a;
	private String add_comments_a;
	private String contract_cd;
	private String status_info;

	public PopupRequestVO() {
		// TODO Auto-generated constructor stub
	}

	public String getCate_cd() {
		return cate_cd;
	}

	public void setCate_cd(String cate_cd) {
		this.cate_cd = cate_cd;
	}

	public String getCate_l() {
		return cate_l;
	}

	public void setCate_l(String cate_l) {
		this.cate_l = cate_l;
	}

	public String getCate_m() {
		return cate_m;
	}

	public void setCate_m(String cate_m) {
		this.cate_m = cate_m;
	}

	public String getCate_s() {
		return cate_s;
	}

	public void setCate_s(String cate_s) {
		this.cate_s = cate_s;
	}

	public String getRocket_cd() {
		return rocket_cd;
	}

	public void setRocket_cd(String rocket_cd) {
		this.rocket_cd = rocket_cd;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getStatus_info() {
		return status_info;
	}

	public void setStatus_info(String status_info) {
		this.status_info = status_info;
	}

}
