create database SchoolDB;
use SchoolDB;

create table tbl_students(
student_id int not null primary key auto_increment,
firstname varchar(20) not null,
surname varchar(20) not null,
dob date not null,
email varchar(40) not null
);

create table tbl_courses(
course_id int not null primary key auto_increment,
course_name varchar(40) not null,
course_description varchar(40) not null,
credits int not null
);

create table tbl_enrollments(
enrollment_id int not null primary key auto_increment,
student_id int not null,
course_id int not null,
enrollment_date date not null,
grade varchar(2) not null,
constraint student_id foreign key(student_id) references tbl_students(student_id) on delete cascade on update cascade,
constraint course_id foreign key(course_id) references tbl_courses(course_id) on delete cascade on update cascade
);

insert into tbl_students (firstname, surname, dob, email) values
('Timmi', 'Scorrer', '2023-12-29', 'tscorrer0@hugedomains.com'),
('Erin', 'Welland', '2023-10-23', 'ewelland1@zimbio.com'),
('Markus', 'Hanrott', '2024-01-11', 'mhanrott2@studiopress.com'),
('Byrann', 'Shirrell', '2023-09-04', 'bshirrell3@theatlantic.com'),
('Casey', 'Campaigne', '2024-04-07', 'ccampaigne4@odnoklassniki.ru'),
('Mattheus', 'Fiander', '2024-05-25', 'mfiander5@tiny.cc'),
('Flossie', 'Merali', '2023-07-26', 'fmerali6@marriott.com'),
('Dulce', 'Minmagh', '2023-10-19', 'dminmagh7@mozilla.com'),
('Sanson', 'Chirm', '2023-10-20', 'schirm8@vinaora.com'),
('Alix', 'Rakestraw', '2023-11-30', 'arakestraw9@toplist.cz');

insert into tbl_courses (course_name, course_description, credits) values
('Introduction to Psychology', 'Creative Writing Workshop', 7),
('Advanced Data Analysis', 'History of Ancient Civilizations', 1),
('Digital Marketing Strategies', 'History of Ancient Civilizations', 6),
('Creative Writing Workshop', 'Creative Writing Workshop', 6),
('History of Ancient Civilizations', 'Introduction to Astrophysics', 6);

insert into tbl_enrollments (student_id, course_id, enrollment_date, grade) values
(1, 2, '2023-10-11', 'C'),
(2, 5, '2023-08-28', 'D'),
(3, 3, '2024-01-19', 'E'),
(4, 2, '2024-03-27', 'B'),
(5, 1, '2024-03-30', 'D'),
(6, 1, '2023-10-11', 'C'),
(7, 4, '2023-08-28', 'D'),
(8, 2, '2024-01-19', 'E'),
(9, 5, '2024-03-27', 'B'),
(10, 4, '2024-03-30', 'D');

select concat(firstname, ' ', surname) 'Students' from tbl_students;
select course_name 'Courses' from tbl_courses;
select concat(tbl_students.firstname, ' ', tbl_students.surname) 'Student', course_name 'Course' from tbl_enrollments
join tbl_students on tbl_enrollments.student_id = tbl_students.student_id
join tbl_courses on tbl_enrollments.course_id = tbl_courses.course_id
order by tbl_students.student_id asc;

delimiter $$
create procedure UpdateGrade(in studentInput text, in gradeInput date)
begin
update tbl_enrollment set grade = gradeInput where student_id = studentInput;
end $$

create procedure StudentResults(in studentInput text)
begin
select tbl_courses.course_name 'Course', grade 'Grade' from tbl_enrollments
join tbl_courses on tbl_enrollments.course_id = tbl_courses.course_id where student_id = studentInput;
end $$

create procedure EnrollStudent(in fnameInput text, in snameInput text, in dobInput date, in emailInput text, in courseInput text, in expectedGrade text)
begin
insert into tbl_students (firstname, surname, dob, email) values (fnameInput, snameInput, dobInput, emailInput);
insert into tbl_enrollments (student_id, course_id, enrollment_date, grade)
values ((select student_id from tbl_students order by student_id desc limit 1), courseInput, (select curdate()), expectedGrade);
end $$

create procedure CatagoriesStudents()
begin
select concat(tbl_students.firstname, ' ', tbl_students.surname) 'Student', grade 'Grade', case
when grade between 'a' and 'c' then 'Passed'
when grade between 'd' and 'f' then 'Failed'
else 'Unmarked' end 'Result'
from tbl_enrollments join tbl_students on tbl_enrollments.student_id = tbl_students.student_id
order by grade asc;
end $$
delimiter ;

call StudentResults(1);
call EnrollStudent('James','Bullen','1998-07-07','james.roberts.bullen@gmail.com','3','A');
call CatagoriesStudents;