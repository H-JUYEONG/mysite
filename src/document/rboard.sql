-- -------------------------------------------
# table 만들기
-- -------------------------------------------
-- web_db 사용
use web_db;

-- table 삭제
drop table rboard;

-- rboard 테이블 생성(web 계정에서 실행)
create table rboard(
   no integer primary key auto_increment,
   user_no integer not null,
   title varchar(500),
   content text,
   hit integer default 0,
   reg_date datetime,
   group_no integer,
   order_no integer,
   depth integer,
   FOREIGN KEY(user_no) REFERENCES users(no)
);

-- 조회
select * from rboard;

select b.no,
	   b.user_no as userNo,
       u.name,
       b.title,
       b.content,
       b.hit,
       b.reg_date as regDate,
       b.group_no as groupNo,
       b.order_no as orderNo,
       b.depth
from rboard b
inner join users u
on b.user_no = u.no
order by b.no
;

select b.no,
	   b.user_no as userNo,
       u.name,
       b.title,
       b.content,
       b.hit,
       b.reg_date as regDate,
       b.group_no as groupNo,
       b.order_no as orderNo,
       b.depth
from rboard b
inner join users u
on b.user_no = u.no
where b.no = 1
order by b.no
;

-- 데이터 추가
insert into rboard (user_no, title, content, reg_date, group_no, order_no, depth) 
values (1, '게임 파티원 구해요', '같이할사람 서버2로 ㄱㄱ', now(), 1, 1, 0);

insert into rboard (user_no, title, content, reg_date, group_no, order_no, depth) 
values (2, '오늘의 기록', '날씨가 너무 더워서 힘들다..', now(), 2, 1, 0);

insert into rboard (user_no, title, content, reg_date, group_no, order_no, depth)  
values (3, '끝말잇기 할사람99', '이기면 문상 5000원줌', now(), 3, 1, 0);

insert into rboard (user_no, title, content, reg_date, group_no, order_no, depth) 
values (4, '그거 아는사람?', '어제 누구 열애설 떴다던데', now(), 4, 1, 0);

insert into rboard (user_no, title, content, reg_date, group_no, order_no, depth)  
values (5, '가입인사~~', '안녕하세요~ 잘부탁드려요~', now(), 5, 1, 0);

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

