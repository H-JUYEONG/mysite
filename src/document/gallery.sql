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
      g.user_no,
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
      g.user_no,
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
      user_no,
       content,
       file_path as filePath,
      org_name as orgName,
       save_name as saveName,
       file_size as fileSize
from gallery
;

-- 데이터 추가
insert into gallery (user_no, content, file_path, org_name, save_name, file_size) 
values (1, '사진올리기~', 'ㅋㅋ', 'ㅋㅋ', 'ㅋㅋ', 7777);

-- 조회수 증가
update rboard
set hit = hit + 1
where no = 1;

-- 게시판 내용 수정
update rboard
set title = '반갑구만유',
   content = '반갑구만 반가워유'
where no = 7;

-- 삭제
delete from rboard
where no = 5;

