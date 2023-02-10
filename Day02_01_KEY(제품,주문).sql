/*

KEY 제약 조건
1. 기본키(PK)
    1. 개체무결성
    2. PK는 NOT NULL + UNIQUE 해야한다.
2. 외래키(FK)
    1. 참조무결성
    2. FK는 참조하는 값만 가질 수 있다

*/

/*
    일대다(1:M) 관계
    1. PK와 FK를 가진 테이블 간의 관계이다
     1. 부모 테이블 : 1 (==> PK를 가진 테이블)
     2. 자식 테이블 : M (==> FK를 가진 테이블)
     
    2. 생성과 삭제 규칙 
        1. 생성 규칙 : "반드시" 부모 테이블을 먼저 생성한다
        2. 삭제 규칙 " "반드시" 자식 테이블을 먼저 삭제한다
        
*/

/*
    외래키 제약 조건의 옵션
    1. ON DELETE CASCADE
        1) 참조 중인 PARENT KEY가 삭제되면 해당 PARENT KEY를 가진 행 전체를 함께 삭제한다.
        2) 예시) 회원 탈퇴 시 작성한 모든 게시글이 함께 삭제됩니다.
                 게시글 삭제 시 해당 게시글에 달린 모든 댓글이 함께 삭제됩니다.
    2. ON DELETE SET NULL
        1) 참조 중인 PARENT KEY가 삭제되면 해당 PARENT KEY를 가진 칼럼 값만 NULL로 처리한다.
        2) 예시) 어떤 상품을 제거하였으나 해당 상품의 주문 내역은 남아 있는 경우
*/


-- 테이블 삭제
DROP TABLE ORDER_TBL;
DROP TABLE PRODUCT_TBL;


--중요중요중요......
-- 삭제를 몰아서 위쪽에 배치하고 생성을 아래쪽에 배치하자.
-- 생성 삭제 순서는 거꾸로!!!!!!!!

-- 만드는거 부터 먼저 한다음 (만들고 맨위에 드랍적고 하는것부터 먼저 적고, 나중에 규칙 생각해서
-- 맨위에 삭제 올려서 순서 거꾸로 삭제 만들어주는 연습하기


-- 제품 테이블(부모테이블)
CREATE TABLE PRODUCT_TBL (
    PROD_NO NUMBER NOT NULL,  --CONSTRAINT PK_PROD PRIMARY KEY, -- NOT NULL은 생략해도 똑같이 돌아가고 원래 생략해도 되는디 수업에서 그냥 명시하잡.
    PROD_NAME VARCHAR2(10 BYTE),
    PROD_PRICE NUMBER,
    PROD_STOCK NUMBER,
    CONSTRAINT PK_PROD PRIMARY KEY(PROD_NO) --이름
);


-- 주문 테이블(자식테이블)
CREATE TABLE ORDER_TBL (
    ORDER_NO NUMBER NOT NULL, --CONSTRAINT PK_ORDER PRIMARY KEY,
    USER_ID VARCHAR2(10 BYTE),
    PROD_NO NUMBER, --CONSTRAINT FK_ORDER_PROD REFERENCES PRODUCT_TBL(PROD_NO),
    ORDER_DATE DATE,
    CONSTRAINT PK_ORDER PRIMARY KEY(ORDER_NO),
    CONSTRAINT FK_ORDER_PROD FOREIGN KEY(PROD_NO) REFERENCES PRODUCT_TBL(PROD_NO) ON DELETE SET NULL
 
);

/*
    제약조건 테이블
    1. SYS, SYSTEM 관리 계정으로 접속해서 확인한다 ==> 제약을 걸수 있는 관리자 계정으로.
    1. 종류 
        1) ALL_CONSTRAINTS 모든 제약조건
        2) USER_CONSTRAINTS 관리자 제약조건
        3) DBA_CONSTRAINTS 사용자 제약조건
*/

-- 제약조건 테이블
-- 제약 조건에 이름을 바꿔주는 문법 ==> 내가 나중에 쉽게 찾기 위해서
--CONSTRAINT 어쩌구 ==> 제약조건 걸어주는거
--FK_ORDER_PRO FK하고 현재테이블먼저 그담PK


-- 테이블의 구조를 확인하는 쿼리문 (설명)
--DESCRIBE ALL_CONSTRAINTS; -- 이름이 칼럼 / 널은 낫널유무 / 유형은 타입
--SELECT * FROM ALL_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE 'PK%'; -- *는 수업에만 편의를 위해 쓰자. 실전에서는 안됨.

-- M:N은 1:M * 2     !!!!!!!!!!!!!!!!!!!!!!!!




















