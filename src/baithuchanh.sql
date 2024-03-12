create database quanlibh;
       use quanlibh;
create table role(
    id int primary key auto_increment,
name varchar(10) not null
);
create table users(
    id int primary key auto_increment,
    name varchar(100),
    address varchar(100)

);
create table user_role(
    user_id int ,
    foreign key (user_id) references users(id),
    role_id int ,
    foreign key (role_id) references  role(id)
);

delimiter //
create procedure register(name_in varchar(100),adress_in varchar(100))
begin
    select users.name from users;
    insert into users( name, address)
        value (name_in,adress_in);
end;
//delimiter ;

call register('thinh','hanoi');
delimiter //
create procedure singin(name_in varchar(100),adress_in varchar(100))
begin
   declare checkU int;
   select count(*) into checkU from users where name=name_in and address=adress_in;
    if checkU>0 then
        select 'dang nhap ok ' as ok;
            else select 'sai roi' as nono;
    end if ;
end;
//delimiter ;
call singin('thinh','hanoi');



