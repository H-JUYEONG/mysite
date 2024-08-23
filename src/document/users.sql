-- -------------------------------------------
# mysite 만들기
-- -------------------------------------------

-- root 사용
use mysql;

-- web 계정생성 (root 계정에서 실행)
create user 'web'@'%' identified by 'web';

-- web_db 권한부여(root 계정에서 실행)
grant all privileges on web_db.* to 'web'@'%';


-- web_db 생성(root 계정에서 실행)
create database web_db
default character set utf8mb4
collate utf8mb4_general_ci
default encryption='n'
;

 -- 계정을 생성하거나 권한을 수정한 후, 변경된 권한을 즉시 적용
 flush privileges;

show databases;


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

-- 데이터 추가
insert into users values(null, 'boy', 'boy', '차은우', '남');
insert into users values(null, 'girl', 'girl', '장원영', '여');

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

