-- -------------------------------------------
# table 만들기
-- -------------------------------------------
-- web_db 사용
use web_db;

-- table 삭제
drop table board;

-- users 테이블 생성(person 계정에서 실행)
create table board(
   no integer primary key auto_increment,
   title varchar(500) not null,
   content text,
   hit integer default 0,
   reg_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   user_no integer not null,
   FOREIGN KEY(user_no) REFERENCES users(no)
);

-- 조회
select * from board;

select no,
	   title,
       content,
       hit,
       reg_date,
       user_no
from board;

select no,
	   title,
       content,
       hit,
       reg_date,
       user_no
from board
where no = 1;

-- 데이터 추가
insert into board (title, content, user_no) 
values ('게임 파티원 구해요', '같이할사람 서버2로 ㄱㄱ', 1);

insert into board (title, content, user_no) 
values ('오늘의 기록', '날씨가 너무 더워서 힘들다..', 2);

-- insert into board (title, content) 
-- values ('옷 싸게 팔아요', '사이즈 미스로 판매합니다. 연락주세요~');


-- 수정
update board
set title = 'ㅎㅇㅎㅇ',
    content= '같이 스터디할사람'
where no = 1;

-- 삭제
delete from board
where no = 5;

