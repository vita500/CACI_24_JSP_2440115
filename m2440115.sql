show databases;
use jsp;
show tables;

/*create table m2440115(
	mid int primary key auto_increment,
    name varchar(32) not null,
    uid varchar(30) not null,
    upw varchar(30) not null,
    phone varchar(12)
);
*/

CREATE TABLE IF NOT EXISTS m2440115(
uid VARCHAR(128) PRIMARY KEY not null,
upw VARCHAR(32) not null,
name VARCHAR(32) not null,
phone varchar(12) not null,
ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS m2440115feed (
no INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
uid VARCHAR(128),
content VARCHAR(4096),
ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
image varchar(1024)
);

insert into m2440115 (uid, upw, name, phone) values("id", "pw", "name", "01000000000");
insert into m2440115 (uid, upw, name, phone) values("2440115", "qlalfqjsgh", "관리자", "01012344321");

drop table m2440115;

DELETE FROM m2440115feed WHERE no = 11;

select * from m2440115;
SELECT * FROM m2440115feed;

ALTER TABLE m2440115 ADD COLUMN admin BOOLEAN DEFAULT FALSE;
UPDATE m2440115 SET admin = TRUE WHERE uid = '2440115';