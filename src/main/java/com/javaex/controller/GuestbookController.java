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
@RequestMapping(value = "/guestbook")
public class GuestbookController {

	@Autowired
	private GuestbookService guestbookService;

	/* 방명록 등록 폼 */
	@RequestMapping(value = "/listform", method = { RequestMethod.GET, RequestMethod.POST })
	public String listForm(Model model) {
		System.out.println("GuestbookController.listForm()");

		List<GuestbookVo> guestbookList = guestbookService.exeGetGuestList();
		model.addAttribute("guestbookList", guestbookList);

		return "guestbook/addList";
	}

	/* 방명록 등록 */
	@RequestMapping(value = "/write", method = { RequestMethod.GET, RequestMethod.POST })
	public String write(@ModelAttribute GuestbookVo guestbookVo) {
		System.out.println("GuestbookController.write()");

		guestbookService.exeInsertGuestbook(guestbookVo);
		return "redirect:/guestbook/listform";
	}

	/* 방명록 삭제 폼 */
	@RequestMapping(value = "/deleteform", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteForm() {

		/*
		 * @RequestParam(value = "no") int no이 굳이 필요없다. 이유: addList.jsp에서 no를 넘겨주기때문에
		 * deleteForm.jsp에서 ${param.no}로 바로 불러오는게 가능함 <a href=
		 * "${pageContext.request.contextPath}/guestbook/deleteform?no=${guestbookVo.no}"
		 * >[삭제]</a>
		 */

		System.out.println("GuestbookController.deleteGuestbook()");

		return "guestbook/deleteForm";
	}

	/* 방명록 삭제 */
	@RequestMapping(value = "/delete", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteGuestbook(@ModelAttribute GuestbookVo guestbookVo) {

		System.out.println("GuestbookController.deleteGuestbook()");

		boolean delete = guestbookService.exeDeleteGuestbook(guestbookVo.getNo(), guestbookVo.getPassword());
		System.out.println(delete);

		return "redirect:/guestbook/listform";
	}

	// ajaxindex
	@RequestMapping(value = "/ajaxindex", method = { RequestMethod.GET, RequestMethod.POST })
	public String ajaxindex() {
		System.out.println("GuestbookController.ajaxindex()");

		// 방명록 데이터 리스트 가져오지 않는다.

		return "guestbook/ajaxindex";
	}
}
