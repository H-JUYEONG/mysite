package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GuestbookVo;

@Repository
public class GuestbookDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	/* 방명록 등록 폼 */
	public List<GuestbookVo> getGuestbookList() {
		
		List<GuestbookVo> guestbookList = sqlSession.selectList("guestbook.selectList");
		
		return guestbookList;
	}
	
	/* 방명록 등록 */
	public int insertGuestbook(GuestbookVo guestbookVo) {
		
		int count = sqlSession.insert("guestbook.insert", guestbookVo);
		
		return count;
	}

	/* 방명록 삭제 */
	public int deleteGuestbook(GuestbookVo guestbookVo) {

		int count = sqlSession.delete("guestbook.delete", guestbookVo);

		return count;
	}
}
