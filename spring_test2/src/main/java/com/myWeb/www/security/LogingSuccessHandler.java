package com.myWeb.www.security;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import com.myWeb.www.service.MemberService;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LogingSuccessHandler implements AuthenticationSuccessHandler {

	@Setter
	@Getter
	private String authEmail;
	
	@Setter
	@Getter
	private String authUrl;
	
	// redirect 데이터를 가지고 리다이렉트 하는 역할
	private RedirectStrategy rdstg = new DefaultRedirectStrategy();
	//실제 로그인 정보, 경로 등을 저장
	private RequestCache reqCache = new HttpSessionRequestCache();
	
	@Inject
	private MemberService msv;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// Authentication 인증된 AuthMember의 객체
		setAuthEmail(authentication.getName());
		setAuthUrl("/board/list");
		
		boolean isOk = msv.updateLastLogin(getAuthEmail());
		
		// 내부에서 로그인 세션 저장됨.
		HttpSession ses = request.getSession();
		log.info("loginSuccess >>> ses >>> " + ses.toString());
		
		if(!isOk || ses == null) {
			return;
		} else {
			// 시큐리티에서 로그인을 시도하면 시도한 로그인 기록 남게 됨.
			// 이전에 시도한 시큐리티의 인증 실패 기록 삭제 
			ses.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
		}
		SavedRequest saveReq = reqCache.getRequest(request, response);
		rdstg.sendRedirect(request, response, (saveReq != null ? saveReq.getRedirectUrl() : getAuthUrl()));
		
	}

}
