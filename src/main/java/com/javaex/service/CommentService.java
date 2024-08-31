package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.CommentDao;
import com.javaex.vo.BoardVo;
import com.javaex.vo.CommentVo;

@Service
public class CommentService {
	
	@Autowired
	private CommentDao commentDao;
	
	/* 게시판 목록 */
	public List<CommentVo> exeGetBoardList() {
		System.out.println("CommentService.exeGetBoardList()");
		
		List<CommentVo> commentList = commentDao.getBoardList();
		
		return commentList;
	}

	/* 게시판 읽기 */
	public CommentVo exeGetContent(int no) {
		System.out.println("CommentService.exeGetContent()");
		
		CommentVo commentVo = commentDao.selectContent(no);
		
		return commentVo;
	}
	
	/* 조회수 증가 */
	public int exeUpdateHit(int no) {
		System.out.println("CommentService.exeUpdateHit()");
		
		int count = commentDao.updateHit(no);
		
		return count;
	}
	
	/* 게시판 등록 */
	public int exeWrite(CommentVo commentVo, int no) {
		System.out.println("CommentService.exeWrite()");
		
		// xml mapper에 parameterType="BoardVo"이므로 boardVo 형태로 보내줘야함 -> 매개변수 no값을 set으로 넣어서 하나의 객체로 만들기
		commentVo.setUserNo(no);
		
		int count = commentDao.insertBoard(commentVo);
		
		return count;
	}
	
	/* 게시판 수정 */
	public int exeModifyBoard(CommentVo commentVo) {
		System.out.println("CommentService.exeModifyBoard()");
		
		int count = commentDao.modifyBoard(commentVo);
		
		return count;
	}
	
	/* 게시판 삭제 */
	public int exeDeleteBoard(int no) {
		System.out.println("BoardService.exeDeleteBoard()");
		
		int count = commentDao.deleteBoard(no);
		
		return count;
				
	}
	
}
