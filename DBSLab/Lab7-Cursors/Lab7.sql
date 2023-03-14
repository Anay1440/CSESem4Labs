-- 1. Write a PL/SQL block to update the salary of each Instructor and insert a record in the salary_raise table. --

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

-- 2. Write a PL/SQL block that will display the ID, name, dept_name and tot_cred of the first 10 students with lowest total credit. --

SET SERVEROUTPUT ON

DECLARE
    CURSOR C IS SELECT * FROM (SELECT * FROM student ORDER BY tot_cred) WHERE ROWNUM < 11;
BEGIN
    FOR I IN C
    LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || I.ID || ' Name: ' || I.name || ' Dept_name: ' || I.dept_name || ' Total credits: ' || I.tot_cred);
    END LOOP;
END;
/

/* 3. Print the Course details and the total number of students registered for each course along with the course details 
- (Course-id, title, dept-name, credits, instructor_name, building, room-number, time-slot-id, tot_student_no ) */

SET SERVEROUTPUT ON

DECLARE
    CURSOR C IS SELECT * FROM teaches;
    N NUMBER;
    instrname instructor.name%TYPE;
    courseRow course%ROWTYPE;
    sectionRow section%ROWTYPE;
BEGIN
    FOR I IN C
    LOOP
        BEGIN
            SELECT COUNT(*) INTO N FROM takes GROUP BY course_id, sec_id, semester, year HAVING course_id = I.course_id AND sec_id = I.sec_id AND semester = I.semester AND year = I.year;
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN N := 0;
        END;
        SELECT name INTO instrname FROM instructor WHERE ID = I.ID;
        SELECT * INTO sectionRow FROM section WHERE course_id = I.course_id AND sec_id = I.sec_id AND semester = I.semester AND year = I.year;
        SELECT * INTO courseRow FROM course WHERE course_id = I.course_id;
        DBMS_OUTPUT.PUT_LINE('Course ID: ' || I.course_id || ' Title: ' || courseRow.title || ' Dept name: ' || courseRow.dept_name || ' Credits: ' || courseRow.credits || 
        ' Instructor name: ' || instrname || ' Building: ' || sectionRow.building || ' Room number: ' || sectionRow.room_number || ' Time slot id: ' || sectionRow.time_slot_id || ' Total students enrolled: ' || N);
    END LOOP;
END;
/

/* 4. Find all students who take the course with Course-id: CS101 and if he/ she has less than 40 total credit (tot-cred), 
deregister the student from that course. (Delete the entry in Takes table) */

SET SERVEROUTPUT ON

DECLARE
    CURSOR C IS SELECT * FROM takes WHERE course_id = 'CS-101';
    creds student.tot_cred%TYPE;
BEGIN
    FOR I IN C
    LOOP
        SELECT tot_cred INTO creds FROM student WHERE ID = I.ID;
        IF creds < 40 THEN
            DELETE FROM takes WHERE ID = I.ID AND course_id = I.course_id;
        END IF;
    END LOOP;
END;
/

/* 5. Alter StudentTable(refer Lab No. 8 Exercise) by resetting column LetterGrade to F. 
Then write a PL/SQL block to update the table by mapping GPA to the corresponding letter grade for each student. */

UPDATE StudentTable SET LetterGrade = 'F';

SET SERVEROUTPUT ON

DECLARE
    CURSOR C IS SELECT * FROM StudentTable FOR UPDATE;
    G StudentTable.GPA%TYPE;
BEGIN
    FOR I IN C
    LOOP
        G := I.GPA;
        IF G > 0 AND G <= 4 THEN
            UPDATE StudentTable SET LetterGrade = 'F' WHERE CURRENT OF C;
        ELSIF G > 4 AND G <= 5 THEN
            UPDATE StudentTable SET LetterGrade = 'E' WHERE CURRENT OF C;
        ELSIF G > 5 AND G <= 6 THEN
            UPDATE StudentTable SET LetterGrade = 'D' WHERE CURRENT OF C;
        ELSIF G > 6 AND G <= 7 THEN
            UPDATE StudentTable SET LetterGrade = 'C' WHERE CURRENT OF C;
        ELSIF G > 7 AND G <= 8 THEN
            UPDATE StudentTable SET LetterGrade = 'B' WHERE CURRENT OF C;
        ELSIF G > 8 AND G <= 9 THEN
            UPDATE StudentTable SET LetterGrade = 'A' WHERE CURRENT OF C;
        ELSIF G > 9 AND G <= 10 THEN
            UPDATE StudentTable SET LetterGrade = 'A+' WHERE CURRENT OF C;
        END IF;
    END LOOP;
END;
/

-- 6. Write a PL/SQL block to print the list of Instructors teaching a specified course. --

SET SERVEROUTPUT ON

DECLARE
    CURSOR C(cid teaches.course_id%TYPE) IS SELECT DISTINCT ID FROM teaches WHERE course_id = cid;
    instrName instructor.name%TYPE;
    cid teaches.course_id%TYPE;
BEGIN
    cid := '&CourseID';
    FOR I IN C(cid)
    LOOP
        SELECT name INTO instrName FROM instructor WHERE ID = I.ID;
        DBMS_OUTPUT.PUT_LINE('ID: ' || I.ID || ' Name: ' || instrName);
    END LOOP;
END;
/

-- 7. Write a PL/SQL block to list the students who have registered for a course taught by his/her advisor. --

SET SERVEROUTPUT ON

DECLARE
    CURSOR C1 IS SELECT * FROM advisor;
    CURSOR C2(i takes.ID%TYPE) IS SELECT * FROM takes WHERE ID = i;
    CURSOR C3(i teaches.ID%TYPE) IS SELECT * FROM teaches WHERE ID = i;
    stdName student.name%TYPE;
    flag NUMERIC(1);
BEGIN
    FOR I IN C1
    LOOP
        flag := 0;
        FOR J IN C2(I.s_ID)
        LOOP
            FOR Z IN C3(I.i_ID)
            LOOP
                IF J.course_id = Z.course_id AND J.sec_id = Z.sec_id AND J.semester = Z.semester AND J.year = Z.year THEN
                SELECT name INTO stdName FROM student WHERE ID = J.ID;
                DBMS_OUTPUT.PUT_LINE('ID: ' || J.ID || 'Name: ' || stdName);
                flag := 1;
                END IF;
            END LOOP;
            IF flag = 1 THEN EXIT; END IF;
        END LOOP;
    END LOOP;
END;
/

/* 8. Write a PL/SQL block that updates the salary of ‘Biology’ department instructors by 20%. 
Subsequently, check the whether the department budget can support the raise. If not, undo the raise given to the instructors. */

SET SERVEROUTPUT ON

DECLARE
    CURSOR C IS SELECT * FROM instructor WHERE dept_name = 'Biology' FOR UPDATE;
    reqBudget NUMBER;
    maxBudget NUMBER;
BEGIN
    SELECT budget INTO maxBudget FROM Department WHERE dept_name = 'Biology';
    COMMIT;
    reqBudget := 0;
    FOR I IN C
    LOOP
        reqBudget := reqBudget + I.salary * 1.2;
        UPDATE instructor SET salary = salary * 1.2 WHERE CURRENT OF C;
    END LOOP;
    IF reqBudget > maxBudget THEN
    DBMS_OUTPUT.PUT_LINE('Budget exceeded. Rolling back.');
    ROLLBACK;
    ELSE
    DBMS_OUTPUT.PUT_LINE('Salaries successfully increased');
    END IF;
END;
/