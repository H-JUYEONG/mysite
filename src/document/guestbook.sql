-- --------------------------------------------
# mysite 계정에서 실행
-- --------------------------------------------
-- web_db 사용
use web_db;

-- table 삭제
drop table guestbook;

-- guestbook 테이블 생성(web 계정에서 실행)
create table guestbook(
	no integer primary key auto_increment,
    name varchar(20),
    password varchar(20),
    content text,
	reg_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table guestbook(
	no integer primary key auto_increment,
    name varchar(20),
    password varchar(20),
    content text,
	reg_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_no integer not null,
    FOREIGN KEY(user_no) REFERENCES users(no)
);

-- 조회
select * from guestbook;

select 	no,
		name,
        password,
		content,
        reg_date
from guestbook;

select 	no,
		name,
        password,
		content,
        reg_date,
        user_no
from guestbook;

-- 등록
insert into guestbook (name, password, content) 
values ('차은우', 'boy', '핸섬가이');

insert into guestbook (name, password, content)  
values ('장원영', 'girl', '프리티큐티');

insert into guestbook (name, password, content, user_no) 
values ('차은우', 'boy', '핸섬가이', 1);

insert into guestbook (name, password, content, user_no)  
values ('장원영', 'girl', '프리티큐티', 2);

-- 삭제
delete from guestbook 
where password = 'qqp' 
and no = 3;


CREATE TABLE guestbook (
    no INT PRIMARY KEY AUTO_INCREMENT,
    content TEXT,
    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_no INT NOT NULL,
    FOREIGN KEY (user_no) REFERENCES users(no)
);

insert into guestbook (content, user_no) 
values ('안녕하세요', 1);