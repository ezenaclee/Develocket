package com.ezen.develocket.inquiry.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

/*
   INQUIRY_CD			varchar2(10)		PRIMARY KEY
	,PARENT_CD			varchar2(10)		NOT NULL 
	,GROUP_CD			varchar2(10)		NOT NULL 
	,INQUIRY_TITLE		varchar2(100)		NOT NULL
	,INQUIRY_CONTENT	varchar2(1000)		NOT NULL
	,INQUIRY_IMG		varchar2(100)		
	,ROCKET_CD			varchar2(15)		NOT NULL
	,WRITE_DATE			DATE				DEFAULT sysdate	NOT NULL
 */

@Component("inquiryVO")
public class InquiryVO {

	private int level;
	private String inquiry_cd;
	private String parent_cd;
	private String group_cd;
	private String inquiry_title;
	private String inquiry_content;
	private String rocket_cd;
	private String id;
	private Date write_date;
	private String profile_img;

	public InquiryVO() {
		// TODO Auto-generated constructor stub
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getInquiry_cd() {
		return inquiry_cd;
	}

	public void setInquiry_cd(String inquiry_cd) {
		this.inquiry_cd = inquiry_cd;
	}

	public String getParent_cd() {
		return parent_cd;
	}

	public void setParent_cd(String parent_cd) {
		this.parent_cd = parent_cd;
	}

	public String getGroup_cd() {
		return group_cd;
	}

	public void setGroup_cd(String group_cd) {
		this.group_cd = group_cd;
	}

	public String getInquiry_title() {
		return inquiry_title;
	}

	public void setInquiry_title(String inquiry_title) {
		this.inquiry_title = inquiry_title;
	}

	public String getInquiry_content() {
		return inquiry_content;
	}

	public void setInquiry_content(String inquiry_content) {
		this.inquiry_content = inquiry_content;
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

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

}
