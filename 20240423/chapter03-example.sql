
-- Documents\dev\database\workspace\chapter03\chapter03-example.sql
-- 1.
select bookname 
from book 
WHERE bookid=1;

select bookname 
from book 
WHERE price >=20000;

select sum(saleprice) as "�������� �ѱ��ž�" 
from orders 
where custid=1;

select count(*) as "�������� ������ ������ ��" 
from orders 
where custid=1;

select count(publisher) as "�������� ������ ������ ���ǻ� ��" 
from orders INNER JOIN book on orders.bookid = book.bookid 
where custid=1;

select book.bookname as "�������� ������ ������ �̸�", book.price as "����", book.price-orders.saleprice as "������ �ǸŰ����� ����" 
from orders INNER JOIN book on orders.bookid = book.bookid 
where custid=1;

-- 2.
select count(*) as "���缭�� ������ �Ѽ�"
from book;

select count(DISTINCT publisher) as "���缭���� ������ ����ϴ� ���ǻ��� �Ѽ�"
from book;

select name as "��� ���� �̸�", address as �ּ�
from customer;

select orderid as "2020.07.04~07 �ֹ����� ������ �ֹ���ȣ"
from orders
where orderdate between '20/07/04' and '20/07/07';

select orderid as "2020.07.04~07 �ֹ����� ������ ������ ������ �ֹ���ȣ"
from orders
where orderdate not between '20/07/04' and '20/07/07';

select name as "�̸�", address as "�ּ�"
from customer
where name like '��%';

select name as "�̸�", address as "�ּ�"
from customer
where name like '��%��';

