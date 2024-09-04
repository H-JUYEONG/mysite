package com.javaex.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.TboardVo;

@Repository
public class TboardDao {

	@Autowired
	private SqlSession sqlSession;

	/* 전체리스트가져오기 리스트(검색X, 페이징X) */
	public List<TboardVo> selectList() {
		System.out.println("TboardDao.selectList()");

		List<TboardVo> tboardList = sqlSession.selectList("tboard.selectList");

		return tboardList;
	}

	/* 전체리스트가져오기 리스트2(검색X, 페이징O) */
	public List<TboardVo> selectList2(Map<String, Integer> limitMap) {
		System.out.println("TboardDao.selectList()");

		List<TboardVo> tboardList = sqlSession.selectList("tboard.selectList2", limitMap);

		return tboardList;
	}

	/* 데이터 전체 갯수 구하기(검색X) */
	public int selectTotalCnt() {
		System.out.println("TboardDao.selectTotalCnt()");

		int totalCnt = sqlSession.selectOne("tboard.selectTotalCnt");

		return totalCnt;
	}

	/* 전체리스트가져오기 리스트3(검색O, 페이징O) */
	public List<TboardVo> selectList3(Map<String, Object> limitMap) {
		System.out.println("TboardDao.selectList()");

		List<TboardVo> tboardList = sqlSession.selectList("tboard.selectList3", limitMap);

		return tboardList;
	}

	/* 데이터 전체 갯수 구하기(검색O) */
	public int selectTotalCntKeyword(String keyword) {
		System.out.println("TboardDao.selectTotalCntKeyword()");

		int totalCnt = sqlSession.selectOne("tboard.selectTotalCntKeyword", keyword);
		System.out.println(totalCnt);
		return totalCnt;
	}
}
