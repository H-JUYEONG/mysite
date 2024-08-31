-- -------------------------------------------
# table 만들기
-- -------------------------------------------
-- web_db 사용
use web_db;

-- table 삭제
drop table rboard;

-- users 테이블 생성(person 계정에서 실행)
create table rboard(
   no integer primary key auto_increment,
   user_no integer not null,
   title varchar(500),
   content text,
   hit integer,
   reg_date datetime,
   group_no integer,
   order_no integer,
   depth integer,
   FOREIGN KEY(user_no) REFERENCES users(no)
);

-- 조회
select * from rboard;

select no,
	   user_no,
       title,
       content,
       hit,
       reg_date,
       group_no,
       order_no,
       depth
from rboard
;

select no,
	   user_no,
       title,
       content,
       hit,
       reg_date,
       group_no,
       order_no,
       depth
from rboard
where no = 1
;

-- 데이터 추가 / 수정 필요
insert into rboard (title, content, reg_date, user_no) 
values ('게임 파티원 구해요', '같이할사람 서버2로 ㄱㄱ', now(), 1);


-- 수정
update rboard
set title = 'ㅎㅇㅎㅇ',
    content= '같이 스터디할사람'
where no = 1;

-- 조회수 증가
update rboard
set hit = hit+1
where no = 1;

-- 게시판 내용 수정
update rboard
set title = '반갑구만유',
	content = '반갑구만 반가워유'
where no = 7;

-- 삭제
delete from rboard
where no = 5;