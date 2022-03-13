package com.ezen.develocket.chat.vo;

import org.springframework.stereotype.Component;

@Component("chatRoomVO")
public class ChatRoomVO {

	private String cate_cd;
	private String cate_l;
	private String cate_m;
	private String cate_s;
	private String star_field_cd;
	private String profile_img;
	private String star_cd;
	private String star_nickname;
	private String rocket_cd;
	private String profile_img_r;
	private String name;
	private String status_info;
	private String hide_check;

	public ChatRoomVO() {
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

	public String getRocket_cd() {
		return rocket_cd;
	}

	public void setRocket_cd(String rocket_cd) {
		this.rocket_cd = rocket_cd;
	}

	public String getProfile_img_r() {
		return profile_img_r;
	}

	public void setProfile_img_r(String profile_img_r) {
		this.profile_img_r = profile_img_r;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus_info() {
		return status_info;
	}

	public void setStatus_info(String status_info) {
		this.status_info = status_info;
	}

	public String getHide_check() {
		return hide_check;
	}

	public void setHide_check(String hide_check) {
		this.hide_check = hide_check;
	}

}
