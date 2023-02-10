-- 학생 이름, 담당 교수 이름 조회하기
-- 메인테이블은 주로 PK 테이블로
-- 실행 : 
SELECT S.S_NAME, P.P_NAME
  FROM PROFESSOR_TBL  P INNER JOIN STUDENT_TBL S
    ON P.P_NO = S.P_NO;
  
SELECT S.S_NAME, P.P_NAME
  FROM PROFESSOR_TBL P, STUDENT_TBL S
 WHERE P.P_NO = S.P_NO;
 
 
 -- 교수번호, 교수이름, 교수전공, 강의이름, 강의위치를 조회하시오
 -- 테이블가서 네임 찾지 않고 찾아야해...
 -- SELECT * 하고 FROM 먼저하고.
 
 SELECT P.P_NO, P.P_NAME, P.P_MAJOR, L.L_NAME, L.L_LOCATION
   FROM PROFESSOR_TBL P INNER JOIN LECTURE_TBL L
     ON P.P_NO = L.P_NO;
     
SELECT S.S_NAME, P.P_NAME
  FROM PROFESSOR_TBL P, STUDENT_TBL S
 WHERE P.P_NO = L.P_NO;
 
 -- 학번, 학생이름, 수강신청한 과목이름, 
 
 SELECT S.S_NO, S.S_NAME, C.C_NAME
 FROM STUDENT_TBL S INNER JOIN ENROLL_TBL E
   ON S.S_NO = E.S_NO INNER JOIN COURSE_TBL C -- 합쳤어 
   ON E.C_NO = C.C_NO;

-- 오라클문법 
 SELECT S.S_NO, S.S_NAME, C.C_NAME
  FROM STUDENT_TBL S, ENROLL_TBL E, COURSE_TBL C
 WHERE S.S_NO = E.S_NO
   AND E.C_NO = C.C_NO;

-- 모든 교수들의 교수이름, 교수전공, 강의이름을 조회하시오(교수는 총 3명이다)
SELECT P.P_NAME, P.P_MAJOR, L.L_NAME
  FROM PROFESSOR_TBL P LEFT OUTER JOIN LECTURE_TBL L
    ON P.P_NO = L.L_NO;

SELECT P.P_NAME, P.P_MAJOR, L.L_NAME
  FROM PROFESSOR_TBL P, LECTURE_TBL L
 WHERE P.P_NO = L.P_NO(+);
    




 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 