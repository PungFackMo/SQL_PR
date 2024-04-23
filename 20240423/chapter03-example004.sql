-- Documents\dev\database\workspace\chapter03\chapter03-example004.sql

-- [���� �����ͺ��̽�] ������ �� ���� ������ �� ���� �����ͺ��̽��̴�. ���� ģ �Ӽ��� �⺻Ű�̴�.
-- ���̺��� ������ ����� �����͸� �Է��� �� ���� ���ǿ� ���� SQL���� �ۼ��Ͻÿ�. ���̺��� ������
-- ���� �� ���� ���������� �ݿ��Ͽ� �ۼ��Ѵ�.

create table theater(
    ttid number primary key,
    ttname varchar(20),
    tt_location varchar(30));
insert into theater values (1, '�Ե�', '���');
insert into theater values (2, '�ް�', '����');
insert into theater values (3, '����', '���');
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
insert into ttroom values (1,1,'����� ��ȭ',15000,48);
insert into ttroom values (3,1,'���� ��ȭ',7500,120);
insert into ttroom values (3,2,'��մ� ��ȭ',8000,110);
select *
from ttroom;

create table ttcustomer(
    custid number primary key,
    cust_name varchar(20),
    cust_address varchar(40));
insert into ttcustomer values (3, 'ȫ�浿', '����');
insert into ttcustomer values (4, '��ö��', '���');
insert into ttcustomer values (9, '�ڿ���', '����');
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

-- ��������
-- ��ȭ������ 20000���� ���� �ʾƾ� �Ѵ�.
-- �󿵰���ȣ�� 1���� 10�����̴�.
-- ���� ����� ���� �¼���ȣ�� �� �� �������� �ʾƾ� �Ѵ�.


-- (1) �ܼ�����
-- �� ��� ������ �̸��� ��ġ�� ���̽ÿ�.
select ttname, tt_location
from theater;
-- �� '���'�� �ִ� ������ ���̽ÿ�.
select ttname
from theater
where tt_location like '���';
--or--
select ttname
from theater
where tt_location in ('���');
-- �� '���'�� ��� ���� �̸��� ���������ɷ� ���̽ÿ�.
select cust_name
from ttcustomer
where cust_address like '���'
order by cust_name;
-- �� ������ 8000�� ������ ��ȭ�� �����ȣ, �󿵰���ȣ, ��ȭ������ ���̽ÿ�.
select ttid, ttroomid, movie_name
from ttroom
where movie_price<=8000;
-- �� ���� ��ġ�� ���� �ּҰ� ���� ���� ���̽ÿ�.
select cust_name, ttname, cust_address
from ttcustomer ttc, theater tt
where ttc.cust_address=tt.tt_location
order by cust_name;

-- (2) ��������
-- �� ������ ���� �� ���ΰ�?
select count(ttid)
from theater;
-- �� �󿵵Ǵ� ��ȭ�� ��� ������ ���ΰ�?
select avg(movie_price)
from ttroom;
-- �� 2020�� 09�� 01�Ͽ� ��ȭ�� ������ ���� ���� ���ΰ�?
select count(ttc.custid)
from ttappointment tta , ttcustomer ttc
where tta.movie_date in ('2020-09-01')
and tta.custid=ttc.custid;

-- (3) �μ����ǿ� ����
-- �� '����'���忡�� �󿵵� ��ȭ������ ���̽ÿ�.
select movie_name
from ttroom ttr, theater tt
where ttr.ttid=tt.ttid
and tt.ttname like '����';
-- �� '����'���忡�� ��ȭ�� �� ���� �̸��� ���̽ÿ�.
select cust_name
from ttcustomer ttc, ttappointment tta, theater tt
where ttc.custid=tta.custid
and tta.ttid=tt.ttid
and tt.ttname like '����';
-- �� '����'������ ��ü ������ ���̽ÿ�
select sum(ttr.movie_price)
from ttroom ttr,theater tt, ttappointment tta
where ttr.ttid=tt.ttid
and tta.ttid=tt.ttid
and ttr.ttroomid=tta.ttroomid
and tt.ttname like '����';

-- (4) �׷�����
-- �� ���庰 �󿵰� ���� ���̽ÿ�.
select count(ttroomid)
from ttroom;
-- �� '���'�� �ִ� ������ �󿵰��� ���̽ÿ�.
select tt.ttname as �����̸�, ttroomid as �󿵰�
from ttroom ttr, theater tt
where tt.tt_location like '���'
and ttr.ttid=tt.ttid;
-- �� 2020�� 9�� 1���� ���庰 ��� ���� �� ���� ���̽ÿ�.
SELECT tt.ttname, 
    COUNT(ttc.custid)/(select count(*)
                        from ttcustomer)
FROM ttappointment tta, theater tt, ttcustomer ttc
where tt.ttid = tta.ttid
and tta.custid = ttc.custid
and tta.movie_date = '2020-09-01'
GROUP BY ttname;
-- �� 2020�� 9�� 1�Ͽ� ���� ���� ���� ������ ��ȭ�� ���̽ÿ�
select movie_date, movie_name
from ttroom ttr, ttappointment tta
where ttr.ttid=tta.ttid
and ttr.ttroomid=tta.ttroomid
and tta.movie_date in ('2020-09-01');

-- DML
-- �� �� ���̺� �����͸� �����ϴ� INSERT ���� �ϳ��� ������� ���ÿ�.
select * from theater;
insert into theater values (4, 'CGV', '����');

select * from ttroom;
insert into ttroom values (4, 1, '�̻��� ��ȭ', 16000, 200);

select * from ttappointment;
insert into ttappointment values (4, 1, 3, 28,'2024-04-23');

select * from ttcustomer;
insert into ttcustomer values (10, '���ڹ�', '����');
-- �� ��ȭ�� ������ 10%�� �λ��Ͻÿ�
update ttroom
set movie_price=movie_price * 1.1;


-- [�Ǹſ� �����ͺ��̽�] ���� �����̼��� ���� ������ ���Ͻÿ�. S_person�� �Ǹſ�, S_Order�� �ֹ�,
-- S_Customer�� ���� ��Ÿ����. ���� ģ �Ӽ��� �⺻Ű�̰� custname�� salesperson�� ����
-- S_Customer.name�� S_person.name�� �����ϴ� �ܷ�Ű�̴�.

-- S_person(name_,age,salary)
-- S_Order(S_number, custname_, salesperson_, amount)
-- S_Customer(name_, city, industrytype)

-- (1) ���̺��� �����ϴ� CREATE���� �����͸� �����ϴ� INSERT���� �ۼ��Ͻÿ�.
-- ���̺��� ������ Ÿ���� ���Ƿ� ���ϰ�, �����ʹ� �Ʒ� ������ ����� �������� �����Ѵ�.
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

-- (2) ��� �Ǹſ��� �̸��� �޿��� ���̽ÿ�. ��, �ߺ� ���� �����Ѵ�.
select * from s_person;
insert into s_person values ('������', 30, 2500000);
insert into s_person values ('������', 29, 2200000);
insert into s_person values ('�ȵ���', 22, 1800000);
insert into s_person values ('�ڿ���', 35, 3500000);
insert into s_person values ('������', 28, 2400000);

select distinct name, salary
from s_person;

-- (3) ���̰� 30�� �̸��� �Ǹſ��� �̸��� ���̽ÿ�.
select name, age
from s_person
where age<30;

-- (4) 'S'�� ������ ���ÿ� ��� ���� �̸��� ���̽ÿ�.
select * from s_customer;
alter table s_customer modify city varchar(40);
alter table s_customer modify industrytype varchar(40);
insert into s_customer values ('����ȣ', 'Changwons', '��������ǰ������');
insert into s_customer values ('�����', 'Seoul', '���ع��');
insert into s_customer (name, industrytype) values ('������', 'Ż�ִ���');

select name, city
from s_customer
where city like '%s';

-- (5) �ֹ��� �� ���� �� (���� �ٸ� ����)�� ���Ͻÿ�.
select * from s_order;
insert into s_order values (1, '����ȣ', '������', 20);
insert into s_order values (2, '����ȣ', '�ڿ���', 10);
insert into s_order values (3, '�����', '������', 5);
insert into s_order values (4, '�����', '�ȵ���', 8);
insert into s_order values (5, '������', '������', 9);

select count(distinct so.custname)
from s_order so, s_customer sc
where so.custname=sc.name;

-- (6) �Ǹſ� ������ ���Ͽ� �ֹ��� ���� ����Ͻÿ�.
select sp.name, count(so.salesperson)
from s_person sp, s_order so
where sp.name=so.salesperson
group by sp.name;

-- (7) 'LA'�� ��� �����κ��� �ֹ��� ���� �Ǹſ��� �̸��� ���̸� ���̽ÿ�(�μ����Ǹ� ���).
insert into s_customer values ('������', 'LA', '����');
insert into s_order values (6, '������', '������', 20);

select sp.name, sp.age
from s_person sp
where sp.name=(
    select so.salesperson
    from s_order so,s_customer sc
    where sc.name=so.custname
    and sc.city in ('LA'));

-- (8) 'LA'�� ��� �����κ��� �ֹ��� ���� �Ǹſ��� �̸��� ���̸� ���̽ÿ�.(������ ���)

select sp.name, sp.age
from s_person sp
Join s_order so on sp.name=so.salesperson
Join s_customer sc on sc.name=so.custname
where sc.city in ('LA');


-- (9) �� �� �̻� �ֹ��� ���� �Ǹſ��� �̸��� ���̽ÿ�.
select sp.name
from s_person sp, s_order so
where sp.name=so.salesperson
group by sp.name
having count(so.salesperson)>=2;

-- (10) �Ǹſ� 'TOM' �� ������ 45000������ �����ϴ� SQL���� �ۼ��Ͻÿ�
insert into s_person values ('TOM', 19, '40000');
select * from s_person;

update s_person
set salary=45000
where name like 'TOM';



-- [��� ������Ʈ �����ͺ��̽�] ���� �����̼��� ���� ������ ���Ͻÿ�. c_Employee�� ���,
-- c_Department�� �μ�, c_project�� ������Ʈ, c_Works�� ����� ������Ʈ�� ������ ������ ��Ÿ����.
-- �� ����� ���� ������Ʈ���� ���ϰų� �� ������Ʈ�� ���� ����� ���� �� �ִ�. hours_worked
-- �Ӽ��� �� ����� �� ������Ʈ���� ���� �ð��� ��Ÿ����. ���� ģ �Ӽ��� �⺻Ű�̴�.

-- c_employee (empno_, name, phoneno, address, sex, position, deptno)
-- c_department (deptno_, deptname, manager)
-- c_project (projno_, projname, deptno)
-- c_works (empno_, projno_, hours_worked)

-- (1) ���̺��� �����ϴ� create���� �����͸� �����ϴ� insert���� �ۼ��Ͻÿ�. ���̺��� ������ Ÿ���� ���Ƿ� ���ϰ�,
-- �����ʹ� �Ʒ� ������ ����� �������� �����Ѵ�.
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

insert into c_employee values (1, '������', '010-1234-5678', '�λ� ����', '��', '���', 1);
insert into c_employee values (2, '������', '010-4545-5678', '�λ� ����', '��', '���', 1);
insert into c_employee values (3, '�̻���', '010-4545-5998', '�λ� �ؿ�뱸', '��', '�븮', 2);
insert into c_employee values (4, '�����', '010-2345-5998', '�λ� ����', '��', '����', 1);
insert into c_employee values (5, '�ֺ���', '010-2375-5998', '�λ� ������', '��', '����', 2);


create table c_department(
    deptno number primary key,
    deptname varchar(30),
    manager varchar(30));
    
insert into c_department values (1, '����', 'ȫ�浿');
insert into c_department values (2, 'IT', '�ֺ���');


create table c_project(
    projno number primary key,
    projname varchar(30),
    deptno number);
alter table c_project add foreign key(deptno) references c_department(deptno);

insert into c_project values (1, '����ϰ��Ӱ���', 1);
insert into c_project values (2, 'pc���Ӱ���', 2);


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

-- (2) ��� ����� �̸��� ���̽ÿ�.
select name
from c_employee;

-- (3) ���� ����� �̸��� ���̽ÿ�.
select name
from c_employee 
where sex like '��';

-- (4) ����(manager)�� �̸��� ���̽ÿ�.
select manager
from c_department;

-- (5) 'IT'�μ����� ���ϴ� ����� �̸��� �ּҸ� ���̽ÿ�.
select ce.name, ce.address
from c_employee ce, c_department cd
where ce.deptno=cd.deptno
and cd.deptname like 'IT';

--(6) 'ȫ�浿' ����(manager) �μ����� ���ϴ� ����� ���� ���̽ÿ�.

select count(empno)
from c_employee ce
join c_department cd on ce.deptno=cd.deptno
where manager like 'ȫ�浿';

-- (7) ������� ���� �ð� ���� �μ���, ��� �̸��� ������������ ���̽ÿ�.
select * from c_employee;

select deptname, name, hours_worked
from c_department cd, c_employee ce, c_works cw
where cd.deptno=ce.deptno
and ce.empno=cw.empno
order by name asc;

-- (8) 2�� �̻��� ����� ������ ������Ʈ�� ��ȣ, �̸�, ����� ���� ���̽ÿ�.
select cp.projno, cp.projname, count(cp.deptno)
from c_project cp, c_employee ce
where cp.deptno=ce.deptno
group by cp.projno, cp.projname
having count(cp.deptno)>=2
order by projno;

select * from c_employee;



