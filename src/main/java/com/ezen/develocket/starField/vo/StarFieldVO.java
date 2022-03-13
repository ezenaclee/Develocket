package com.ezen.develocket.starField.vo;

import org.springframework.stereotype.Component;

@Component("starFieldVO")
public class StarFieldVO {

	private String star_field_cd;
	private String star_cd;
	private String cate_cd;
	private String profile_img;
	private String short_intro;
	private String detail_intro;
	private String career;
	private String business_img;
	private String qna;

	public StarFieldVO() {
		// TODO Auto-generated constructor stub
	}

	public String getStar_field_cd() {
		return star_field_cd;
	}

	public void setStar_field_cd(String star_field_cd) {
		this.star_field_cd = star_field_cd;
	}

	public String getStar_cd() {
		return star_cd;
	}

	public void setStar_cd(String star_cd) {
		this.star_cd = star_cd;
	}

	public String getCate_cd() {
		return cate_cd;
	}

	public void setCate_cd(String cate_cd) {
		this.cate_cd = cate_cd;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

	public String getShort_intro() {
		return short_intro;
	}

	public void setShort_intro(String short_intro) {
		this.short_intro = short_intro;
	}

	public String getDetail_intro() {
		return detail_intro;
	}

	public void setDetail_intro(String detail_intro) {
		this.detail_intro = detail_intro;
	}

	public String getCareer() {
		return career;
	}

	public void setCareer(String career) {
		this.career = career;
	}

	public String getBusiness_img() {
		return business_img;
	}

	public void setBusiness_img(String business_img) {
		this.business_img = business_img;
	}

	public String getQna() {
		return qna;
	}

	public void setQna(String qna) {
		this.qna = qna;
	}

}
