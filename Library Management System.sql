create database LibraryDB;
use LibraryDB;

create table tbl_books(
book_id int not null primary key auto_increment,
title varchar(40) not null,
author varchar(40) not null,
genre  varchar(40) not null,
published_year date
);

create table tbl_borrowers(
borrower_id int not null primary key auto_increment,
fullname varchar(40) not null,
email varchar(40) not null,
phone  varchar(40) not null
);

create table tbl_borrowed(
borrowed_id int not null primary key auto_increment,
book_id int not null,
borrower_id int not null,
borrow_date date not null,
return_date date default null,
constraint book_id foreign key(book_id) references tbl_books(book_id) on delete cascade on update cascade,
constraint borrower_id foreign key(borrower_id) references tbl_borrowers(borrower_id) on delete cascade on update cascade
);

delimiter $$
create procedure ReturnBook(in bookInput text, in dateInput date)
begin
update tbl_borrowed set return_date = dateInput where book_id = bookInput;
delete from tbl_borrowers where borrower_id not in (select borrower_id from tbl_borrowed where return_date is null group by borrower_id);
end $$
delimiter ;

insert into tbl_books(title, author, genre, published_year) values
('The Hobbit', 'JRR Tolkien', 'Fantasy', '1937-09-21'),
('A Song of Fire and Ice', 'George RR Martin', 'Fantasy', '1996-08-01'),
('A Study in Scarlet', 'Sir Arthur Conan Doyle', 'Mystery', '1887-01-01'),
('The Anarchist Cookbook', 'William Powell', 'Cookbook', '1971-01-01'),
('Casino Royale', 'Ian Fleming', 'Spy', '1953-04-13');

insert into tbl_borrowers(fullname, email, phone) values
('Dela Grimme', 'dgrimme0@microsoft.com', '480-615-0758'),
('Lanie Kopec', 'lkopec1@elpais.com', '736-992-4114'),
('Lenee Rishman', 'lrishman2@europa.eu', '479-253-5104');

insert into tbl_borrowed(book_id, borrower_id, borrow_date, return_date) values
('4','1','2023-07-17', default),
('1','2','2023-08-25', default),
('3','3','2023-11-05', default),
('5','3','2023-02-12', default),
('2','1','2024-04-23', default);

select title 'Books' from tbl_books;
select fullname 'Borrowers' from tbl_borrowers;
select title 'Borrowed Books' from tbl_borrowed inner join tbl_books on tbl_borrowed.book_id = tbl_books.book_id;

call ReturnBook('2','2024-05-01');
call ReturnBook('3','2023-11-19');
call ReturnBook('5','2023-02-20');

select * from tbl_borrowed
