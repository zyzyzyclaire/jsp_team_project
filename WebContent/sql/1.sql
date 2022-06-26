drop  table cart cascade constraints;
drop  table product_imageFile cascade constraints;
drop  table user_table cascade constraints;
drop  table user_order cascade constraints;
drop  table userOrder_detail cascade constraints;
drop  table product cascade constraints;
drop  table product_category cascade constraints;
drop  table notice cascade constraints;
drop  table qna_board cascade constraints;
drop table userorder_refund  cascade constraints;
drop table  mylist  cascade constraints;

CREATE TABLE user_table
(USER_ID VARCHAR2(30) PRIMARY KEY 
,USER_PWD VARCHAR2(50)
,USER_NAME VARCHAR2(20) 
,USER_PHONE VARCHAR2(20)
,USER_EMAIL VARCHAR2(20)
,USER_ADDR VARCHAR2(500)
,USER_GRADE VARCHAR2(10)
);
commit;
insert into user_table values ('admin','1234','admin1','010-1111-1111','admin@','adminh','C');
insert into user_table values ('user1','1234','user1','010-user1','user1@','user1h','B');
insert into user_table values ('user2','1234','user2','010-user2','user2@','user2h','B');
insert into user_table values ('b1','1234','b1','010-b1','b1@','b1h','A');
insert into user_table values ('b2','1234','b2','010-b2','b2@','b2h','A');
CREATE TABLE user_order (
    order_number  VARCHAR2(30 byte)  primary key,
    user_id        VARCHAR2(30 BYTE),
    order_date     DATE,
    receiver_addr  VARCHAR2(500 BYTE),
    receiver_name  VARCHAR2(20 BYTE),
    receiver_phone VARCHAR2(20 BYTE),
    constraint user_order_fk1 foreign key(user_id) references user_table(user_id)ON DELETE CASCADE
);
insert into user_order values ('970212-user1','user1','1991-01-01','부산','user1','010-user1');
insert into user_order values ('970216-user1','user1','1991-01-01','서울','user1','010-user1');
insert into user_order values ('970216-user2','user2','1992-02-02','대구','user2','010-user2');



CREATE TABLE product_category (
    category_code     VARCHAR2(30 BYTE) primary key,
    category_name     VARCHAR2(50 BYTE),
    category_ref_code VARCHAR2(30 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE system LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
insert into product_category values ('신발','상의','1');
insert into product_category values ('상의','하의','1');
insert into product_category values ('하의','신발','1');




CREATE TABLE product (
    product_number NUMBER(*, 0)  primary key,   -- 프라이머리키 추가
    category_code  VARCHAR2(30 BYTE)  ,
    product_name   VARCHAR2(50 BYTE)  ,
    product_price  NUMBER(*, 0)  ,
    product_stock  NUMBER(*, 0)  ,
    product_desc   VARCHAR2(3000 BYTE)  ,
    product_date   DATE  ,
    product_hits   NUMBER(*, 0)  ,
    product_ordered_count   NUMBER(*, 0)  ,
    constraint category_fk foreign key(category_code) references product_category(category_code) ON DELETE CASCADE
);  

insert into product values (1,'상의','[무배]BEST 후드티 모음!',1000,10,'티셔츠입니다','1990-11-11',1,1);
insert into product values (2,'상의','[무배]BEST 후드티 모음!',1000,10,'2티셔츠입니다','1990-11-11',1,1);
insert into product values (3,'상의','[무배]BEST 후드티 모음!',1000,10,'3티셔츠입니다','1990-11-11',1,1);
insert into product values (4,'상의','[무배]BEST 후드티 모음!',1000,10,'4티셔츠입니다','1990-11-11',1,1);
insert into product values (5,'상의','[무배]BEST 후드티 모음!',1000,10,'5티셔츠입니다','1990-11-11',1,1);
insert into product values (6,'상의','[무배]BEST 후드티 모음!',1000,10,'6티셔츠입니다','1990-11-11',1,1);
insert into product values (7,'상의','[무배]BEST 후드티 모음!',1000,10,'7티셔츠입니다','1990-11-11',1,1);
insert into product values (8,'상의','[무배]BEST 후드티 모음!',1000,10,'8티셔츠입니다','1990-11-11',1,1);
insert into product values (9,'상의','[무배]BEST 후드티 모음!',1000,10,'여름용 티셔츠입니다 검정,보라','1990-11-11',1,1);
insert into product values (10,'상의','[기모안감추가]나미 면오버핏가디건',8,10,'10티셔츠입니다','1990-11-11',1,1);

insert into product values (11,'하의','바지',1,10,'바지입니다','1990-11-11',1,1);
insert into product values (12,'하의','바지',1,10,'바지입니다','1990-11-11',1,1);
insert into product values (13,'하의','바지',1,10,'바지입니다','1990-11-11',1,1);
insert into product values (14,'하의','바지',1,10,'바지입니다','1990-11-11',1,1);
insert into product values (15,'하의','바지',1,10,'바지입니다','1990-11-11',1,1);
insert into product values (16,'하의','바지',1,10,'바지입니다','1990-11-11',1,1);
insert into product values (17,'하의','바지',1,10,'바지입니다','1990-11-11',1,1);
insert into product values (18,'하의','바지',1,10,'바지입니다','1990-11-11',1,1);

insert into product values (19,'하의','하의',1,10,'신발입니다','1990-11-11',1,1);
insert into product values (20,'신발','바지',1,10,'바지입니다','1990-11-11',1,1);

insert into product values (21,'신발','신발',1,10,'신발입니다','1990-11-11',1,1);
insert into product values (22,'신발','바지',1,10,'바지입니다','1990-11-11',1,1);
insert into product values (23,'신발','신발',1,10,'신발입니다','1990-11-11',1,1);
insert into product values (24,'신발','신발',1,10,'신발입니다','1990-11-11',1,1);
insert into product values (25,'신발','신발',1,10,'신발입니다','1990-11-11',1,1);
insert into product values (26,'신발','신발',1,10,'신발입니다','1990-11-11',1,1);
insert into product values (27,'신발','신발',1,10,'신발입니다','1990-11-11',1,1);
insert into product values (28,'신발','신발',1,10,'신발입니다','1990-11-11',1,1);
insert into product values (29,'신발','신발',1,10,'신발입니다','1990-11-11',1,1);
insert into product values (30,'신발','티',1,10,'티입니다','1990-11-11',1,1);


CREATE TABLE userOrder_detail (
    order_detail_number   NUMBER(*, 0) primary key,
    order_number          VARCHAR2(30 byte),
    product_number        NUMBER(*, 0),
    product_count         NUMBER(*, 0),
    product_price           NUMBER(*, 0),
    order_detail_status   VARCHAR2(20 BYTE),
    refund_check  VARCHAR2(10 BYTE),
    constraint userOrder_detail_fk1 foreign key(order_number) references user_order(order_number) ON DELETE CASCADE,
    constraint userOrder_detail_fk2 foreign key(product_number) references product(product_number)ON DELETE CASCADE
);
insert into userOrder_detail values (1,'970216-user1',1,1,1000,'배송준비','no');
insert into userOrder_detail values (2,'970216-user1',2,2,2000,'배송준비','no');
insert into userOrder_detail values (3,'970216-user1',3,3,3000,'배송준비','no');


CREATE TABLE cart (
    cart_number    NUMBER(*, 0) primary key,   
    user_id varchar2(30),
    product_number NUMBER(*, 0),
    product_count  NUMBER(*, 0),
    constraint cart_fk1 foreign key(user_id) references user_table(user_id) ON DELETE CASCADE ,
    constraint cart_fk2 foreign key(product_number) references product(product_number)ON DELETE CASCADE 
);

insert into cart values (1,'user1',1,'1');
insert into cart values (2,'user1',2,'2');
insert into cart values (3,'user1',3,'3');
insert into cart values (4,'user1',4,'4');
insert into cart values (5,'user2',5,'5');
insert into cart values (6,'user2',6,'6');
insert into cart values (7,'user2',7,'7');
insert into cart values (8,'user2',8,'8');


CREATE TABLE product_imagefile (
    file_number        NUMBER(*, 0) NOT NULL,
    product_number     NUMBER(*, 0),
    orgin_file_name    VARCHAR2(300 BYTE),
    stored_file_name   VARCHAR2(300 BYTE),
    stored_thumbnail   VARCHAR2(300 BYTE),
    delegate_thumbnail VARCHAR2(5 BYTE),
    file_size          NUMBER(*, 0),
    create_date        DATE,
    delete_check       VARCHAR2(5 BYTE)
    ,constraint numberfk foreign key(product_number) references product(product_number)ON DELETE CASCADE
);

insert into product_imagefile values (1,1,'1.jpg','2.webp',null,'1',1,'1990-01-01','1');
insert into product_imagefile values (2,2,'2.jpg','2.webp',null,'2',2,'1990-02-02','2');
insert into product_imagefile values (3,3,'3.jpg','3.webp',null,'3',3,'1990-03-03','3');
insert into product_imagefile values (4,4,'4.jpg','4.webp',null,'4',4,'1990-04-04','4');
insert into product_imagefile values (5,5,'5.jpg','5.webp',null,'5',5,'1990-05-05','5');
insert into product_imagefile values (6,6,'6.jpg','6.webp',null,'6',6,'1990-06-06','6');
insert into product_imagefile values (7,7,'7.jpg','7.webp',null,'7',7,'1990-07-07','7');
insert into product_imagefile values (8,8,'8.jpg','8.webp',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (9,9,'8.jpg','9.webp',null,'9',8,'1990-08-08','8');

insert into product_imagefile values (31,9,'8.jpg',null,'9.webp','9',8,'1990-08-08','8');
insert into product_imagefile values (32,9,'8.jpg',null,'9.webp','9',8,'1990-08-08','8');
insert into product_imagefile values (33,9,'8.jpg',null,'9.webp','9',8,'1990-08-08','8');

insert into product_imagefile values (10,10,'8.jpg','10.webp',null,'10',8,'1990-08-08','8');
insert into product_imagefile values (11,11,'8.jpg','11.webp',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (12,12,'8.jpg','12.webp',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (13,13,'8.jpg','13.webp',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (14,14,'8.jpg','14.webp',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (15,15,'8.jpg','15.webp',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (16,16,'8.jpg','16.webp',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (17,17,'8.jpg','17.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (18,18,'8.jpg','18.webp',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (19,19,'8.jpg','19.webp',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (20,20,'8.jpg','20.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (21,21,'8.jpg','21.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (22,22,'8.jpg','22.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (23,23,'8.jpg','23.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (24,24,'8.jpg','24.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (25,25,'8.jpg','25.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (26,26,'8.jpg','26.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (27,27,'8.jpg','27.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (28,28,'8.jpg','28.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (29,29,'8.jpg','29.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (30,30,'8.jpg','30.jpg',null,'8',8,'1990-08-08','8');



CREATE TABLE NOTICE
(
N_NUM NUMBER(5,0) PRIMARY KEY 
,N_TITLE VARCHAR2(100)
,N_CONTENT VARCHAR2(3000)
,N_DATE DATE
,N_HIT NUMBER(5,0) DEFAULT(0)
,N_PWD VARCHAR2(12)
,N_IP VARCHAR2(15)
,USER_ID VARCHAR2(50)
);

insert into NOTICE values (1,'1','1','1991-01-01','1','1','1','admin');
insert into NOTICE values (2,'2','2','1992-02-02','2','2','2','admin');
insert into NOTICE values (3,'3','3','1992-02-02','2','2','2','admin');

CREATE TABLE qna_board(
b_id	NUMBER(10) primary key		
,u_id	VARCHAR2(15)	
,b_category	VARCHAR2(100)		
,b_view	NUMBER(10)	DEFAULT 0	
,b_title	VARCHAR2(100)		
,b_content	VARCHAR2(3000)
,b_ip varchar2(30)
,b_pwd varchar2(30)
,b_date	DATE		
,b_secret	CHAR(1)		
,b_ref	NUMBER(10)
,b_step NUMBER(10)
,b_level NUMBER(10)
,b_fname VARCHAR2(100)
,b_fsize NUMBER(10)
,b_rfname VARCHAR2(100)
,b_anschk CHAR(1)	
);		



CREATE TABLE userorder_refund(
     refund_number NUMBER PRIMARY KEY 
    ,order_detail_number NUMBER
    ,refund_reason VARCHAR2(500)
    ,refund_img VARCHAR2(300)
    ,user_email VARCHAR2(50)
    ,constraint orderdetailnumberFK foreign key(order_detail_number) references userOrder_detail(order_detail_number)ON DELETE CASCADE
);

create table mylist(
    product_number     NUMBER(*, 0),
    product_date   VARCHAR2(100)
    ,constraint productfk foreign key(product_number) references product(product_number)ON DELETE CASCADE
);


commit;