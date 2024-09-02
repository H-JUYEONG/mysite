package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.GuestbookDao;
import com.javaex.vo.GuestbookVo;

@Service
public class GuestbookService {

	@Autowired
	private GuestbookDao guestbookDao;

	/* 방명록 등록 폼 */
	public List<GuestbookVo> exeGetGuestList() {
		System.out.println("GuestbookService.exeGetGuestList()");

		List<GuestbookVo> guestbookList = guestbookDao.getGuestbookList();

		return guestbookList;
	}

	/* 방명록 등록 */
	public int exeInsertGuestbook(GuestbookVo guestbookVo) {

		int count = guestbookDao.insertGuestbook(guestbookVo);

		return count;
	}

	/* 방명록 삭제 */
	public boolean exeDeleteGuestbook(int no, String password) {

		boolean delete = false;

		System.out.println("GuestbookService.deleteGuest()");

		GuestbookVo guestbookVo = new GuestbookVo(no, password);

		int count = guestbookDao.deleteGuestbook(guestbookVo);

		if (count > 0) { // 삭제된 경우
			delete = true;
		}

		return delete;
	}

	/* ajax 등록 */
	public GuestbookVo exeAddandGuest(GuestbookVo guestbookVo) {
		System.out.println("GuestbookService.exeAddandGuest()");

		// 저장
		int count = guestbookDao.insertSelectKey(guestbookVo);

		// 가져온 키 값으로 데이터 1개 가져오기
		GuestbookVo gVo = guestbookDao.guestbookSelectOne(guestbookVo.getNo());

		return gVo;
	}
}
