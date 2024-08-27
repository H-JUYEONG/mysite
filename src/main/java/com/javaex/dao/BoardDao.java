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
	
	public List<BoardVo> getBoardList() {
		
		List<BoardVo> boardList = sqlSession.selectList("board.selectList");
		
		return boardList;
	}
}
