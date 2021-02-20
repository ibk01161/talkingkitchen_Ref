DROP TABLE TKK_SCRAP;
DROP TABLE TKK_MYKIT;
DROP TABLE TKK_RECIPE_INGR;
DROP TABLE TKK_RECIPE_STEP;
DROP TABLE TKK_RECIPE;
DROP TABLE TKK_INGREDIENT;
DROP TABLE TKK_USER;


CREATE TABLE TKK_USER
(
	USER_NO 		INT(10) NOT NULL AUTO_INCREMENT COMMENT '번호',
	USER_ID 		VARCHAR(50) NOT NULL COMMENT '아이디',
	USER_PW 		VARCHAR(128) NOT NULL COMMENT '비밀번호',
	USER_NAME 		VARCHAR(20) NOT NULL COMMENT '이름',
	USER_NICK 		VARCHAR(50) NOT NULL COMMENT '닉네임',
	USER_EMAIL 		VARCHAR(255) COMMENT '이메일',
	USER_PHONE 		VARCHAR(20) COMMENT '폰번호',
	USER_TYPE 		VARCHAR(1) DEFAULT 'U' NOT NULL COMMENT '권한 (A : 관리자, U : 일반유저)',
	REG_DATE		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
	MOD_DATE        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
	PRIMARY KEY (USER_NO),
	UNIQUE (USER_ID),
	UNIQUE (USER_NICK)
)
COMMENT='회원 정보',
COLLATE='utf8_general_ci'
;


CREATE TABLE TKK_RECIPE
(
	REC_NO 			INT NOT NULL AUTO_INCREMENT COMMENT '번호',
	USER_NO 		INT NOT NULL COMMENT '유저 번호',
	REC_TITLE 		VARCHAR(255) NOT NULL COMMENT '제목',
	REC_INTRO 		TEXT NOT NULL COMMENT '소개',
	REC_CATEGORY1 	VARCHAR(60) COMMENT '카테고리1 (나라별)',
	REC_CATEGORY2 	VARCHAR(60) COMMENT '카테고리2 (상황별)',
	REC_CATEGORY3 	VARCHAR(60) COMMENT '카테고리3 (재료별)',
	REC_CATEGORY4 	VARCHAR(60) COMMENT '카테고리4 (방법별)',
	REC_PORTION 	VARCHAR(10) NOT NULL COMMENT '인분',
	REC_TIME 		VARCHAR(10) NOT NULL COMMENT '레시피 걸리는 시간',
	REC_LEVEL 		VARCHAR(10) NOT NULL COMMENT '난이도',
	REC_RATING 		FLOAT(2,1) DEFAULT 0 COMMENT '평점',
	REC_READ_CNT 	INT(5) DEFAULT 0 COMMENT '조회수',
	REC_SCRAP_CNT 	INT(5) DEFAULT 0 COMMENT '스크랩수',
	REC_GOOD	 	INT(5) DEFAULT 0 COMMENT '좋아요',
	REC_BAD		 	INT(5) DEFAULT 0 COMMENT '싫어요',
	REG_DATE		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
	MOD_DATE        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
	PRIMARY KEY (REC_NO)
)
COMMENT='레시피 정보',
COLLATE='utf8_general_ci'
;


CREATE TABLE TKK_RECIPE_INGR
(
	REC_NO 			INT NOT NULL COMMENT '레시피 번호',
	INGR_CODE 		VARCHAR(30) NOT NULL COMMENT '재료 코드',
	REC_INGR_QNT 	VARCHAR(20) NOT NULL COMMENT '재료 양',
	PRIMARY KEY (REC_NO, INGR_CODE)
)
COMMENT='레시피 재료',
COLLATE='utf8_general_ci'
;


CREATE TABLE TKK_RECIPE_STEP
(
	STEP_NO 		INT NOT NULL COMMENT '스탭 번호',
	STEP_CONTENT 	TEXT NOT NULL COMMENT '스탭 내용',
	STEP_TIME 		INT(5) COMMENT '스탭별 걸리는 시간',
	REC_NO 			INT NOT NULL COMMENT '레시피 번호',
	PRIMARY KEY (STEP_NO, REC_NO)
)
COMMENT='레시피 스탭',
COLLATE='utf8_general_ci'
;


CREATE TABLE TKK_INGREDIENT
(
	INGR_CODE 		VARCHAR(30) NOT NULL COMMENT '재료 코드',
	INGR_SUP 		VARCHAR(60) NOT NULL COMMENT '재료 중분류',
	INGR_SUB 		VARCHAR(60) NOT NULL COMMENT '스탭 소분류',
	PRIMARY KEY (INGR_CODE)
)
COMMENT='재료',
COLLATE='utf8_general_ci'
;


CREATE TABLE TKK_COMMENT
(
	COMM_NO 		INT NOT NULL AUTO_INCREMENT COMMENT '번호',
	COMM_CONTENT 	TEXT NOT NULL COMMENT '내용',
	COMM_RATING 	FLOAT(2,1) DEFAULT 0.0 NOT NULL COMMENT '평점',
	USER_NO 		INT NOT NULL COMMENT '유저 번호',
	REC_NO 			INT NOT NULL COMMENT '레시피 번호',
	REG_DATE		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
	MOD_DATE        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
	PRIMARY KEY (COMM_NO)
)
COMMENT='댓글',
COLLATE='utf8_general_ci'
;


CREATE TABLE TKK_MYKIT
(
	INGR_CODE 			VARCHAR(30) NOT NULL COMMENT '재료 코드',
	MYKIT_INGR_QNT 		VARCHAR(20) NOT NULL COMMENT '내 주방 재료 양',
	USER_NO 			INT NOT NULL COMMENT '유저 번호',
	PRIMARY KEY (INGR_CODE, USER_NO)
)
COMMENT='내주방',
COLLATE='utf8_general_ci'
;


CREATE TABLE TKK_SCRAP
(
	USER_NO 		INT NOT NULL COMMENT '유저 번호',
	REC_NO 			INT NOT NULL COMMENT '레시피 번호',
	REG_DATE		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
	PRIMARY KEY (USER_NO, REC_NO)
)
COMMENT='스크랩',
COLLATE='utf8_general_ci'
;


/* 210213 추가 (레시피, 레시피 스탭 테이블에 첨부파일 컬럼 지우고 첨부파일 테이블 새로 만들기) */
/* 210220 수정 */
CREATE TABLE TKK_ATTACH
(
ATTACH_NO INT NOT NULL COMMENT '첨부파일 번호',
	ATTACH_NAME		VARCHAR(800) NOT NULL COMMENT '첨부파일 이름',
	ATTACH_PATH		VARCHAR(300) NOT NULL COMMENT '첨부파일 경로',
	REC_NO 			INT NOT NULL COMMENT '레시피 번호',
	STEP_NO 		INT NOT NULL COMMENT '스탭 번호',
	REG_DATE 		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
	MOD_DATE 		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
	PRIMARY KEY (ATTACH_NO)
)
COMMENT='첨부파일',
COLLATE='utf8_general_ci'
;




/* Create Foreign Keys */

ALTER TABLE TKK_MYKIT
	ADD FOREIGN KEY (INGR_CODE)
	REFERENCES TKK_INGREDIENT (INGR_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

ALTER TABLE TKK_RECIPE_INGR
	ADD FOREIGN KEY (INGR_CODE)
	REFERENCES TKK_INGREDIENT (INGR_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE TKK_COMMENT
	ADD FOREIGN KEY (REC_NO)
	REFERENCES TKK_RECIPE (REC_NO)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

ALTER TABLE TKK_RECIPE_INGR
	ADD FOREIGN KEY (REC_NO)
	REFERENCES TKK_RECIPE (REC_NO)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

ALTER TABLE TKK_RECIPE_STEP
	ADD FOREIGN KEY (REC_NO)
	REFERENCES TKK_RECIPE (REC_NO)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

ALTER TABLE TKK_SCRAP
	ADD FOREIGN KEY (REC_NO)
	REFERENCES TKK_RECIPE (REC_NO)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

ALTER TABLE TKK_COMMENT
	ADD FOREIGN KEY (USER_NO)
	REFERENCES TKK_USER (USER_NO)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

ALTER TABLE TKK_MYKIT
	ADD FOREIGN KEY (USER_NO)
	REFERENCES TKK_USER (USER_NO)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

ALTER TABLE TKK_RECIPE
	ADD FOREIGN KEY (USER_NO)
	REFERENCES TKK_USER (USER_NO)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

ALTER TABLE TKK_SCRAP
	ADD FOREIGN KEY (USER_NO)
	REFERENCES TKK_USER (USER_NO)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

/* 210213 추가 */
ALTER TABLE TKK_ATTACH
	ADD FOREIGN KEY (REC_NO)
	REFERENCES TKK_RECIPE (REC_NO)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

ALTER TABLE TKK_ATTACH
	ADD FOREIGN KEY (STEP_NO)
	REFERENCES TKK_RECIPE_STEP (STEP_NO)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


INSERT INTO TKK_USER VALUES ('0', 'test02', 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe', '석류맛쿠키', '석류맛', 'test@naver.com', '010-1234-1234', 'U' , REG_DATE, MOD_DATE);
