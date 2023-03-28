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