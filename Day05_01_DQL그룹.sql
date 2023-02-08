/*
     GROUP BY 절
     1. GROUP BY 절에서 지정한 칼럼의 데이터는 동일한 데이터끼리 하나로 모여서 조회된다
     2. SELECT 절에서 조회하려는 칼럼은 '반드시' GROUP BY 절에 있어야 한다 (필수 규칙)
*/

-- 1. 동일한 DEPARTMENT_ID를 그룹화하여 조회하시오 
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID;

-- 2. 동일한 DEPARTMENT_ID로 그룹화하여 FIRST_NAME과 DEPARTMENT_ID 조회하시오 (실패하는 쿼리문)
SELECT FIRST_NAME, DEPARTMENT_ID  -- FIRST_NAME 칼럼이 GROUP BY절에 없기 때문에 실행되지 않는다.
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID;

-- 3. GOROUP BY 절이 없는 집계함수는 전체 데이터를 대상으로 한다 
SELECT
       COUNT(*) AS 전체사원수
     , SUM(SALARY) AS 전체사원연봉합
     , AVG(SALARY) AS 전체사원연봉평균
     , MAX(SALARY) AS 전체사원연봉킹
     , MIN(SALARY) AS 전체사원연봉꽝
  FROM
       EMPLOYEES;

       
-- 4. GROUP BY  절을 지정하면 같은 그룹끼리 집계함수가 적용된다
SELECT
       DEPARTMENT_ID
     , COUNT(*) AS 부서별사원수
     , SUM(SALARY) AS 부서별연봉합
     , AVG(SALARY) AS 부서별연봉평균
     , MAX(SALARY) AS 부서별연봉킹
     , MIN(SALARY) AS 부서별연봉꽝  -- 칼럼대상으로 규칙이 적용 
  FROM
       EMPLOYEES
       WHERE 
       DEPARTMENT_ID IS NOT NULL --     부서가 없는 애 제외하기 
 GROUP BY
       DEPARTMENT_ID; -- 그룹바이절 다음에 HAVING절 올 수 있음 // 다만 웨얼이랑 해빙의 성능차이가 있음. 웨얼절이 성능이 좋음 그룹바이를 안해도 웨얼사용할 수 있음 
-- HAVING 그룹바이(그핑룹)을 해야 사용할 수 있는 조건은 해빙절. 집계함수와 함께 쓰이는 경우가 많음. 

 -- 참고. GROUP BY 없이 집계함수 사용하기
SELECT
       DISTINCT DEPARTMENT_ID
     , COUNT(*) OVER(PARTITION BY DEPARTMENT_ID) AS 부서별사원수
     , SUM(SALARY) OVER(PARTITION BY DEPARTMENT_ID) AS 부서별연봉합
     , AVG(SALARY) OVER(PARTITION BY DEPARTMENT_ID) AS 부서별연봉평균
     , MAX(SALARY) OVER(PARTITION BY DEPARTMENT_ID) AS 부서별연봉킹
     , MIN(SALARY) OVER(PARTITION BY DEPARTMENT_ID) AS 부서별연봉꽝
  FROM
       EMPLOYEES;



/*
    조건 지정하기
    1. GROUP BY 절로 그룹화 할 대상(모수)이 적을수록 성능에 유리하다.
    2. GROUP BY 이전에 처리할 수 있는 조건은 WHERE절로 처리하는 것이 유리하다
    3. GROUP BY 이후에만 처리할 수 있는 조건은 HAVING 절 처리한다.
*/

-- 5. DEPARTMENT_ID가 NULL인 부서를 제외하고, 모든 부서의 부서별 사원 수를 조회하시오.
--    해설) DEPARTMENT_ID가 NULL 부서의 제외는 GROUP BY 이전에 처리할 수 있으므로 WHERE절로 처리한다.
SELECT
       DEPARTMENT_ID
     , COUNT(*) AS 부서별사원수
  FROM
       EMPLOYEES
 WHERE
       DEPARTMENT_ID IS NOT NULL
 GROUP BY
       DEPARTMENT_ID;

       
-- 6. 부서별 인원 수가 5명 이하인 부서를 조회하시오.
--    해설) 부서별 인원 수는 GROUP BY 이후에 확인할 수 있으므로 HAVING절에서 조건을 처리한다.
SELECT
       DEPARTMENT_ID
     , COUNT(*) AS 부서별사원수
  FROM
       EMPLOYEES
 GROUP BY
       DEPARTMENT_ID
HAVING
       COUNT(*) <= 5;




