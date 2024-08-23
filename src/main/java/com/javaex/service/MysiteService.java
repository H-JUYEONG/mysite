package com.javaex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.MysiteDao;
import com.javaex.vo.UserVo;

@Service
public class MysiteService {
	
	@Autowired
	private MysiteDao mysiteDao;
	
	/* 회원가입 */
	public int exeJoinUser(UserVo userVo) {
		System.out.println("MysiteService.exeJoinUser()");
		
		int count = mysiteDao.insertUser(userVo);
		
		return count;
	}
	
	/* 로그인 */
	public int exeLogin(UserVo userVo) {
		System.out.println("MysiteService.exeLogin()");
		
		int count = mysiteDao.selectUser(userVo);
		
		return count;
	
	}

}
