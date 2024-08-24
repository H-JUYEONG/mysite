package com.javaex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.UserService;
import com.javaex.vo.UserVo;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	// 필드
	@Autowired
	private UserService userService;
	// 생성자
	// 메소드 gs
	// 메소드 일반

	/* 회원가입 폼 */
	@RequestMapping(value = "/user/joinform", method = { RequestMethod.GET, RequestMethod.POST })
	public String joinForm() {
		System.out.println("UserController.joinForm()");
		return "user/joinForm";
	}

	/* 회원가입 */
	@RequestMapping(value = "/user/join", method = { RequestMethod.GET, RequestMethod.POST })
	public String join(@ModelAttribute UserVo userVo) {
		System.out.println("UserController.join()");

		userService.exeJoinUser(userVo);

		return "user/joinOk";
	}

	/* 로그인 폼 */
	@RequestMapping(value = "/user/loginform", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginForm() {
		System.out.println("UserController.loginForm()");

		return "user/loginForm";
	}

	/* 로그인 */
	@RequestMapping(value = "/user/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String selectUser(@ModelAttribute UserVo userVo, HttpSession session) {
		System.out.println("UserController.login()");

		UserVo authUser = userService.exeLogin(userVo);

		// 로그인
		session.setAttribute("authUser", authUser);

		// 메인페이지로 리다이렉트
		return "redirect:/main";
	}

	/* 로그아웃 */
	@RequestMapping(value = "/user/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session) {
		System.out.println("UserController.logout()");

		// session.removeAttribute("authUser"); // 주소 삭제는 안하고 주소 안에 있는 데이터를 지움
		session.invalidate(); // 주소 자체를 삭제함

		return "redirect:/main";
	}

	/* 회원정보 수정 폼 */
	@RequestMapping(value = "/user/modifyform", method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyForm(HttpSession session, Model model) {
		System.out.println("UserController.modifyForm()");

		// 코드작성
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		
		UserVo userVo = userService.exeGetUserInfo(authUser.getNo());

		// 로그인
		session.setAttribute("userVo", userVo);

		return "user/modifyForm";
	}

	/* 회원정보 수정 */
	@RequestMapping(value = "/user/modify", method = { RequestMethod.GET, RequestMethod.POST })
	public String modify() {
		System.out.println("UserController.modify()");
		return "";
	}

}
