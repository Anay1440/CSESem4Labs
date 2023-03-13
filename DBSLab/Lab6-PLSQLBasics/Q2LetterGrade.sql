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
    IF G > 0 AND G <= 4 THEN
        DBMS_OUTPUT.PUT_LINE('Grade is F');
    ELSIF G > 4 AND G <= 5 THEN
        DBMS_OUTPUT.PUT_LINE('Grade is E');
    ELSIF G > 5 AND G <= 6 THEN
        DBMS_OUTPUT.PUT_LINE('Grade is D');
    ELSIF G > 6 AND G <= 7 THEN
        DBMS_OUTPUT. PUT_LINE('Grade is C');
    ELSIF G > 7 AND G <= 8 THEN
        DBMS_OUTPUT.PUT_LINE('Grade is B');
    ELSIF G > 8 AND G <= 9 THEN
        DBMS_OUTPUT.PUT_LINE('Grade is A');
    ELSIF G > 9 AND G <= 10 THEN
        DBMS_OUTPUT.PUT_LINE('Grade is A+');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No such grade');
    END IF;
END;
/