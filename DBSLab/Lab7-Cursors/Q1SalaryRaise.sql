CREATE TABLE Salary_raise(
    Instructor_ID NUMBER,
    Raise_date DATE,
    Raise_amt NUMBER);

SET SERVEROUTPUT ON

DECLARE
    CURSOR C(dname instructor.dept_name%TYPE) IS SELECT * FROM Instructor WHERE dept_name = dname;
    str instructor.dept_name%TYPE;
    instRow instructor%ROWTYPE;
BEGIN
    str := '&DeptName';
    OPEN C(str);
    LOOP
        FETCH C INTO instRow;
        EXIT WHEN C%NOTFOUND;
        UPDATE Instructor SET salary = salary * 1.05 WHERE ID = instRow.ID;
        INSERT INTO salary_raise VALUES (instRow.ID,SYSDATE,instRow.salary*0.05);
    END LOOP;
    CLOSE C;
END;
/