-- Documents\dev\database\workspace\chapter04\chapter04-example002.sql

-- 05. 부속질의에 관한 다음 SQL문을 수행해 보고 어떤 질의에 대한 답인지 설명하시오.
select custid, (select address
                from customer cs
                where cs.custid = od.custid) "address",
                      sum(saleprice) "total"
from orders od
group by od.custid;
-- 주문 고객, 주문 고객의 주소, 총주문액


select cs.name, s
from (select custid, avg(saleprice) s
      from orders
      group by custid) od, customer cs
where cs.custid = od.custid;
-- 주문 고객 이름, 각 고객이 주문한 구매액의 평균


select sum(saleprice) "total"
from orders od
where exists (select * 
              from customer cs
              where custid <= 3 and cs.custid = od.custid);
-- 고객 번호가 3이하인 고객의 주문 총액


-- 08. 마당서점 데이터베이스를 이용해 다음에 해당하는 뷰를 작성하시오.
-- (1) 판매가격이 20000원 이상인 도서의 도서번호, 도서이름, 고객이름, 출판사, 판매가격을 보여주는 highorders뷰를 생성하시오.
create view highorders
as select b.bookid, b.bookname, b.publisher, c.name, o.saleprice
from book b, customer c, orders o
where b.bookid = o.bookid 
and c.custid = o.custid
and o.saleprice >= 20000;
select * from highorders;


-- (2) 생성한 뷰를 이용하여 판매된 도서의 이름과 고객의 이름을 출력하는 SQL문을 작성하시오.
select bookname, name from highorders;


-- (3) highorders뷰를 변경하고자 한다. 판매가격 속성을 삭제하는 명령을 수행하시오. 삭제 후 (2)번 SQL문을 다시 수행하시오.
create or replace view highorders
as select b.bookid, b.bookname, b.publisher, c.name
from book b, customer c, orders o
where b.bookid = o.bookid 
and c.custid = o.custid
and o.saleprice >= 20000;
select * from highorders;



-- 09. [사원 데이터베이스] 3장의 연습문제 14번의 데이터베이스를 이용하여 다음 질의에 해당하는 SQL문을 작성하시오.
-- (1) 팀장(mgr)이 없는 직원의 이름을 보이시오.
select ename from emp where mgr is null;


-- (2) 사원의 이름과 부서의 이름을 보이시오. (조인/스칼라 부속질의 사용)
select e.ename, (select dname 
                from dept d 
                where d.deptno = e.deptno) 
from emp e;


-- (3) 'CHICAGO'에 근무하는 사원의 이름을 보이시오. (조인/인라인 뷰/ 중첩질의/ exists 사용)
select e.ename
from (select deptno 
      from dept 
      where loc = 'CHICAGO') d,
      emp e
where d.deptno = e.deptno;


-- (4) 평균보다 급여가 많은 직원의 이름을 보이시오.
select ename, sal 
from emp
where sal > (select avg(sal) from emp);


-- (5) 자기 부서의 평균보다 급여가 많은 직원의 이름을 보이시오. (상관 부속질의 사용)
select e1.ename
from emp e1
where sal > (select avg(e2.sal) 
            from emp e2 
            where e1.deptno = e2.deptno);
