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