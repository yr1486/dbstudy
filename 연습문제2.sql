-- 1. 다음 설명을 읽고 적절한 테이블을 생성하되, 기본키/외래키는 별도로 설정하지 마시오.


DROP TABLE ORDER_TBL;
DROP TABLE CUSTOMER_TBL;
DROP TABLE BOOK_TBL;

-- 1) BOOK_TBL 테이블
--    (1) BOOK_ID : 책번호, 숫자 (최대 11자리), 필수
--    (2) BOOK_NAME : 책이름, 가변 길이 문자 (최대 100 BYTE)
--    (3) PUBLISHER : 출판사, 가변 길이 문자 (최대 50 BYTE)
--    (4) PRICE : 가격, 숫자 (최대 6자리)

CREATE TABLE BOOK_TBL (
    BOOK_ID   NUMBER(11) NOT NULL,
    BOOK_NAME VARCHAR2(100 BYTE),
    PUBLISHER VARCHAR2(50 BYTE),
    PRICE     NUMBER(6)
);

-- 2) CUSTOMER_TBL 테이블
--    (1) CUSTOMER_ID : 고객번호, 숫자 (최대 11자리), 필수
--    (2) CUSTOMER_NAME : 고객명, 가변 길이 문자 (최대 20 BYTE)
--    (3) ADDRESS : 주소, 가변 길이 문자 (최대 50 BYTE)
--    (4) PHONE : 전화, 가변 길이 문자 (최대 20 BYTE)

CREATE TABLE CUSTOMER_TBL (
    CUSTOMER_ID NUMBER(11) NOT NULL,
    CUSTOMER_NAME VARCHAR2(20 BYTE),
    ADDRESS VARCHAR2(50 BYTE),
    PHONE VARCHAR2(20 BYTE)

);

-- 3) ORDER_TBL 테이블
--    (1) ORDER_ID : 주문번호, 가변 길이 문자 (최대 20 바이트), 필수
--    (2) CUSTOMER_ID : 고객번호, 숫자 (최대 11자리)
--    (3) BOOK_ID : 책번호, 숫자 (최대 11자리)
--    (4) AMOUNT : 판매수량, 숫자 (최대 2자리)
--    (5) ORDER_DATE : 주문일, 날짜

CREATE TABLE ORDER_TBL (
    ORDER_ID VARCHAR2(20 BYTE) NOT NULL,
    CUSTOMER_ID NUMBER(11),
    BOOK_ID NUMBER(11),
    AMOUNT NUMBER(2),
    ORDER_DATE DATE

);

-- 2. 1부터 1씩 증가하는 값을 생성하는 BOOK_SEQ 시퀀스를 생성한 뒤, BOOK_SEQ를 이용하여 BOOK_TBL 테이블에 INSERT를 수행하시오.
/*
책번호  책이름           출판사      가격
1       축구의 역사      굿스포츠    7000
2       축구 아는 여자   나이스북    13000
3       축구의 이해      대한미디어  22000
4       골프 바이블      대한미디어  35000
5       피겨 교본        굿스포츠    6000
6       역도 단계별 기술 굿스포츠    6000
7       야구의 추억      이상미디어  20000
8       야구를 부탁해    이상미디어  13000
9       올림픽 이야기    삼성당      7500
10      올림픽 챔피언    나이스북    13000
*/

DROP SEQUENCE BOOK_SEQ;
CREATE SEQUENCE BOOK_SEQ
    NOCACHE;
INSERT INTO BOOK_TBL(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (BOOK_SEQ.NEXTVAL, '축구의 역사', '굿스포츠', 7000);
INSERT INTO BOOK_TBL(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (BOOK_SEQ.NEXTVAL, '축구 아는 여자', '나이스북', 13000);
INSERT INTO BOOK_TBL(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (BOOK_SEQ.NEXTVAL, '축구의 이해', '대한미디어', 22000);
INSERT INTO BOOK_TBL(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (BOOK_SEQ.NEXTVAL, '골프 바이블', '대한미디어', 35000);
INSERT INTO BOOK_TBL(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (BOOK_SEQ.NEXTVAL, '피겨 교본', '굿스포츠', 6000);
INSERT INTO BOOK_TBL(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (BOOK_SEQ.NEXTVAL, '역도 단계별 기술', '굿스포츠', 6000);
INSERT INTO BOOK_TBL(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (BOOK_SEQ.NEXTVAL, '야구의 추억', '이상미디어', 20000);
INSERT INTO BOOK_TBL(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (BOOK_SEQ.NEXTVAL, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO BOOK_TBL(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (BOOK_SEQ.NEXTVAL, '올림픽 이야기', '삼성당', 7500);
INSERT INTO BOOK_TBL(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (BOOK_SEQ.NEXTVAL,'올림픽 챔피언', '나이스북', 13000);
COMMIT;


-- 3. 1000부터 1씩 증가하는 값을 생성하는 CUSTOMER_SEQ 시퀀스를 생성한 뒤, CUSTOMER_SEQ를 이용하여 INSERT를 수행하시오.
/*
회원번호 고객명   주소      전화
1000     박지성   영국      000-000-000
1001     김연아   대한민국  111-111-111
1002     장미란   대한민국  222-222-222
1003     추신수   미국      333-333-333
1004     박세리   대한민국  NULL
*/

DROP SEQUENCE CUSTOMER_SEQ;
CREATE SEQUENCE CUSTOMER_SEQ
    START WITH 1000
    NOCACHE;

INSERT INTO CUSTOMER_TBL(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (CUSTOMER_SEQ.NEXTVAL, '박지성', '영국', '000-000-000');
INSERT INTO CUSTOMER_TBL(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (CUSTOMER_SEQ.NEXTVAL, '김연아', '대한민국', '111-111-111');
INSERT INTO CUSTOMER_TBL(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (CUSTOMER_SEQ.NEXTVAL, '장미란', '대한민국', '222-222-222');
INSERT INTO CUSTOMER_TBL(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (CUSTOMER_SEQ.NEXTVAL, '추신수', '미국', '333-333-333');
INSERT INTO CUSTOMER_TBL(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (CUSTOMER_SEQ.NEXTVAL, '박세리', '대한민국', NULL);
COMMIT;

-- 4. 1부터 1씩 증가하는 ORDER_SEQ 시퀀스를 생성한 뒤, '현재날짜6자리-시퀀스' 형식으로 주문번호를 만들어서 INSERT를 수행하시오.
/*
주문번호   고객번호  책번호  판매수량 주문일자
230210-1   1000      1       1        20/07/01
230210-2   1000      3       2        20/07/03
230210-3   1001      5       1        20/07/03
230210-4   1002      6       2        20/07/04
230210-5   1003      7       3        20/07/05
230210-6   1000      2       5        20/07/07
230210-7   1003      8       2        20/07/07
230210-8   1002      10      2        20/07/08
230210-9   1001      10      1        20/07/09
230210-10  1002      6       4        20/07/10
*/
DROP SEQUENCE ORDER_SEQ;
CREATE SEQUENCE ORDER_SEQ;
    NOCACHE;

INSERT INTO ORDER_TBL(ORDER_ID, CUSTOMER_ID, BOOK_ID, AMOUNT, ORDER_DATE) VALUES(TO_CHAR(SYSDATE, 'YY/MM/DD-') || ORDER_SEQ.NEXTVAL,



















DROP SEQUENCE ORDER_SEQ;
CREATE SEQUENCE ORDER_SEQ
    NOCACHE; -- 저장공간을 쓰지 않는다. 번호표미리뽑아놓지 않는다.

INSERT INTO ORDER_TBL(ORDER_ID, CUSTOMER_ID, BOOK_ID, AMOUNT, ORDER_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMMDD-') || ORDER_SEQ.NEXTVAL, 1000, 1, 1, '20/07/01');
INSERT INTO ORDER_TBL(ORDER_ID, CUSTOMER_ID, BOOK_ID, AMOUNT, ORDER_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMMDD-') || ORDER_SEQ.NEXTVAL, 1000, 3, 2, '20/07/03');
INSERT INTO ORDER_TBL(ORDER_ID, CUSTOMER_ID, BOOK_ID, AMOUNT, ORDER_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMMDD-') || ORDER_SEQ.NEXTVAL, 1001, 5, 1, '20/07/03');
INSERT INTO ORDER_TBL(ORDER_ID, CUSTOMER_ID, BOOK_ID, AMOUNT, ORDER_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMMDD-') || ORDER_SEQ.NEXTVAL, 1002, 6, 2, '20/07/04');
INSERT INTO ORDER_TBL(ORDER_ID, CUSTOMER_ID, BOOK_ID, AMOUNT, ORDER_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMMDD-') || ORDER_SEQ.NEXTVAL, 1003, 7, 3, '20/07/05');
INSERT INTO ORDER_TBL(ORDER_ID, CUSTOMER_ID, BOOK_ID, AMOUNT, ORDER_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMMDD-') || ORDER_SEQ.NEXTVAL, 1000, 2, 5, '20/07/07');
INSERT INTO ORDER_TBL(ORDER_ID, CUSTOMER_ID, BOOK_ID, AMOUNT, ORDER_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMMDD-') || ORDER_SEQ.NEXTVAL, 1003, 8, 2, '20/07/07');
INSERT INTO ORDER_TBL(ORDER_ID, CUSTOMER_ID, BOOK_ID, AMOUNT, ORDER_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMMDD-') || ORDER_SEQ.NEXTVAL, 1002, 10, 2, '20/07/08');
INSERT INTO ORDER_TBL(ORDER_ID, CUSTOMER_ID, BOOK_ID, AMOUNT, ORDER_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMMDD-') || ORDER_SEQ.NEXTVAL, 1001, 10, 1, '20/07/09');
INSERT INTO ORDER_TBL(ORDER_ID, CUSTOMER_ID, BOOK_ID, AMOUNT, ORDER_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMMDD-') || ORDER_SEQ.NEXTVAL, 1002, 6, 4, '20/07/10');
COMMIT;

-- 5. BOOK_TBL, CUSTOMER_TBL, ORDER_TBL 테이블의 BOOK_ID, CUSTOMER_ID, ORDER_ID 칼럼에 기본키를 추가하시오.
-- 기본키 제약조건의 이름은 PK_BOOK, PK_CUSTOMER, PK_ORDER으로 지정하시오.

ALTER TABLE BOOK_TBL ADD CONSTRAINT PK_BOOK PRIMARY KEY(BOOK_ID);
ALTER TABLE CUSTOMER_TBL ADD CONSTRAINT PK_CUSTOMER PRIMARY KEY(CUSTOMER_ID);
ALTER TABLE ORDER_TBL ADD CONSTRAINT PK_ORDER PRIMARY KEY(ORDER_ID);

-- 6. ORDER_TBL 테이블의 CUSTOMER_ID, BOOK_ID 칼럼에 각각 CUSTOMER_TBL 테이블과 BOOK_TBL 테이블을 참조할 외래키를 추가하시오.
-- 외래키 제약조건의 이름은 FK_ORDER_CUSTOMER, FK_ORDER_BOOK으로 지정하시오.
-- CUSTOMER_ID나 BOOK_ID가 삭제되는 경우 이를 참조하는 ORDER_TBL 테이블의 정보는 NULL로 처리하시오.

ALTER TABLE ORDER_TBL ADD CONSTRAINT FK_ORDER_CUSTOMER FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER_TABLE(CUSTOMER_ID) ON DELETE SET NULL;

CREATE TABLE ORDER_TBL (
    ORDER_ID VARCHAR2(20 BYTE) NOT NULL,
    CUSTOMER_ID NUMBER(11),
    BOOK_ID NUMBER(11),
    AMOUNT NUMBER(2),
    ORDER_DATE DATE

);


-- 7. '김연아'가 구매한 도서개수를 조회하시오.
-- 고객명  구매도서수
-- 김연아  2


-- 8. 주문한 이력이 없는 고객의 이름을 조회하시오.
-- 고객명
-- 박세리


-- 9. '박지성'이 구매한 도서를 발간한 출판사(PUBLISHER) 개수를 조회하시오.
-- 고객명  출판사수
-- 박지성  3


-- 10. 2020년 7월 4일부터 7월 7일 사이에 주문 받은 도서를 제외하고 나머지 모든 주문 정보를 조회하시오.
-- 구매번호  구매자  책이름           판매가격 주문일자
-- 230210-1  박지성  축구의 역사      7000     20/07/01
-- 230210-2  박지성  축구의 이해      44000    20/07/03
-- 230210-3  김연아  피겨 교본        6000     20/07/03
-- 230210-10 장미란  역도 단계별 기술 24000    20/07/10
-- 230210-9  김연아  올림픽 챔피언    13000    20/07/09
-- 230210-8  장미란  올림픽 챔피언    26000    20/07/08


-- 11. 모든 구매 고객의 이름과 총구매액(PRICE * AMOUNT)을 조회하시오.
-- 구매 이력이 있는 고객만 조회하시오.(주문내역에 있고, 고객에 있는 데이터 = 내부 조인)
-- 고객명  총구매액
-- 김연아  19000
-- 장미란  62000
-- 박지성  116000
-- 추신수  86000


-- 12. 모든 구매 고객의 이름과 총구매액(PRICE * AMOUNT)과 구매횟수를 조회하시오.
-- 구매 이력이 없는 고객은 총구매액과 구매횟수를 0으로 조회하시오. (고객은 모두 조회, 주문내역은 있는 자료만 조회 = 왼쪽 외부 조인)
-- 고객번호순으로 오름차순 정렬하여 조회하시오.
-- 고객명  총구매액  구매횟수
-- 박지성  116000     3
-- 김연아  19000      2
-- 장미란  62000      3
-- 추신수  86000      2
-- 박세리  0          0


-- 13. 가장 최근에 구매한 고객의 이름과 구매내역(책이름, 주문일자)을 조회하시오.
-- 고객명  책이름            주문일자
-- 장미란  역도 단계별 기술  20/07/10


-- 14. 모든 서적 중에서 가장 비싼 서적을 구매한 고객의 이름과 구매내역(책이름, 가격)을 조회하시오.
-- 가장 비싼 서적을 구매한 고객이 없다면 고객 이름은 NULL로 처리하시오.
-- 고객명  책이름       책가격
-- NULL    골프 바이블  35000


-- 15. 총구매액이 2~3위인 고객의 이름와 총구매액을 조회하시오.
-- 고객명  총구매액
-- 추신수  86000
-- 장미란  62000
