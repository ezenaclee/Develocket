package com.ezen.develocket.mypage.vo;

import org.springframework.stereotype.Component;

@Component("mypageVO")
public class MypageVO {

	private String rocket_cd;
	private String id;
	private String name;
	private String email;
	private String password;
	private String phone_number;
	private String profile_img;
	
	public MypageVO() {
		// TODO Auto-generated constructor stub
	}
	
	public String getRocket_cd() {
		return rocket_cd;
	}
	public void setRocket_cd(String rocket_cd) {
		this.rocket_cd = rocket_cd;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone_number() {
		return phone_number;
	}
	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public MypageVO(String rocket_cd, String id, String name, String email, String password, String phone_number,
			String profile_img) {
		super();
		this.rocket_cd = rocket_cd;
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.phone_number = phone_number;
		this.profile_img = profile_img;
	}
	
	
}
 