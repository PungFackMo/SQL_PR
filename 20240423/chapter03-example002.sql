
-- Documents\dev\database\workspace\chapter03\chapter03-example002.sql
-- (3) 박지성의 총구매액
select customer.name as 이름, sum(saleprice) as 총구매액
from customer , orders 
where customer.custid=orders.custid(+) and customer.custid=1
group by customer.name;

select sum(saleprice)
from customer, orders
where customer.custid=orders.custid
and customer.name like '박지성';

-- (4) 박지성이 구매한 도서의 수
select customer.name, 
    (select count(*)
    from orders
    where custid=1) as "구매한 도서의 수"
from customer, orders
where customer.custid=1
group by customer.name;

select count(*)
from customer c, orders o
where c.custid=o.custid
and c.name like '박지성';

-- (5) 박지성이 구매한 도서의 출판사 수
select count(distinct publisher) as 출판사수
from customer c, orders o, book b
where c.custid=o.custid
and o.bookid=b.bookid
and c.name like '박지성';

-- (6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select bookname, price, price-saleprice
from customer c, orders o, book b
where c.custid=o.custid
and o.bookid=b.bookid
and c.name like '박지성';

-- (7) 박지성이 구매하지 않은 도서의 이름
select distinct b.bookname
from customer c, orders o, book b
where c.custid=o.custid
and b.bookid=o.bookid
and c.name!='박지성';

-- (10) 고객의 이름과 고객별 구매액
select name, sum(saleprice)
from orders o,customer c
where o.custid=c.custid
group by name;

-- (11) 고객의 이름과 고객이 구매한 도서 목록
select c.name, b.bookname
from customer c, orders o, book b
where c.custid=o.custid
and o.bookid=b.bookid;

-- (12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
select *
from book b, orders o
where b.bookid=o.bookid
and price-saleprice=(select max(price-saleprice)
                    from book b, orders o
                    where b.bookid=o.bookid);
                    
-- (13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
select name, avg(saleprice)
from customer c,orders o
where c.custid=o.custid
group by name
having avg(saleprice)>(
    select avg(saleprice)
    from orders o
);

-- 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
select name
from customer c,orders o, book b
where b.bookid=o.bookid
and c.custid=o.custid
and c.name not like '박지성'
and publisher in (
    select b.publisher
    from customer c,orders o, book b
    where b.bookid=o.bookid
    and c.custid=o.custid
    and c.name like '박지성'
);

-- 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
select name
from customer c1
where 2<=(
    select count(distinct b.publisher)
    from customer c2,orders o, book b
    where b.bookid=o.bookid
    and c2.custid=o.custid
    and c1.name like c2.name
);

select c.name, count(b.publisher)
from customer c, book b, orders o
where c.custid=o.custid
and b.bookid=o.bookid
group by name
having count(distinct b.publisher)>=2;

select name, publisher
from customer c,orders o, book b
where b.bookid=o.bookid
and c.custid=o.custid;

-- 전체 고객의 30% 이상이 구매한 도서
select distinct bookname
from book b, orders o
where 0.3<=(
select count(*)
from orders
)/(
select count(*)
from customer
);

select bookname
from book;

select bookname
from book b1
where((
    select count(b2.bookid)
    from book b2, orders o
    where b2.bookid=o.bookid
    and b1.bookid=b2.bookid)
    >=0.3*(
        select count(*)
        from customer
        )
);

select count(*)
from customer;
select count(bookid) from orders
group by bookid;


-- 문제1
-- 마당 서점에서 택배를 보내기 위해 택배에 필요한 정보가 필요하다
-- 택배에 필요한 정보만 추출하시오. - 책이름 고객이름 고객주소 고객번호
select name, bookname, address, phone
from customer c, book b, orders o
where c.custid=o.custid
and o.bookid=b.bookid;

-- 문제 2
-- 택배비 만원이상이면 무료이므로 택배비 무료인 주문과
-- 택배비 발생 주문 테이블 두개를 검색해 오시오.

select name, bookname, o.saleprice
from customer c, book b, orders o
where c.custid=o.custid
and o.bookid=b.bookid
and o.saleprice>=10000;


select name, bookname, saleprice
from customer c, book b, orders o
where c.custid=o.custid
and o.bookid=b.bookid
and o.saleprice<10000;