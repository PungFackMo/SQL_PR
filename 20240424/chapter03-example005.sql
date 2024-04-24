-- Documents\dev\database\workspace\chapter03\chapter03-example005.sql

-- [사원 데이터베이스] Dept는 부서(Department) 테이블로 deptno(부서번호), dname(부서이름),
-- loc(위치, location)으로 구성되어 있다. Emp는 사원(Employee)테이블로 empno(사원번호),
-- ename(사원이름), job(업무), mgr(팀장번호, manager), hiredate(고용날짜), sal(급여, salary),
-- comm(커미션금액, commission), deptno(부서번호)로 구성되어 있다. 밑줄 친 속성은 기본키이고
-- Emp의 deptno는 Dept의 deptno를 참조하는 외래키이다. 사원 데이터베이스는 demo_scott.sql
-- 스크립트를 실행하여 설치하도록 한다.

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


-- (1) 사원의 이름과 업무를 출력하시오. 단, 사원의 이름은 '사원이름', 업무는 '사원업무' 머리클이 나오도록 출력한다.
select ename as 사원이름, job as 사원업무
from emp;


-- (2) 30번 부서의 근무하는 모든 사원의 이름과 급여를 출력하시오
SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO = 30; 


-- (3) 사원번호와 이름, 현재 급여, 증가된 급여분(열 이름은 '증가액'), 10% 인상된 급여(열 이름은 '인상된 급여')를 사원번호순으로 출력하시오.
SELECT EMPNO AS 사원번호,
    ENAME AS 이름,
    SAL AS "현재 급여",
    SAL*0.1 AS 증가액,
    SAL*1.1 AS "인상된 급여"
FROM  EMP
ORDER BY EMPNO;
    

-- (4) 'S'로 시작하는 모든 사원과 부서번호를 출력하시오.
SELECT ENAME AS 이름,
    DEPTNO AS 부서번호
FROM EMP
WHERE ENAME LIKE 'S%';


-- (5) 모든 사원의 최대 및 최소 급여, 합계 및 평균 급여를 출력하시오. 열 이름은 각각 MAX, MIN, SUM, AVG로 한다.
-- 단, 소수점 이하는 반올림하여 정수로 출력한다.
SELECT MAX(SAL) AS MAX,
    MIN(SAL) AS MIN,
    SUM(SAL) AS SUM,
    ROUND(AVG(SAL)) AS AVG
FROM EMP;


-- (6) 업무 이름과 업무별로 동일한 업무를 하는 사원의 수를 출력하시오. 열 이름은 각각 '업무'와 '업무별 사원수'로 한다.
SELECT DNAME AS 업무, 
    COUNT(*) AS "업무별 사원수"
FROM DEPT, EMP
WHERE DEPT.DEPTNO=EMP.DEPTNO
GROUP BY DNAME;


-- (7) 사원의 최대 급여와 최소 급여의 차액을 출력하시오.
SELECT MAX(SAL)-MIN(SAL) AS 차액
FROM EMP;


-- (8) 30번 부서의 사원 수와 사원들 급여의 합계와 평균을 출력하시오.
SELECT COUNT(*) AS "사원 수",
    SUM(SAL) AS "급여 합계",
    ROUND(AVG(SAL)) AS "급여 평균"
FROM EMP
WHERE DEPTNO = 30;


-- (9) 평균 급여가 가장 높은 부서의 번호를 출력하시오.
SELECT DEPTNO AS 부서번호
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


-- (10) 세일즈맨(SALESMAN)을 제외하고, 각 업무별 사원의 총급여가 3,000 이상인 각 업무에 대해서, 업무명과 각 업무별 평균 급여를 출력하시오.
-- 단 평균 급여의 내림차순으로 출력한다.
SELECT JOB AS 업무명,
    ROUND(AVG(SAL)) AS "평균 급여"
FROM EMP
GROUP BY JOB
HAVING JOB != 'SALESMAN'
AND SUM(SAL)>=3000
ORDER BY AVG(SAL) DESC;


-- (11) 전체 사원 가운데 직속상관이 있는 사원의 수를 출력하시오.
SELECT COUNT(*)
FROM EMP
WHERE MGR IS NOT NULL;


-- (12) Emp 테이블에서 이름, 급여, 커미션(comm) 금액, 총액(sal*12+comm)을 구하여 총액이 많은 순서대로 출력하시오.
-- 단, 커미션이 NULL인 사람은 제외한다.
SELECT ENAME AS 이름,
    SAL AS 급여,
    COMM AS "커미션 금액",
    SUM(SAL*12)+SUM(COMM) AS 총액
FROM EMP
GROUP BY ENAME, SAL, COMM
HAVING SUM(SAL*12)+SUM(COMM) IS NOT NULL
ORDER BY SUM(SAL*12+COMM) DESC;


-- (13) 각 부서별로 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무 이름, 인원수를 출력하시오.
SELECT DEPTNO AS 부서번호,
    JOB AS 업무이름,
    COUNT(*) AS 인원수
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO;


-- (14) 사원이 1명도 없는 부서의 이름을 출력하시오.
SELECT DNAME
FROM DEPT
WHERE DEPTNO NOT IN(
    SELECT DEPTNO
    FROM EMP
);


-- (15) 같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수를 출력하시오.
SELECT JOB AS 업무,
    COUNT(*) AS 인원수
FROM EMP
GROUP BY JOB
HAVING COUNT(*)>=4;


-- (16) 사원번호가 7400 이상 7600 이하인 사원의 이름을 출력하시오.
SELECT ENAME AS 이름
FROM EMP
WHERE EMPNO >= 7400
AND EMPNO <= 7600;


-- (17) 사원의 이름과 사원의 부서이름을 출력하시오.
SELECT ENAME AS 이름,
    DNAME AS 부서이름
FROM DEPT, EMP
WHERE DEPT.DEPTNO=EMP.DEPTNO
ORDER BY ENAME;


-- (18) 사원의 이름과 팀장(mgr)의 이름을 출력하시오.
SELECT E1.ENAME AS 이름,
    E2.ENAME AS 팀장
FROM EMP E1, EMP E2
WHERE E1.MGR=E2.EMPNO;


-- (19) 사원 SCOTT보다 급여를 많이 받는 사람의 이름을 출력하시오.
SELECT ENAME AS 이름
FROM EMP
WHERE SAL>(
    SELECT SAL
    FROM EMP
    WHERE ENAME LIKE 'SCOTT'
);


-- (20) 사원 SCOTT이 일하는 부서번호 혹은 DALLAS에 있는 부서번호를 출력하시오.
SELECT DEPTNO AS 부서번호
FROM EMP
WHERE ENAME LIKE 'SCOTT';

SELECT DEPTNO AS 부서번호
FROM DEPT
WHERE LOC LIKE 'DALLAS';










