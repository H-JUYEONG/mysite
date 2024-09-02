package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.UserService;

@Controller
public class ApiUserController {
	
	@Autowired
	private UserService userService;
	
	/* 아이디 중복 체크 */
	@ResponseBody // 리턴에 있는 데이터를 json으로 바꿔서 응답문서의 body에 넣어줘
	@RequestMapping(value = "/api/user/idcheck", method = { RequestMethod.GET, RequestMethod.POST })
	public int idCheck(@RequestParam(value="id") String id) {
		System.out.println("ApiUserController.idCheck()");
		System.out.println(id);
		int count = userService.exeUseridCheck(id);
		
		return count;
	}

}
