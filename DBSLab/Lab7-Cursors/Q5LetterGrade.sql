UPDATE StudentTable SET LetterGrade = 'F';

SET SERVEROUTPUT ON

DECLARE
    CURSOR C IS SELECT * FROM StudentTable FOR UPDATE;
    G StudentTable.GPA%TYPE;
BEGIN
    FOR I IN C
    LOOP
        G := I.GPA;
        IF G > 0 AND G <= 4 THEN
            UPDATE StudentTable SET LetterGrade = 'F' WHERE CURRENT OF C;
        ELSIF G > 4 AND G <= 5 THEN
            UPDATE StudentTable SET LetterGrade = 'E' WHERE CURRENT OF C;
        ELSIF G > 5 AND G <= 6 THEN
            UPDATE StudentTable SET LetterGrade = 'D' WHERE CURRENT OF C;
        ELSIF G > 6 AND G <= 7 THEN
            UPDATE StudentTable SET LetterGrade = 'C' WHERE CURRENT OF C;
        ELSIF G > 7 AND G <= 8 THEN
            UPDATE StudentTable SET LetterGrade = 'B' WHERE CURRENT OF C;
        ELSIF G > 8 AND G <= 9 THEN
            UPDATE StudentTable SET LetterGrade = 'A' WHERE CURRENT OF C;
        ELSIF G > 9 AND G <= 10 THEN
            UPDATE StudentTable SET LetterGrade = 'A+' WHERE CURRENT OF C;
        END IF;
    END LOOP;
END;
/