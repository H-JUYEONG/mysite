package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.TboardService;
import com.javaex.vo.TboardVo;

@Controller
public class TboardController {

	@Autowired
	private TboardService tboardService;

	// 전체리스트가져오기 리스트(페이징X)
	@RequestMapping(value = "/tboard/list", method = { RequestMethod.GET, RequestMethod.POST })
	public String list(Model model) {
		System.out.println("TboardController.list()");

		List<TboardVo> tboardList = tboardService.exeList();
		model.addAttribute("tboardList", tboardList);

		return "tboard/list";
	}

	// 전체리스트가져오기 리스트(페이징O)
	@RequestMapping(value = "/tboard/list2", method = { RequestMethod.GET, RequestMethod.POST })
	public String list2(@RequestParam(value = "crtpage", required = false, defaultValue = "1") int crtPage, Model model) {
		System.out.println("TboardController.list()");

		List<TboardVo> tboardList = tboardService.exeList2(crtPage);
		model.addAttribute("tboardList", tboardList);

		return "tboard/list2";
	}

}
