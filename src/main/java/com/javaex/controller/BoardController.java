package com.javaex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.javaex.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;

}
