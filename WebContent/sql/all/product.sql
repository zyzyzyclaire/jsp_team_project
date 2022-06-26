
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
    ,constraint numberfk foreign key(product_number) references product(product_number)
);




select * from product_imagefile;
insert into product_imagefile values (1,1,'1','1','1','1',1,'1990-01-01','1');
insert into product_imagefile values (2,2,'2','2','2','2',2,'1990-02-02','2');
insert into product_imagefile values (3,3,'3','3','3','3',3,'1990-03-03','3');
insert into product_imagefile values (4,4,'4','4','4','4',4,'1990-04-04','4');
insert into product_imagefile values (5,5,'5','5','5','5',5,'1990-05-05','5');
insert into product_imagefile values (6,6,'6','6','6','6',6,'1990-06-06','6');
insert into product_imagefile values (7,7,'7','7','7','7',7,'1990-07-07','7');
insert into product_imagefile values (8,8,'8','8','8','8',8,'1990-08-08','8');

select * from product;

CREATE TABLE product (
    product_number NUMBER(*, 0) NOT NULL primary key,   -- 프라이머리키 추가
    category_code  VARCHAR2(30 BYTE) NOT NULL,
    product_name   VARCHAR2(50 BYTE) NOT NULL,
    product_price  NUMBER(*, 0) NOT NULL,
    product_stock  NUMBER(*, 0) NOT NULL,
    product_desc   VARCHAR2(3000 BYTE) NOT NULL,
    product_date   DATE NOT NULL,
    product_hits   NUMBER(*, 0) NOT NULL
);

select product_number,category_code,product_name,product_price

							,product_stock,product_desc,product_hits from product;

select * from product;
drop table product;

insert into product values (1,1,'티',1,1,1,'1990-11-11',1);
insert into product values (2,1,'티2',2,2,2,'1990-11-11',1);
insert into product values (3,1,'티3',3,3,3,'1990-11-11',1);
insert into product values (4,2,'바지4',4,4,4,'1990-11-11',1);
insert into product values (5,2,'바지5',5,5,5,'1990-11-11',1);
insert into product values (6,2,'바지6',6,6,6,'1990-11-11',1);
insert into product values (7,3,'신발7',7,7,7,'1990-11-11',1);
insert into product values (8,3,'신발8',8,8,8,'1990-11-11',1);
commit;