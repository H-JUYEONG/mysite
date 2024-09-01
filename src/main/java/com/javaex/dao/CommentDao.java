package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.BoardVo;
import com.javaex.vo.CommentVo;

@Repository
public class CommentDao {

	@Autowired
	private SqlSession sqlSession;

	/* 게시판 목록 */
	public List<CommentVo> getBoardList() {
		System.out.println("CommentDao.getBoardList()");

		List<CommentVo> commentList = sqlSession.selectList("comment.selectList");

		return commentList;
	}

	/* 게시판 읽기 */
	public CommentVo selectContent(int no) {
		System.out.println("CommentDao.selectContent()");

		CommentVo commentVo = sqlSession.selectOne("comment.selectContent", no);

		return commentVo;

	}

	/* 조회수 증가 */
	public int updateHit(int no) {
		System.out.println("CommentDao.updateHit()");

		int count = sqlSession.update("comment.updateHit", no);

		return count;

	}

	/* 게시판 등록 */
	public int insertBoard(CommentVo commentVo) {
		System.out.println("CommentDao.insertBoard()");

		int count = sqlSession.insert("comment.insert", commentVo);

		return count;
	}
	
	/* 댓글 등록 */
	public void writeComment(CommentVo commentVo) {
		
		
		return ;
	}

	/* 게시판 수정 */
	public int modifyBoard(CommentVo commentVo) {
		System.out.println("CommentDao.modifyBoard()");

		int count = sqlSession.update("comment.update", commentVo);

		return count;
	}
	
	/* 게시판 삭제 */
	public int deleteBoard(int no) {
		System.out.println("CommentDao.deleteBoard()");
		
		int count = sqlSession.delete("comment.delete", no);
		
		return count;
	}

}
