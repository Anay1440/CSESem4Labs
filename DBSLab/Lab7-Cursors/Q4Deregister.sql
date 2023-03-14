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