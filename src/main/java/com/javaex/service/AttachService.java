package com.javaex.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class AttachService {
	
	public void upload(MultipartFile file) {
		System.out.println("AttachService.upload()");
		
		// 사진에 기본정보로 우리가 관리할 정보를 뽑아내야된다 --> db저장
		
		// 오리지널 파일명
		String orgName = file.getOriginalFilename();
		System.out.println("orgName: " + orgName);
		
		// 확정자
		String exeName =orgName.substring(orgName.lastIndexOf("."));
		System.out.println(exeName);
		
		// 파일사이즈
		long fileSize = file.getSize();
		System.out.println(fileSize);
		
		// 사진을 서버에 하드디스크에 복사해야된다
		
	}

}
