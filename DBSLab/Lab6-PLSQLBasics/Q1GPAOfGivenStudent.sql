DROP TABLE StudentTable;
CREATE TABLE StudentTable(
    RollNo NUMERIC(5),
    GPA NUMERIC(3,1));

INSERT INTO StudentTable VALUES (1,5.8);
INSERT INTO StudentTable VALUES (2,6.5);
INSERT INTO StudentTable VALUES (3,3.4);
INSERT INTO StudentTable VALUES (4,7.8);
INSERT INTO StudentTable VALUES (5,9.5);

-- 1. Write a PL/SQL block to display the GPA of given student. --

SET SERVEROUTPUT ON

DECLARE
    RNO StudentTable.RollNo%TYPE;
    G StudentTable.GPA%TYPE;
BEGIN
    RNO := '&rno';
    SELECT GPA
    INTO G
    FROM StudentTable
    WHERE RollNo = RNO;
    DBMS_OUTPUT.PUT_LINE('The GPA is: ' || G);
END;
/