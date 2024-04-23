
-- Documents\dev\database\workspace\chapter03\chapter03-example003.sql

-- [극장 데이터 베이스] 밑줄 친 속성은 기본키이다 테이블의 구조를 만드시오. 데이터 타입은 임의로 정하시오.
-- 테이블 구조를 만들 때 다음 제약조건을 반영햐여 작성한다.
-- 제약조건
-- 영화 가격은 20000원을 넘지 않아야 한다
-- 상영관번호는 1부터 10사이이다.
-- 같은 사람이 같은 좌석번호를 두 번 예약하지 않아야 한다.

-- 극장 테이블
DROP TABLE THEATER;
CREATE TABLE THEATER(
    THEATERID NUMBER,
    THEATERNAME VARCHAR(20),
    THEATERPLACE VARCHAR(20),
    PRIMARY KEY(THEATERID));

INSERT INTO THEATER(THEATERID, THEATERNAME, THEATERPLACE) VALUES (1, '롯데', '잠실');
INSERT INTO THEATER(THEATERID, THEATERNAME, THEATERPLACE) VALUES (2, '메가', '강남');
INSERT INTO THEATER(THEATERID, THEATERNAME, THEATERPLACE) VALUES (3, '대한', '잠실');

select *
from theater;


-- 상영관 테이블
DROP TABLE ROOM;
CREATE TABLE ROOM(
    THEATERID NUMBER,
    ROOMID NUMBER CHECK(ROOMID>=1 AND ROOMID<=10),
    MOVIENAME VARCHAR(20),
    PRICE NUMBER CHECK(PRICE<20000),
    SEATCNT NUMBER,
    PRIMARY KEY (THEATERID, ROOMID),
    FOREIGN KEY (THEATERID) REFERENCES THEATER(THEATERID) 
    ON DELETE CASCADE);
    
INSERT INTO ROOM(THEATERID, ROOMID, MOVIENAME, PRICE, SEATCNT) VALUES (1, 1, '어려운 영화', 15000, 48);
INSERT INTO ROOM(THEATERID, ROOMID, MOVIENAME, PRICE, SEATCNT) VALUES (3, 1, '멋진 영화', 7500, 120);
INSERT INTO ROOM(THEATERID, ROOMID, MOVIENAME, PRICE, SEATCNT) VALUES (3, 2, '재밌는 영화', 8000, 110);

select *
from ROOM;


-- 고객 테이블
CREATE TABLE THEATERCUSTOMER(
    CUSTOMERID NUMBER,
    NAME VARCHAR(20),
    ADRRESS VARCHAR(20),
    PRIMARY KEY(CUSTOMERID));
    
INSERT INTO THEATERCUSTOMER(CUSTOMERID, NAME, ADRRESS) VALUES (3, '홍길동', '강남');
INSERT INTO THEATERCUSTOMER(CUSTOMERID, NAME, ADRRESS) VALUES (4, '김철수', '잠실');
INSERT INTO THEATERCUSTOMER(CUSTOMERID, NAME, ADRRESS) VALUES (9, '박영희', '강남');

select *
from THEATERCUSTOMER;


-- 예약 테이블
CREATE TABLE APPOINTMENT(
    THEATERID NUMBER,
    ROOMID NUMBER,
    CUSTOMERID NUMBER,
    SEATID NUMBER UNIQUE,
    DATE DATE,
    FOREIGN KEY (THEATERID) REFERENCES THEATER(THEATERID),
    FOREIGN KEY (ROOMID) REFERENCES ROOM(ROOMID),
    FOREIGN KEY (CUSTOMERID) REFERENCES THEATERCUSTOMER(CUSTOMERID)
    ON DELETE CASCADE);
    
    



-- [판매원 데이터베이스] 밑줄 친 속성은 기본키이고, custname과 salesperson은 각각 customer.name과 salesperson.name을 
-- 참조하는 외래키이다. 테이블을 생성하시오. 테이블의 데이터 타입은 임의로 정하시오.



-- [기업 프로젝트 데이터베이스] 밑줄 친 속성은 기본키이다. Works테이블의 empno, projno 속성은 외래키이다.
-- 테이블의 데이터 타입은 임의로 정하시오. 테이블을 생성하시오.