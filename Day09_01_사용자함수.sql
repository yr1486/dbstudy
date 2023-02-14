/*
     사용자 함수(FUNCTION)
     -- 자바처럼 클래스 안에 들어가면 함수를 메소드라고 부르는거지 함수와 똑같다.
     1. 어떤 값을 반환할 때 사용하는 데이터베이스 객체
     2. 실제로 함수를 만들어서 직접 사용하는 개념이다.
     3. RETURN 개념이 존재한다.
     4. 함수의 결과값을 확인할 수 있도록 SELECT문에서 많이 사용한다. (비긴은 이름만으로 호출함)
     5. 형식
        CREATE [OR REPLACE] FUNCTION 함수명[(매개변수)] -- 매개변수가 없을때는 생략한다는..
        RETURN 반환타입 -- 값이 아니라 반환할 타입을 적는다.
        IS (또는 AS도 가능)
            변수 선언
        BEGIN
            함수 본문
        [EXCEPTION
            예외 처리]
        END;

*/

-- 사용자 함수 FUNC1 정의
CREATE OR REPLACE FUNCTION FUNC1
RETURN VARCHAR2 -- 반환타입에서는 크기를 명시하지 않는다. 20 BYTE 같은거 안적어도 됨. NUMBER 도 마찬가지
IS
BEGIN
    RETURN 'Hello World';
END;

--사용자 함수 FUNC1   호출
-- FUNC1(); 이렇게 호출하면 안됨
SELECT FUNC1() FROM DUAL;

-- 사용자 함수 FUNC2 정의
-- 사원번호를 전달하면 해당 사원의 FIRST_NAME을 반환하는 함수

-- 사용자 함수의 파라미터는 IN/OUT 표기가 없다
-- 입력 파라미터 형식으로 사용된다

CREATE OR REPLACE FUNCTION FUNC2(EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURN VARCHAR2
IS
    FNAME EMPLOYEES.FIRST_NAME%TYPE;
    LNAME EMPLOYEES.LAST_NAME%TYPE;
BEGIN

    SELECT FIRST_NAME, LAST_NAME
      INTO FNAME, LNAME
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID = EMP_ID;
     
     RETURN FNAME || ' ' || LNAME;

END;

-- 사용자 함수 FUNC2 호출
SELECT FUNC2(100), LAST_NAME
  FROM EMPLOYEES;
 --WHERE EMPLOYEE_ID = 100;
 
 -- 사용자 함수 FUNC3 정의
 -- 사원번호를 전달하면 해당 사원의 연봉이 15000 이상이면 '고액연봉', 아니면 '보통연봉'을 반환하는 함수
 CREATE OR REPLACE FUNCTION FUNC3(EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE)
 RETURN VARCHAR2
 IS
    SAL EMPLOYEES.SALARY%TYPE;
    MESSAGE VARCHAR2(12 BYTE);
BEGIN

    SELECT SALARY
      INTO SAL -- 변수로 저장시키
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID = EMP_ID;
     
     IF SAL >= 15000 THEN
        MESSAGE := '고액연봉';
    ELSE 
        MESSAGE := '보통연봉';
    END IF;
    
    RETURN MESSAGE;
    
END;

 -- 항상 정의 잡아서 실행 후
 -- 그담 아래 실행하기 
 
 -- 사용자 함수 FUNC3 호출
 SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, FUNC3(EMPLOYEE_ID)
   FROM EMPLOYEES; -- 모든 사원을 대상으로 
   
 
-- 함수 MY_CEIL 정의
CREATE OR REPLACE FUNCTION MY_CEIL(N NUMBER, DIGIT NUMBER)
RETURN NUMBER
IS
BEGIN
    RETURN CEIL(N * POWER(10, DIGIT)) /  POWER(10, DIGIT); -- DIGIT 은 제곱임!!
END;

-- 함수 MY_CEIL 호출
SELECT
       MY_CEIL(111.111, 2) -- 소수2자리 올림 
     , MY_CEIL(111.111, 1) -- 소수1자리 올림 
     , MY_CEIL(111.111, 0) -- 정수로 올림 
     , MY_CEIL(111.111, -1) -- 일의 자리 올림 
     , MY_CEIL(111.111, -2) -- 십의자리 올림 
  FROM
        DUAL;





/*

CREATE OR REPLACE FUNCTION MY_CEIL(N NUMBER, DIGIT NUMBER)
RETURN NUMBER
IS
BEGIN
    RETURN CEIL(N * POWER(10, DIGIT)) /  POWER(10, DIGIT); -- DIGIT 은 제곱임!!
END;

이거 풀어서 쓰면은
CEIL : 소수점 자리 올려주는 함수!!! ==> 실수를 정수로 만들어 주는 함수 

1.111 * 10 2(10의 2승) ==> CEIL(111.1) = 112 ///  112 / 10 2 ===> 1.12
1.111 * 10 1(10의 1승) ==> CEIL(11.11) = 12  ///  12  / 10 1 ===> 1.2
1.111 * 10 0(10의 0승) ==> CEIL(1.111) = 2  ///   2   / 10 0 ===> 2
10의 0승은 1임
*/

/*
floor 함수는 뜻 뜻 그대로 바닥..
소수점 아래를 무조건 무시
floor(3.6) = 3
floor(-1.6) = -2
floor(5.1) = 5

round함수는 우리가 알고있는 반올림 함수 
round(3.4) = 3
round(5.6) = 6
*/



-- 함수 MY_FLOOR 정의 
CREATE OR REPLACE FUNCTION MY_FLOOR(N NUMBER, DIGIT NUMBER)
RETURN NUMBER
IS
BEGIN
    RETURN FLOOR(N * POWER(10, DIGIT)) / POWER(10, DIGIT);
    
END;

-- 함수 MY_FLOOR 호출
SELECT
       MY_FLOOR(9999.999, 2)  --소수2자리 내림
     , MY_FLOOR(9999.999, 1)  --소수1자리 내림
     , MY_FLOOR(9999.999, 0)  --정수로 내림
     , MY_FLOOR(9999.999, -1)  --일의자리 내림
     , MY_FLOOR(9999.999, -2)  --십의자리 내림
    FROM DUAL;
              





































