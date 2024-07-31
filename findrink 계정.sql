

CREATE TABLE "MEMBER" (
	"MEMBER_NO"	NUMBER	PRIMARY KEY,
	"MEMBER_ID"	VARCHAR2(30)		NOT NULL,
	"MEMBER_PW"	VARCHAR2(100)	NOT NULL,
	"MEMBER_NM"	VARCHAR2(10)		NOT NULL,
	"MEMBER_TEL"	CHAR(11)	NULL,
	"MEMBER_NICK"	VARCHAR2(30)		NOT NULL,
	"MEMBER_EMAIL"	VARCHAR2(50)		NULL,
	"MEMBER_INT"	VARCHAR2(1500)	NULL,
	"MEMBER_CATEGORY"	VARCHAR(20)		NULL,
	"ENROLL_DT"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEMBER_IMG"	VARCHAR2(500)	NULL,
	"SALT"	VARCHAR2(100)	NOT NULL,
	"SECESSION_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL
);

COMMENT ON COLUMN "MEMBER"."MEMBER_NO" IS '회원 번호(PK)';
COMMENT ON COLUMN "MEMBER"."MEMBER_ID" IS '회원 아이디';
COMMENT ON COLUMN "MEMBER"."MEMBER_PW" IS '회원 비밀번호';
COMMENT ON COLUMN "MEMBER"."MEMBER_NM" IS '회원 이름';
COMMENT ON COLUMN "MEMBER"."MEMBER_TEL" IS '회원 전화번호';
COMMENT ON COLUMN "MEMBER"."MEMBER_NICK" IS '회원 닉네임';
COMMENT ON COLUMN "MEMBER"."MEMBER_EMAIL" IS '회원 이메일';
COMMENT ON COLUMN "MEMBER"."MEMBER_INT" IS '회원 한줄소개';
COMMENT ON COLUMN "MEMBER"."MEMBER_CATEGORY" IS '회원 유형(사용자, 사업자)';
COMMENT ON COLUMN "MEMBER"."ENROLL_DT" IS '회원 가입일';
COMMENT ON COLUMN "MEMBER"."MEMBER_IMG" IS '회원 프로필 이미지';
COMMENT ON COLUMN "MEMBER"."SALT" IS '회원 암호';
COMMENT ON COLUMN "MEMBER"."SECESSION_FL" IS '탈퇴 여부(Y/N)';


CREATE SEQUENCE SEQ_MEMBER_NO;

----------------------

CREATE TABLE "BOARD_TYPE" (
	"BOARD_CD"	NUMBER	PRIMARY KEY,
	"BOARD_NM"	VARCHAR2(30)	NOT NULL
);
ALTER TABLE BOARD_TYPE
MODIFY BOARD_NM VARCHAR2(50);

COMMENT ON COLUMN "BOARD_TYPE"."BOARD_CD" IS '게시판 코드';
COMMENT ON COLUMN "BOARD_TYPE"."BOARD_NM" IS '게시판 이름';


CREATE SEQUENCE SEQ_BOARD_CD;

--------


CREATE TABLE "BOARD" (
	"BOARD_NO"	NUMBER	PRIMARY KEY,
	"BOARD_TITLE" 	VARCHAR2(150)	NOT NULL,
	"BOARD_CONTENT"	VARCHAR2(4000)	NOT NULL,
	"CREATE_DT"	DATE	DEFAULT SYSDATE	NOT NULL,
	"UPDATE_DT"	DATE	DEFAULT SYSDATE	NOT NULL,
	"READ_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"BOARD_ST"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"BOARD_CATEGORY"	VARCHAR2(100)	NULL,
	MEMBER_NO	NUMBER	REFERENCES	MEMBER NOT NULL, -- MEMBER 테이블 PK 값 참조
	BOARD_CD	NUMBER	REFERENCES	BOARD_TYPE NOT NULL -- BOARD_TYPE 테이블 PK 값 참조
);

COMMENT ON COLUMN "BOARD"."BOARD_NO" IS '게시글 번호(PK)';
COMMENT ON COLUMN "BOARD"."BOARD_TITLE" IS '게시글 제목';
COMMENT ON COLUMN "BOARD"."BOARD_CONTENT" IS '게시글 내용';
COMMENT ON COLUMN "BOARD"."CREATE_DT" IS '게시글 등록일';
COMMENT ON COLUMN "BOARD"."UPDATE_DT" IS '게시글 마지막 수정일';
COMMENT ON COLUMN "BOARD"."READ_COUNT" IS '게시글 조회수';
COMMENT ON COLUMN "BOARD"."BOARD_ST" IS '게시글 상태(Y/N)';
COMMENT ON COLUMN "BOARD"."BOARD_CATEGORY" IS '카테고리(게시판 유형)';
COMMENT ON COLUMN "BOARD"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "BOARD"."BOARD_CD" IS '게시판 코드';


CREATE SEQUENCE SEQ_BOARD_NO;

---------------




CREATE TABLE "BOARD_IMG" (
	"IMG_NO"	NUMBER	PRIMARY KEY,
	"IMG_RENAME"	VARCHAR2(500)	NOT NULL,
	"IMG_ORIGINAL"	VARCHAR2(500)	NOT NULL,
	"IMG_LEVEL"	NUMBER	NOT NULL,
	"BOARD_NO"	NUMBER	REFERENCES	BOARD	NOT NULL	  -- BOARD 테이블 PK 값 참조


);

COMMENT ON COLUMN "BOARD_IMG"."IMG_NO" IS '이미지 번호(PK)';
COMMENT ON COLUMN "BOARD_IMG"."IMG_RENAME" IS '이미지 변경명';
COMMENT ON COLUMN "BOARD_IMG"."IMG_ORIGINAL" IS '이미지 원본명';
COMMENT ON COLUMN "BOARD_IMG"."IMG_LEVEL" IS '이미지 레벨';
COMMENT ON COLUMN "BOARD_IMG"."BOARD_NO" IS '게시글 번호';


CREATE SEQUENCE SEQ_IMG_NO;

------------------



CREATE TABLE "REPLY" (
	"REPLY_NO"	NUMBER	PRIMARY KEY,
	"REPLY_CONTENT"	VARCHAR(200)		NULL,
	"CREATE_DT"	DATE	DEFAULT SYSDATE	NOT NULL,
	"REPLY_ST"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"REPLY_PARENT"	NUMBER	NULL,
	"BOARD_NO"	NUMBER	REFERENCES	BOARD	NOT NULL,  -- BOARD 테이블 PK 값 참조
	"MEMBER_NO"	NUMBER	REFERENCES	MEMBER	NOT NULL -- MEMBER 테이블 PK 값 참조

);

COMMENT ON COLUMN "REPLY"."REPLY_NO" IS '댓글 번호(PK)';
COMMENT ON COLUMN "REPLY"."REPLY_CONTENT" IS '댓글 내용';
COMMENT ON COLUMN "REPLY"."CREATE_DT" IS '등록일';
COMMENT ON COLUMN "REPLY"."REPLY_ST" IS '댓글 상태(Y/N)';
COMMENT ON COLUMN "REPLY"."REPLY_PARENT" IS '부모 댓글';
COMMENT ON COLUMN "REPLY"."BOARD_NO" IS '게시글 번호';
COMMENT ON COLUMN "REPLY"."MEMBER_NO" IS '회원 번호';

CREATE SEQUENCE SEQ_REPLY_NO;

------------------


CREATE TABLE "STORE" (
	"STORE_NO"	NUMBER	PRIMARY KEY,
	"STORE_NM"	VARCHAR2(60)		NOT NULL,
	"STORE_ADDRESS"	VARCHAR2(1000)	NOT NULL,
	"STORE_TEL"	CHAR(11)		NULL,
	"STORE_INT"	VARCHAR2(1500)	NULL,
	"STORE_ST"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"TOTAL_SCORE"	DECIMAL(2,1)	NULL,
	"MEMBER_NO"	NUMBER	REFERENCES	MEMBER	NOT NULL-- MEMBER 테이블 PK 값 참조

);

COMMENT ON COLUMN "STORE"."STORE_NO" IS '매장 번호(PK)';
COMMENT ON COLUMN "STORE"."STORE_NM" IS '매장 이름';
COMMENT ON COLUMN "STORE"."STORE_ADDRESS" IS '매장 주소';
COMMENT ON COLUMN "STORE"."STORE_TEL" IS '매장 전화번호';
COMMENT ON COLUMN "STORE"."STORE_INT" IS '매장 한줄소개';
COMMENT ON COLUMN "STORE"."STORE_ST" IS '매장 상태(Y/N)';
COMMENT ON COLUMN "STORE"."TOTAL_SCORE" IS '총점';
COMMENT ON COLUMN "STORE"."MEMBER_NO" IS '회원 번호';

CREATE SEQUENCE SEQ_STORE_NO;

------------


DROP TABLE "LIKE";
DROP TABLE "HEART";

CREATE TABLE "HEART" (
	"MEMBER_NO"	NUMBER	NOT NULL,
	"BOARD_NO"	NUMBER	NOT NULL,
    "HEART_COUNT" NUMBER NULL
);


COMMENT ON COLUMN "HEART"."MEMBER_NO" IS '회원번호(시퀀스)';
COMMENT ON COLUMN "HEART"."BOARD_NO" IS '게시글 번호(시퀀스)';
COMMENT ON COLUMN "HEART"."HEART_COUNT" IS '좋아요 수';

-----------

CREATE TABLE "SCORE" (
	"SCORE_VALUE"	NUMBER	NOT NULL,
	"STORE_NO"	NUMBER	REFERENCES	STORE	NOT NULL, -- STORE 테이블 PK 값 참조	
	"REPLY_NO"	NUMBER	REFERENCES	REPLY	NOT NULL -- REPLY 테이블 PK 값 참조
);

COMMENT ON COLUMN "SCORE"."SCORE_VALUE" IS '별점 개수';
COMMENT ON COLUMN "SCORE"."STORE_NO" IS '매장 번호';
COMMENT ON COLUMN "SCORE"."REPLY_NO" IS '댓글 번호';


---------


CREATE TABLE "ADMIN" (
	"ADMIN_NO"	NUMBER	PRIMARY KEY,
	"ADMIN_ID"	VARCHAR2(30)		NOT NULL,
	"ADMIN_PW"	VARCHAR2(100)	NOT NULL,
	"ADMIN_NICK"	VARCHAR2(30)		NOT NULL
);

COMMENT ON COLUMN "ADMIN"."ADMIN_NO" IS '관리자 번호(PK)';
COMMENT ON COLUMN "ADMIN"."ADMIN_ID" IS '관리자 아이디';
COMMENT ON COLUMN "ADMIN"."ADMIN_PW" IS '관리자 비밀번호';
COMMENT ON COLUMN "ADMIN"."ADMIN_NICK" IS '작성자(관리자 닉네임)';

CREATE SEQUENCE SEQ_ADMIN_NO;

-------


CREATE TABLE "NOTICE" (
	"NOTICE_NO"	NUMBER	NOT NULL,
	"NOTICE_TITLE"	VARCHAR2(100)	NOT NULL,
	"NOTICE_CONTENT"	VARCHAR(4000)	NOT NULL,
	"NOTICE_DT"	DATE	DEFAULT SYSDATE	NOT NULL,
	"UPDATE_DT"	DATE	DEFAULT SYSDATE	NOT NULL,
	"READ_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"NOTICE_ST"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"ADMIN_NO"	NUMBER	REFERENCES	ADMIN	NOT NULL -- ADMIN 테이블 PK 값 참조
);

COMMENT ON COLUMN "NOTICE"."NOTICE_NO" IS '게시글 번호(시퀀스)';
COMMENT ON COLUMN "NOTICE"."NOTICE_TITLE" IS '게시글 제목';
COMMENT ON COLUMN "NOTICE"."NOTICE_CONTENT" IS '게시글 내용';
COMMENT ON COLUMN "NOTICE"."NOTICE_DT" IS '등록일';
COMMENT ON COLUMN "NOTICE"."UPDATE_DT" IS '마지막 수정일';
COMMENT ON COLUMN "NOTICE"."READ_COUNT" IS '조회수';
COMMENT ON COLUMN "NOTICE"."NOTICE_ST" IS '게시글 상태(Y/N)';
COMMENT ON COLUMN "NOTICE"."ADMIN_NO" IS '관리자 번호';

CREATE SEQUENCE SEQ_NOTICE_NO;

----------


CREATE TABLE "REPORT" (
	"REPORT_NO"	NUMBER	PRIMARY KEY,
	"CREATE_DT"	DATE	DEFAULT SYSDATE	NOT NULL,
	"REPORT_ST"	CHAR(1)	NOT NULL,
	"REPORT_CONTENT"	VARCHAR2(100)	NULL,
	"MEMBER_NO"	NUMBER	REFERENCES	MEMBER	NULL,  -- MEMBER 테이블 PK 값 참조
	"RT_MEMBER_NO"	NUMBER	REFERENCES	MEMBER	NOT NULL -- MEMBER 테이블 PK 값 참조
);



COMMENT ON COLUMN "REPORT"."REPORT_NO" IS '신고 번호(PK)';
COMMENT ON COLUMN "REPORT"."CREATE_DT" IS '등록일';
COMMENT ON COLUMN "REPORT"."REPORT_ST" IS '신고 처리 상태';
COMMENT ON COLUMN "REPORT"."REPORT_CONTENT" IS '신고 내용';
COMMENT ON COLUMN "REPORT"."MEMBER_NO" IS '회원번호';
COMMENT ON COLUMN "REPORT"."RT_MEMBER_NO" IS '신고한 회원번호';

-------



CREATE TABLE "STORE_CATEGORY" (
	"STORE_VIEW"	VARCHAR(10)		NULL,
	"STORE_SERVICE"	VARCHAR(10)		NULL,
	"STORE_MOOD"	VARCHAR(10)		NULL,
	"STORE_VALUE"	VARCHAR(10)		NULL,
	"STORE_VARIETY"	VARCHAR(10)		NULL,
	"STORE_NO"	NUMBER	REFERENCES	STORE 	NOT NULL -- STORE 테이블 PK 값 참조

);

COMMENT ON COLUMN "STORE_CATEGORY"."STORE_VIEW" IS '뷰';
COMMENT ON COLUMN "STORE_CATEGORY"."STORE_SERVICE" IS '서비스';
COMMENT ON COLUMN "STORE_CATEGORY"."STORE_MOOD" IS '분위기';
COMMENT ON COLUMN "STORE_CATEGORY"."STORE_VALUE" IS '가치';
COMMENT ON COLUMN "STORE_CATEGORY"."STORE_VARIETY" IS '다양성';
COMMENT ON COLUMN "STORE_CATEGORY"."STORE_NO" IS '매장번호';


--------------------------------

-- MEMBER 테이블 샘플 데이터
INSERT INTO MEMBER
VALUES(SEQ_MEMBER_NO.NEXTVAL, 'user01', 'pass01', '유저일', '01012345678', '닉네임', 'user01@email.com','안녕하세요 유저일입니다', 'user', DEFAULT, NULL, '+3YDBXS577cxPbrDcXyaAtttOWZ3M5gvcgqeOqBrksNtpOXdRIZXqAdwTUprF7PVtls5QHVpEoVipyXJogVEyQ==', DEFAULT);


SELECT * FROM MEMBER;


-- BOARD_TYPE 데이터 삽입
INSERT INTO BOARD_TYPE VALUES(1, '리뷰 게시판');
INSERT INTO BOARD_TYPE VALUES(2, '추천 게시판');
INSERT INTO BOARD_TYPE VALUES(3, '커뮤니티 게시판');

SELECT * FROM BOARD_TYPE;




-- BOARD 테이블 샘플 데이터
INSERT INTO BOARD 
VALUES(SEQ_BOARD_NO.NEXTVAL, '샘플 게시글 1', '샘플1 내용입니다.', DEFAULT, DEFAULT, 1, DEFAULT, '공지사항', 1, 1);

SELECT * FROM BOARD;

-- BOARD 테이블 샘플 데이터 삽입(PL/SQL)
--
--BEGIN
--    FOR I IN 1..500 LOOP
--    
--        INSERT INTO BOARD
--        VALUES(SEQ_BOARD_NO.NEXTVAL,
--                SEQ_BOARD_NO.CURRVAL || '번째 게시글',
--                SEQ_BOARD_NO.CURRVAL || '번째 게시글 내용입니다.',
--                DEFAULT, DEFAULT, DEFAULT, DEFAULT, 1, 3
--        );
--    END LOOP;
--END;
--/

SELECT * FROM MEMBER;

-- 공지사항 게시판 조회
SELECT COUNT(*) FROM BOARD WHERE BOARD_CD = 1;

-- 자유 게시판 조회
SELECT COUNT(*) FROM BOARD WHERE BOARD_CD = 2;

-- 질문 게시판 조회
SELECT COUNT(*) FROM BOARD WHERE BOARD_CD = 3;

-- 게시판 이름 조회
SELECT BOARD_NM FROM BOARD_TYPE
WHERE BOARD_CD = 2;



-- REPLY 테이블 샘플 데이터
INSERT INTO REPLY VALUES(SEQ_REPLY_NO.NEXTVAL, '댓글 테스트1', DEFAULT, DEFAULT, DEFAULT, 50, 1);

