package com.ezen.develocket.inquiry.vo;

import org.springframework.stereotype.Component;

/*
   INQUIRY_IMG_CD      VARCHAR2(15)   PRIMARY KEY,
   IMAGEFILENAME      VARCHAR2(100)   NOT NULL,
   REGISTOR_DATE      DATE         DEFAULT SYSDATE NOT NULL,
   INQUIRY_CD         VARCHAR2(10)   NOT NULL
 */
@Component("inquiryImgVO")
public class InquiryImgVO {

	private String inquiry_img_cd;
	private String imageFileName;
	private String registor_date;
	private String inquiry_cd;

	public InquiryImgVO() {
		// TODO Auto-generated constructor stub
	}

	public String getInquiry_img_cd() {
		return inquiry_img_cd;
	}

	public void setInquiry_img_cd(String inquiry_img_cd) {
		this.inquiry_img_cd = inquiry_img_cd;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getRegistor_date() {
		return registor_date;
	}

	public void setRegistor_date(String registor_date) {
		this.registor_date = registor_date;
	}

	public String getInquiry_cd() {
		return inquiry_cd;
	}

	public void setInquiry_cd(String inquiry_cd) {
		this.inquiry_cd = inquiry_cd;
	}

}
