-- 문자열 함수

-- 1. 대소문자 변환 함수
SELECT
       UPPER(EMAIL) -- 대문자
     , LOWER(EMAIL) -- 소문자
     , INITCAP(EMAIL) -- 첫 글자는 대문자, 나머지는 소문자
  FROM
       EMPLOYEES;
        
        
-- 2. 글자 수(LENGTH) / 바이트 수(LENGTHB) 반환함수 

SELECT
       LENGTH('HELLO')      -- 글자수 : 5S
     , LENGTH('안녕')        -- 글자수 : 2
     , LENGTHB('HELLO')     -- 글자수 : 5
     , LENGTHB('안녕')       -- 글자수 : 6 ( UTF-8 이라서)
     
    
  FROM
        DUAL;
        
-------------------------------------------------

-- 3. 문자열 연결 함수/연산자
--    1) 함수 : CONCAT(A,B) **주의 : 인수가 2개만 전달 가능하다 (CONCAT(A,B,C)같은 형태는 불가능하다)
--    2) 연산자: 주의!!! OR 연산자 아닙니다 오라클 전용입니다!!!!


SELECT
       CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME)
     , FIRST_NAME || ' ' || LAST_NAME -- 오라클에서는 || 이게 + 임
  FROM
        EMPLOYEES;
        

-- 자바와 디비에서 둘다 할 수 있다면 디비에서 하는게 맞다.
--------------------------------------------------------

        
-- 4. 문자열 일부 반환하기
-- SUBSTR(칼럼, BEGIN, LENGTH) : BEGIN 부터 LEINGTH개를 반환 

-- 주의!! begin은 1에서 시작한다

SELECT
       SUBSTR(EMAIL, 1, 3) -- 1부터 3까지
       
  FROM
        EMPLOYEES;

-- 5. 특정 문자열의 위치 반환하기
-- INTSTR(칼럼, 문자열)
-- 주의! 반환되는 위치 정보는 인덱스가 아니므로  0부터 시작하지 않고 1부터 시작한다.
-- 못 찾으면 0을 반환한다 
        
SELECT
       INSTR(EMAIL, 'A') -- 'A'의 위치를 반환
  FROM
        EMPLOYEES;
        
-- 6. 문자열 채우기(PADDING)
-- 1) LPAD(칼럼, 전체폭, 채울문자)
-- 2) RPAD(칼럼, 전체폭, 채울문자)
-- 아이디 같은거 일부만 보여줄 때 사용

SELECT
       LPAD(NVL(DEPARTMENT_ID, 0), 3, '0') --널이나오면 0을 쓸게
     , RPAD(SUBSTR(EMAIL, 1, 2), 5, '*') -- 에스터리스크
  FROM
        EMPLOYEES;
        
-- 7. 불필요한 공백 제거

-- 1) LTRIM(칼럼) : 왼쪽 공백 제거
-- 2) RTRIM(칼럼) : 오른쪽 공백 제거
-- 3) TRIM(칼럼) : 왼쪽, 오른쪽 공백 모두 제거

SELECT
       '[' || LTRIM('      HELLO') || ']'
     , '[' || RTRIM('HELLO      ') || ']'
     , '[' || TRIM('    HELLO   ') || ']'
  FROM
        DUAL;

      
        
        
        
