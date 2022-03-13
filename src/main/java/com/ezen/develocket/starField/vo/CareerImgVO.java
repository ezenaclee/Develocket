package com.ezen.develocket.starField.vo;

import org.springframework.stereotype.Component;

@Component("careerImgVO")
public class CareerImgVO {

	private String career_img_cd;
	private String imageFileName;
	private String registor_date;
	private String star_field_cd;

	public CareerImgVO() {
		// TODO Auto-generated constructor stub
	}

	public String getCareer_img_cd() {
		return career_img_cd;
	}

	public void setCareer_img_cd(String career_img_cd) {
		this.career_img_cd = career_img_cd;
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

	public String getStar_field_cd() {
		return star_field_cd;
	}

	public void setStar_field_cd(String star_field_cd) {
		this.star_field_cd = star_field_cd;
	}

}
