package kr.co.soldesk.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
	//WebSocketMessageBrokerConfigurer: WebSocket과 STOMP를 이용한 메시징을 설정할 때 사용되는 인터페이스
	//웹소켓을 통해 메시지를 주고받는 환경을 구성할 수 있도록 도와주는 역할
	//클라이언트와 서버 간의 메시지 브로커를 설정하고, 엔드포인트(클라이언트가 웹소켓 서버에 접속하는 URL 경로)를 등록하는 등의 작업을 수행
		@Override
		public void registerStompEndpoints(StompEndpointRegistry registry) {
		//STOMP: 웹소켓 목적지 등록
		//클라이언트가 웹소켓 서버에 연결할 때 사용하는 URL을 지정
			registry.addEndpoint("/chat").setAllowedOriginPatterns("*") // 모든 도메인의 요청을 허용
					.withSockJS();//웹소켓이 지원되지 않는 환경에서는 SockJS(대체 기술) 사용
		}

		@Override
		public void configureMessageBroker(MessageBrokerRegistry registry) {
		//메시지 브로커를 설정
		//메시지 브로커: 메시지를 클라이언트에게 전달하는 중간관리자 여러 클라이언트가 동시 채팅, 브로드 캐스팅
		//메시지를 주고받는 경로(prefix) 설정
			registry.enableSimpleBroker("/topic");//메시지 브로커 설정
			registry.setApplicationDestinationPrefixes("/app");
			// 클라이언트에서 메시지를 보낼 경로
		}
	}
	/*
	 * 웹소켓 1.개요 -클라이언트(웹브라우저)와 서버 간 양방향 통신을 실시간으로 가능하게 하는 프로토콜 -서버와 클라이언트가 한 번 연결되면
	 * 서로 지속적으로 데이터를 주고 받을 수 있는 방식
	 * 
	 * 2.HTTP 통신의 한계 -클라이언트가 요청해야만 서버가 응답을 반환 -실시간 데이터가 서버에 추가되어도 클라이언트가 요청하지 않으면
	 * 클라이언트가 알 수가 없음
	 * 
	 * 3. 웹소켓의 장점 -최초에 한 번 연결하면, 클라이언트와 서버가 계속 연결된 상태를 유지가 가능 -클라이언트의 요청 없이도 서버가 먼저
	 * 데이터를 보낼 수 있음(Push 방식 가능) -HTTP보다 오버헤드가 적고, 빠르게 데이터를 송수신 가능
	 * 
	 * 4. 클라이언트가 웹소켓 서버에 연결을 요청 -ws:// 프로토콜을 이용해 서버와 웹소켓 연결 시도 -서버가 연결 승인 시, 클라이언트와
	 * 데이터 교환이 가능 -클라이언트가 서버로 메시지를 전송(send) -서버가 클라이언트에게 응답
	 * 
	 * 
	 */  


