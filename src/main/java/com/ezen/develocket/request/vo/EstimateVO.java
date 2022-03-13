package com.ezen.develocket.request.vo;

import org.springframework.stereotype.Component;

@Component("estimateVO")
public class EstimateVO { // 받은 견적 팝업창에 쓰일 VO

	private String cate_cd;
	private String cate_l;
	private String cate_m;
	private String cate_s;
	private String star_field_cd;
	private String profile_img;
	private String star_cd;
	private String star_nickname;
	private String survey_cd;
	private String level_a;
	private String period_a;
	private String times_a;
	private String add_comments_a;
	private String request_cd;
	private String price;
	private String estimate_comments;
	private String contract_cd;
	private String status_info;

	public EstimateVO() {
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

	public String getStar_field_cd() {
		return star_field_cd;
	}

	public void setStar_field_cd(String star_field_cd) {
		this.star_field_cd = star_field_cd;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

	public String getStar_cd() {
		return star_cd;
	}

	public void setStar_cd(String star_cd) {
		this.star_cd = star_cd;
	}

	public String getStar_nickname() {
		return star_nickname;
	}

	public void setStar_nickname(String star_nickname) {
		this.star_nickname = star_nickname;
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
