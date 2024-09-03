-- -------------------------------------------
# table 만들기
-- -------------------------------------------
-- web_db 사용
use web_db;

-- table 삭제
drop table gallery;

-- gallery 테이블 생성(web 계정에서 실행)
create table gallery(
   no integer primary key auto_increment,
   user_no integer,
   content varchar(1000),
   file_path varchar(500),
   org_name varchar(200),
   save_name varchar(500),
   file_size integer,
   FOREIGN KEY(user_no) REFERENCES users(no)
);

-- 조회
select * from gallery;

-- 유저 정보랑 같이 가져오기
select g.no,
      g.user_no as userNo,
       u.name,
       g.content,
       g.file_path as filePath,
      g.org_name as orgName,
       g.save_name as saveName,
       g.file_size as fileSize
from gallery g
inner join users u
on g.user_no = u.no
;

select g.no,
      g.user_no as userNo,
       u.name,
       g.content,
       g.file_path as filePath,
      g.org_name as orgName,
       g.save_name as saveName,
       g.file_size as fileSize
from gallery g
inner join users u
on g.user_no = u.no
where g.no = 1
;

select no,
      user_no as userNo,
       content,
       file_path as filePath,
      org_name as orgName,
       save_name as saveName,
       file_size as fileSize
from gallery
;

-- 데이터 추가
insert into gallery (user_no, content, file_path, org_name, save_name, file_size) 
values (1, '강호동', 'C:\javaStudy\upload\1725362448109af8f499b-eaac-4d5c-901f-61d8ddce8eea.jpg', 'Gangho-dong.jpg', '1725362448109af8f499b-eaac-4d5c-901f-61d8ddce8eea.jpg', 49876);

insert into gallery (user_no, content, file_path, org_name, save_name, file_size) 
values (2, '이정재1', 'C:\javaStudy\upload\1725362457108e619d15c-6ede-46ad-82ae-fc3c9d7a2731.jpg', 'Jeongjae-Lee.jpg', '1725362457108e619d15c-6ede-46ad-82ae-fc3c9d7a2731.jpg', 92457);

insert into gallery (user_no, content, file_path, org_name, save_name, file_size) 
values (3, '이정재2', 'C:\javaStudy\upload\172536247180851c2871b-9a58-4789-97aa-cb20429e8463.jpg', 'Jeongjae-Lee.jpg', '172536247180851c2871b-9a58-4789-97aa-cb20429e8463.jpg', 92457);

-- 삭제
delete from gallery
where no = 4;

