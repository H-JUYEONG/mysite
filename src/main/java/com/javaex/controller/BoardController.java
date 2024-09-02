package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.BoardService;
import com.javaex.vo.BoardVo;
import com.javaex.vo.UserVo;

import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	/* 게시판 목록 */
	@RequestMapping(value="/board/list", method = { RequestMethod.GET, RequestMethod.POST })
	public String list(Model model) {
		System.out.println("BoardController.list()");
		
		List<BoardVo> boardList = boardService.exeGetBoardList();
		model.addAttribute("boardList", boardList);
		
		return "board/list";
	}
	
	/* 게시판 읽기 */
	@RequestMapping(value="/board/read", method = { RequestMethod.GET, RequestMethod.POST })
	public String read(@RequestParam(value="no") int no, Model model) {
		System.out.println("BoardController.read()");

		// param으로 게시판 내용 가져오기
		BoardVo boardVo = boardService.exeGetContent(no);
		
		// jsp에 데이터 전달
		model.addAttribute("boardVo", boardVo);
		
		return "board/read";
	}
	
	/* 게시판 등록 폼 */
	@RequestMapping(value="/board/writeform", method = { RequestMethod.GET, RequestMethod.POST })
	public String writeForm() {
		System.out.println("BoardController.writeForm()");
		
		return "board/writeForm";
	}
	
	/* 게시판 등록 */
	@RequestMapping(value="/board/write", method = { RequestMethod.GET, RequestMethod.POST })
	public String write(@ModelAttribute BoardVo boardVo, HttpSession session) {
		System.out.println("BoardController.write()");
		
		// session 가져오기(session에는 회원 no, name 있음)
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		
		// 회원번호를 같이 insert
		boardService.exeWrite(boardVo, authUser.getNo());
		
		return "redirect:/board/list";
	}
	
	/* 게시판 수정 폼 */
	@RequestMapping(value="/board/modifyform", method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyForm(@RequestParam(value="no") int no, Model model) {
		System.out.println("BoardController.modifyForm()");

		// 게시판 읽을때 주소에 있는 param 사용
		BoardVo boardVo = boardService.exeGetContent(no);

		// 게시판 번호로 불러온 게시판 내용 전달
		model.addAttribute("boardVo", boardVo);
		
		return "board/modifyForm";
	}
	
	/* 게시판 수정 */
	@RequestMapping(value="/board/modify", method = { RequestMethod.GET, RequestMethod.POST })
	public String modify(@ModelAttribute BoardVo boardVo) {
		System.out.println("BoardController.modify()");
		
		boardService.exeModifyBoard(boardVo);
		
		return "redirect:/board/list";
	}
	
	/* 게시판 삭제 */
	@RequestMapping(value="/board/delete", method = { RequestMethod.GET, RequestMethod.POST })
	public String delete(@RequestParam(value="no") int no) {
		System.out.println("BoardController.delete()");
		
		boardService.exeDeleteBoard(no);
		
		return "redirect:/board/list";
	}

}
