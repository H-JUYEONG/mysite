-- -------------------------------------------
# table 만들기
-- -------------------------------------------
-- web_db 사용
use web_db;

-- table 삭제
drop table users;

-- users 테이블 생성(person 계정에서 실행)
create table users(
   no integer primary key auto_increment,
    id varchar(20) unique not null,
    password varchar(20) not null,
    name varchar(20),
    gender varchar(10)
);

-- 조회
select * from users;

select no,
      id,
       password,
       name,
       gender
from users;

select no,
      id,
       password,
       name,
       gender
from users
where no = 1;

select no,
	   name
from users
where id = 'boy'
and password = 'boy'
;

-- 데이터 추가
insert into users values(null, 'boy', 'boy', '차은우', 'male');
insert into users values(null, 'girl', 'girl', '장원영', 'female');
insert into users values(null, 'yyy', 'yyy', '유재석', 'male');
insert into users values(null, 'kkk', 'kkk', '김종국', 'male');
insert into users values(null, 'lll', 'lll', '이효리', 'female');

-- 수정
update users
set id = 'qqq',
   password = '111',
   name= '강호동',
   gender = '010-9999-9999'
where no = 2;

-- 삭제
delete from users
where no = 14;

