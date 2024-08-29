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

select b.no,
	   b.title,
       u.name,
       b.content,
       b.hit,
       b.reg_date,
       b.user_no
from board b
inner join users u 
on b.user_no = u.no
order by b.no
;

select b.no,
	   b.title,
       u.name,
       b.content,
       b.hit,
       b.reg_date,
       b.user_no
from board b
inner join users u
on b.user_no = u.no
where b.no = 1
;

-- 데이터 추가
insert into board (title, content, user_no) 
values ('게임 파티원 구해요', '같이할사람 서버2로 ㄱㄱ', 1);

insert into board (title, content, user_no) 
values ('오늘의 기록', '날씨가 너무 더워서 힘들다..', 2);

insert into board (title, content, user_no) 
values ('끝말잇기 할사람99', '이기면 문상 5000원줌', 3);

insert into board (title, content, user_no) 
values ('그거 아는사람?', '어제 누구 열애설 떴다던데', 4);

insert into board (title, content, user_no) 
values ('가입인사~~', '안녕하세요~ 잘부탁드려요~', 5);

-- insert into board (title, content) 
-- values ('옷 싸게 팔아요', '사이즈 미스로 판매합니다. 연락주세요~');


-- 수정
update board
set title = 'ㅎㅇㅎㅇ',
    content= '같이 스터디할사람'
where no = 1;

-- 조회수 증가
update board
set hit = hit+1
where no = 1;

-- 게시판 내용 수정
update board
set title = '반갑구만유',
	content = '반갑구만 반가워유'
where no = 7;

-- 삭제
delete from board
where no = 5;

