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