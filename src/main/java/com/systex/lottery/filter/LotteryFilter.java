package com.systex.lottery.filter;
import java.io.IOException;

import org.hibernate.annotations.Comment;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import com.systex.lottery.utils.JwtUtil;

import io.jsonwebtoken.Claims;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebFilter(urlPatterns = "/*") // 适用所有 URL
@Component
public class LotteryFilter implements Filter{
	private static final int TOKEN_IS_VALID=0;
	private static final int TOKEN_IS_INVALID=1;
	private static final int TOKEN_IS_EXPIRED=2;
	/**
	 * lottery/index.jsp
	 * lottery/style/mycss.css
	 * lottery/main
	 * /lottery/login
	 * */
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		 HttpServletRequest req = (HttpServletRequest) request;
         HttpServletResponse resp = (HttpServletResponse) response;
         String uri = req.getRequestURI();       
         System.out.println(uri);
         switch(uri) {
         	case "/lottery/index.jsp":
         	case "/lottery/login":
         	case "/lottery/style/mycss.css":
         	case "/lottery/register":
         	case "/lottery/logout":	
         		chain.doFilter(request, response);
         		break;
         	default:
         		int result = IsTokenValid(req,resp);
         		if(result==TOKEN_IS_VALID) {
         			chain.doFilter(request, response);
         		}else if(result==TOKEN_IS_EXPIRED) {
         			resp.sendRedirect(req.getContextPath() + "/logout");
         		}
         		else {
         			resp.sendRedirect(req.getContextPath() + "/login");
         		}
         		break;
         }


	}
	/**
	 * 0 失敗 1 成功 2 過期
	 * **/
	private int IsTokenValid(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		int result= TOKEN_IS_VALID;
 		String  token =  (String) req.getParameter("jwtToken");
 		try {
 	 		if(token==null) {
 	 			throw new Exception("no token");
 	 		}
 	 		Claims claims = JwtUtil.parseJWT(JwtUtil.KEY, token);
 	 		String sessionToken = (String) req.getSession().getAttribute("token");
 	 		System.out.println(sessionToken);
 	 		if(sessionToken==null || !sessionToken.equals(token)) {
 	 			result = TOKEN_IS_EXPIRED;
 	 			throw new Exception("token expired");
 	 		}
		}
 		catch (Exception e) { // SignatureException ExpiredJwtException
			// TODO: handle exception
 			result = TOKEN_IS_INVALID;
 			e.printStackTrace();
		} 
 		return result;
	}

}
