package com.systex.lottery.controller;

import java.net.http.HttpRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.service.annotation.GetExchange;

import com.fasterxml.jackson.databind.node.BooleanNode;
import com.systex.lottery.exception.LoginException;
import com.systex.lottery.exception.RegisterException;
import com.systex.lottery.model.Member;
import com.systex.lottery.model.MemberRepository;
import com.systex.lottery.service.LotteryService;
import com.systex.lottery.utils.JwtUtil;

import io.jsonwebtoken.Claims;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LotteryController {
	@Resource
	LotteryService lotteryService;
	@Resource
	MemberRepository memberRepository;
	@GetMapping("/main")
	public String mainPage() {
		return "main";
	}
	@PostMapping("/lotteryController.do")
	public String generateLottery(String sets,String excludeNumbersString,Model model) {
	
		try {
			if(!validateString(sets)) {
				throw new Exception("組數不得為空");
			}
			Integer set = Integer.parseInt(sets);
			ArrayList<Integer> excludeList=null;
			if(validateString(excludeNumbersString)) {
				
				String[] excludeNumbers = excludeNumbersString.trim().split(" ");
				excludeList = new ArrayList<>();
				for(String str :excludeNumbers) {
					if(!str.matches("\\d+")) {
						throw new Exception("請勿傳入非數字文字");
					}
					Integer number = Integer.parseInt(str);
					if(number>0 && number<50) {
						excludeList.add(number);
					}else {
						throw new Exception("數字範圍為1~49，請勿輸入其他數字");
					}
				}
				if(excludeList.size()>43) {
					throw new Exception("排除數字不應超過43個");
				}
			}
			ArrayList<Integer>[]resultList = lotteryService.getNumbers(set, excludeList);
			model.addAttribute("resultList",resultList);
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			model.addAttribute("errors",e.getMessage());
			return "main";
		}

		return "result";
	}
	@GetMapping("/login")
	public String loginPage(String username,String password) {
		return "login";
	}
	/**
	 * 如果登入成功就，就往session中存入token
	 * */
	@PostMapping("/login")
	public String login(String username,String password,HttpServletRequest request,Model model) {
		System.out.println("username "+username);
		System.out.println("password "+password);
		try {
			if(!validateString(username,password)) {
				throw new LoginException("不得傳入空值");
			}
			Optional<Member> memberOptional = memberRepository.queryByUserName(username);
			System.out.println(memberOptional.get());
			Member member =  memberOptional.get();
			if(!memberOptional.isPresent()) {
				throw new LoginException("帳號不存在");
			}
			if(!(member.getPassword().equals(password))) {
				throw new LoginException("密碼錯誤");
			}
			Map<String,Object> claims = new HashMap<>();
			claims.put("USER_ID", member.getId());
			String token = JwtUtil.createJWT(JwtUtil.KEY, 60*60*1000, claims);
			System.out.println(token);
			HttpSession session =request.getSession();
			session.setAttribute("token", token);
			session.setMaxInactiveInterval(60*60);
			
		}catch(Exception e) {
			model.addAttribute("errors",e.getMessage());
			return "/login"; 
		}
		

		return "main";
	}
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/index.jsp";
	}
	@GetMapping("/register")
	public String registerPage() {
		return "register";
	}
	/**
	 * 判斷 是否 帳號重複、密碼錯誤、密碼格式錯誤
	 * 為問題就往sql新增，最後倒回都入頁面
	 * */
	@PostMapping("/register")
	public String register(String username,String password,String confirmPassword,Model model) {
		Optional<Member> memberOptional = memberRepository.queryByUserName(username);
		
		try {
			if(!validateString(username,password,confirmPassword)) {
				throw new RegisterException("值不得為空");
			}
			if(!validUserNameOrPassowrd(username)) {
				throw new RegisterException("帳號不應包含空格，且嘗到介於5~30");
			}
			if(!validUserNameOrPassowrd(password)) {
				throw new RegisterException("密碼不應包含空格，且嘗到介於5~30");
			}
			if(memberOptional.isPresent()) {
				throw new RegisterException("帳號已存在");
			}
			if(!password.equals(confirmPassword)) {
				throw new RegisterException("輛次輸入密碼不一致");
			}

			Member member =new Member(username,password);
			memberRepository.save(member);
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			model.addAttribute("errors",e.getMessage());
			return "register"; 
		}
		return "redirect:/login";
	}

	private boolean validateString(String... strings) {
		boolean result=true;
	    if (strings != null) {
	        for (String param : strings) {
	            if (param.trim().isEmpty()) {
	            	result =  false;
	            	break;
	            }
	        }
	    }else {
	    	result =false;
	    }

		return result;
	}
	/**
	 * 帳號密碼必須長度大於5且小於30，
	 * */
	private boolean validUserNameOrPassowrd(String str) {
		boolean result=true;
		if(str.contains(" ") || 
				str.length()>30 || str.length()<5) {
			result=false;
		}
		return result;
	}
	
}
