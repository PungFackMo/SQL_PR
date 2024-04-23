
-- Documents\dev\database\workspace\chapter03\chapter03-example.sql
-- 1.
select bookname 
from book 
WHERE bookid=1;

select bookname 
from book 
WHERE price >=20000;

select sum(saleprice) as "박지성의 총구매액" 
from orders 
where custid=1;

select count(*) as "박지성이 구매한 도서의 수" 
from orders 
where custid=1;

select count(publisher) as "박지성의 구매한 도서의 출판사 수" 
from orders INNER JOIN book on orders.bookid = book.bookid 
where custid=1;

select book.bookname as "박지성이 구매한 도서의 이름", book.price as "가격", book.price-orders.saleprice as "정가와 판매가격의 차이" 
from orders INNER JOIN book on orders.bookid = book.bookid 
where custid=1;

-- 2.
select count(*) as "마당서점 도서의 총수"
from book;

select count(DISTINCT publisher) as "마당서점에 도서를 출고하는 출판사의 총수"
from book;

select name as "모든 고객의 이름", address as 주소
from customer;

select orderid as "2020.07.04~07 주문받은 도서의 주문번호"
from orders
where orderdate between '20/07/04' and '20/07/07';

select orderid as "2020.07.04~07 주문받은 도서를 제외한 도서의 주문번호"
from orders
where orderdate not between '20/07/04' and '20/07/07';

select name as "이름", address as "주소"
from customer
where name like '김%';

select name as "이름", address as "주소"
from customer
where name like '김%아';

