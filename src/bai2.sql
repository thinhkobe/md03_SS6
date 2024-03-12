create database students_management;
use students_management;
create table class
(
    class_id   int primary key auto_increment,
    class_name varchar(50),
    start_date datetime,
    status     bit
);
create table subject
(
    subject_id int primary key auto_increment,
    sub_name   varchar(50),
    credit     int,
    status     bit
);
create table student
(
    student_id int primary key auto_increment,
    student_name varchar(50),
    address varchar(255),
    phone varchar(11),
    status bit,
    class_id int,
    foreign key (class_id) references class(class_id)
);
create table mark(
                     mark_id int primary key auto_increment,
                     mark int,
                     examTime datetime,
                     sub_id int,
                     id_student int,
                     foreign key (sub_id) references subject(subject_id),
                     foreign key (id_student) references student(student_id)
)
;
DELIMITER //
CREATE PROCEDURE InsertClass(
    IN class_name VARCHAR(50),
    IN start_date DATETIME,
    IN status BIT
)
BEGIN
    INSERT INTO class (class_name, start_date, status)
    VALUES (class_name, start_date, status);
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE InsertSubject(
    IN sub_name VARCHAR(50),
    IN credit INT,
    IN status BIT
)
BEGIN
    INSERT INTO subject (sub_name, credit, status)
    VALUES (sub_name, credit, status);
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE InsertStudent(
    IN student_name VARCHAR(50),
    IN address VARCHAR(255),
    IN phone VARCHAR(11),
    IN status BIT,
    IN class_id INT
)
BEGIN
    INSERT INTO student (student_name, address, phone, status, class_id)
    VALUES (student_name, address, phone, status, class_id);
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE InsertMark(
    IN mark INT,
    IN examTime DATETIME,
    IN sub_id INT,
    IN id_student INT
)
BEGIN
    INSERT INTO mark (mark, examTime, sub_id, id_student)
    VALUES (mark, examTime, sub_id, id_student);
END //
DELIMITER ;

delimiter //
CREATE PROCEDURE getMostChemitry(
)
BEGIN
   select S.student_name,M.mark
       from student S join mark m on S.student_id = m.id_student
    join subject s2 on s2.subject_id = m.sub_id
   order by student_id desc
   ;
END //
DELIMITER ;
-- Thêm dữ liệu ngẫu nhiên cho bảng "Class"
INSERT INTO class (class_name, start_date, status)
VALUES
    ('Class A', '2022-01-01', 1),
    ('Class B', '2022-02-01', 1),
    ('Class C', '2022-03-01', 0);

-- Thêm dữ liệu ngẫu nhiên cho bảng "Subject"
INSERT INTO subject (sub_name, credit, status)
VALUES
    ('Math', 3, 1),
    ('English', 4, 1),
    ('Science', 3, 0);

-- Thêm dữ liệu ngẫu nhiên cho bảng "Student"
INSERT INTO student (student_name, address, phone, status, class_id)
VALUES
    ('John Doe', '123 Main St', '12345678901', 1, 1),
    ('Jane Smith', '456 Oak St', '98765432109', 1, 2),
    ('Bob Johnson', '789 Pine St', '55511122334', 0, 3);

-- Thêm dữ liệu ngẫu nhiên cho bảng "Mark"
INSERT INTO mark (mark, examTime, sub_id, id_student)
VALUES
    (75, '2022-03-10', 1, 1),
    (85, '2022-03-11', 2, 2),
    (90, '2022-03-12', 3, 3);

call getMostChemitry();

delimiter //
create procedure getListSub()
begin
    select Sub.sub_name,count(subject_id) 'so người thi'
        from subject Sub join mark m on Sub.subject_id = m.sub_id
    group by subject_id
    order by subject_id desc ;
end //
delimiter ;

