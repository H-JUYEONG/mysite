-- -------------------------------------------
# table 만들기
-- -------------------------------------------
-- web_db 사용
use web_db;

-- table 삭제
drop table attach;

-- attach 테이블 생성(web 계정에서 실행)
create table attach(
   no integer primary key auto_increment,
   org_name varchar(200),
   save_name varchar(500),
   file_path varchar(500),
   file_size integer
);

-- 조회
select * from attach;

select no,
      org_name,
       save_name as saveName,
       file_path as filePath,
       file_size as fileSize
from attach
;

insert into attach 
values (null, 'org_name', 'save_name', 'file_path', 7777);