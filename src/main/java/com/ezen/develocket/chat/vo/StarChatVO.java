package com.ezen.develocket.chat.vo;

import org.springframework.stereotype.Component;

@Component("starChatVO")
public class StarChatVO {

	private String cate_cd;
	private String cate_l;
	private String cate_m;
	private String cate_s;
	private String rocket_cd;
	private String profile_img;
	private String name;
	private String message;
	private String send_time;
	private String contract_cd;
	private String status_info;
	private String view_check;

	public StarChatVO() {
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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getSend_time() {
		return send_time;
	}

	public void setSend_time(String send_time) {
		this.send_time = send_time;
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

	public String getView_check() {
		return view_check;
	}

	public void setView_check(String view_check) {
		this.view_check = view_check;
	}

}
