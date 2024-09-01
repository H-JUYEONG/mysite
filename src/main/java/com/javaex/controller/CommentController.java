package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.CommentService;
import com.javaex.vo.BoardVo;
import com.javaex.vo.CommentVo;
import com.javaex.vo.UserVo;

import jakarta.servlet.http.HttpSession;

@Controller
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	
	/* 게시판 목록 */
	@RequestMapping(value="/board2/list2", method = { RequestMethod.GET, RequestMethod.POST })
	public String list(Model model) {
		System.out.println("CommentController.list()");
		
		List<CommentVo> commentList = commentService.exeGetBoardList();
		model.addAttribute("commentList", commentList);

		return "board/list2";
	}
	
	/* 게시판 읽기 */
	@RequestMapping(value="/board2/read2", method = { RequestMethod.GET, RequestMethod.POST })
	public String read(@RequestParam(value="no") int no, Model model) {
		System.out.println("CommentController.read()");
		
		// 조회수 증가
		commentService.exeUpdateHit(no);
		
		// param으로 게시판 내용 가져오기
		CommentVo commentVo = commentService.exeGetContent(no);
		
		// jsp에 데이터 전달
		model.addAttribute("commentVo", commentVo);
		
		return "board/read2";
	}
	
	/* 게시판 등록 폼 */
	@RequestMapping(value="/board2/writeform2", method = { RequestMethod.GET, RequestMethod.POST })
	public String writeForm() {
		System.out.println("CommentController.writeForm()");
		
		return "board/writeForm2";
	}
	
	/* 게시판 등록 */
	@RequestMapping(value="/board2/write2", method = { RequestMethod.GET, RequestMethod.POST })
	public String write(@ModelAttribute CommentVo commentVo, HttpSession session) {
		System.out.println("CommentController.write()");
		
		// session 가져오기(session에는 회원 no, name 있음)
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		
		// 회원번호를 같이 insert
		commentService.exeWrite(commentVo, authUser.getNo());
		
		return "redirect:/board2/list2";
	}
	
	/* 댓글 등록 폼 */
    @RequestMapping(value="/board2/writeCommentForm2", method = { RequestMethod.GET, RequestMethod.POST })
    public String writeReplyForm() {
    	System.out.println("CommentController.writeReplyForm()");
    	
        return "board/writeCommentForm2";
    }
	
	/* 댓글 등록 */
    @RequestMapping(value="/board2/writecomment2", method = { RequestMethod.GET, RequestMethod.POST })
    public String writeComment(@ModelAttribute CommentVo commentVo, HttpSession session) {
    	System.out.println("CommentController.writeComment()");
    	
    	// 코드 작성
    	 
         return "";
    }
	
	/* 게시판 수정 폼 */
	@RequestMapping(value="/board2/modifyform2", method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyForm(@RequestParam(value="no") int no, Model model) {
		System.out.println("CommentController.modifyForm()");

		// 게시판 읽을때 주소에 있는 param 사용
		CommentVo commentVo = commentService.exeGetContent(no);

		// 게시판 번호로 불러온 게시판 내용 전달
		model.addAttribute("commentVo", commentVo);
		
		return "board/modifyForm2";
	}
	
	/* 게시판 수정 */
	@RequestMapping(value="/board2/modify2", method = { RequestMethod.GET, RequestMethod.POST })
	public String modify(@ModelAttribute CommentVo commentVo) {
		System.out.println("BoardController.modify()");
		
		commentService.exeModifyBoard(commentVo);
		
		return "redirect:/board2/list2";
	}

	/* 게시판 삭제 */
	@RequestMapping(value="/board2/delete2", method = { RequestMethod.GET, RequestMethod.POST })
	public String delete(@RequestParam(value="no") int no) {
		System.out.println("BoardController.delete()");
		
		commentService.exeDeleteBoard(no);
		
		return "redirect:/board2/list2";
	}

}
