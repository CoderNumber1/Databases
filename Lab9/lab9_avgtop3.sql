DECLARE
  CURSOR c1 IS
    SELECT grade FROM Student s, Taken t
      WHERE s.sid=t.sid AND seqid='00001'
      ORDER BY grade DESC;
  my_grade NUMBER(2,1);
  sum_grade NUMBER(3,1) := 0.0;
BEGIN
  OPEN c1;
  FOR i IN 1..3 LOOP
    FETCH c1 INTO my_grade;
	sum_grade := sum_grade + my_grade;
    EXIT WHEN c1%NOTFOUND; /* in case the number requested */
                           /* is more than the total */
                           /* number of enrolled students in the class */
  END LOOP;
  CLOSE c1;
  
  dbms_output.put_line('Average Grade: ' || (sum_grade / 3));
END;
/
