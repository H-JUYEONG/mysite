package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.TboardDao;
import com.javaex.vo.TboardVo;

@Service
public class TboardService {

	@Autowired
	private TboardDao tboardDao;

	/* 전체리스트가져오기 리스트(페이징X) */
	public List<TboardVo> exeList() {
		System.out.println("TboardService.exeList()");

		List<TboardVo> tboardList = tboardDao.selectList();

		return tboardList;
	}

	// 전체리스트가져오기 리스트(페이징O)
	public List<TboardVo> exeList2(int crtPage) {
		System.out.println("TboardService.exeList()");

		// 한 페이지의 출력갯수
		int listCnt = 10;

		// startRowNo 구하기
		// 1->(1 10) 2->(11 10) 3->(21 10) 사람
		// 1->(0 10) 2->(10 10) 3->(20 10) mysql
		// (1-1)10 0
		// (2-1)10 10
		// (3-1)10 20

		// 1->(1 3) 2->(4 3) 3->(7 3) 사람
		// 1->(0 3) 2->(3 3) 3->(6 3) mysql

		// (1-1)3 0
		// (2-1)3 3
		// (3-1)3 6
		// StartRowNo = (crtPage-1)listCnt

		int StartRowNo = (crtPage - 1) * listCnt;

		// 2개의 데이터를 1개로 묶어준다
		Map<String, Integer> limitMap = new HashMap<String, Integer>();
		limitMap.put("StartRowNo", StartRowNo); // 별명, 실제 값(변수명)
		limitMap.put("listCnt", listCnt); // 별명, 실제 값(변수명)

		List<TboardVo> tboardList = tboardDao.selectList2(limitMap);

		// 페이지당 버튼 갯수
		int pageBtnCount = 5;

		// endPageBtnNo 마지막 버튼 번호
		// 1 2 3 4 5 > 페이지당 버튼
		// 1 --> (1~5) 
		// 2 --> (1~5)
		// 3 --> (1~5)
		// 4 --> (1~5)
		// 5 --> (1~5)
		// 6 --> (6~10)
		// 7 --> (6~10)
		// ...
		// 10 -> (6~10)
		// 11 -> (11~15)

		// (1 5) => 올림(1/5)*5 0.2 올림하면 1.0 --> 1*5 --> 5
		// (2 5) => 올림(2/5)*5 0.4 올림하면 1.0 --> 1*5 --> 5
		// (3 5) => 올림(3/5)*5 0.6 올림하면 1.0 --> 1*5 --> 5
		// (4 5) => 올림(4/5)*5 0.8 올림하면 1.0 --> 1*5 --> 5
		// (5 5) => 올림(5/5)*5 1.0 올림하면 1.0 --> 1*5 --> 5
		// (6 10) => 올림(6/5)*5 1.2 올림하면 2.0 --> 2*5 --> 10
		// ...
		// (11 15) => 올림(11/5)*5 2.2 올림하면 3.0 --> 2*5 --> 15
		// (올림(crtPage/pageBtnCount)) * pageBtnCount
		
		// 마지막 버튼 번호
		int endPageBtn = (int) Math.ceil((crtPage / (double) pageBtnCount)) * pageBtnCount;
		
		// 시작 버튼 번호
		int startPageBtnNo = (endPageBtn - pageBtnCount) + 1;
		
		System.out.println(crtPage + ", " + startPageBtnNo + ", " + endPageBtn);


		return tboardList;
	}

}
