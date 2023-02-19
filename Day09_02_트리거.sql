-- 인설트 업데이트 딜레이트 하면 trigger가 동작
-- 회원  / 회원 탈퇴 를 예시로 들면
-- 우리는 회원 딜레이트만 시켜주면 자동으로 트리거가 탈퇴시켜주는.
-- 요즘 휴면계정도 있으니, 그 구성할떄는 트리거 동작시키기가 애매함

/*
    트리거(TRIGGER)
    1. DML(INSERT, UPDATE, DELETE) 작업 후 자동으로 실행되는 데이터 베이스 객체이다.
    2. 행(ROW) 단위로 트리거가 동작한다.
    3. 종류
        1) BEFORE 트리거 : DML 동작 이전에 수행된다
        2) AFTER 트리거  : DML 동작 이후에 수행된다 
    4. 형식
        CREATE [OR REPLACE] TRIGGER 트리거명
        BEFORE | AFTER -- (또는)
        INSERT OR UPDATE OR DELETE
        ON 테이블명
        FOR EACH ROW
        BEGIN
            트리거본문
        END;
        
*/

SET SERVEROUTPUT ON;

-- TRIG1 정의
CREATE OR REPLACE TRIGGER TRIG1
    AFTER
    UPDATE
    ON EMPLOYEES
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World');
END;

-- TRIG1 동작 확인(EMPLOYEES 테이블의 데이터를 수정 해본다)
UPDATE EMPLOYEES
   SET LAST_NAME = 'Queen'
 WHERE EMPLOYEE_ID = 100;
 
 
-- TRIG1 삭제
DROP TRIGGER TRIG1; -- 계속 업데이트 되니까 삭제 시켜놓자.


-- TRIG2 정의
CREATE OR REPLACE TRIGGER TRIG2
    AFTER
    INSERT OR UPDATE OR DELETE  -- 작성 순서 없음
    ON EMPLOYEES
    FOR EACH ROW
BEGIN
    IF INSERTING THEN  -- 삽입 후 동작할 작업
        DBMS_OUTPUT.PUT_LINE('INSERT를 했군요.');
    ELSIF UPDATING THEN  -- 수정 후 동작할 작업
        DBMS_OUTPUT.PUT_LINE('UPDATE를 했군요.');
    ELSIF DELETING THEN  -- 삭제 후 동작할 작업
        DBMS_OUTPUT.PUT_LINE('DELETE를 했군요.');
    END IF;
END;


-- TRIG2 동작 확인
INSERT INTO EMPLOYEES(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID) VALUES(99, 'A', 'A', SYSDATE, 'A');
UPDATE EMPLOYEES SET FIRST_NAME = 'Kim' WHERE EMPLOYEE_ID = 99;
DELETE FROM EMPLOYEES WHERE EMPLOYEE_ID = 99;

-- TRIG2 삭제
DROP TRIGGER TRIG2;

/*
    OLD 테이블
    1. INSERT, UPDATE, DELETE 수행 이전의 정보를 임시 저장하고 있는 테이블이다.
    2. :OLD 방식으로 호출한다.
    3. AFTER 트리거와 함께 사용한다.
        1) AFTER INSERT : NULL
        2) AFTER UPDATE : UPDATE 이전 데이터(수정되기 전의 데이터)
        3) AFTER DELETE : DELETE 이전 데이터(삭제되기 전의 데이터)
*/

-- TRIG3 정의
CREATE OR REPLACE TRIGGER TRIG3
    AFTER
    UPDATE OR DELETE
    ON EMPLOYEES
    FOR EACH ROW
BEGIN
    IF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('수정 전 LAST_NAME : ' || :OLD.LAST_NAME);
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('삭제 전 LAST_NAME : ' || :OLD.LAST_NAME);
    END IF;
END;

-- TRIG3 동작 확인
UPDATE EMPLOYEES SET LAST_NAME = 'Kim' WHERE EMPLOYEE_ID = 100;
DELETE FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

-- TRIG3 삭제
DROP TRIGGER TRIG3;



/*
    트리거 실습
    사원 테이블에서 삭제할 사원정보를 퇴사자 테이블로 삽입하는 RETIRE_TRIG 생성하기
    
    작업 순서
    1. 사원(EMPLOYEES) 테이블의 구조를 복사하여 퇴사자(RETIRES) 테이블을 생성한다.
    2. 퇴사자(RETIRES) 테이블에 퇴사번호(RETIRE_ID), 퇴사일자(RETIRE_DATE) 칼럼을 추가한다.
    3. 퇴사번호(RETIRE_ID) 칼럼을 기본키로 지정한다.
    4. 퇴사번호를 생성할 RETIRE_SEQ 시퀀스를 생성한다.
    5. RETIRE_TRIG 트리거를 생성한다.
        1) AFTER DELETE 트리거
        2) OLD 테이블의 데이터를 모두 퇴사자 테이블로 삽입한다.
        3) 퇴사번호는 시퀀스, 퇴사일자는 SYSDATE로 처리해서 삽입한다.
*/

-- 1. 사원(EMPLOYEES) 테이블의 구조를 복사하여 퇴사자(RETIRES) 테이블을 생성한다.
DROP TABLE RETIRES;
CREATE TABLE RETIRES
    AS(SELECT * FROM EMPLOYEES WHERE 1 = 2);

-- 2. 퇴사자(RETIRES) 테이블에 퇴사번호(RETIRE_ID), 퇴사일자(RETIRE_DATE) 칼럼을 추가한다.
ALTER TABLE RETIRES ADD RETIRE_ID NUMBER NOT NULL;
ALTER TABLE RETIRES ADD RETIRE_DATE DATE;

-- 3. 퇴사번호(RETIRE_ID) 칼럼을 기본키로 지정한다.
ALTER TABLE RETIRES
    ADD CONSTRAINT PK_RETIRE PRIMARY KEY(RETIRE_ID);

-- 4. 퇴사번호를 생성할 RETIRE_SEQ 시퀀스를 생성한다.
DROP SEQUENCE RETIRE_SEQ;
CREATE SEQUENCE RETIRE_SEQ NOCACHE;

-- 5. RETIRE_TRIG 트리거를 생성한다.
CREATE OR REPLACE TRIGGER RETIRE_TRIG
    AFTER
    DELETE
    ON EMPLOYEES
    FOR EACH ROW
BEGIN
    INSERT INTO RETIRES(RETIRE_ID, RETIRE_DATE, EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
    VALUES(RETIRE_SEQ.NEXTVAL, SYSDATE, :OLD.EMPLOYEE_ID, :OLD.FIRST_NAME, :OLD.LAST_NAME, :OLD.EMAIL, :OLD.PHONE_NUMBER, :OLD.HIRE_DATE, :OLD.JOB_ID, :OLD.SALARY, :OLD.COMMISSION_PCT, :OLD.MANAGER_ID, :OLD.DEPARTMENT_ID);
END;

-- RETIRE_TRIG 동작 확인
DELETE FROM EMPLOYEES WHERE EMPLOYEE_ID BETWEEN 150 AND 200;





