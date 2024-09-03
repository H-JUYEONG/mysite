package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.GalleryService;
import com.javaex.vo.GalleryVo;

@Controller
public class GalleryController {
	
	@Autowired
	private GalleryService galleryService;

	/* 이미지 리스트 */
	@RequestMapping(value = "/gallery/list", method = { RequestMethod.GET, RequestMethod.POST })
	public String list(Model model) {
		System.out.println("GalleryController.list()");
		
		List<GalleryVo> galleryList = galleryService.exeGetList();

		model.addAttribute("galleryList", galleryList);
		
		return "gallery/list";
	}
	
//	@RequestMapping(value = "/gallery/list", method = { RequestMethod.GET, RequestMethod.POST })
//	public String list(@RequestParam(value = "file") MultipartFile file, @ModelAttribute GalleryVo galleryVo,
//			Model model, HttpSession session) {
//		System.out.println("GalleryController.list()");
//		
//		// 로그인한 session 값 가져오기
		//UserVo authUser = (UserVo)session.getAttribute("authUser");
//
//		return "gallery/list";
//	}

}
