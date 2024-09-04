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
	
	/* 전체리스트가져오기 리스트(페이징X) */
	public List<TboardVo> selectList() {
		System.out.println("TboardDao.selectList()");
		
		List<TboardVo> tboardList = sqlSession.selectList("tboard.selectList");
		
		return tboardList;
	}
	
	// 전체리스트가져오기 리스트(페이징O)
	public List<TboardVo> selectList2(Map<String, Integer> limitMap) {
		System.out.println("TboardDao.selectList()");
		
		List<TboardVo> tboardList = sqlSession.selectList("tboard.selectList2", limitMap);
		
		return tboardList;
	}

}
