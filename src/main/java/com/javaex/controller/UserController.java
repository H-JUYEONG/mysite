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

		/* (UserVo)으로 형 변환(타입 캐스팅)을 하는 이유
		 session.getAttribute("authUser") 메서드는 Object 타입을 반환한다.
		 Object는 자바에서 모든 클래스의 최상위 부모 클래스이므로, 어떤 타입의 객체도 반환할 수 있다.
		 하지만, Object 타입은 일반적으로 사용할 때 구체적인 타입으로 변환해야 각 클래스에 정의된 메서드나 필드에 접근할 수 있다.
		 */
		// 로그인한 session 값을 객체로 가져오기
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		
		// session의 no 값으로 회원정보 가져오기
		UserVo userVo = userService.exeGetUserInfo(authUser.getNo());

		// 회원정보를 jsp에 전달
		model.addAttribute("userVo", userVo);

		return "user/modifyForm";
	}

	/* 회원정보 수정 */
	@RequestMapping(value = "/user/modify", method = { RequestMethod.GET, RequestMethod.POST })
	public String modify(@ModelAttribute UserVo userVo, HttpSession session) {
		System.out.println("UserController.modify()");
		
		UserVo authUser = userService.exeUserModify(userVo);
		
		// 수정된 회원정보를 session에 전달
		session.setAttribute("authUser", authUser);
		
		return "redirect:/main";
	}

	/* ajax 회원가입 */
	@RequestMapping(value = "/user/joinform2", method = { RequestMethod.GET, RequestMethod.POST })
	public String joinForm2() {
		System.out.println("UserController.joinForm2()");
		return "user/joinForm2";
	}
}
