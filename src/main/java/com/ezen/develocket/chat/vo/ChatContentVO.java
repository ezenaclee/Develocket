package com.ezen.develocket.chat.vo;

import java.sql.Date;

public class ChatContentVO {

	private String chat_content_cd;
	private String chat_sn;
	private String sender_id;
	private String message;
	private Date send_time;
	private String contract_cd;

	public ChatContentVO() {
		// TODO Auto-generated constructor stub
	}

	public String getChat_content_cd() {
		return chat_content_cd;
	}

	public void setChat_content_cd(String chat_content_cd) {
		this.chat_content_cd = chat_content_cd;
	}

	public String getChat_sn() {
		return chat_sn;
	}

	public void setChat_sn(String chat_sn) {
		this.chat_sn = chat_sn;
	}

	public String getSender_id() {
		return sender_id;
	}

	public void setSender_id(String sender_id) {
		this.sender_id = sender_id;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getSend_time() {
		return send_time;
	}

	public void setSend_time(Date send_time) {
		this.send_time = send_time;
	}

	public String getContract_cd() {
		return contract_cd;
	}

	public void setContract_cd(String contract_cd) {
		this.contract_cd = contract_cd;
	}

}
