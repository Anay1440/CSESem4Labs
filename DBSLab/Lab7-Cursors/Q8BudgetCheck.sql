SET SERVEROUTPUT ON

DECLARE
    CURSOR C IS SELECT * FROM instructor WHERE dept_name = 'Biology' FOR UPDATE;
    reqBudget NUMBER;
    maxBudget NUMBER;
BEGIN
    SELECT budget INTO maxBudget FROM Department WHERE dept_name = 'Biology';
    COMMIT;
    reqBudget := 0;
    FOR I IN C
    LOOP
        reqBudget := reqBudget + I.salary * 1.2;
        UPDATE instructor SET salary = salary * 1.2 WHERE CURRENT OF C;
    END LOOP;
    IF reqBudget > maxBudget THEN
    DBMS_OUTPUT.PUT_LINE('Budget exceeded. Rolling back.');
    ROLLBACK;
    ELSE
    DBMS_OUTPUT.PUT_LINE('Salaries successfully increased');
    END IF;
END;
/