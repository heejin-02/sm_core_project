create table tbl_book (
	num int NOT NULL AUTO_INCREMENT,
	title varchar(50) not null,
	author varchar(30) not null,
	company varchar(50) not null,
	isbn varchar(30) not null,
	count int not null,
	PRIMARY KEY(num)
)

select * from tbl_book;

INSERT INTO tbl_book(title, author,company, isbn, count)
VALUE('해리포터와 아즈카반의 죄수', 'J.K 롤링', '문학수첩', '8983920726', 12);
INSERT INTO tbl_book(title, author,company, isbn, count)
VALUE('난중일기', '이순신', '서해문집', '8974832232', 8);
INSERT INTO tbl_book(title, author,company, isbn, count)
VALUE('수학 귀신', '한스 마그누스 ', '비룡소', '8949187310', 9);
INSERT INTO tbl_book(title, author,company, isbn, count)
VALUE('윌리를 찾아라!', '마틴 핸드포드', '예꿈', '8992882734', 20);
INSERT INTO tbl_book(title, author,company, isbn, count)
VALUE('오세암', '정채봉', '창비', '8936440195', 4);