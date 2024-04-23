
-- Documents\dev\database\workspace\chapter03\chapter03-example002.sql
-- (3) �������� �ѱ��ž�
select customer.name as �̸�, sum(saleprice) as �ѱ��ž�
from customer , orders 
where customer.custid=orders.custid(+) and customer.custid=1
group by customer.name;

select sum(saleprice)
from customer, orders
where customer.custid=orders.custid
and customer.name like '������';

-- (4) �������� ������ ������ ��
select customer.name, 
    (select count(*)
    from orders
    where custid=1) as "������ ������ ��"
from customer, orders
where customer.custid=1
group by customer.name;

select count(*)
from customer c, orders o
where c.custid=o.custid
and c.name like '������';

-- (5) �������� ������ ������ ���ǻ� ��
select count(distinct publisher) as ���ǻ��
from customer c, orders o, book b
where c.custid=o.custid
and o.bookid=b.bookid
and c.name like '������';

-- (6) �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����
select bookname, price, price-saleprice
from customer c, orders o, book b
where c.custid=o.custid
and o.bookid=b.bookid
and c.name like '������';

-- (7) �������� �������� ���� ������ �̸�
select distinct b.bookname
from customer c, orders o, book b
where c.custid=o.custid
and b.bookid=o.bookid
and c.name!='������';

-- (10) ���� �̸��� ���� ���ž�
select name, sum(saleprice)
from orders o,customer c
where o.custid=c.custid
group by name;

-- (11) ���� �̸��� ���� ������ ���� ���
select c.name, b.bookname
from customer c, orders o, book b
where c.custid=o.custid
and o.bookid=b.bookid;

-- (12) ������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ�
select *
from book b, orders o
where b.bookid=o.bookid
and price-saleprice=(select max(price-saleprice)
                    from book b, orders o
                    where b.bookid=o.bookid);
                    
-- (13) ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�
select name, avg(saleprice)
from customer c,orders o
where c.custid=o.custid
group by name
having avg(saleprice)>(
    select avg(saleprice)
    from orders o
);

-- �������� ������ ������ ���ǻ�� ���� ���ǻ翡�� ������ ������ ���� �̸�
select name
from customer c,orders o, book b
where b.bookid=o.bookid
and c.custid=o.custid
and c.name not like '������'
and publisher in (
    select b.publisher
    from customer c,orders o, book b
    where b.bookid=o.bookid
    and c.custid=o.custid
    and c.name like '������'
);

-- �� �� �̻��� ���� �ٸ� ���ǻ翡�� ������ ������ ���� �̸�
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

-- ��ü ���� 30% �̻��� ������ ����
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


-- ����1
-- ���� �������� �ù踦 ������ ���� �ù迡 �ʿ��� ������ �ʿ��ϴ�
-- �ù迡 �ʿ��� ������ �����Ͻÿ�. - å�̸� ���̸� ���ּ� ����ȣ
select name, bookname, address, phone
from customer c, book b, orders o
where c.custid=o.custid
and o.bookid=b.bookid;

-- ���� 2
-- �ù�� �����̻��̸� �����̹Ƿ� �ù�� ������ �ֹ���
-- �ù�� �߻� �ֹ� ���̺� �ΰ��� �˻��� ���ÿ�.

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