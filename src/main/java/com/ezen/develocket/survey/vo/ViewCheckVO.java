package com.ezen.develocket.survey.vo;

import org.springframework.stereotype.Component;

@Component("viewCheckVO")
public class ViewCheckVO {

	private String contract_cd;
	private String status_info;
	private String view_check;

	public ViewCheckVO() {
		// TODO Auto-generated constructor stub
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
