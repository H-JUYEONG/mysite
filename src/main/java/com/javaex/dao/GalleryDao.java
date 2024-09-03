package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GalleryVo;

@Repository
public class GalleryDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	/* 이미지 리스트 */
	public List<GalleryVo> getList() {
		
		List<GalleryVo> galleryList = sqlSession.selectList("gallery.selectList");
		
		return galleryList;
	}
	
	/* 업로드 된 사진 데이터 DB에 올리기 */
	public int insertFile(GalleryVo galleryVo) {
		System.out.println("GalleryDao.insertFile()");

		int count = sqlSession.insert("gallery.insert", galleryVo);

		return count;
	}

}
