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