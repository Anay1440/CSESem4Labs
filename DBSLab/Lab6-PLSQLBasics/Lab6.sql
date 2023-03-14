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

/* 2. Write a PL/SQL block to display the letter grade(0-4: F; 4-5: E;
 5-6: D; 6-7: C; 7-8: B; 8-9: A; 9-10: A+) of given student. */

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

/* 3. Input the date of issue and date of return for a book. 
Calculate and display the fine with the appropriate message using a PL/SQL block. 
The fine is charged as per the table 8.1 */

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

/* 5. Alter StudentTable by appending an additional column LetterGrade Varchar2(2). 
Then write a PL/SQL block to update the table with letter grade of each student. */

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

-- 6. Write a PL/SQL block to find the student with max. GPA without using aggregate function. --

SET SERVEROUTPUT ON 

DECLARE
    G StudentTable.GPA%TYPE;
    MAXG StudentTable.GPA%TYPE;
    N NUMBER;
    I NUMBER;
BEGIN
    SELECT COUNT(*) INTO N FROM StudentTable;
    I := 1;
    MAXG := 0;
    WHILE I <= N
    LOOP
        SELECT GPA
        INTO G
        FROM StudentTable
        WHERE RollNo = I;
        IF G > MAXG THEN
            MAXG := G;
        END IF;
        I := I + 1;
    END LOOP;
    SELECT RollNo INTO I FROM StudentTable WHERE GPA = MAXG;
    DBMS_OUTPUT.PUT_LINE('Student with max. GPA is: Roll Number ' || I);
END;
/

-- 7. Implement lab exercise 4 using GOTO. --

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

/* 9. Extend lab exercise 5 to validate the GPA value used to find letter grade. 
If it is outside the range, 0 – 10, display an error message, ‘Out of Range’ via an exception handler. */

SET SERVEROUTPUT ON

DECLARE 
    G StudentTable.GPA%TYPE;
    I NUMBER;
    N NUMBER;
BEGIN
    SELECT COUNT(*) INTO N FROM StudentTable;
    I := 1;
    WHILE I <= N
    LOOP
        SELECT GPA
        INTO G
        FROM StudentTable
        WHERE RollNo = I;
        IF G < 0 OR G > 10 THEN
            RAISE OutOfRange;
        END IF;
        EXCEPTION 
            WHEN OutOfRange THEN
                DBMS_OUTPUT.PUT_LINE('GPA is Out of Range');
        I := I + 1;
    END LOOP;
END;
/

-- ADDITIONAL --
-- 5. Write a PL/SQL block to reverse a given string --

SET SERVEROUTPUT ON

DECLARE 
    G StudentTable.GPA%TYPE;
    I NUMBER;
    N NUMBER;
BEGIN
    STRINP := '&String';
    I := (LENGTH(STRINP));
    WHILE I >= 1
    LOOP
        STRREV := CONCAT(STRREV , SUBSTR(STRINP,I,1));
    I := I - 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Reverse of string is: ' || STRREV);
END;
/

-- 6. Write a PL/SQL block of code for inverting a number 5639 or 9365. --

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

/* 7. Write a PL/SQL block of code to achieve the following: 
if the price of Product ‘p00001’ is less than 4000, then change the price to 4000. 
The Price change has to be recorded in the old_price_table along with Product_no and the date on which the price was last changed. */

DROP TABLE Product_master;
DROP TABLE Old_price_table;

CREATE TABLE Product_master(
    product_no NUMBER,
    sell_price NUMBER);
CREATE TABLE Old_price_table(
    product_no NUMBER,
    date_change DATE,
    Old_price NUMBER);
INSERT INTO Product_master VALUES (00001, 3000);

SET SERVEROUTPUT ON

DECLARE
    product Product_master%ROWTYPE;
BEGIN
    SELECT * INTO product FROM Product_master WHERE product_no = 00001;
    IF product.sell_price >= 4000 THEN
        GOTO sk;
    ELSE
        INSERT INTO Old_price_table VALUES (product.product_no, SYSDATE, product.sell_price);
        UPDATE Product_master SET sell_price = 4000 WHERE product_no = product.product_no;
    END IF;
<<sk>> 
    DBMS_OUTPUT.PUT_LINE('Done');
END;
/

/* 8. Write a PL/SQL block that asks the user to input first number, 
second number and an arithmetic operator (+, -, *, /). If the operator is invalid, throw and handle a user-defined exception. 
If the second number is zero and the operator is /, handle the ZERO_DIVIDE predefined server exception. */

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
