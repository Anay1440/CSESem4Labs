SET SERVEROUTPUT ON

DECLARE
    I NUMERIC(1);
    G StudentTable.GPA%TYPE;
    LetterGrade VARCHAR2(2);
BEGIN
    I := 1;
    LOOP
        SELECT GPA
        INTO G
        FROM StudentTable
        WHERE RollNo = I;
        IF G > 0 AND G < 4 THEN
            LetterGrade := 'F';
            GOTO OUTP;
        ELSIF G > 4 AND G < 5 THEN
            LetterGrade := 'E';
            GOTO OUTP;
        ELSIF G > 5 AND G < 6 THEN
            LetterGrade := 'D';
            GOTO OUTP;
        ELSIF G > 6 AND G < 7 THEN
            LetterGrade := 'C';
            GOTO OUTP;
        ELSIF G > 7 AND G < 8 THEN
            LetterGrade := 'B';
            GOTO OUTP;
        ELSIF G > 8 AND G < 9 THEN
            LetterGrade := 'A';
            GOTO OUTP;
        ELSIF G > 9 AND G < 10 THEN
            LetterGrade := 'A+';
            GOTO OUTP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('No such grade');
        END IF;
        <<OUTP>>
            DBMS_OUTPUT.PUT_LINE('Grade is ' || LetterGrade);
        I := I + 1;
        IF I > 5 THEN EXIT;
        END IF;
    END LOOP;
END;
/