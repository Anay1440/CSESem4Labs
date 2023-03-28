-- 1. Write a procedure to display a message “Good Day to You”. --

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE disp IS
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Good day to you.');
END;
/

BEGIN
    disp;
END;
/

/* 2. Write a procedure which takes the dept_name as input parameter and lists all the instructors 
associated with the department as well as list all the courses offered by the department. */

CREATE OR REPLACE PROCEDURE disp(d_name VARCHAR) IS
    CURSOR C1(d instructor.dept_name%TYPE) IS SELECT ID,name FROM instructor WHERE dept_name = d;
    CURSOR C2(d course.dept_name%TYPE) IS SELECT course_id, title FROM course WHERE dept_name = d;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Instructor ID    Instructor Name');
    FOR I IN C1(d_name)
    LOOP
        DBMS_OUTPUT.PUT_LINE(I.ID || ' ' || I.name);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Course ID    Course Title');
    FOR I IN C2(d_name)
    LOOP
        DBMS_OUTPUT.PUT_LINE(I.course_id || ' ' || I.title);
    END LOOP;
END;
/

BEGIN
    disp('&deptName');
END;
/

/* 3. Write a Pl/Sql block of code that lists the most popular course for each of the departments. 
It should make use of a procedure course_popular which finds the most popular course in the given department. */

CREATE OR REPLACE PROCEDURE course_popular(d_name VARCHAR) IS
    CURSOR C(d course.dept_name%TYPE) IS SELECT course_id FROM course WHERE dept_name = d;
    courseID course.course_id%TYPE;
    m INTEGER;
    counter INTEGER;
BEGIN
    m:= -1;
    FOR I IN C(d_name)
    LOOP
        BEGIN
            SELECT COUNT(*) INTO counter FROM takes GROUP BY course_id HAVING course_id = I.course_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN counter := 0;
        END;
        IF counter > m THEN
            m := counter;
            courseID := I.course_id;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Most popular course of ' || d_name || ' is ' || courseID);
END;
/

DECLARE
    CURSOR C IS SELECT DISTINCT dept_name FROM course;
BEGIN
    FOR I IN C
    LOOP
        course_popular(I.dept_name);
    END LOOP;
END;
/

/* 4. Write a procedure which takes the dept-name as input parameter and lists all the 
students associated with the department as well as list all the courses offered by the department */

CREATE OR REPLACE PROCEDURE disp(d_name VARCHAR) IS
    CURSOR C1(d student.dept_name%TYPE) IS SELECT ID,name FROM student WHERE dept_name = d;
    CURSOR C2(d course.dept_name%TYPE) IS SELECT course_id, title FROM course WHERE dept_name = d;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Student ID    Student Name');
    FOR I IN C1(d_name)
    LOOP
        DBMS_OUTPUT.PUT_LINE(I.ID || ' ' || I.name);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Course ID    Course Title');
    FOR I IN C2(d_name)
    LOOP
        DBMS_OUTPUT.PUT_LINE(I.course_id || ' ' || I.title);
    END LOOP;
END;
/

BEGIN
    disp('&deptName');
END;
/

-- 5. Write a function to return the Square of a given number and call it from an anonymous block. --

CREATE OR REPLACE FUNCTION square(n INTEGER)
RETURN INTEGER AS
BEGIN
    RETURN n * n;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(square('&number'));
END;
/

-- 6. Write a Pl/Sql block of code that lists the highest paid Instructor in each of the Department --

CREATE OR REPLACE PROCEDURE disp(d_name VARCHAR) IS
    CURSOR C(d instructor.dept_name%TYPE) IS SELECT salary,name FROM instructor WHERE dept_name = d;
    instrName instructor.name%TYPE;
    m INTEGER;
BEGIN
    m:= -1;
    FOR I IN C(d_name)
    LOOP
        IF I.salary > m THEN
            instrName := I.name;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Highest paid instructor of ' || d_name || ' is ' || instrName);
END;
/

DECLARE
    CURSOR C IS SELECT DISTINCT dept_name FROM instructor;
BEGIN
    FOR I IN C
    LOOP
        disp(I.dept_name);
    END LOOP;
END;
/