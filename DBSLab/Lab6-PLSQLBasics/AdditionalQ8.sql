SET SERVEROUTPUT ON

DECLARE
    IncorrectOperator EXCEPTION;
    N1 NUMBER;
    N2 NUMBER;
    OP CHAR(1);
BEGIN
    N1 := '&FirstNumber';
    N2 := '&SecondNumber';
    OP := '&Operator';
    IF OP = '+' THEN
        DBMS_OUTPUT.PUT_LINE('Result: ' || (N1 + N2));
    ELSIF OP = '-' THEN
        DBMS_OUTPUT.PUT_LINE('Result: ' || (N1 - N2));
    ELSIF OP = '*' THEN
        DBMS_OUTPUT.PUT_LINE('Result: ' || (N1 * N2));
    ELSIF OP = '/' THEN
        DBMS_OUTPUT.PUT_LINE('Result: ' || (N1 / N2));
    ELSE
        RAISE IncorrectOperator;
    END IF;
    EXCEPTION 
        WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('Cannot divide by 0');
        WHEN IncorrectOperator THEN DBMS_OUTPUT.PUT_LINE('Incorrect operator');
END;
/