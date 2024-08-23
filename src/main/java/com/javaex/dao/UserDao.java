package com.javaex.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.UserVo;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	/* 회원가입 */
	public int insertUser(UserVo userVo) {
		System.out.println("UserDao.insertUser()");
		
		int count = sqlSession.insert("user.insert", userVo);
		
		return count;
		
	}
	
	/* 로그인 */
	public UserVo selectUser(UserVo userVo) {
		System.out.println("UserDao.selectUser()");
		
		// 파란색 데이터
		UserVo authUser = sqlSession.selectOne("user.selectByIdPw", userVo);
		
		return authUser;
	}
	
	
}
