SET SERVEROUTPUT ON

DECLARE
    DOI DATE;
    DOR DATE;
    Days NUMERIC(3);
    Fine NUMERIC(6);
BEGIN
    DOI := TO_DATE('&DateOfIssue','DD-MM-YY');
    DOR := TO_DATE('&DateOfReturn','DD-MM-YY');
    Days := (DOR - DOI);
    IF Days >= 0 AND Days <= 7 THEN
        DBMS_OUTPUT.PUT_LINE('Fine is NIL');
    ELSIF Days >= 8 AND Days <= 15 THEN
        Fine := Days * 1;
        DBMS_OUTPUT.PUT_LINE('Fine is ' || Fine);
    ELSIF Days >= 16 AND Days <= 30 THEN
        Fine := Days * 2;
        DBMS_OUTPUT.PUT_LINE('Fine is ' || Fine);
    ELSIF Days > 30 THEN
        Fine := Days * 5;
        DBMS_OUTPUT.PUT_LINE('Fine is ' || Fine);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error');
    END IF;
END;
/