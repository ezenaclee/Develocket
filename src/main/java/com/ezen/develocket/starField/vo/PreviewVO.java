package com.ezen.develocket.starField.vo;

import org.springframework.stereotype.Component;

@Component("previewVO")
public class PreviewVO {

	private String contract_cd;
	private String star_field_cd;
	private String profile_img;
	private String short_intro;
	private String star_cd;
	private String star_nickname;
	private String cate_l;
	private String cate_m;
	private String cate_s;

	public PreviewVO() {
		// TODO Auto-generated constructor stub
	}
	
	public String getContract_cd() {
		return contract_cd;
	}

	public void setContract_cd(String contract_cd) {
		this.contract_cd = contract_cd;
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

	public String getShort_intro() {
		return short_intro;
	}

	public void setShort_intro(String short_intro) {
		this.short_intro = short_intro;
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

}
