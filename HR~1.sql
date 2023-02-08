-- 문자열 함수

-- 1. 대소문자 변환 함수
SELECT
       UPPER(EMAIL) -- 대문자
     , LOWER(EMAIL) -- 소문자
     , INITCAP(EMAIL) -- 첫 글자는 대문자, 나머지는 소문자
  FROM
       DUAL;
        
        
-- 2. 글자 수 (바이트 수) 반환함수 

SELECT
       LENGTH('HELLO')      -- 글자수 : 5S
     , LENGTH('안녕')        -- 글자수 : 2
     , LENGTHB('HELLO')     -- 글자수 : 5
     , LENGTHB('안녕')       -- 글자수 : 6 ( UTF-8 이라서)
    
  FROM
        DUAL;
        
        
-- 3. 문자열 연결 함수/연산자
--    1) 함수 : CONCAT(A,B) **주의 : 인수가 2개만 전달 가능하다 (CONCAT(A,B,C)같은 형태는 불가능하다)
--    2) 연산자: 주의!!! OR 연산자 아닙니다 오라클 전용입니다!!!!


SELECT
       CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME)
     , FIRST_NAME || ' ' || LAST_NAME -- 오라클에서는 || 이게 + 임
  FROM
        DUAL;

-- 자바와 디비에서 둘다 할 수 있다면 디비에서 하는게 맞다.
-- 
        
        
        
        
        
        
        
        