drop table client cascade constraints;
drop table clientsession cascade constraints;

create table client (
  clientid varchar2(8) primary key,
  name varchar2(30),
  password varchar2(12),
  type varchar2(1)
);

create table clientsession (
  sessionid varchar2(32) primary key,
  clientid varchar2(8),
  sessiondate date,
  foreign key (clientid) references client
);
 
