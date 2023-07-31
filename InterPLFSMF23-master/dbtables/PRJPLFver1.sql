DROP TABLE process_plan; --공정계획
CREATE TABLE process_plan(
    planID      VARCHAR2(20)
   ,prodNo      VARCHAR2(20)
   ,prodQty     NUMBER
   ,lineID      VARCHAR(20)
   ,startdate   DATE
   ,enddate     DATE
   ,empNo       VARCHAR2(20)
   ,check_yn    char(1) -- Y/N
   ,CONSTRAINT PK_plan PRIMARY KEY(planID,prodNo)
);

select * from process_plan;
--------------------------------------------------------------------------------
DROP TABLE product; --제품
CREATE TABLE product(
    prodNo      VARCHAR2(20)
   ,prodName    VARCHAR2(30)
   ,prodPrice   NUMBER
   ,category    VARCHAR2(20)
   ,leadtime    NUMBER
   ,CONSTRAINT PK_product_No PRIMARY KEY(prodNo)    
);

select * from product;
--------------------------------------------------------------------------------
DROP TABLE BOM; --제품에 들어가는 원자재관리
CREATE TABLE BOM(
    prodNo      VARCHAR2(20)
   ,materNo     VARCHAR2(20)
   ,materPrNo   VARCHAR2(20)
   ,materQty    NUMBER
   ,CONSTRAINT PK_BOM PRIMARY KEY(prodNo, materNo)
);

select * from BOM;
--------------------------------------------------------------------------------
DROP TABLE material; --원자재
CREATE TABLE material(
    materNo      VARCHAR2(20)
   ,materName    VARCHAR2(20)
   ,materPrice   NUMBER
   ,unit         VARCHAR2(10)
   
   ,CONSTRAINT PK_material_No PRIMARY KEY(materNo)
);
select * from material;
--------------------------------------------------------------------------------
DROP TABLE inventory; --재고
CREATE TABLE inventory(
    LOT        VARCHAR(10)     NOT NULL
   ,prodNo     VARCHAR2(20)
   ,materNo    VARCHAR2(20)
   ,Qty        NUMBER
   ,whseNo     VARCHAR2(20)
   
   ,CONSTRAINT PK_inventory_LOT PRIMARY KEY(LOT)
);

select * from inventory;
--------------------------------------------------------------------------------
DROP TABLE warehouse; --창고
CREATE TABLE warehouse(
    whseNo     VARCHAR2(20)     NOT NULL
   ,whseLoc    VARCHAR2(200)
   ,whseName   VARCHAR2(50)
   ,CONSTRAINT PK_warehouse_No PRIMARY KEY(whseNo)
);

select * from warehouse;
--------------------------------------------------------------------------------
DROP TABLE process; -- 공정
CREATE TABLE process
(
     processID  VARCHAR2(20)
    ,planID     VARCHAR2(20) 
    ,leadTime   NUMBER
    ,CONSTRAINT PK_process_ID PRIMARY KEY(processID)
);

SELECT * FROM process;
--------------------------------------------------------------------------------
DROP TABLE result_prod; -- 생산제품
CREATE TABLE result_prod 
(
     serialNo    VARCHAR2(20)
    ,processID   VARCHAR2(20) 
    ,cycleTime   NUMBER
    ,status      NUMBER -- "0/1" -> pass/fail
    ,LOT         VARCHAR(10)     
    ,CONSTRAINT PK_serialNo PRIMARY KEY(serialNo)
);
SELECT * FROM result_prod;
--------------------------------------------------------------------------------
DROP TABLE process_Time; -- 시간대별 생산
CREATE TABLE process_Time
(
     processTime    NUMBER  NOT NULL
    ,planID         VARCHAR2(20)
    ,value          NUMBER
    ,CONSTRAINT PK_process_Time PRIMARY KEY(processTime)
);

SELECT * FROM process_Time;
--------------------------------------------------------------------------------
DROP TABLE process_res; --공정결과
CREATE TABLE process_res (
    resID      VARCHAR2(20) NOT NULL
   ,planID     VARCHAR2(20)
   ,startdate  DATE  
   ,enddate    DATE 
   ,passedQty  NUMBER 
   ,failedQty  NUMBER 
   ,empNo      VARCHAR2(20)
   ,CONSTRAINT PK_process_res_ID PRIMARY KEY(resID)
);

SELECT * FROM process_res;
--------------------------------------------------------------------------------
DROP TABLE process_issue;-- 공정이슈
CREATE TABLE process_issue (
    arm_seq     NUMBER
   ,planID      VARCHAR2(20)
   ,issueNo     VARCHAR2(10)
   ,issueInfo   VARCHAR2(50)
   ,timestamp   DATE
   
   ,CONSTRAINT PK_process_issue_seq PRIMARY KEY(arm_seq)
);

select * from process_issue;
--------------------------------------------------------------------------------
DROP TABLE issue; --이슈
CREATE TABLE issue (
    issueNo     VARCHAR2(10)
   ,issueName   VARCHAR2(30) 
   
   ,CONSTRAINT PK_issue_No PRIMARY KEY(issueNo)
);

select * from issue;
--------------------------------------------------------------------------------
DROP TABLE line; --생산라인
CREATE TABLE line (
    lineID     VARCHAR2(10)
   ,prodName   VARCHAR2(20)
   ,status     VARCHAR2(10) --ON/OFF 
   
   ,CONSTRAINT PK_line_ID PRIMARY KEY(lineID)
);

select * from line;
--------------------------------------------------------------------------------
DROP TABLE e_user;
CREATE TABLE e_user( --MEMBER
    USERNO  NUMBER,
    EMPNO   VARCHAR(10),
    NAME    VARCHAR2(30),
    ID      VARCHAR2(50),
    PW      VARCHAR2(50),
    RANK    VARCHAR2(50),
    ADMIN    CHAR(1)      DEFAULT 0,
    REGIDATE DATE DEFAULT SYSDATE,
    CONSTRAINT pk_USER PRIMARY KEY(userno)
    );
--------------------------------------------------------------------------------
DROP SEQUENCE user_seq;
CREATE SEQUENCE user_seq --시퀀스
       INCREMENT BY 1
       START WITH 1000
       MINVALUE 1000
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;
    
INSERT INTO e_user(userno, empno, name, id, pw, rank, admin) VALUES(user_seq.NEXTVAL, 00000000, '시스템관리자', 'admin1', 'admin123', 'Guest', 1);
INSERT INTO e_user(userno, empno, name, id, pw, rank, admin) VALUES(user_seq.NEXTVAL, 00000000, 'TEST', 'test1', 'test123', 'Guest', 0);
INSERT INTO e_user(userno, empno, name, id, pw, rank, admin) VALUES(user_seq.NEXTVAL, 'EMP001', '권재식', 'kwon1', '1234', '부장', 1);
INSERT INTO e_user(userno, empno, name, id, pw, rank, admin) VALUES(user_seq.NEXTVAL, 'EMP002', '한창준', 'han1', '1234', '대리', 0);
INSERT INTO e_user(userno, empno, name, id, pw, rank, admin) VALUES(user_seq.NEXTVAL, 'EMP003', '정신우', 'jung1', '1234', '차장', 1);
INSERT INTO e_user(userno, empno, name, id, pw, rank, admin) VALUES(user_seq.NEXTVAL, 'EMP004', '정종식', 'jung2', '1234', '사원', 0);
--------------------------------------------------------------------------------
DROP TABLE Board;
CREATE TABLE Board (
	num number(11) constraint pk_board_num primary key,
    planID varchar2(20),
	empName varchar2(20),
    content clob,
    prodName varchar2(50),
    prodNo varchar2(50),
    startdate date,
    enddate date,	
	pos NUMBER(7),
	ref number(7),
	depth number(7),
	regdate date,
	pass varchar2(15),
    ip varchar2(15),
	filename varchar2(30),
	filesize number(11)
);
--------------------------------------------------------------------------------
DROP sequence board_seq; --보드시퀀스
CREATE SEQUENCE board_seq
    INCREMENT BY 1
    START WITH 0
    MAXVALUE 999999
    MINVALUE 0
    NOCYCLE
    NOCACHE;
--------------------------------------------------------------------------------
DROP TABLE process_Order;
CREATE TABLE process_Order -- 공정명령
(
     num         NUMBER -- 수정
    ,planID      VARCHAR2(20)-- 수정
    ,prodNo      VARCHAR2(20)
    ,startdate   DATE
    ,enddate     DATE
    ,NAME        VARCHAR2(30) -- e_user
    ,lineID      VARCHAR2(10) -- 라인선택
    ,procheck    VARCHAR2(1) -- 진행여부 Y/N
    ,CONSTRAINT PK_planID PRIMARY KEY(planID)
);
----------------------------------------------------------------------------------
DROP TABLE process_Time;
CREATE TABLE process_Time
(
     processTime    NUMBER
    ,planID         VARCHAR2(20)
    ,value          NUMBER
    ,CONSTRAINT PK_process_Time PRIMARY KEY(processTime)
);
-----------------------------------------------------------------------------------
DROP TABLE process_issue;
CREATE TABLE process_issue (
    arm_seq     NUMBER
   ,planID      VARCHAR2(20)
   ,issueNo     VARCHAR2(10)
   ,issueInfo   VARCHAR2(50)
   ,timestamp   DATE
   ,CONSTRAINT PK_process_issue_seq PRIMARY KEY(arm_seq)
);
--------------------------------------------------------------------------------
 -- 하위는 뷰
 -- [상품번호별 담당자와 제품명]
DROP view p_names;
create view p_names
    as(
    select pp.planID, pp.prodNo, p.prodName, pp.empNo, e.Name
    from process_plan pp
        ,product p
        ,e_user e
    where pp.prodNo = p.prodNo
    and pp.empNo = e.empNo);
    
SELECT * FROM p_names;
--------------------------------------------------------------------------------    
-- [상품번호별 납기와 불량률]
DROP view p_pr;
create view p_pr
    as(
    select pp.planID, pp.prodNo, pr.startdate, pr.enddate, pr.passedQty, pr.failedQtya
    from process_plan pp
        ,process_res pr
    where pp.planID = pr.planID);
    
select * from p_pr;

--------------------------------------------------------------------------------    
-- [상품번호별 이슈]
DROP view p_issue;
create view p_issue
    as(
    select  pp.planID, pp.prodNo, pi.arm_Seq, pi.issueNo, i.issueName, pi.issueInfo, pi.timestamp
    from process_plan pp
        , process_issue pi
        , issue i
    where pp.planID = pi.planID
    and pi.issueNo = i.issueNo); 
    
select * from p_issue;

--------------------------------------------------------------------------------    
-- [상품번호별 재고]
DROP view p_inven;
create view p_inven
    as(
    select pp.planID, pp.prodNo, b.materNo, m.materName, m.materPrice, b.materQty
    from material m
        , BOM b
        , process_plan pp
    where pp.prodNo = b.prodNo
    and m.materNo = b.materNo); 
select * from p_inven;
-- [라인번호별 담당자와 제품명]
DROP view l_names;
create view l_names  
	as(
    select pp.planID, pp.prodNo, p.prodName, pp.lineID, l.status, pp.empNo, e.Name
    from process_plan pp
        ,product p
        ,e_user e
        ,line l
    where pp.prodNo = p.prodNo
    and pp.lineID = l.lineID
    and pp.empNo = e.empNo);
	
SELECT * FROM l_names;
--------------------------------------------------------------------------------    
-- [라인번호별 납기와 불량률]
DROP view l_pr;
CREATE view l_pr
	as(
    select pp.planID, l.lineID, pp.prodNo, pr.startdate, pr.enddate, pr.passedQty, pr.failedQty
    from process_plan pp
        ,process_res pr
        ,line l
    where pp.planID = pr.planID
    and pp.lineID = l.lineID);
select * from l_pr;
--------------------------------------------------------------------------------    
-- [라인번호별 이슈]
DROP view l_issue;
CREATE view l_issue
	as(
    select pp.planID, l.lineID, pp.prodNo, pi.arm_Seq, pi.issueNo, i.issueName, pi.issueInfo, pi.timestamp
    from process_plan pp
        ,process_issue pi
        ,issue i
        ,line l
    where pp.planID = pi.planID
    and pp.lineID = l.lineID
    and pi.issueNo = i.issueNo);
select * from l_issue;
--------------------------------------------------------------------------------    
-- [라인번호별 재고]
DROP view l_inven;
CREATE view l_inven
	as(
    select pp.planID, l.lineID, pp.prodNo, b.materNo, m.materName, m.materPrice, b.materQty
    from material m
        ,BOM b
        ,process_plan pp
        ,line l
    where pp.prodNo = b.prodNo
    and pp.lineID = l.lineID
    and m.materNo = b.materNo);
select * from l_inven;

commit;