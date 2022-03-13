package com.ezen.develocket.chat;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/chatingServer")
public class ChatServer {

	/*
	 *  새로 접속한 클라이언트의 세션을 저장할 컬렉션 생성
	 *  멀티 스레드 환경에서 안전한 컬렉션 생성해줌. => 여러 클라이언트 동시 접속해도 문제가 않생김.
	 */
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
	
	@OnOpen        // 클라이언트 접속 시 실행
	public void onOpen(Session session) {
		clients.add(session);		// clients 컬렉션에 클라이언트의 세션 추가
		System.out.println("웹소켓 연결: " + session.getId());
	}
	
	@OnMessage    // 클라이언트로부터 메시지를 받으면 실행 -- 클라이언트가 보낸 메시지와
	public void onMessage(String message, Session session) throws IOException {
		System.out.println("전송 아이디: " + session.getId() + ", 메시지: " + message);
		synchronized (clients) {
			for (Session client : clients) {			// 모든 클라이언트 실행시 메시지를 전송함
				if (!client.equals(session)) {			// 단, 메시지를 보낸 클라이언트는 제외
					client.getBasicRemote().sendText(message);
				}
			}
		}	
	}
	
	@OnClose    // 클라이언트와의 연결이 끊기면 실행
	public void onClose(Session session) {
		
		clients.remove(session);		// 해당 클라이언트의 세션 삭제함
		System.out.println("웹 소켓 종료: " + session.getId());
	}
	
	@OnError    // 에러 발생 시 실행
	public void onError(Throwable e) {
		System.out.println("에러 발생");
		e.printStackTrace();
	}
	
}
