package com.javaex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.UserDao;
import com.javaex.vo.UserVo;

@Service
public class UserService {
	
	@Autowired
	private UserDao userDao;
	
	/* 회원가입 */
	public int exeJoinUser(UserVo userVo) {
		System.out.println("UserService.exeJoinUser()");
		
		int count = userDao.insertUser(userVo);
		
		return count;
	}
	
	/* 로그인 */
	public UserVo exeLogin(UserVo userVo) {
		System.out.println("UserService.exeLogin()");
		
		UserVo authUser = userDao.selectUser(userVo);
		
		return authUser;
	
	}
	
	/* 회원정보 수정 폼 */
	public UserVo exeGetUserInfo(int no) {
		System.out.println("UserService.exeModifyForm()");
		
		UserVo userVo = userDao.selectInfo(no);
		
		return userVo;
	}
	
	/* 회원정보 수정 */
	public int exeUserModify(UserVo userVo) {
		System.out.println("UserService.exeUserModify()");
		
		int count = userDao.modifyUser(userVo);
		
		return count;
	}

}
