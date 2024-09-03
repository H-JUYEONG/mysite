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

select no,
	   user_no,
       content,
       file_path as filePath,
	   org_name as orgName,
       save_name as saveName,
       file_size as fileSize
from gallery
;

select no,
	   user_no,
       content,
       file_path as filePath,
	   org_name as orgName,
       save_name as saveName,
       file_size as fileSize
from gallery
where no = 1
;

-- 데이터 추가
insert into rboard (user_no, title, content, reg_date, group_no, order_no, depth) 
values (1, '게임 파티원 구해요', '같이할사람 서버2로 ㄱㄱ', now(), 1, 1, 0);

insert into rboard (user_no, title, content, reg_date, group_no, order_no, depth) 
values (2, '오늘의 기록', '날씨가 너무 더워서 힘들다..', now(), 2, 1, 0);

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

