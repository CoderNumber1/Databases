--Query to select the password of a user
select Password
from User
Where UserName = :userName;

--Creating a new user
insert into User values(:userName,:password,:isStudent,:isAdministrator);

--Creating a new session
insert into Session values(:sessionId,:userName,GetDate());

--Invalidate all sessions for a user.
--	We will use this to make sure there is only one active
--		sesion for a user when they log in.
update Session
set SessionEndDate = GetDate()
where UserName = :userName;

--Get user information when we log them in
select IsStudent, IsAdministrator
from User
where UserName = :userName;

--Change a users password
update myUser
set Password = :password
where UserName = :userName

--Search users
select UserName, IsStudent, IsAdministrator
from myUser
where UserName = case when :userName is not null and :userName <> '' 
					then :userName 
					else UserName 
				end
	and IsStudent = case when :isStudent is not null and :isStudent = 1 
						then :isStudent 
						else IsStudent 
					end
	and IsAdministrator = case when :isAdministrator is not null and :isAdministrator = 1 
								then :isAdministrator 
								else IsAdministrator 
						end;
	