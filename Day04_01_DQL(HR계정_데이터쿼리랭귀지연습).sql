/*
문법1. EMPLOYEES 테이블에서 FIRST_NAME, LAST_NAME 조회 하기 

SELECT FIRST_NAME, LAST_NAME
  FROM EMPLOYEES; 
  
 문법2. EMPLOYEES 테이블에서 FIRST_NAME, LAST_NAME 오너 명시하기
        기존의 SELECT문에서 오너를 명시하는 추가 문법. 쓰든 안쓰든 결과는 같음

SELECT EMPLOYEES.FIRST_NAME, EMPLOYEES.LAST_NAME -- 칼럼의 오너 표시
  FROM HR.EMPLOYEES; -- HR계정이 가지고 있는 EMPLOYEES 불러오기 => HR. 이라고 오너를 명시하기. // 칼럼의 오너도 적을 수 있음
    
문법3. 네임이 길어지니까 별명 주기 => 한칸 띄고 별명
SELECT E.FIRST_NAME AS FNAME, E.LAST_NAME AS LNAME -- 칼럼은 공백 별명 또는 AS 공백 별명 둘다 사용 가능, 가독성을 위해 AS를 쓰도록 하자.
  FROM HR.EMPLOYEES E; ----테이블 이름은 공백만되고. AS가 안됨 
  
  */
  
  
-- 2. EMPLOYEES 테이블에서 DEPARTMENT_ID를 중복 제거하고 조회하기
 
-- 중복값이 있음
SELECT DEPARTMENT_ID
  FROM EMPLOYEES;
-- 중복값이 없음
SELECT DISTINCT DEPARTMENT_ID
  FROM EMPLOYEES;
    
-- 3. EMPLOYEES 테이블에서 EMPLOYEE_ID가 150인 사원 조회하기
    
-- 먼저 임플로이 아이디가 숫자인지 문자인지 확인해야하니까 디스크라이브로 확인 ==> 굳이 테이블을 열지 않아도 됨
DESCRIBE EMPLOYEES;
    DESC EMPLOYEES; -- 줄여서 쓰자
    
-- 이제 DESCSRIBE를 통해 숫자인거 알았으니
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID = 150; -- WHERE 니까 조건절, WHERE절(조건)의 등호(=)는 비교 연산자이다.    
    
-- 4. EMPLOYEES 테이블에서 SALARY 가 10000 ~ 20000 사이인 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY BETWEEN 10000 AND 20000; -- SALARY >= 10000 AND SALARY <= 20000;
    
-- 5. EMPLOYEES 테이블에서 DEPARTMENT_ID가 30, 40, 50인 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (30, 40, 50); -- IN은 30 OR 4O OR 50을 대신해 쓸수 있는 연산자
     
     
-- 6. EMPLOYEES 테이블에서 DEPARTMENT_ID가 NULL인 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IS NULL; -- NULL 체크문 꼭 기억하기 // IS NOT NULL
     
    
-- 7. EMPLOYEES 테이블에서 PHONE_NUMBER '515' 로 시작하는 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE '515%'; -- = 515 하면 안됨. // -- PHONE_NUMBER NOT LIKE '515%'
    

-- 8. EMPLOYEES 테이블을 FIRST_NAME의 가나다순(오름차순:Ascending Sort)으로 정렬해서 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
  FROM EMPLOYEES
 ORDER BY FIRST_NAME ASC; --ASC는 생략가능 안적어도 오름차순으로 동작함
    
--9. EMPLOYEES 테이블을 높은 SALARY(내림차순:Descending Sort)를 받는 사원 순으로 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
  FROM EMPLOYEES
 ORDER BY SALARY DESC; --DESC는 생략 불가, 기본이 오름차순이니까.
    
-- 10. EMPLOYEES 테이블의 사원들을 DEPARTMENT_ID순으로 조회하고, 동일한 DEPARTMENT_ID를 가진 사원들은 높은 SALARY 순으로 조회하기
-- 1차 정렬 2차 높은 샐러리
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY AS SAL --SALARY AS SAL ==> 가능한 이유. 프롬-셀렉트-오더문 순서로 실행되니까 적용가능.
  FROM EMPLOYEES
ORDER BY DEPARTMENT_ID ASC, SAL DESC;
-- 주의 할 것 : 1차  ASC는 오름이라 생략이 가능함, 2차는 내림으로 해석해야함 각각 다른 차순인걸 이해하기 오름은 생략이 가능하니까!!! 조심하기.
    
    