package com.ezen.develocket.survey.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("contractVO")
public class ContractVO {

	private String contract_cd;
	private String rocket_cd;
	private String star_field_cd;
	private String status_info;
	private Date date1;
	private Date date2;
	private Date date3;
	private Date date4;
	private String view_check;
	private String hide_check;

	public ContractVO() {
		// TODO Auto-generated constructor stub
	}

	public String getContract_cd() {
		return contract_cd;
	}

	public void setContract_cd(String contract_cd) {
		this.contract_cd = contract_cd;
	}

	public String getRocket_cd() {
		return rocket_cd;
	}

	public void setRocket_cd(String rocket_cd) {
		this.rocket_cd = rocket_cd;
	}

	public String getStar_field_cd() {
		return star_field_cd;
	}

	public void setStar_field_cd(String star_field_cd) {
		this.star_field_cd = star_field_cd;
	}

	public String getStatus_info() {
		return status_info;
	}

	public void setStatus_info(String status_info) {
		this.status_info = status_info;
	}

	public Date getDate1() {
		return date1;
	}

	public void setDate1(Date date1) {
		this.date1 = date1;
	}

	public Date getDate2() {
		return date2;
	}

	public void setDate2(Date date2) {
		this.date2 = date2;
	}

	public Date getDate3() {
		return date3;
	}

	public void setDate3(Date date3) {
		this.date3 = date3;
	}

	public Date getDate4() {
		return date4;
	}

	public void setDate4(Date date4) {
		this.date4 = date4;
	}

	public String getView_check() {
		return view_check;
	}

	public void setView_check(String view_check) {
		this.view_check = view_check;
	}

	public String getHide_check() {
		return hide_check;
	}

	public void setHide_check(String hide_check) {
		this.hide_check = hide_check;
	}

}
