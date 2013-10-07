create or replace procedure firstthree (my_seqid in varchar2, my_average out number) as
  cursor c1 is
    select sname, grade from student s, taken t
      where s.sid=t.sid and seqid=my_seqid
      order by grade desc;
  my_sname varchar2(40);
  my_grade number(2,1);
begin
  /* clear the my_tmp table */
  delete from my_tmp;
  commit;

  open c1;
  for i in 1..3 loop
    fetch c1 into my_sname, my_grade;
    exit when c1%notfound; /* in case the number requested */
                           /* is more than the total */
                           /* number of enrolled students */
    /* display the result */
    --dbms_output.put_line('name: ' || my_sname || '  ' || 'grade: ' || my_grade);
    /* put into temporary table */
    insert into my_tmp values(my_sname, my_grade);
    commit;
  end loop;
  close c1;
  
  select (sum(grade) / count(*)) as average into my_average from my_tmp;
end;
/
