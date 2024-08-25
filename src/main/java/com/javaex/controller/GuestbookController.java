package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.GuestbookService;
import com.javaex.vo.GuestbookVo;

@Controller
public class GuestbookController {
	
	@Autowired
	private GuestbookService guestbookService;
	
	/* 방명록 등록 폼 */
	@RequestMapping(value="/guestbook/listform", method = { RequestMethod.GET, RequestMethod.POST })
	public String listForm(Model model) {
		System.out.println("GuestbookController.listForm()");
		
		List<GuestbookVo> guestbookList = guestbookService.exeGetGuestList();
		model.addAttribute("guestbookList", guestbookList);
		
		return "guestbook/addList";
	}
	
	/* 방명록 등록 */
	@RequestMapping(value="/guestbook/write", method = { RequestMethod.GET, RequestMethod.POST })
	public String write(@ModelAttribute GuestbookVo guestbookVo) {
		System.out.println("GuestbookController.write()");
		
		guestbookService.exeInsertGuestbook(guestbookVo);
		return "redirect:/guestbook/listform";
	} 
	

}
