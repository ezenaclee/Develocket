package com.ezen.develocket.rocketInfo.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

/*
    rocket_cd			varchar2(10)		PRIMARY KEY
    ,id					
	,name				varchar2(20)		NOT NULL
	,email 				varchar2(40)		NOT NULL
	,password			varchar2(15)		NOT NULL
	,phone_number		varchar2(15)		NOT NULL
	,join_date			DATE				DEFAULT sysdate	NOT NULL 
 */

@Component("rocketInfoVO")
public class RocketInfoVO {

	private String rocket_cd;
	private String id;
	private String name;
	private String email;
	private String password;
	private String phone_number;
	private Date join_date;
	private String profile_img;

	public RocketInfoVO() {
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

	public Date getJoin_date() {
		return join_date;
	}

	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

}
