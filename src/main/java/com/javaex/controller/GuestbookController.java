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
	
	/* 방명록 삭제 폼 */
	@RequestMapping(value="/guestbook/deleteform", method = { RequestMethod.GET, RequestMethod.POST }) 
	public String deleteForm(@RequestParam(value = "no") int no) {
		
		System.out.println("GuestbookController.deleteGuestbook()");
		
		return "guestbook/deleteForm";
	}
	
	/* 방명록 삭제 */
	@RequestMapping(value="/guestbook/delete", method = { RequestMethod.GET, RequestMethod.POST }) 
	public String deleteGuestbook(@ModelAttribute GuestbookVo guestbookVo) {
		
		System.out.println("GuestbookController.deleteGuestbook()");
		
		boolean delete = guestbookService.exeDeleteGuestbook(guestbookVo.getNo(), guestbookVo.getPassword());
		System.out.println(delete);
		
		return "redirect:/guestbook/listform";
	}
}
