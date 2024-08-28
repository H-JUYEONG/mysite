package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.BoardVo;

@Repository
public class BoardDao {

	@Autowired
	private SqlSession sqlSession;
	
	/* 게시판 목록 */
	public List<BoardVo> getBoardList() {
		System.out.println("BoardDao.getBoardList()");
		
		List<BoardVo> boardList = sqlSession.selectList("board.selectList");
		
		return boardList;
	}
	
	/* 게시판 읽기 */
	public BoardVo selectContent(int no) {
		System.out.println("BoardDao.selectContent()");
		
		BoardVo boardVo = sqlSession.selectOne("board.selectContent", no);
		
		return boardVo;
		
	}
	
	/* 조회수 증가 */
	public int updateHit(int no) {
		System.out.println("BoardDao.updateHit()");
		
		int count = sqlSession.update("board.updateHit", no);
		System.out.println("------");
		System.out.println(count);
		
		return count;
		
	}
}
