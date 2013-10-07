drop table MyUser cascade constraints;
drop table MySession cascade constraints;
drop table Term cascade constraints;
drop table Course cascade constraints;
drop table CoursePrerequisite cascade constraints;
drop table Section cascade constraints;
drop table Student cascade constraints;
drop table SectionEnrollment cascade constraints;

drop sequence TermId_Identity;
drop sequence CourseId_Identity;
drop sequence SectionId_Identity;
drop sequence StudentId_Identity;

drop view vw_StudentSummary;
drop view vw_SectionSeatsFilled;

drop procedure sp_EnrollInSection;
drop procedure sp_StudentStatusUpdate;

create table MyUser (
    UserName varchar2(16) primary key,
    Password varchar2(12) not null,
    IsStudent number(1,0) not null,
    IsAdministrator number(1,0) not null
);

create table MySession (
    SessionId varchar2(32) primary key,
    UserName varchar2(16) not null,
    SessionDate date not null,
    SessionValid number(1,0) not null,
	foreign key (UserName) references myUser
);

create table Term (
	TermId number primary key,
	EnrollmentDeadline timestamp not null,
	TermYear number(4,0) not null,
	Semester varchar2(15) not null
);

create sequence TermId_Identity
start with 1
increment by 1;

create or replace trigger TermId_Increment
before insert on Term
for each row
begin
	select TermId_Identity.nextval into :new.TermId from dual;
end;
/

create table Course (
	CourseId varchar2(6) primary key,
	Description varchar2(150) null,
	Credits number(1,0) not null,
	Title varchar2(50) not null
);

--create sequence CourseId_Identity
--start with 1
--increment by 1;

--create or replace trigger CourseId_Increment
--before insert on Course
--for each row
--begin
--select CourseId_Identity.nextval into :new.CourseId from dual;
--end;
--/

create table CoursePrerequisite (
	CourseId varchar2(6) not null,
	PrerequisiteCourseId varchar2(6) not null,
	MinimumGrade char(1) not null,
	primary key(CourseId,PrerequisiteCourseId),
	foreign key (CourseId) references Course,
	foreign key (PrerequisiteCourseId) references Course
);

create table Section (
	SectionId number primary key,
	CourseId varchar2(6) not null,
	TermId number not null,
	SectionTime timestamp not null,
	MaxSeats number(3,0) not null,
	foreign key (CourseId) references Course,
	foreign key (TermId) references Term
);

create sequence SectionId_Identity
start with 1
increment by 1;

create or replace trigger SectionId_Increment
before insert on Section
for each row
begin
select SectionId_Identity.nextval into :new.SectionId from dual;
end;
/

create table Student (
	StudentId varchar2(8) primary key,
	UserName varchar2(16) null,
	FirstName varchar2(10) not null,
	LastName varchar2(10) not null,
	Age number not null,
	Street varchar2(30) not null,
	City varchar2(10) not null,
	State char(2) not null,
	Zip number not null,
	StudentType varchar2(20) not null,
	IsProbational number(1,0),
	foreign key (UserName) references myUser
);

create sequence StudentId_Identity
start with 1
increment by 1
maxvalue 99999;

create or replace trigger StudentId_Increment
before insert on Student
for each row
begin
select substr(:new.FirstName,1,1) || substr(:new.LastName,1,1) || substr(to_char(StudentId_Identity.nextval, '000000'),2) into :new.StudentId from dual;
end;
/

create table SectionEnrollment (
	SectionId number not null,
	StudentId varchar2(8) not null,
	Grade char(1) null,
	primary key(SectionId, StudentId),
	foreign key (SectionId) references Section,
	foreign key (StudentId) references Student
);

create view vw_StudentSummary as
select sse.StudentId,
	count(*) as CourseCount, 
	sum(crs.Credits) as CreditsEarned, 
	sum((case when sse.Grade = 'A' then 4
			when sse.Grade = 'B' then 3
			when sse.Grade = 'C' then 2
			when sse.Grade = 'D' then 1
			else 0 end) * crs.Credits) / sum(crs.Credits) as GPA
from SectionEnrollment sse
	inner join Section sec
		on sse.SectionId = sec.SectionId
	inner join Course crs
		on sec.CourseId = crs.CourseId
where sse.Grade is not null
	and sse.Grade < 'G'
	and sse.Grade >= 'A'
group by sse.StudentId;

create view vw_SectionSeatsFilled as
select SectionId, count(*) as SeatsFilled
from SectionEnrollment
group by SectionId;

create or replace procedure sp_EnrollInSection(sectionId in number, studentId in varchar)
as
	seatCount number;
	seatTakenCount number;
	studentEnrolledCount number;
	prerequisiteCount number;
	enrollmentDeadline timestamp;
begin

	select max(MaxSeats) as MaxCount into seatCount from Section where SectionId = sectionid;
	--for x in (select max(MaxSeats) as MaxCount from Section where SectionId = sectionid) 
	--loop
	--	seatCount := x;
	--	break;
	--end loop;
	select count(*) as TakenCount into seatTakenCount from SectionEnrollment where SectionId = sectionId;
	select count(*) as EnrolledCount into studentEnrolledCount from SectionEnrollment sse where (sse.SectionId = sectionId) and (sse.StudentId = studentId);
	select count(*) as PreCount into prerequisiteCount 
	from Section crsSec
		inner join CoursePrerequisite crsPre
			on crsSec.CourseId = crsPre.CourseId
		left outer join (select sec.CourseId, sse.Grade
					from SectionEnrollment sse
						inner join Section sec
							on sse.SectionId = sec.SectionId
					where (sse.StudentId = studentId)
						and (sse.Grade is not null) 
						and (sse.Grade <= 'F') 
						and (sse.Grade >= 'A')
					) stdCrs
			on crsPre.PrerequisiteCourseId = stdCrs.CourseId
	where (crsSec.SectionId = sectionId)
		and ((crsPre.MinimumGrade is not null and crsPre.MinimumGrade < stdCrs.Grade)
			or (stdCrs.CourseId is null));

	select max(trm.EnrollmentDeadline)
	into enrollmentDeadline
	from Term trm
		join Section sec
			on trm.TermId = sec.TermId
	where sec.SectionId = sectionId;
	
	if studentEnrolledCount > 0 then
		raise_application_error(-20000, 'The student is already enrolled in this sectin.');
	elsif prerequisiteCount > 0 then
		raise_application_error(-20000, 'The courses prerequisites are not for this section.');
	elsif enrollmentDeadline < sysdate then
		raise_application_error(-20000, 'Enrollment deadline past for this section.');
	elsif seatTakenCount >= seatCount then
		raise_application_error(-20000, 'The section is already full.');
	else
		insert into SectionEnrollment values (sectionId, studentId, null);
	end if;
end;
/

create or replace procedure sp_StudentStatusUpdate(studentId varchar)
as
	gpa number;
	isProbational number;
begin
	select GPA into gpa from vw_StudentSummary where StudentId = studentId;

	if gpa < 2.0 then
		isProbational := 1;
	else
		isProbational := 0;
	end if;

	update Student set IsProbational = isProbational where StudentId = studentId;
end;
/

insert into MyUser values('KJ000001', 'Test1234', 1, 1);
insert into MyUser values('SiteAdmin', 'Test1234', 0, 1);
insert into Term(EnrollmentDeadline,TermYear,Semester) values(to_timestamp('2013-06-01 11:59:59 PM', 'YYYY-MM-DD HH:MI:SS AM'), 2013, 'Summer');
insert into Term(EnrollmentDeadline,TermYear,Semester) values(to_timestamp('2013-08-01 11:59:59 PM', 'YYYY-MM-DD HH:MI:SS AM'), 2013, 'Fall');
insert into Term(EnrollmentDeadline,TermYear,Semester) values(to_timestamp('2014-01-01 11:59:59 PM', 'YYYY-MM-DD HH:MI:SS AM'), 2014, 'Spring');
insert into Course(CourseId,Description,Credits,Title) values('CS1234','Intro class to computer science',3,'Comp Intro');
insert into Course(CourseId,Description,Credits,Title) values('CS4321','Advanced programming class',4,'Adv Comp');
insert into Course(CourseId,Description,Credits,Title) values('EN1234','The first english composition class',3,'English Comp 1');
insert into CoursePrerequisite(CourseId,PrerequisiteCourseId,MinimumGrade) values('CS4321','CS1234','C');
insert into Section(CourseId,TermId,SectionTime,MaxSeats) values('CS1234',1,to_timestamp('11:00 AM', 'HH:MI AM'),1);
insert into Section(CourseId,TermId,SectionTime,MaxSeats) values('CS4321',1,to_timestamp('1:00 PM', 'HH:MI AM'),1);
insert into Section(CourseId,TermId,SectionTime,MaxSeats) values('EN1234',2,to_timestamp('1:00 PM', 'HH:MI AM'),2);
insert into Section(CourseId,TermId,SectionTime,MaxSeats) values('CS1234',2,to_timestamp('3:00 PM', 'HH:MI AM'),1);
insert into Section(CourseId,TermId,SectionTime,MaxSeats) values('CS4321',2,to_timestamp('5:00 PM', 'HH:MI AM'),1);
insert into Section(CourseId,TermId,SectionTime,MaxSeats) values('EN1234',3,to_timestamp('1:00 PM', 'HH:MI AM'),2);
insert into Section(CourseId,TermId,SectionTime,MaxSeats) values('CS1234',3,to_timestamp('3:00 PM', 'HH:MI AM'),1);
insert into Section(CourseId,TermId,SectionTime,MaxSeats) values('CS4321',3,to_timestamp('5:00 PM', 'HH:MI AM'),1);
insert into Student(UserName,FirstName,LastName,Age,Street,City,State,Zip,StudentType,IsProbational) values('KJ000001','Karl','James',23,'123 S. 1st','OKC','OK',73165,'Undergraduate',0);

commit;