package com.ezen.develocket.review.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("reviewVO")
public class ReviewVO {

	private String review_cd;
	private String rocket_cd;
	private String rating;
	private String review_content;
	private Date review_date;
	private String star_field_cd;

	public ReviewVO() {
		// TODO Auto-generated constructor stub
	}

	public String getReview_cd() {
		return review_cd;
	}

	public void setReview_cd(String review_cd) {
		this.review_cd = review_cd;
	}

	public String getRocket_cd() {
		return rocket_cd;
	}

	public void setRocket_cd(String rocket_cd) {
		this.rocket_cd = rocket_cd;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public Date getReview_date() {
		return review_date;
	}

	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}

	public String getStar_field_cd() {
		return star_field_cd;
	}

	public void setStar_field_cd(String star_field_cd) {
		this.star_field_cd = star_field_cd;
	}

}
