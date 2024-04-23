-- Documents\dev\database\workspace\chapter03\chapter03-example004.sql

-- [극장 데이터베이스] 다음은 네 개의 지점을 둔 극장 데이터베이스이다. 밑줄 친 속성은 기본키이다.
-- 테이블의 구조를 만들고 데이터를 입력한 후 다음 질의에 대한 SQL문을 작성하시오. 테이블의 구조를
-- 만들 때 다음 제약조건을 반영하여 작성한다.

create table theater(
    ttid number primary key,
    ttname varchar(20),
    tt_location varchar(30));
insert into theater values (1, '롯데', '잠실');
insert into theater values (2, '메가', '강남');
insert into theater values (3, '대한', '잠실');
select *
from theater;

create table ttroom(
    ttid number,
    ttroomid number check(ttroomid>=1) check(ttroomid<=10),
    movie_name varchar(40),
    movie_price number check(movie_price<20000),
    movie_seat_cnt number,
    primary key (ttid, ttroomid),
    FOREIGN key (ttid) references theater(ttid));
insert into ttroom values (1,1,'어려운 영화',15000,48);
insert into ttroom values (3,1,'멋진 영화',7500,120);
insert into ttroom values (3,2,'재밌는 영화',8000,110);
select *
from ttroom;

create table ttcustomer(
    custid number primary key,
    cust_name varchar(20),
    cust_address varchar(40));
insert into ttcustomer values (3, '홍길동', '강남');
insert into ttcustomer values (4, '김철수', '잠실');
insert into ttcustomer values (9, '박영희', '강남');
select *
from ttcustomer;

create table ttappointment(
    ttid number,
    ttroomid number check(ttroomid>=1) check(ttroomid<=10),
    custid number,
    movie_seat_num number unique,
    movie_date date,
    primary key (ttid, ttroomid, custid),
    foreign key (ttid, ttroomid) references ttroom(ttid, ttroomid),
    foreign key (custid) references ttcustomer(custid));
insert into ttappointment values (3, 2, 3, 15, '2020-09-01');
insert into ttappointment values (3, 1, 4, 16, '2020-09-01');
insert into ttappointment values (1, 1, 9, 48, '2020-09-01');
select *
from ttappointment;

-- 제약조건
-- 영화가격은 20000원을 넘지 않아야 한다.
-- 상영관번호는 1부터 10상이이다.
-- 같은 사람이 같은 좌석번호를 두 번 예약하지 않아야 한다.


-- (1) 단순질의
-- ① 모든 극장의 이름과 위치를 보이시오.
select ttname, tt_location
from theater;
-- ② '잠실'에 있는 극장을 보이시오.
select ttname
from theater
where tt_location like '잠실';
--or--
select ttname
from theater
where tt_location in ('잠실');
-- ③ '잠실'에 사는 고객의 이름을 오름차수능로 보이시오.
select cust_name
from ttcustomer
where cust_address like '잠실'
order by cust_name;
-- ④ 가격이 8000원 이하인 영화의 극장번호, 상영관번호, 영화제목을 보이시오.
select ttid, ttroomid, movie_name
from ttroom
where movie_price<=8000;
-- ⑤ 극장 위치와 고객의 주소가 같은 고객을 보이시오.
select cust_name, ttname, cust_address
from ttcustomer ttc, theater tt
where ttc.cust_address=tt.tt_location
order by cust_name;

-- (2) 집계질의
-- ① 극장의 수는 몇 개인가?
select count(ttid)
from theater;
-- ② 상영되는 영화의 평균 가격은 얼마인가?
select avg(movie_price)
from ttroom;
-- ③ 2020년 09월 01일에 영화를 관람한 고객의 수는 얼마인가?
select count(ttc.custid)
from ttappointment tta , ttcustomer ttc
where tta.movie_date in ('2020-09-01')
and tta.custid=ttc.custid;

-- (3) 부속질의와 조인
-- ① '대한'극장에서 상영된 영화제목을 보이시오.
select movie_name
from ttroom ttr, theater tt
where ttr.ttid=tt.ttid
and tt.ttname like '대한';
-- ② '대한'극장에서 영화를 본 고객의 이름을 보이시오.
select cust_name
from ttcustomer ttc, ttappointment tta, theater tt
where ttc.custid=tta.custid
and tta.ttid=tt.ttid
and tt.ttname like '대한';
-- ③ '대한'극장의 전체 수입을 보이시오
select sum(ttr.movie_price)
from ttroom ttr,theater tt, ttappointment tta
where ttr.ttid=tt.ttid
and tta.ttid=tt.ttid
and ttr.ttroomid=tta.ttroomid
and tt.ttname like '대한';

-- (4) 그룹질의
-- ① 극장별 상영관 수를 보이시오.
select count(ttroomid)
from ttroom;
-- ② '잠실'에 있는 극장의 상영관을 보이시오.
select tt.ttname as 극장이름, ttroomid as 상영관
from ttroom ttr, theater tt
where tt.tt_location like '잠실'
and ttr.ttid=tt.ttid;
-- ③ 2020년 9월 1일의 극장별 평균 관람 고객 수를 보이시오.
SELECT tt.ttname, 
    COUNT(ttc.custid)/(select count(*)
                        from ttcustomer)
FROM ttappointment tta, theater tt, ttcustomer ttc
where tt.ttid = tta.ttid
and tta.custid = ttc.custid
and tta.movie_date = '2020-09-01'
GROUP BY ttname;
-- ④ 2020년 9월 1일에 가장 많은 고객이 관람한 영화를 보이시오
select movie_date, movie_name
from ttroom ttr, ttappointment tta
where ttr.ttid=tta.ttid
and ttr.ttroomid=tta.ttroomid
and tta.movie_date in ('2020-09-01');

-- DML
-- ① 각 테이블에 데이터를 삽입하는 INSERT 문을 하나씩 실행시켜 보시오.
select * from theater;
insert into theater values (4, 'CGV', '서면');

select * from ttroom;
insert into ttroom values (4, 1, '이상한 영화', 16000, 200);

select * from ttappointment;
insert into ttappointment values (4, 1, 3, 28,'2024-04-23');

select * from ttcustomer;
insert into ttcustomer values (10, '김자바', '양정');
-- ② 영화의 가격을 10%씩 인상하시오
update ttroom
set movie_price=movie_price * 1.1;


-- [판매원 데이터베이스] 다음 릴레이션을 보고 물음에 답하시오. S_person은 판매원, S_Order는 주문,
-- S_Customer는 고객을 나타낸다. 밑줄 친 속성은 기본키이고 custname과 salesperson은 각각
-- S_Customer.name과 S_person.name을 참조하는 외래키이다.

-- S_person(name_,age,salary)
-- S_Order(S_number, custname_, salesperson_, amount)
-- S_Customer(name_, city, industrytype)

-- (1) 테이블을 생성하는 CREATE문과 데이터를 삽입하는 INSERT문을 작성하시오.
-- 테이블의 데이터 타입은 임의로 정하고, 데이터는 아래 질의의 결과가 나오도록 삽입한다.
create table S_person(
    name varchar(20) primary key,
    age number,
    salary number);
create table S_Customer(
    name varchar(20) primary key,
    city varchar(20),
    industrytype varchar(20));
create table S_Order(
    S_number number,
    custname varchar(20),
    salesperson varchar(20),
    amount number,
    primary key (custname, salesperson),
    foreign key (custname) references S_Customer(name),
    foreign key (salesperson) references S_person(name));

select *
from S_person sp, S_Customer sc, S_Order so
where sp.name=salesperson
and sc.name=custname;

-- (2) 모든 판매원의 이름과 급여를 보이시오. 단, 중복 행은 제거한다.
select * from s_person;
insert into s_person values ('여정모', 30, 2500000);
insert into s_person values ('류동현', 29, 2200000);
insert into s_person values ('안동균', 22, 1800000);
insert into s_person values ('박영준', 35, 3500000);
insert into s_person values ('정봉규', 28, 2400000);

select distinct name, salary
from s_person;

-- (3) 나이가 30세 미만인 판매원의 이름을 보이시오.
select name, age
from s_person
where age<30;

-- (4) 'S'로 끝나는 도시에 사는 고객의 이름을 보이시오.
select * from s_customer;
alter table s_customer modify city varchar(40);
alter table s_customer modify industrytype varchar(40);
insert into s_customer values ('안형호', 'Changwons', '금형설계품질관리');
insert into s_customer values ('김대현', 'Seoul', '연극배우');
insert into s_customer (name, industrytype) values ('성승헌', '탈주닌자');

select name, city
from s_customer
where city like '%s';

-- (5) 주문을 한 고객의 수 (서로 다른 고객만)를 구하시오.
select * from s_order;
insert into s_order values (1, '안형호', '여정모', 20);
insert into s_order values (2, '안형호', '박영준', 10);
insert into s_order values (3, '김대현', '류동현', 5);
insert into s_order values (4, '김대현', '안동균', 8);
insert into s_order values (5, '성승헌', '정봉규', 9);

select count(distinct so.custname)
from s_order so, s_customer sc
where so.custname=sc.name;

-- (6) 판매원 각각에 대하여 주문의 수를 계산하시오.
select sp.name, count(so.salesperson)
from s_person sp, s_order so
where sp.name=so.salesperson
group by sp.name;

-- (7) 'LA'에 사는 고객으로부터 주문을 받은 판매원의 이름과 나이를 보이시오(부속질의를 사용).
insert into s_customer values ('김종국', 'LA', '가수');
insert into s_order values (6, '김종국', '여정모', 20);

select sp.name, sp.age
from s_person sp
where sp.name=(
    select so.salesperson
    from s_order so,s_customer sc
    where sc.name=so.custname
    and sc.city in ('LA'));

-- (8) 'LA'에 사는 고객으로부터 주문을 받은 판매원의 이름과 나이를 보이시오.(조인을 사용)

select sp.name, sp.age
from s_person sp
Join s_order so on sp.name=so.salesperson
Join s_customer sc on sc.name=so.custname
where sc.city in ('LA');


-- (9) 두 번 이상 주문을 받은 판매원의 이름을 보이시오.
select sp.name
from s_person sp, s_order so
where sp.name=so.salesperson
group by sp.name
having count(so.salesperson)>=2;

-- (10) 판매원 'TOM' 의 봉급을 45000원으로 변경하는 SQL문을 작성하시오
insert into s_person values ('TOM', 19, '40000');
select * from s_person;

update s_person
set salary=45000
where name like 'TOM';



-- [기업 프로젝트 데이터베이스] 다음 릴레이션을 보고 물음에 답하시오. c_Employee는 사원,
-- c_Department는 부서, c_project는 프로젝트, c_Works는 사원이 프로젝트에 참여한 내용을 나타낸다.
-- 한 사원이 여러 프로젝트에서 일하거나 한 프로젝트에 여러 사원이 일할 수 있다. hours_worked
-- 속성은 각 사원이 각 프로젝트에서 일한 시간을 나타낸다. 밑줄 친 속성은 기본키이다.

-- c_employee (empno_, name, phoneno, address, sex, position, deptno)
-- c_department (deptno_, deptname, manager)
-- c_project (projno_, projname, deptno)
-- c_works (empno_, projno_, hours_worked)

-- (1) 테이블을 생성하는 create문과 데이터를 삽입하는 insert문을 작성하시오. 테이블의 데이터 타입은 임의로 정하고,
-- 데이터는 아래 질의의 결과가 나오도록 삽입한다.
create table c_employee(
    empno number primary key,
    name varchar(20),
    phoneno varchar(30),
    address varchar(40),
    sex char(2),
    position varchar(20),
    deptno number);
alter table c_employee modify sex varchar(10);
alter table c_employee add foreign key(deptno)references c_department(deptno);

insert into c_employee values (1, '여정모', '010-1234-5678', '부산 남구', '남', '사원', 1);
insert into c_employee values (2, '김희진', '010-4545-5678', '부산 진구', '여', '사원', 1);
insert into c_employee values (3, '이상준', '010-4545-5998', '부산 해운대구', '남', '대리', 2);
insert into c_employee values (4, '김부장', '010-2345-5998', '부산 진구', '남', '부장', 1);
insert into c_employee values (5, '최부장', '010-2375-5998', '부산 강서구', '남', '부장', 2);


create table c_department(
    deptno number primary key,
    deptname varchar(30),
    manager varchar(30));
    
insert into c_department values (1, '개발', '홍길동');
insert into c_department values (2, 'IT', '최부장');


create table c_project(
    projno number primary key,
    projname varchar(30),
    deptno number);
alter table c_project add foreign key(deptno) references c_department(deptno);

insert into c_project values (1, '모바일게임개발', 1);
insert into c_project values (2, 'pc게임개발', 2);


create table c_works(
    empno number,
    projno number,
    hours_worked number,
    primary key (empno, projno));
alter table c_works add foreign key(empno) references c_employee(empno);
alter table c_works add foreign key(projno) references c_project(projno);

insert into c_works values (1, 1, 8);
insert into c_works values (2, 1, 16);
insert into c_works values (3, 2, 24);
insert into c_works values (4, 1, 24);
insert into c_works values (5, 2, 24);




select *
from c_department cd, c_employee ce, c_project cp, c_works cw
where cd.deptno=ce.deptno
and cd.deptno=cp.deptno
and ce.empno=cw.empno
and cp.projno=cw.projno;

select * from c_department;

-- (2) 모든 사원의 이름을 보이시오.
select name
from c_employee;

-- (3) 여자 사원의 이름을 보이시오.
select name
from c_employee 
where sex like '여';

-- (4) 팀장(manager)의 이름을 보이시오.
select manager
from c_department;

-- (5) 'IT'부서에서 일하는 사원의 이름과 주소를 보이시오.
select ce.name, ce.address
from c_employee ce, c_department cd
where ce.deptno=cd.deptno
and cd.deptname like 'IT';

--(6) '홍길동' 팀장(manager) 부서에서 일하는 사원의 수를 보이시오.

select count(empno)
from c_employee ce
join c_department cd on ce.deptno=cd.deptno
where manager like '홍길동';

-- (7) 사원들이 일한 시간 수를 부서별, 사원 이름별 오름차순으로 보이시오.
select * from c_employee;

select deptname, name, hours_worked
from c_department cd, c_employee ce, c_works cw
where cd.deptno=ce.deptno
and ce.empno=cw.empno
order by name asc;

-- (8) 2명 이상의 사원이 참여한 프로젝트의 번호, 이름, 사원의 수를 보이시오.
select cp.projno, cp.projname, count(cp.deptno)
from c_project cp, c_employee ce
where cp.deptno=ce.deptno
group by cp.projno, cp.projname
having count(cp.deptno)>=2
order by projno;

select * from c_employee;



