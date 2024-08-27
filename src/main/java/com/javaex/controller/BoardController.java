package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.BoardService;
import com.javaex.vo.BoardVo;

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
	public String read() {
		System.out.println("BoardController.read()");
		
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
	public String write() {
		System.out.println("BoardController.write()");
		
		return "";
	}
	
	/* 게시판 수정 폼 */
	@RequestMapping(value="/board/modifyform", method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyForm() {
		System.out.println("BoardController.modifyForm()");
		
		return "board/modifyForm";
	}
	
	/* 게시판 수정 */
	@RequestMapping(value="/board/modify", method = { RequestMethod.GET, RequestMethod.POST })
	public String modify() {
		System.out.println("BoardController.modify()");
		
		return "";
	}

}
