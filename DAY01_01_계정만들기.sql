-- 번외.. sql파일을 쿼리라고 많이 부름
-- 단일행 주석  이클립스에서는 // 와 같음
/*
    다중 행 주석 이클립스랑 같음
*/

/*
    1. SYS, SYSTEM 계정은 '관리 계정'이므로 해당 계정에서 작업을 하지 않는다
    2. 새로운 계정을 만들고 해당 계정으로 접속해서 작업을 수행한다
    3. 새로운 계정을 만드는 작업은 SYS, SYSTEM 계정에서 처리한다 ==> 관리 계정에서 생성 가능
    4. 새로운 계정을 만드는 방법
        1) DROP USER 계정이름 CASCADE : 
        기존에 생성된 계정이 있다면 삭제하시오 
        CASCADE는 계정이 가진 데이터도 함께 삭제하라는 옵션이다(선택..?)
        2) CREATE USER 계정이름 IDENTIFIED BY 비밀번호 : 계정 만들기
        3) GRANT 권한 TO  계정이름 : 생성된 계정에 권한(CONNECT, RESOURCE, DBA)을 준다
            DBA:데이터베이스 관리자 권한 ==>관리자라서 다할수 있음
            
*/

/*
    쿼리문을 실행하는 방법 2가지
    1. 선택 쿼리 실행 : Ctrl + Enter
    2. 모든 쿼리 실행 : F5(새로고침 아님 주의)
    ==> 맨위에 초록 버튼 1. 선택(▶) 2.전체 인데 우리는 단축키로 많이 쓸거임.
*/

-- sys계정으로 접속후 진행하기. GDJ계정 접속되어있으면 안됨.
DROP USER GDJ61 CASCADE;
CREATE USER GDJ61 IDENTIFIED BY 1111;
GRANT DBA TO GDJ61;

-- F5누르면(모든쿼리실행) 위문장부터 실행이 되는데 첫문장은 삭제여서 실행하면 오류가 남 . 그럼 오류에서 멈추지 않고 아래문장이 그대로 실행됨. 오라클의 특징
-- 근데 F5 한번 더 누르면 정삭적으로 작동함. 왜냐 2번째 문장으로 생성자가 만들어 졌으니까! => 원리 이해하기
-- 그리고 새로 만들고자 하는게 무엇이든 만들고자 하는 코드 위에 삭제코드를 넣으면 편함, 위 3문장 암기

DROP USER BYR CASCADE;
CREATE USER BYR IDENTIFIED BY 1111;
GRANT DBA TO BYR;

-- HR 계정 불러오기
-- CMD창에서
-- 1. sqlplus 입력
-- 2. 관리자 계정으로 로그인 : SYSTEM / 1111 로그인
-- 3. ALTER USER HR ACCOUNT UNLOCK; 엔터
-- 4. ALTER USER HR IDENTIFIED BY 1111; 엔터
-- 5. 끝(노션에 메모해놈)

        
    