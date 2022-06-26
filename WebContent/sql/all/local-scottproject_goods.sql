insert into team_product values (1,1,1,1,1,1,'1990-11-11',1);
insert into team_product values (2,2,2,2,2,2,'1990-11-11',1);
insert into team_product values (3,3,3,3,3,3,'1990-11-11',1);
insert into team_product values (4,4,4,4,4,4,'1990-11-11',1);
insert into team_product values (5,5,5,5,5,5,'1990-11-11',1);
insert into team_product values (6,6,6,6,6,6,'1990-11-11',1);
insert into team_product values (7,7,7,7,7,7,'1990-11-11',1);
insert into team_product values (8,8,8,8,8,8,'1990-11-11',1);

CREATE TABLE team_product (
    product_number NUMBER(*, 0) NOT NULL primary key,   -- 프라이머리키 추가
    category_code  VARCHAR2(30 BYTE) NOT NULL,
    product_name   VARCHAR2(50 BYTE) NOT NULL,
    product_price  NUMBER(*, 0) NOT NULL,
    product_stock  NUMBER(*, 0) NOT NULL,
    product_desc   VARCHAR2(3000 BYTE) NOT NULL,
    product_date   DATE NOT NULL,
    product_hits   NUMBER(*, 0) NOT NULL
);

CREATE TABLE cart (
    cart_number    NUMBER(*, 0) primary key,   -- 프라이머리키 추가    
    user_id varchar2(30),
    product_number NUMBER(*, 0) NOT NULL,
--    cart_value     VARCHAR2(30 BYTE) NOT NULL,
    product_count  NUMBER(*, 0) NOT NULL,
    constraint cart_fk1 foreign key(user_id) references user_table(user_id),
    constraint cart_fk2 foreign key(product_number) references product(product_number)
);

drop table cart;

insert into team_product values (1,1,1,1,1,1,'1990-11-11',1);

select * from cart;