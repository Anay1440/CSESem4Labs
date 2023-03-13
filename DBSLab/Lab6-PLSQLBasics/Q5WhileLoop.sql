ALTER TABLE StudentTable ADD LetterGrade VARCHAR2(2);

SET SERVEROUTPUT ON

DECLARE
    G StudentTable.GPA%TYPE;
    N NUMBER;
    I NUMBER;
BEGIN
    SELECT COUNT(*) INTO N FROM StudentTable;
    I := 1;
    WHILE I <= N
    LOOP
        SELECT GPA
        INTO G
        FROM StudentTable
        WHERE RollNo = I;
        IF G > 0 AND G <= 4 THEN
            UPDATE StudentTable SET LetterGrade = 'F' WHERE RollNo = I;
        ELSIF G > 4 AND G <= 5 THEN
            UPDATE StudentTable SET LetterGrade = 'E' WHERE RollNo = I;
        ELSIF G > 5 AND G <= 6 THEN
            UPDATE StudentTable SET LetterGrade = 'D' WHERE RollNo = I;
        ELSIF G > 6 AND G <= 7 THEN
            UPDATE StudentTable SET LetterGrade = 'C' WHERE RollNo = I;
        ELSIF G > 7 AND G <= 8 THEN
            UPDATE StudentTable SET LetterGrade = 'B' WHERE RollNo = I;
        ELSIF G > 8 AND G <= 9 THEN
            UPDATE StudentTable SET LetterGrade = 'A' WHERE RollNo = I;
        ELSIF G > 9 AND G <= 10 THEN
            UPDATE StudentTable SET LetterGrade = 'A+' WHERE RollNo = I;
        END IF;
        I := I + 1;
    END LOOP;
END;
/