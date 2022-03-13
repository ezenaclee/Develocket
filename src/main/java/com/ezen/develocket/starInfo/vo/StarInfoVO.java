package com.ezen.develocket.starInfo.vo;

import org.springframework.stereotype.Component;

@Component("starInfoVO")
public class StarInfoVO {

	private String star_cd;
	private String rocket_cd;
	private String star_nickname;
	private String area;

	public StarInfoVO() {
		// TODO Auto-generated constructor stub
	}

	public String getStar_cd() {
		return star_cd;
	}

	public void setStar_cd(String star_cd) {
		this.star_cd = star_cd;
	}

	public String getRocket_cd() {
		return rocket_cd;
	}

	public void setRocket_cd(String rocket_cd) {
		this.rocket_cd = rocket_cd;
	}

	public String getStar_nickname() {
		return star_nickname;
	}

	public void setStar_nickname(String star_nickname) {
		this.star_nickname = star_nickname;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

}
