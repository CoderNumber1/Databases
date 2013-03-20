drop table myUser cascade constraints;
drop table mySession cascade constraints;

create table myUser (
    UserName varchar2(16) primary key,
    Password varchar2(12) not null,
    IsStudent number(1,0) not null,
    IsAdministrator number(1,0) not null
);

create table mySession (
    SessionId varchar2(32) primary key,
    UserName varchar2(16) not null,
    SessionDate date not null,
    SessionValid number(1,0) not null,
	foreign key (UserName) references myUser
);

insert into myUser values('root', 'root', 1, 1);
commit;