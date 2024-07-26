create database eCommerceDB;
use eCommerceDB;

create table tbl_products(
product_id int not null primary key auto_increment,
product_name varchar(40) not null,
product_description varchar(60) not null,
price real not null,
stock int not null
);

create table tbl_customers(
customer_id int not null primary key auto_increment,
firstname varchar(20) not null,
surname varchar(20) not null,
email varchar(40) not null,
phone varchar(15) not null,
address varchar(60) not null
);

create table tbl_orders(
order_id int not null primary key auto_increment,
customer_id int not null,
order_date date not null,
order_status text,
constraint customer_id foreign key(customer_id) references tbl_customers(customer_id) on delete cascade on update cascade
);

create table tbl_order_items(
order_item_id int not null primary key auto_increment,
order_id int not null,
product_id int not null,
quantity int not null,
price int not null,
constraint order_id foreign key(order_id) references tbl_orders(order_id) on delete cascade on update cascade,
constraint product_id foreign key(product_id) references tbl_products(product_id) on delete cascade on update cascade
);

insert into tbl_products (product_name, product_description, price, stock) values
('Fireside Chat Throw Blanket', 'Vintage inspired pocket watch', 21.35, 90),
('Autumn Spice Candle', 'Gourmet chocolate gift box', 19.99, 100),
('Dancing Flames Body Mist', 'Durable stainless steel water bottle', 22.31, 30),
('Sunflower Fields Deodorant', 'Hand-painted ceramic plant pot', 34.19, 26),
('Coconut Cove Body Scrub', 'Sleek stainless steel kitchen utensils', 14.28, 22),
('Whispering Woods Essential Oil', 'Trendy boho macrame wall hanging', 9.08, 9),
('Ocean Breeze Body Lotion', 'Artistic watercolor brush set', 9.43, 24),
('Harvest Moon Hand Cream', 'Elegant glass vase', 13.33, 31),
('Lemon Zest Bath Bomb', 'Modern minimalist desk lamp', 24.59, 69),
('Whispering Wind Lip Scrub', 'Sustainable bamboo toothbrush set', 21.69, 92);

insert into tbl_customers (firstname, surname, email, phone, address) values
('Bertina', 'Lessmare', 'blessmare0@aol.com', '499-520-1854', '7635 Artisan Terrace'),
('Lowell', 'Sarvar', 'lsarvar1@github.com', '294-975-8482', '7 Hooker Circle'),
('Bliss', 'Reskelly', 'breskelly2@wunderground.com', '832-919-5077', '2842 Bayside Street'),
('Jaymie', 'Gotts', 'jgotts3@tripod.com', '757-906-9625', '645 Gina Crossing'),
('Flossie', 'Kennerley', 'fkennerley4@netvibes.com', '629-255-5423', '6483 Bunting Court');

insert into tbl_orders (customer_id, order_date, order_status) values
(5, '2023-09-02', 'shipped'),
(1, '2023-09-06', 'shipped'),
(2, '2024-07-01', 'processing'),
(1, '2024-02-24', 'processing'),
(3, '2024-06-25', 'pending'),
(3, '2024-02-24', 'shipped'),
(1, '2023-09-02', 'delivered');

insert into tbl_order_items (order_id, product_id, quantity, price) values
(1, 9, 15, 88.22),
(2, 1, 4, 29.87),
(3, 7, 15, 58.13),
(4, 10, 12, 45.05),
(5, 6, 19, 94.53),
(6, 10, 5, 57.34),
(7, 1, 7, 49.32);

select product_name as 'Products' from tbl_products;
select concat(firstname, ' ', surname) as 'Customers' from tbl_customers;
select order_date as 'All Orders' from tbl_orders;

delimiter $$
create procedure PlaceOrder(in productId int, in amount int)
begin
update tbl_products set stock = stock - amount where product_id = productId and stock >= amount;
end $$

create procedure GenerateRevenueReport()
begin
select concat('£', (select sum(price) from tbl_order_items)) as 'Total Revenue';
end $$

create procedure OrdersPerCustomer()
begin
select count(tbl_orders.customer_id) 'Total Orders', concat(tbl_customers.firstname, ' ', tbl_customers.surname) 'Customer' from tbl_orders
join tbl_customers on tbl_orders.customer_id = tbl_customers.customer_id group by tbl_orders.customer_id order by count(order_id) desc;
end $$
delimiter ;

call GenerateRevenueReport;
call OrdersPerCustomer;