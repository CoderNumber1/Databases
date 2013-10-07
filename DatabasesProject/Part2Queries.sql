select StudentId, FirstName, LastName, Age, Street, City, State, Zip, StudentType, IsProbational
from Student
where UserName = (case when :userName is not null and :userName <> '' then :userName else UserName end)
	and StudentId = (case when :studentId is not null and :studentId <> '' then :studentId else StudentId end);
			
select sec.SectionId, 
		sec.CourseId, crs.Title, 
		trm.Semester, 
		trm.TermYear, 
		crs.Credits, 
		sse.Grade
from SectionEnrollment sse
	inner join Section sec
		on sse.SectionId = sec.SectionId
	inner join Course crs
		on sec.CourseId = crs.CourseId
	inner join Term trm
		on sec.TermId = trm.TermId
where sse.StudentId = :studentId
	and 1 = (case 
				when :enrollmentType = 'C' and sse.Grade is null then 1
				when :enrollmentType = 'P' and sse.Grade is not null then 1
				when :enrollmentType = 'A' then 1
				else 0
			end);

select CourseCount, CreditsEarned, GPA
from vw_StudentSummary
where StudentId = :studentId;

select sec.SectionId, 
		sec.CourseId, 
		crs.Title,
		crs.Description, 
		trm.Semester, 
		trm.TermYear, 
		crs.Credits, 
		to_char(sec.SectionTime, 'hh:mi AM') as CourseTime
from Section sec
	inner join Course crs
		on sec.CourseId = crs.CourseId
	inner join Term trm
		on sec.TermId = trm.TermId;

select sec.SectionId, 
		sec.CourseId, 
		crs.Title,
		trm.Semester, 
		trm.TermYear, 
		crs.Credits, 
		to_char(sec.SectionTime, 'hh:mi AM') as CourseTime,
		sec.MaxSeats,
		sse.SeatsFilled
from Section sec
	inner join Course crs
		on sec.CourseId = crs.CourseId
	inner join Term trm
		on sec.TermId = trm.TermId
	left outer join vw_SectionSeatsFilled sse
		on sec.SectionId = sse.SectionId
where trm.Semester = 'Fall'; (case when 'Fall' is not null and 'Fall' <> '' then 'Fall' else trm.Semester end);
	and sec.CourseId like '%' || (case when :course is not null and :course <> '' then :course else sec.CourseId end) || '%'
	and trm.EnrollmentDeadline >= sysdate;

select StudentId,
		UserName,
		FirstName,
		LastName,
		Age,
		Street,
		City,
		State,
		Zip,
		StudentType,
		IsProbational
from Student stu
	left outer join SectionEnrollment sse
		on stu.StudentId = sse.StudentId
	join Section sec
		on sse.SectionId = sec.SectionId
where (:firstName is not null and :firstName <> '' and stu.FirstName like '%' || :firstName || '%')
	or (:lastName is not null and :lastName <> '' and stu.LastName like '%' || :lastName || '%')
	or (:studentType is not null and :studentType <> '' and stu.StudentType = :studentType)
	or (:studentId is not null and :studentId <> '' and stu.StudentId like '%' || :studentId || '%')
	or (:courseId is not null and :courseId <> '' and sec.CourseId like '%' || :courseId || '%')
group by StudentId,
		UserName,
		FirstName,
		LastName,
		Age,
		Street,
		City,
		State,
		Zip,
		StudentType,
		IsProbational