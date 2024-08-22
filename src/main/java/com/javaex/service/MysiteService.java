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
		System.out.println("PhonebookService.exeJoinUser()");
		
		int count = mysiteDao.insertUser(userVo);
		
		return count;
	}

}
