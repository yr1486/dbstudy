
/*
    <테이블>
    1. 데이터베이스의 가장 대표적인 '객체'이다.
    2. 데이터를 보관하는 객체이다.
    3. 표 형식으로 데이터를 보관한다
    4. 테이블 기본 용어
        1) 열 : column = attribute 속성이라고도 함 = 필드(field) 라고도 함
        2) 행 : row,          entity 개체                 레코드(record)
    
    반듀시 외워랏
*/


/*
    <오라클의 데이터 타입>
    1. CHAR(size)           : 고정 길이 '문자' 타입 ====> 이클립스랑 비교하면 char아니고 String으로 생각하기
                              데이터의 길이가 고정되어 있을때 쓰기 좋음 ex) 주민번호
                              size : 1 ~ 2000바이트
    
    2. VARCHAR2(size)        : 가변 길이 문자 타입   ====> 길이가 변한다. ex) 집주소(길이가 다름)
                              size : 1 ~ 4000바이트 (4000 이상 못씀)
        
    3. DATE                 : 날짜/시간 타입
    4. TIMESTAMP            : 날짜/시간 타입 (위보다 좀더 정밀함)
    5. NUMBER(p,s)          : 정밀도(p), 스케일(s)로 표현하는 숫자 타입
                              1) 정밀도 : 정수부와 소수부를 모두 포함하는 전체 유효 숫자가 몇 개인가?
                              2) 스케일 : 소수부의 전체 유효 숫자가 몇 개인가?
                                       
                                        예시) 
                                        1. NUMBER : 최대 38자리 숫자 (22바이트)
                                        2. NUMBER(3) : 정수부가 최대 3자리인 숫자 (최대 999)
                                        3. NUMBER(5,2) : 최대 전체 5자리, 소수부 2자리인 숫자 (123.45)
                                        4. NUMBER(2,2) : 1미만의 
                                        소수부 1자리인 실수(0.15) - 정수부의 0은 유효 자리가 아님


*/

/*
    제약조건(Constraint) 5개 중 3가지를 먼저 알아보자.
    1. 널
        1) NULL 또는 생략하거나
        2) NOT NULL 하거나
    
    2. 중복 데이터 방지 (동일한 데이터를 가질 수 없다)
        UNIQUE
        
    3. 값의 제한
        CHECK 제약 조건이라 부른다
        
*/

-- 예시 테이블
-- CREATE TABLE ()괄호 안에서 '필드 데이터' 타입으로 쭉 나열한거임 // 데이터가 입력된 테이블인데 가로 하나가(한줄이) 입력되어 있는걸 말함.
DROP TABLE PRODUCT; -- 지우겠단 뜻.
CREATE TABLE PRODUCT(
    CODE         VARCHAR2(2 BYTE) NOT NULL UNIQUE, --동일한 제품의 코드를 하나씩만 이라서 UNIQUE가 쓰였음 //그리고 낫널 유니크를 뒤집어서 유니크먼저쓰고 낫널 써도 됨
    MODEL        VARCHAR2(10 BYTE), --여기에 NULL이라고 적으면 안적는거랑 똑같움
    CATEGORY     VARCHAR2(5 BYTE) CHECK(CATEGORY = 'MAIN' OR CATEGORY = 'SUB'), --여기서 같다는 = 하나임.. ==이거아님 메인또는 카테고리에 제약조건을 건거임 // CHECK(CATEGORY IN('MAIN', 'SUB')) 카테고리가 메인과 IN 중 하나다 라는뜻 이문법으로 가자
    PRICE        NUMBER             CHECK(PRICE >= 0), --가격은 -가 오면 안되니까 CHECK써서 처리
    AMOUNT       NUMBER(2)          CHECK(AMOUNT >= 0 AND AMOUNT <= 100), --대체문법:CHECK(AMOUNT BETWEEN 0 AND 100) 으로 마스터하자
    MANUFACTURED DATE
);

/*
CREATE TABLE PRODUCT(
    CODE    VARCHAR2(2 BYTE) NOT NULL UNIQUE,
    MODEL VARCHAR2(10 BYTE),
    CATEGORY VARCHAR2(5 BYTE) CHECK(CATEGORY = 'MAIN' OR CATEGORY = 'SUB'), CHECK(CATEGORY IN('MAIN', 'SUB'))
    PRICE NUMBER CHECK(PRICE >=0),
    AMOUNT NUMBER CHECK(AMOUNT >= 0 AND AMOUNT <= 100),
    MANUFACTURED DATE
    
    
    
    
    
*/

-- 이거 한문장임, 띄어쓰기 많이 들어가도 상관없음

--이클립스는 타입 변수 인데 String code
-- 얘는 변수 타입임 CODE VARCHAR2

-- 필수 제약 조건
--1. NOT NULL


































