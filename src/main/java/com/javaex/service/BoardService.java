package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BoardDao;
import com.javaex.vo.BoardVo;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	public List<BoardVo> exeGetBoardList() {
		System.out.println("BoardService.exeGetBoardList()");
		
		List<BoardVo> boardList = boardDao.getBoardList();
		
		return boardList;
	}

}
