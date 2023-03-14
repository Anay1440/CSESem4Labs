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