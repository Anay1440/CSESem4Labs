SET SERVEROUTPUT ON 

DECLARE
    G StudentTable.GPA%TYPE;
    MAXG StudentTable.GPA%TYPE;
    N NUMBER;
    I NUMBER;
BEGIN
    SELECT COUNT(*) INTO N FROM StudentTable;
    I := 1;
    MAXG := 0;
    WHILE I <= N
    LOOP
        SELECT GPA
        INTO G
        FROM StudentTable
        WHERE RollNo = I;
        IF G > MAXG THEN
            MAXG := G;
        END IF;
        I := I + 1;
    END LOOP;
    SELECT RollNo INTO I FROM StudentTable WHERE GPA = MAXG;
    DBMS_OUTPUT.PUT_LINE('Student with max. GPA is: Roll Number ' || I);
END;
/