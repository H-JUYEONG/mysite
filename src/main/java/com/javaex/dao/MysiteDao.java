package com.javaex.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MysiteDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	/* 회원가입 */
	public int insertUser(UserVo userVo) {
		int count = sqlSession.insert("mysite.insert",userVo);
		
		return count;
		
	}
	
	
}
