/*
    DQL
    1. Data query language
    2. 데이터 질의(조회) 언어
    3. 테이블의 데이터를 조회하는 언어이다
    4. 테이블 내용의 변경이 생기지 않는다
        (트랜잭션의 처리 대상이 아니고, COMMIT 이 필요하지 않다)
         내용이 바뀌는 작업(삽입 수정 삭제)를 트랜잭션의 처리 대상으로 본다
        
    5. 형식( []는 생략 가능 )
        SELECT 다음 조회할 칼럼을 ,컴마로 구분해주면 됨. 몇개를 써도 상관없고 맨 마지막에 
        FROM 테이블 이름
        SELECT 조회할칼럼, 조회할칼럼, .....   FROM 테이블 이름
        '     SELECT절                      '  'FROM절이라고부름'
        
        ==> 가독성이 편하려고 아래처럼 줄바꿈해서 씀
        
        SELECT 조회할칼럼, 조회할칼럼, ..... 
        FROM 테이블 이름
        
        아래 절들은 생략 할 수 있음. []는 생략 가능
        순서를 지켜서 쓸 것
        [WHERE 조건식] ==> 원하는 데이터 추출, 조건절!!!
        [GROUP BY 그룹화할칼럼] ====> 주로 통계/집계 낼 때 , 그 룹 화 => 남자/여자
        [GROUP BY 그룹화할칼럼 [HAVING 그룹조건식]]
        [ORDER BY 정렬할칼럼 정렬방식]
        
        [HAVING 그룹조건식] ==> 남자만 보겠다
        [ORDER BY 정렬할칼럼 정렬 방식] ==>( 조회. 순서. )정렬할 칼럼이 나오고 정렬 방식이 나온다, 
        높은거먼저 낮은거먼저 


 ===> 최종 형식 정리
        SELECT 조회할칼럼, 조회할칼럼, ..... 
        FROM 테이블 이름
        [WHERE 조건식]
        [GROUP BY 그룹화할칼럼 [HAVING 그룹조건식]]
        [ORDER BY 정렬할칼럼 정렬방식]



        6. 실행 순서!!!!!!!!!!!!!!!
        4 - SELECT 조회할칼럼, 조회할칼럼, ..... 
        1 - FROM 테이블 이름
        2 - [WHERE 조건식]
        3 - [GROUP BY 그룹화할칼럼 [HAVING 그룹조건식]]
        5 - [ORDER BY 정렬할칼럼 정렬방식]
        ==> 모든 쿼리문은 프롬절부터 읽어들이는걸 이해하기 (쿼리문 = 절)
*/

/*
    트랜잭션
    1. Transaction
    2. 여러개(2개 이상)의 세부 작업으로 구성된 하나의 작업을 의미한다.
    3. 모든 세부 작업이 성공하면 COMMIT이라고 하고, 하나라도 실패하면 모든 세부 작업의 취소를 진행한다
        (All or Noting)
        ex) 휴면 계정 처리 같은거 할때, 
        어떤, 정보 테이블에서는 삭제하고, 휴면 테이블에는 넣어줘야하고 
        ==> 저기서 지운 정보를 다른 곳에다 넣을때 ==> 2개 이상의 작업을 모두 다 해야하고, 
        하나만 하면 소용없는 경우
        ==> 2개 이상 다 하고 커밋을 해줘야 하는 경우 .
        ==> 하나라도 안하면 모두 다 취소 되고 원상복귀? 되는거..
        

*/


-- 조회 실습

-- 1. 사원 테이블에서 사원명 조회하기
SELECT ENAME
 FROM  EMP;
-- 한문장임 주의
-- 셀렉트의 결과는 테이블
-- 세미콜론 옆에서 컨트롤 엔터해야함

-- 2. 오너 명시하기(테이블을 가지고 있는 계정)
SELECT ENAME
  FROM SCOTT.EMP;

-- 3. 테이블 명시하기(칼럼을 가지고 있는 테이블)
SELECT EMP.ENAME --EMP테이블의 ENAME
  FROM EMP;

-- 셋다 결과 똑같음

-- 4. 테이블 별명 지정하기 ==> 테이블이름이 길때 사용하면 됨 줄임말임 ==> 별명은 이 문장안에서만 유효함. 진짜 이름을 바꿀수는 없음!! 그냥 긴 네임을 이 안에서 줄여서 쓴다는 거.
SELECT E.ENAME 
  FROM EMP E; -- EMP 테이블의 별명을 E로 부여한다. AS(ALIAS)를 사용할 수 없다

-- 5. 칼럼 별명 지정하기 ==> 줄임말
SELECT E.ENAME AS 사원명 -- E.ENAME 칼럼의 별명을 '사원명'으로 부여한다. AS(ALIAS)를 사용할 수 있다, AS를 쓰건 안쓰건 차이가 없음. 써도 안써도 똑같음
  FROM EMP E; 

--셀렉트가 여러가지 형태로 작성 될 수 있는데 대부분 4,5번 형태로 많이 쓰인다.
--이름이 길거나 보기 안좋아서 바꿈..


-- 2. 사원 테이블의 모든 칼럼 조회하기
-- 1) * 활용하기(SELECT절에서 *는 모든 칼럼을 의미한다)

SELECT * -- 불려 가기 싫으면 사용 금지...회사가서 쓰지말기..............
  FROM EMP;
  

-- 2) 모든 칼럼 직접 작성하기
SELECT EMP, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
  FROM EMP;


-- 3) 동일한 데이터는 한번만 조회하기
-- DISTINCT JOB
    
SELECT DISTINCT JOB
  FROM EMP; 


-- 4. JOB이 MANAGER인 사원 목록 조회하기
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
  FROM EMP
 WHERE JOB = 'MANAGER'; --입력되어 있는 텍스트들은 소문자 대문자를 주의해야함 그대로 써야함

SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
  FROM EMP
 WHERE JOB IN('MANAGER');

-- SKIMA = 계정이라는 뜻.


-- 5. SAL이 1500 초과인 사원 목록 조회하기
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
  FROM EMP
 WHERE SAL > 1500;


-- 6. SAL이 2000~2999인 사원 목록 조회하기

SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
  FROM EMP
 WHERE SAL BETWEEN 2000 AND 2999;
 
 
 -- 7. COMM을 받는 사원 목록 조회하기
 --       1) NULL 이다 : IS NULL
 --       2) NOT NULL 아니다 : IS NOT NULL
 SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
   FROM EMP
 --WHERE COMM IS NOT NULL AND COMM != 0;
  WHERE COMM IS NOT NULL 
    AND COMM != 0;

--SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
  --FROM EMP
 --WHERE 1 = 1
 

-- 8. ENAME이 A로 시작하는 사원 목록 조회하기
--    1) WILD CARD
--          (1) % : 글자 수 제한 없는 '모든 문자'
--          (2) _ : 1글자로 제한된 모든 문자
--    2) 연산자
--          (1) LIKE        : WILD CARD 를 포함한다
--          (2) NOT LIKE  : WILD CARD를 포함하지 않는다


SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
  FROM EMP
 WHERE ENAME LIKE 'A%';










