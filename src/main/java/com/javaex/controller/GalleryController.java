package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.GalleryService;
import com.javaex.vo.GalleryVo;
import com.javaex.vo.UserVo;

import jakarta.servlet.http.HttpSession;

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

	/* 업로드 */
	@RequestMapping(value = "/gallery/upload", method = { RequestMethod.GET, RequestMethod.POST })
	public String list(@RequestParam(value = "file") MultipartFile file, @ModelAttribute GalleryVo galleryVo,
			HttpSession session) {
		System.out.println("GalleryController.upload()");

		// 로그인한 session 값을 객체로 가져오기
		UserVo authUser = (UserVo) session.getAttribute("authUser");

		System.out.println("-----");
		System.out.println(authUser.getNo());
		System.out.println(galleryVo.getContent());
		System.out.println(file);
		System.out.println("-----");

		// 회원의 no, content, file 같이 넘겨주기
		galleryService.upload(authUser.getNo(), galleryVo.getContent(), file);

		return "redirect:/gallery/list";
	}

	/* 이미지 삭제 */
	@ResponseBody
	@RequestMapping(value = "/api/gallery/remove", method = { RequestMethod.GET, RequestMethod.POST })
	public int remove(@RequestParam(value = "no") int no) {
		System.out.println("ApiGuestbookController.remove()");

		int count = galleryService.exeDeleteImg(no);

		return count;
	}
}
