SET SERVEROUTPUT ON

DECLARE
    I NUMBER;
    NUM NUMBER;
    LEN NUMBER;
    NINP NUMBER;
    NREV NUMBER;
BEGIN
    NINP := '&Number';
    NREV := 0;
    LEN := (LENGTH(TO_CHAR(NINP)));
    FOR I IN 1..LEN LOOP
        NUM := MOD(NINP,10);
        NINP := TRUNC(NINP / 10);
        NREV := NREV * 10 + NUM;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Reverse of number is: ' || NREV);
END;
/