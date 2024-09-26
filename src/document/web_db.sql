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