-- Documents\dev\database\workspace\chapter04\chapter04-example001.sql

-- 01. 다음 내장 함수의 결과를 적으시오.
SELECT ABS(-15) FROM DUAL;                                   -- 15
SELECT CEIL(15.7) FROM DUAL;                                 -- 16
SELECT COS(3.14159) FROM DUAL;                               -- -0.99999999999647923060461239250850048324
SELECT FLOOR(15.7) FROM DUAL;                                -- 15
SELECT LOG(10,100) FROM DUAL;                                -- 2
SELECT MOD(11,4) FROM DUAL;                                  -- 3
SELECT POWER(3,2) FROM DUAL;                                 -- 9
SELECT ROUND(15.7) FROM DUAL;                                -- 16
SELECT SIGN(-15) FROM DUAL;                                  -- -1
SELECT TRUNC(15.7) FROM DUAL;                                -- 15
SELECT CHR(67) FROM DUAL;                                    -- C
SELECT CONCAT('HAPPY', 'Birthday') FROM DUAL;                -- HAPPYBirthday
SELECT LOWER('Birthday') FROM DUAL;                          -- birthday
SELECT LPAD('Page',15,'*') FROM DUAL;                        -- ***********Page
SELECT LTRIM('Page 1','ae') FROM DUAL;                       -- Page 1
SELECT REPLACE('JACK', 'J', 'BL') FROM DUAL;                 -- BLACK
SELECT RPAD('Page',15,'*') FROM DUAL;                        -- Page***********
SELECT RTRIM('Page 1','ae') FROM DUAL;                       -- Page 1
SELECT SUBSTR('ABCDEFG',3,4) FROM DUAL;                      -- CDEF
SELECT TRIM(LEADING 0 FROM '00AA00') FROM DUAL;              -- AA00
SELECT UPPER('Birthday') FROM DUAL;                          -- BIRTHDAY
SELECT ASCII('AA') FROM DUAL;                                -- 65
SELECT INSTR('CORPORATE FLOOR', 'OR', 3, 2) FROM DUAL;       -- 14
SELECT LENGTH('Birthday') FROM DUAL;                         -- 8
SELECT ADD_MONTHS('14/05/21', 1) FROM DUAL;                  -- 14/06/21
SELECT LAST_DAY(SYSDATE) FROM DUAL;                          -- 24/04/30
SELECT NEXT_DAY(SYSDATE, '화') FROM DUAL;                    -- 24/04/30
SELECT ROUND(SYSDATE) FROM DUAL;                             -- 24/04/26
SELECT SYSDATE FROM DUAL;                                    -- 24/04/25
SELECT TO_CHAR(SYSDATE) FROM DUAL;                           -- 24/04/25
SELECT TO_CHAR(123) FROM DUAL;                               -- 123
SELECT TO_DATE('12 05 2020', 'DD MM YYYY') FROM DUAL;        -- 20/05/12
SELECT TO_NUMBER('12.3') FROM DUAL;                          -- 12.3
SELECT DECODE(1, 1, 'aa', 'bb') FROM DUAL;                   -- aa
SELECT NULLIF(123, 345) FROM DUAL;                           -- 123
SELECT NVL(NULL, 123) FROM DUAL;                             -- 123


-- 02. 다음과 같이 Mybook 테이블을 생성한 후 NULL에 관한 SQL 문에 답하고, 결과를 보면서 NULL에 대한 개념도 정리해 보시오.
-- Mybook
-- bookid  |  price
--   1     |  10000
--   2     |  20000
--   3     |   NULL

create table mybook(
    bookid number primary key,
    price number);
insert into mybook values(1,1000);
insert into mybook values(2,2000);
insert into mybook values(3,null);
select * from mybook;

-- SQL 문
SELECT *
FROM MYBOOK;
-- bookid  |  price
--   1     |  10000
--   2     |  20000
--   3     |   NULL


SELECT BOOKID, NVL(PRICE,0)
FROM MYBOOK;
-- bookid  |  NVL(PRICE,0)
--   1     |  10000
--   2     |  20000
--   3     |      0


SELECT *
FROM MYBOOK
WHERE PRICE IS NULL;
-- bookid  |  price
--   3     |   NULL


SELECT *
FROM MYBOOK
WHERE PRICE IS NOT NULL;  -- ?????
-- bookid  |  price
--   1     |  10000
--   2     |  20000


SELECT BOOKID, PRICE+100
FROM MYBOOK;
-- bookid  |  price+100
--   1     |  10100
--   2     |  20100
--   3     |   NULL


SELECT SUM(PRICE), AVG(PRICE), COUNT(*)
FROM MYBOOK
WHERE BOOKID>=4;
-- SUM(PRICE)  |  AVG(PRICE)  |  COUNT
--     NULL    |     NULL     |    0


SELECT COUNT(*), COUNT(PRICE)
FROM MYBOOK;
-- COUNT(*)  |  COUNT(PRICE)
--     3     |     2


SELECT SUM(PRICE), AVG(PRICE)
FROM MYBOOK;
-- SUM(PRICE)  |  AVG(PRICE)  
--    30000    |    15000     



-- 03. ROWNUM에 관한 다음 SQL문에 답하시오. 데이터는 마당서점 데이터베이스를 이용한다.
-- SQL 문
SELECT *
FROM BOOK;
-- BOOKID BOOKNAME          PUBLISHER       PRICE
--   1	  축구의 역사	        굿스포츠	        7000
--   2	  축구아는 여자       나무수	        13000
--   3    축구의 이해	        대한미디어	    22000
--   4    골프 바이블	        대한미디어	    35000
--   5	  피겨 교본          굿스포츠	        8000
--   6	  역도 단계별기술    	굿스포츠	        6000
--   7	  야구의 추억	        이상미디어	    20000
--   8	  야구를 부탁해 	    이상미디어	    13000
--   9	  올림픽 이야기 	    삼성당	        7500
--   10	  Olympic Champions	Pearson	        13000
--   11	  스포츠 의학	        한솔의학서적	    90000
--   12	  스포츠의학	        한솔의학서적	    90000
--   13	  스포츠 의학	        한솔의학서적	    90000
--   14   스포츠 의학	        한솔의학서적	    NULL
--   21	  Zen Golf	        Pearson	        12000
--   22	  Soccer Skills	    Human Kinetics	15000


SELECT *
FROM BOOK
WHERE ROWNUM<=5;
-- BOOKID BOOKNAME          PUBLISHER       PRICE
--   1	  축구의 역사	        굿스포츠	        7000
--   2	  축구아는 여자	    나무수	        13000
--   3	  축구의 이해	        대한미디어	    22000
--   4	  골프 바이블	        대한미디어	    35000
--   5	  피겨 교본	        굿스포츠	        8000


SELECT *
FROM BOOK
WHERE ROWNUM<=5
ORDER BY PRICE;
-- BOOKID BOOKNAME          PUBLISHER       PRICE
-- 1	  축구의 역사	        굿스포츠	        7000
-- 5	  피겨 교본	        굿스포츠	        8000
-- 2	  축구아는 여자	    나무수	        13000
-- 3	  축구의 이해	        대한미디어	    22000
-- 4	  골프 바이블        	대한미디어	    35000


SELECT *
FROM (SELECT * FROM BOOK ORDER BY PRICE)B
WHERE ROWNUM<=5;
-- BOOKID BOOKNAME          PUBLISHER       PRICE
-- 6	  역도 단계별기술	    굿스포츠	        6000
-- 1	  축구의 역사	        굿스포츠	        7000
-- 9	  올림픽 이야기	    삼성당	        7500
-- 5	  피겨 교본	        굿스포츠	        8000
-- 21	  Zen Golf	        Pearson	        12000


SELECT *
FROM (SELECT * FROM BOOK WHERE ROWNUM<=5)B
ORDER BY PRICE;
-- BOOKID BOOKNAME          PUBLISHER       PRICE
-- 1	  축구의 역사	        굿스포츠	        7000
-- 5	  피겨 교본	        굿스포츠	        8000
-- 2	  축구아는 여자	    나무수	        13000
-- 3	  축구의 이해	        대한미디어	    22000
-- 4	  골프 바이블	        대한미디어	    35000


SELECT *
FROM (SELECT * FROM BOOK
      WHERE ROWNUM <= 5 ORDER BY PRICE)B;
-- BOOKID BOOKNAME          PUBLISHER       PRICE
-- 1	  축구의 역사	        굿스포츠	        7000
-- 5	  피겨 교본	        굿스포츠	        8000
-- 2	  축구아는 여자	    나무수	        13000
-- 3	  축구의 이해	        대한미디어	    22000
-- 4	  골프 바이블        	대한미디어	    35000














