/*
    셀프조인 어려우면 다른거부터 공부하기.. 웹개발에서 잘 안나옴 
    
    셀프 조인 SELF JOIN
    1. 하나의 테이블에 PK와 FK가 모두 있는 경우에 사용되는 조인이다. 함께 있는 구조
    2. 동일한 테이블을 조인하기 때문에 '별명'을 다르게 지정해서 조인한다
    3. 문법은 기본적으로 내부 조인과 동일하다 

*/

-- 모든 사원들의 EMPLOYEE_ID, FIRST_NAME, LAST_NAME, MANAGER의 FIRST_NAME을 조회하시오

-- 1:M 관계 파악
-- PK           FK
-- EMPLOYEE_ID  MANAGER_ID

-- 조인 조건 파악
-- 같은 테이블이지만 테이블이 2개 있다고 생각하고 PK와 FK의 관계를 그려보자.
-- PK에는 사원 정보가 들어있으니 왼쪽에 테이블을 넣고 FK에는 매니저 정보가 들어있으니 오른쪽에 테이블을 넣어 그려보자
-- 사원테이블 E          -   매니저테이블 M
-- 사원들의 매니저번호     -   매니저의 사원번호 

SELECT
       E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME  -- 각 사원들의 정보
     , M.FIRST_NAME                              -- 매니저 정보
  FROM
       EMPLOYEES E LEFT OUTER JOIN EMPLOYEES M
    ON
       E.MANAGER_ID = M.EMPLOYEE_ID
 ORDER BY
       E.EMPLOYEE_ID;

-- 셀프 조인 연습 
-- 각 사원 중에서 매니저보다 먼저 입사한 사원을 조회하시오

SELECT
       E.EMPLOYEE_ID, E.FIRST_NAME, E.HIRE_DATE AS 입사일자
     , M.EMPLOYEE_ID, M.FIRST_NAME, M.HIRE_DATE AS 매니저입사일자
  FROM
       EMPLOYEES E INNER JOIN EMPLOYEES M
    ON
       E.MANAGER_ID = M.EMPLOYEE_ID
 WHERE
       TO_DATE(E.HIRE_DATE, 'YY/MM/DD') < TO_DATE(M.HIRE_DATE, 'YY/MM/DD')
 ORDER BY
       E.EMPLOYEE_ID;

-- PK, FK가 아닌 일반 칼럼을 이용한 셀프 조인

-- 동일한 부서에서 근무하는 사원들을 조인하기 위해서  DEPATMENT_ID로 조인 조건을 생성
-- 사원(나)             사원(남)
-- EMPLOYEES ME       EMPLOYEES YOU

-- 문제... 같은 부서에서 근무하는 사원 중에서 나보다 SALARY 가 높은 사원 정보 조회하기
SELECT
       ME.EMPLOYEE_ID, ME.FIRST_NAME, ME.SALARY AS 내급여
     , YOU.FIRST_NAME, YOU.SALARY AS 너급여
     , ME.DEPARTMENT_ID, YOU.DEPARTMENT_ID
  FROM
       EMPLOYEES ME INNER JOIN EMPLOYEES YOU
    ON
       ME.DEPARTMENT_ID = YOU.DEPARTMENT_ID
 WHERE
       ME.SALARY < YOU.SALARY
 ORDER BY
       ME.EMPLOYEE_ID;



----------------------------------------------------------------------------------------------------------------------------------

-- 조인 연습.

-- 1. LOCATION_ID가 1700인 부서에 근무하는 사원들의 EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME을 조회하시오.
-- 1) 표준 문법
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 WHERE D.LOCATION_ID = 1700;

-- 2) 오라클 문법
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
   AND D.LOCATION_ID = 1700;


-- 2. DEPARTMENT_NAME이 'Executive'인 부서에 근무하는 사원들의 EMPLOYEE_ID, FIRST_NAME을 조회하시오.
-- 1) 표준 문법
SELECT E.EMPLOYEE_ID, E.FIRST_NAME
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 WHERE D.DEPARTMENT_NAME = 'Executive';

-- 2) 오라클 문법
SELECT E.EMPLOYEE_ID, E.FIRST_NAME
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
   AND D.DEPARTMENT_NAME = 'Executive';


-- 3. 모든 사원들의 EMPLOYEE_ID, FIRST_NANE, DEPARTMENT_NAME, CITY를 조회하시오
--  1) 표준문법
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME, L.CITY
  FROM LOCATIONS L INNER JOIN DEPARTMENTS D
     -- 여기까지 엘로케이션과 이로케이션을 합친 테이블. 
     -- 이제 이너조인 해야해
    
    ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;



--  2) 오라클문법
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME, L.CITY
  FROM LOCATIONS L, DEPARTMENTS D, EMPLOYEES E
 WHERE L.LOCATION_ID = D.LOCATION_ID
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;
   
   
   
-- 4. 부서별 DEPARTMENT_NAME과 사원 수와 평균 연봉을 조회하시오
-- GROUP BY와 JOIN 함께 사용해 보기

SELECT D.DEPARTMENT_NAME, COUNT(*), AVG(E.SALARY)
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME;

  -- 이름은 또같은게 여러개 나올 수 있어서 이름으로 그룹핑하면 어려움...!!!! 걸러낼 수가 없어
 -- 그리고 보고싶은걸 셀렉트가 아닌 그룹바이에 적는 것.
 -- 사실 부서이름도 똑같은 부서이름이 있다고 보기 어렵지만 이름의 상황을 생각하면 걸러내기 어려울수 있다고 생각하기.
 -- 둘 이상의 칼럼 이용해 다중 그룹화 진행이 가능함
 
-- 5. 모든 사원들의 EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME을 조회하시오.
-- 1) 표준 문법
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
  FROM DEPARTMENTS D RIGHT OUTER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 ORDER BY E.EMPLOYEE_ID;

-- 2) 오라클 문법
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID
 ORDER BY E.EMPLOYEE_ID;


-- 6. 모든 부서의 DEPARTMENT_NAME과 근무 중인 사원 수를 조회하시오. 근무하는 사원이 없으면 0으로 조회하시오.
SELECT D.DEPARTMENT_NAME, COUNT(E.EMPLOYEE_ID)
  FROM DEPARTMENTS D LEFT OUTER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME;