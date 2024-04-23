
-- Documents\dev\database\workspace\chapter03\chapter03-example003.sql

-- [���� ������ ���̽�] ���� ģ �Ӽ��� �⺻Ű�̴� ���̺��� ������ ����ÿ�. ������ Ÿ���� ���Ƿ� ���Ͻÿ�.
-- ���̺� ������ ���� �� ���� ���������� �ݿ��Ῡ �ۼ��Ѵ�.
-- ��������
-- ��ȭ ������ 20000���� ���� �ʾƾ� �Ѵ�
-- �󿵰���ȣ�� 1���� 10�����̴�.
-- ���� ����� ���� �¼���ȣ�� �� �� �������� �ʾƾ� �Ѵ�.

-- ���� ���̺�
DROP TABLE THEATER;
CREATE TABLE THEATER(
    THEATERID NUMBER,
    THEATERNAME VARCHAR(20),
    THEATERPLACE VARCHAR(20),
    PRIMARY KEY(THEATERID));

INSERT INTO THEATER(THEATERID, THEATERNAME, THEATERPLACE) VALUES (1, '�Ե�', '���');
INSERT INTO THEATER(THEATERID, THEATERNAME, THEATERPLACE) VALUES (2, '�ް�', '����');
INSERT INTO THEATER(THEATERID, THEATERNAME, THEATERPLACE) VALUES (3, '����', '���');

select *
from theater;


-- �󿵰� ���̺�
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
    
INSERT INTO ROOM(THEATERID, ROOMID, MOVIENAME, PRICE, SEATCNT) VALUES (1, 1, '����� ��ȭ', 15000, 48);
INSERT INTO ROOM(THEATERID, ROOMID, MOVIENAME, PRICE, SEATCNT) VALUES (3, 1, '���� ��ȭ', 7500, 120);
INSERT INTO ROOM(THEATERID, ROOMID, MOVIENAME, PRICE, SEATCNT) VALUES (3, 2, '��մ� ��ȭ', 8000, 110);

select *
from ROOM;


-- �� ���̺�
CREATE TABLE THEATERCUSTOMER(
    CUSTOMERID NUMBER,
    NAME VARCHAR(20),
    ADRRESS VARCHAR(20),
    PRIMARY KEY(CUSTOMERID));
    
INSERT INTO THEATERCUSTOMER(CUSTOMERID, NAME, ADRRESS) VALUES (3, 'ȫ�浿', '����');
INSERT INTO THEATERCUSTOMER(CUSTOMERID, NAME, ADRRESS) VALUES (4, '��ö��', '���');
INSERT INTO THEATERCUSTOMER(CUSTOMERID, NAME, ADRRESS) VALUES (9, '�ڿ���', '����');

select *
from THEATERCUSTOMER;


-- ���� ���̺�
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
    
    



-- [�Ǹſ� �����ͺ��̽�] ���� ģ �Ӽ��� �⺻Ű�̰�, custname�� salesperson�� ���� customer.name�� salesperson.name�� 
-- �����ϴ� �ܷ�Ű�̴�. ���̺��� �����Ͻÿ�. ���̺��� ������ Ÿ���� ���Ƿ� ���Ͻÿ�.



-- [��� ������Ʈ �����ͺ��̽�] ���� ģ �Ӽ��� �⺻Ű�̴�. Works���̺��� empno, projno �Ӽ��� �ܷ�Ű�̴�.
-- ���̺��� ������ Ÿ���� ���Ƿ� ���Ͻÿ�. ���̺��� �����Ͻÿ�.