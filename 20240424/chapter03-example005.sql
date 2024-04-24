-- Documents\dev\database\workspace\chapter03\chapter03-example005.sql

-- [��� �����ͺ��̽�] Dept�� �μ�(Department) ���̺�� deptno(�μ���ȣ), dname(�μ��̸�),
-- loc(��ġ, location)���� �����Ǿ� �ִ�. Emp�� ���(Employee)���̺�� empno(�����ȣ),
-- ename(����̸�), job(����), mgr(�����ȣ, manager), hiredate(��볯¥), sal(�޿�, salary),
-- comm(Ŀ�̼Ǳݾ�, commission), deptno(�μ���ȣ)�� �����Ǿ� �ִ�. ���� ģ �Ӽ��� �⺻Ű�̰�
-- Emp�� deptno�� Dept�� deptno�� �����ϴ� �ܷ�Ű�̴�. ��� �����ͺ��̽��� demo_scott.sql
-- ��ũ��Ʈ�� �����Ͽ� ��ġ�ϵ��� �Ѵ�.

-- Dept(deptno NUMBER(2), dname VARCHAR2(14), loc VARCHAR2(13))
-- Emp(empno NUMBER(4), ename VARCHAR2(10), job VARCHAR2(9),
--      mgr NUMBER(4), hiredate DATE, sal NUMBER(7,2),
--      comm NUMBER(7,2), deptno NUMBER(2))

create table Dept(
    deptno NUMBER(2) primary key,
    dname VARCHAR2(14),
    loc VARCHAR2(13));
create table Emp(
    empno NUMBER(4) primary key,
    ename VARCHAR2(10),
    job VARCHAR2(9),
    mgr NUMBER(4),
    hiredate DATE,
    sal NUMBER(7,2),
    comm NUMBER(7,2),
    deptno NUMBER(2),
    foreign key (deptno) references Dept(deptno));
    
INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES(20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES(30, 'SALES', 'CHICAGO');
INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES(40, 'OPERATIONS', 'BOSTON');

INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000, NULL, 20);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100, NULL, 20);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);


-- (1) ����� �̸��� ������ ����Ͻÿ�. ��, ����� �̸��� '����̸�', ������ '�������' �Ӹ�Ŭ�� �������� ����Ѵ�.
select ename as ����̸�, job as �������
from emp;


-- (2) 30�� �μ��� �ٹ��ϴ� ��� ����� �̸��� �޿��� ����Ͻÿ�
SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO = 30; 


-- (3) �����ȣ�� �̸�, ���� �޿�, ������ �޿���(�� �̸��� '������'), 10% �λ�� �޿�(�� �̸��� '�λ�� �޿�')�� �����ȣ������ ����Ͻÿ�.
SELECT EMPNO AS �����ȣ,
    ENAME AS �̸�,
    SAL AS "���� �޿�",
    SAL*0.1 AS ������,
    SAL*1.1 AS "�λ�� �޿�"
FROM  EMP
ORDER BY EMPNO;
    

-- (4) 'S'�� �����ϴ� ��� ����� �μ���ȣ�� ����Ͻÿ�.
SELECT ENAME AS �̸�,
    DEPTNO AS �μ���ȣ
FROM EMP
WHERE ENAME LIKE 'S%';


-- (5) ��� ����� �ִ� �� �ּ� �޿�, �հ� �� ��� �޿��� ����Ͻÿ�. �� �̸��� ���� MAX, MIN, SUM, AVG�� �Ѵ�.
-- ��, �Ҽ��� ���ϴ� �ݿø��Ͽ� ������ ����Ѵ�.
SELECT MAX(SAL) AS MAX,
    MIN(SAL) AS MIN,
    SUM(SAL) AS SUM,
    ROUND(AVG(SAL)) AS AVG
FROM EMP;


-- (6) ���� �̸��� �������� ������ ������ �ϴ� ����� ���� ����Ͻÿ�. �� �̸��� ���� '����'�� '������ �����'�� �Ѵ�.
SELECT DNAME AS ����, 
    COUNT(*) AS "������ �����"
FROM DEPT, EMP
WHERE DEPT.DEPTNO=EMP.DEPTNO
GROUP BY DNAME;


-- (7) ����� �ִ� �޿��� �ּ� �޿��� ������ ����Ͻÿ�.
SELECT MAX(SAL)-MIN(SAL) AS ����
FROM EMP;


-- (8) 30�� �μ��� ��� ���� ����� �޿��� �հ�� ����� ����Ͻÿ�.
SELECT COUNT(*) AS "��� ��",
    SUM(SAL) AS "�޿� �հ�",
    ROUND(AVG(SAL)) AS "�޿� ���"
FROM EMP
WHERE DEPTNO = 30;


-- (9) ��� �޿��� ���� ���� �μ��� ��ȣ�� ����Ͻÿ�.
SELECT DEPTNO AS �μ���ȣ
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL)=(
    SELECT MAX(AVG_SAL)
    FROM(
        SELECT AVG(SAL) AS AVG_SAL
        FROM EMP
        GROUP BY DEPTNO
    )
);


-- (10) �������(SALESMAN)�� �����ϰ�, �� ������ ����� �ѱ޿��� 3,000 �̻��� �� ������ ���ؼ�, ������� �� ������ ��� �޿��� ����Ͻÿ�.
-- �� ��� �޿��� ������������ ����Ѵ�.
SELECT JOB AS ������,
    ROUND(AVG(SAL)) AS "��� �޿�"
FROM EMP
GROUP BY JOB
HAVING JOB != 'SALESMAN'
AND SUM(SAL)>=3000
ORDER BY AVG(SAL) DESC;


-- (11) ��ü ��� ��� ���ӻ���� �ִ� ����� ���� ����Ͻÿ�.
SELECT COUNT(*)
FROM EMP
WHERE MGR IS NOT NULL;


-- (12) Emp ���̺��� �̸�, �޿�, Ŀ�̼�(comm) �ݾ�, �Ѿ�(sal*12+comm)�� ���Ͽ� �Ѿ��� ���� ������� ����Ͻÿ�.
-- ��, Ŀ�̼��� NULL�� ����� �����Ѵ�.
SELECT ENAME AS �̸�,
    SAL AS �޿�,
    COMM AS "Ŀ�̼� �ݾ�",
    SUM(SAL*12)+SUM(COMM) AS �Ѿ�
FROM EMP
GROUP BY ENAME, SAL, COMM
HAVING SUM(SAL*12)+SUM(COMM) IS NOT NULL
ORDER BY SUM(SAL*12+COMM) DESC;


-- (13) �� �μ����� ���� ������ �ϴ� ����� �ο����� ���Ͽ� �μ���ȣ, ���� �̸�, �ο����� ����Ͻÿ�.
SELECT DEPTNO AS �μ���ȣ,
    JOB AS �����̸�,
    COUNT(*) AS �ο���
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO;


-- (14) ����� 1�� ���� �μ��� �̸��� ����Ͻÿ�.
SELECT DNAME
FROM DEPT
WHERE DEPTNO NOT IN(
    SELECT DEPTNO
    FROM EMP
);


-- (15) ���� ������ �ϴ� ����� ���� 4�� �̻��� ������ �ο����� ����Ͻÿ�.
SELECT JOB AS ����,
    COUNT(*) AS �ο���
FROM EMP
GROUP BY JOB
HAVING COUNT(*)>=4;


-- (16) �����ȣ�� 7400 �̻� 7600 ������ ����� �̸��� ����Ͻÿ�.
SELECT ENAME AS �̸�
FROM EMP
WHERE EMPNO >= 7400
AND EMPNO <= 7600;


-- (17) ����� �̸��� ����� �μ��̸��� ����Ͻÿ�.
SELECT ENAME AS �̸�,
    DNAME AS �μ��̸�
FROM DEPT, EMP
WHERE DEPT.DEPTNO=EMP.DEPTNO
ORDER BY ENAME;


-- (18) ����� �̸��� ����(mgr)�� �̸��� ����Ͻÿ�.
SELECT E1.ENAME AS �̸�,
    E2.ENAME AS ����
FROM EMP E1, EMP E2
WHERE E1.MGR=E2.EMPNO;


-- (19) ��� SCOTT���� �޿��� ���� �޴� ����� �̸��� ����Ͻÿ�.
SELECT ENAME AS �̸�
FROM EMP
WHERE SAL>(
    SELECT SAL
    FROM EMP
    WHERE ENAME LIKE 'SCOTT'
);


-- (20) ��� SCOTT�� ���ϴ� �μ���ȣ Ȥ�� DALLAS�� �ִ� �μ���ȣ�� ����Ͻÿ�.
SELECT DEPTNO AS �μ���ȣ
FROM EMP
WHERE ENAME LIKE 'SCOTT';

SELECT DEPTNO AS �μ���ȣ
FROM DEPT
WHERE LOC LIKE 'DALLAS';










