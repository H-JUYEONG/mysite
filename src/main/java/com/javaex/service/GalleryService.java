package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.GalleryDao;
import com.javaex.vo.GalleryVo;

@Service
public class GalleryService {
	
	@Autowired
	private GalleryDao galleryDao;
	
	/* 이미지 리스트 */
	public List<GalleryVo> exeGetList() {
		System.out.println("GalleryService.exeGetList()");
		
		List<GalleryVo> galleryList = galleryDao.getList();
		
		return galleryList;
	}
	
	/* 업로드 */
	public String upload(int userNo, String content, MultipartFile file) {
		System.out.println("GalleryService.upload()");

		// 사진에 기본정보로 우리가 관리할 정보를 뽑아내야된다 --> db저장
		// 파일 저장 폴더
		String saveDir = "C:\\javaStudy\\upload";

		// 오리지널 파일명
		String orgName = file.getOriginalFilename();
		System.out.println("orgName: " + orgName);

		// 확장자
		String exeName = orgName.substring(orgName.lastIndexOf("."));
		System.out.println("exeName: " + exeName);

		// 파일사이즈
		long fileSize = file.getSize();
		System.out.println("fileSize: " + fileSize);

		// 저장파일명(겹치지 않아야 한다)
		String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exeName;
		System.out.println("saveName: " + saveName);

		// 파일 전체 경로 + 파일명
		String filePath = saveDir + "\\" + saveName;
		System.out.println("filePath: " + filePath);

		// (1) DB 저장
		// (1-1) 데이터 묶기
		GalleryVo galleryVo = new GalleryVo(userNo, content, filePath, orgName, saveName, fileSize);
		System.out.println("galleryVo: " + galleryVo);

		// (1-2) dao를 통해서 db에 저장
		galleryDao.insertFile(galleryVo);

		// 사진을 서버의 하드디스크에 복사해야된다
		// 파일 저장
		try {
			byte[] fileData = file.getBytes();
			OutputStream os = new FileOutputStream(filePath);
			BufferedOutputStream bos = new BufferedOutputStream(os);
			
			bos.write(fileData);
			bos.close();			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return saveName; // 시간 + uuid + .jpg

	}
	
	/* 이미지 삭제 */
	public int exeDeleteImg(int no) {
		System.out.println("GalleryService.exeDeleteImg()");
		
		int count = galleryDao.deleteImg(no);
		
		return count;
	}
	

}
