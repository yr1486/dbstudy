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

/*  중요 !!!!!!!!!!!!!!!!!!!!!

    테이블의 제약조건(Constraint) 5개
    1. 널
        1) NULL 또는 생략하거나
        2) NOT NULL 하거나
    
    2. 중복 데이터 방지 (동일한 데이터를 가질 수 없다)
        UNIQUE
        
    3. 값의 제한
        CHECK 제약 조건이라 부른다
    -----------------------------------------------------------------
    
    4. Primary Key = PK = 기본키 = 개체 무결성
    칼럼만들면서 pk를 고르는거임.
    pk를 주문 기본으로 낫널과 유니크를 가지는 개념.
    not null + unique 를 pk라고 부른다. pk = primary key = 기본키
    
    개체는 행!!!!! 가로
    
    CREATE TABLE MEMBER (
    ID VARCHAR2(20 BYTE) NOT NULL UNIQUE,
    ...
    회원번호 --PK
    가입일
    );
    
    CREATE TABLE BLOG (
    블로그번호 --PK
    제목
    내용
    조회수
    작성일
    회원번호 FK --->(메모..이화살표를 위 테이블로 올라간다고 생각하기)
    );
    
    CREATE TABLE BLOG IMAGE (
    이름
    경로
    블로그번호 FK--->(메모..이화살표를 위 테이블로 올라간다고 생각하기)
    );
   ---------------------------------------------------------------
    
    5. Foreign key = FK =참조무결성
    외래키 = FK
    밖으로 나가는 키

    FK는 PK를 참조한다
    이 문장에서 외래키는 맨마지막 구문
    이 문장에서 프라이머리키는 두번째 구문으로 이해하자.
    
    1과 M에 대해
    1 : M ===> 1대 다관계
    1은 블로그번호 1개만 있는 고유의 값 ==> 그러니까 1쪽에는 항상 PK가 있는거임 PK는 중복이 없으니까
    M은 낫널도 유니크도 아무것도 없어. 그냥 참조만 한다는 뜻. 참조하는 값만 가질 수 있다. 관계지을때 사용하는 키는? FK.
    
    DB는
    
1 대 다관계
    PK <- KF
    1  :  M   
    
다 대 다 관계
    M : N

    테이블 2개로는 만들 수 없다 ! 추가 테이블이 필요함!!!!!!!!!!!!
    1대 다관계 2개 있다 생각하면 되고 테이블은 3개있어야!!!!!!!!!! 다 대 다관계를 만들 수 있음
    
    *중요*
    다 대 다관계는 DB로 구현할 수 없다.
    (다 대 다)는 (1 대 다) 2개가 모여야 (다 대 다)가 된다.
    (해당 구조에 대해 사진찍어놈 , 꼭 그려보기)
    
    키 종류들을 다 알 필요는 없고 개념을 이해해보고 넘어가도 괜찮음
    PK와 FK만 확실하게 알고 가자.
    선거를 한다 생각해보면
    
    -----------------------------
    여러 키 후보들 중에
    
    모두 가능한건. 슈퍼키
    슈퍼키 중에서 후보를 추려 보자. 후보키
    그 후보 중에서 하나를 고르자. 기본키(PK)
    선택 못받은 나머지. 대체키
    
    ===> 다 기본키를 선정하기 위한 과정이라고 이해하기
    ----------------------------
    외래키(FK)
*/


-- 예시 테이블

-- CREATE TABLE ()괄호 구조를 이해해보자.
-- 자바에서는 '데이터타입 필드' 순서인데
-- 여기서는 '필드 데이터 타입'으로 쭉 나열되었다고 볼 수 있다.
-- 데이터가 입력된 테이블의 모습이고 가로 하나가(한 줄이) 입력되어 있는걸 말함.

DROP TABLE PRODUCT;
CREATE TABLE PRODUCT(
    CODE         VARCHAR2(2 BYTE)   NOT NULL UNIQUE, --동일한 제품의 코드를 하나씩만 이란 뜻이여서 UNIQUE가 쓰였음 // 그리고 낫널 유니크를 뒤집어서 유니크먼저쓰고 낫널 써도 됨
    MODEL        VARCHAR2(10 BYTE), -- 여기에 NULL이라고 적으면 안적는거랑 똑같움
    CATEGORY     VARCHAR2(5 BYTE)   CHECK(CATEGORY = 'MAIN' OR CATEGORY = 'SUB'), --여기서 같다는 = 기호 하나임.. == 이거아님 // CHECK(CATEGORY IN('MAIN', 'SUB')) 카테고리가 메인과 서브 중 하나다 라는 뜻 이 문법으로 익히자.
    PRICE        NUMBER             CHECK(PRICE >= 0), -- 가격은 -마이너스가 오면 안되니까 CHECK 써서 처리
    AMOUNT       NUMBER(2)          CHECK(AMOUNT >= 0 AND AMOUNT <= 100), --대체문법:CHECK(AMOUNT BETWEEN 0 AND 100) 으로 마스터하자
    MANUFACTURED DATE
); -- 여기까지가 한 문장, 띄어쓰기 많이 들어가도 상관없음

--이클립스는 순서가 타입 변수  // String code
-- 얘는             변수 타입  // CODE VARCHAR2

























