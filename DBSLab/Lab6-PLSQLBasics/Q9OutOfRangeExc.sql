SET SERVEROUTPUT ON

DECLARE 
    G StudentTable.GPA%TYPE;
    I NUMBER;
    N NUMBER;
BEGIN
    SELECT COUNT(*) INTO N FROM StudentTable;
    I := 1;
    WHILE I <= N
    LOOP
        SELECT GPA
        INTO G
        FROM StudentTable
        WHERE RollNo = I;
        IF G < 0 AND G > 10 THEN
            RAISE OutOfRange;
        END IF;
        EXCEPTION 
            WHEN OutOfRange THEN
                DBMS_OUTPUT.PUT_LINE('GPA is Out of Range');
        I := I + 1;
    END LOOP;
END;
/