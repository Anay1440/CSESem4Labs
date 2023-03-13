DROP TABLE StudentTable;
CREATE TABLE StudentTable(
    RollNo NUMERIC(5),
    GPA NUMERIC(3,1));

INSERT INTO StudentTable VALUES (1,5.8);
INSERT INTO StudentTable VALUES (2,6.5);
INSERT INTO StudentTable VALUES (3,3.4);
INSERT INTO StudentTable VALUES (4,7.8);
INSERT INTO StudentTable VALUES (5,9.5);

-- 4. Write a PL/SQL block to print the letter grade of all the students(RollNo: 1 - 5). --

SET SERVEROUTPUT ON

DECLARE
    I NUMERIC(1);
    G StudentTable.GPA%TYPE;
BEGIN
    I := 1;
    LOOP
        SELECT GPA
        INTO G
        FROM StudentTable
        WHERE RollNo = I;
        IF G > 0 AND G < 4 THEN
            DBMS_OUTPUT.PUT_LINE('Grade is F');
        ELSIF G > 4 AND G < 5 THEN
            DBMS_OUTPUT.PUT_LINE('Grade is E');
        ELSIF G > 5 AND G < 6 THEN
            DBMS_OUTPUT.PUT_LINE('Grade is D');
        ELSIF G > 6 AND G < 7 THEN
            DBMS_OUTPUT. PUT_LINE('Grade is C');
        ELSIF G > 7 AND G < 8 THEN
            DBMS_OUTPUT.PUT_LINE('Grade is B');
        ELSIF G > 8 AND G < 9 THEN
            DBMS_OUTPUT.PUT_LINE('Grade is A');
        ELSIF G > 9 AND G < 10 THEN
            DBMS_OUTPUT.PUT_LINE('Grade is A+');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No such grade');
        END IF;
        I := I + 1;
        IF I > 5 THEN EXIT;
        END IF;
    END LOOP;
END;
/