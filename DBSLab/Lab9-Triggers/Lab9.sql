/* 1. Based on the University database Schema in Lab 2, write a row trigger that records along with the time any 
change made in the Takes (ID, course-id, sec-id, semester, year, grade) table 
in log_change_Takes (Time_Of_Change, ID, courseid,sec-id, semester, year, grade). */

CREATE TABLE log_change_Takes(
    Time_Of_Change DATE,
    ID VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4,0),
    grade VARCHAR(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year));

SET SERVEROUTPUT ON

CREATE OR REPLACE TRIGGER logTakes
BEFORE INSERT OR UPDATE OF ID, course_id, sec_id, semester, year, grade OR DELETE ON takes
BEGIN
CASE
WHEN INSERTING THEN
    INSERT INTO log_change_Takes 
    VALUES(SYSDATE,:NEW.ID, :NEW.course_id, :NEW.sec_id, :NEW.semester, :NEW.year, :NEW.grade);
WHEN UPDATING OR DELETING THEN
    INSERT INTO log_change_Takes 
    VALUES(SYSDATE,:OLD.ID, :OLD.course_id, :OLD.sec_id, :OLD.semester, :OLD.year, :OLD.grade);
END CASE;
END;
/

-- To test --

COMMIT; 
--To have a save to rollback to
SELECT * FROM takes WHERE ID = 12345 AND sec_id = 2; 
--View old
UPDATE takes SET sec_id = 1 WHERE ID = 12345 AND sec_id = 2; 
--Update
DELETE FROM takes WHERE ID = 12345 AND course_id = 'CS-190' 
--Delete
SELECT * FROM takes WHERE ID = 12345 AND sec_id = 2; 
--View after updating
SELECT * FROM log_change_Takes; 
--See output from trigger
ROLLBACK; 
--Rollback to original data

/* 2. Based on the University database schema in Lab: 2, write a row trigger to insert the existing values of the Instructor 
(ID, name, dept-name, salary) table into a new table Old_ Data_Instructor (ID, name, dept-name, salary) when the salary table is updated. */

CREATE TABLE Old_Data_Instructor (
    ID VARCHAR(5),
    name VARCHAR(20),
    dept_name VARCHAR(20),
    salary NUMERIC(8,2),
    PRIMARY KEY (ID));

CREATE OR REPLACE TRIGGER logSalary
BEFORE UPDATE OF salary ON instructor
BEGIN
INSERT INTO Old_Data_Instructor VALUES (:OLD.ID, :OLD.name, :OLD.dept_name, :OLD.salary);
END;
/

-- To test --

COMMIT; 
--To have a save to rollback to
SELECT * FROM instructor WHERE ID = 12121; 
--View old
UPDATE instructor SET salary = salary * 1.5 WHERE ID = 12121; 
--Update
SELECT * FROM instructor WHERE ID = 12121; 
--View after updating
SELECT * FROM Old_Data_Instructor; 
--See output from trigger
ROLLBACK; 
--Rollback to original data

/* 3. Based on the University Schema, write a database trigger on Instructor that checks the following:
i. The name of the instructor is a valid name containing only alphabets.
ii. The salary of an instructor is not zero and is positive
iii. The salary does not exceed the budget of the department to which the instructor belongs. */

CREATE OR REPLACE TRIGGER instrInsert
BEFORE INSERT ON instructor
DECLARE
sal NUMBER;
budg NUMBER;
BEGIN
IF LENGTH(TRIM(TRANSLATE(:NEW.name, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0 THEN
    RAISE_APPLICATION_ERROR(-20100,'Name must contain only alphabets');
ELSE
    IF :NEW.salary < 1 THEN
        RAISE_APPLICATION_ERROR(-20100,'Salary must be greater than 0');
    ELSE
        SELECT SUM(salary) INTO sal FROM instructor WHERE dept_name = :NEW.dept_name;
        SELECT budget INTO budg FROM department WHERE dept_name = :NEW.dept_name;
        IF sal + :NEW.salary > budg THEN
            RAISE_APPLICATION_ERROR(-20100,'Not enough department budget');  
        END IF;
    END IF;
END IF;
END;
/

-- To test --

COMMIT; 
--To have a save to rollback to
SELECT * FROM instructor; 
--View old
INSERT INTO instructor VALUES('12345','NewInstructor','Comp. Sci.',50000);
--Error: Not enough department budget
INSERT INTO instructor VALUES('12345','NewInstructor12','Music',20000);
--Error: Name must contain only alphabets
INSERT INTO instructor VALUES('12345','NewInstructor','Music',30000);
--Insert
SELECT * FROM instructor; 
--View after inserting
ROLLBACK; 
--Rollback to original data

/* 4. Create a transparent audit system for a table Client_master (client_no, name, address, Bal_due). 
The system must keep track of the records that are being deleted or updated. 
The functionality being when a record is deleted or modified the original record details and the date 
of operation are stored in the auditclient (client_no, name, bal_due, operation, userid, opdate) table, 
then the delete or update is allowed to go through. */

CREATE TABLE Client_master (
    client_no NUMBER,
    name VARCHAR(20),
    address VARCHAR(50),
    bal_due NUMBER,
    PRIMARY KEY (client_no));

INSERT INTO Client_master VALUES (1,'Client1','Addr1',20000);
INSERT INTO Client_master VALUES (2,'Client2','Addr2',10000);
INSERT INTO Client_master VALUES (3,'Client3','Addr3',50000);
INSERT INTO Client_master VALUES (4,'Client4','Addr4',80000);

CREATE TABLE auditclient (
    client_no NUMBER,
    name VARCHAR(20),
    bal_due NUMBER,
    operation VARCHAR(20),
    userid NUMBER,
    opdate DATE);

CREATE OR REPLACE TRIGGER auditLog
BEFORE UPDATE OF bal_due OR DELETE ON Client_master
BEGIN
CASE
WHEN UPDATING THEN
    INSERT INTO auditClient VALUES (:OLD.client_no, :OLD.name, :OLD.bal_due, 'Update', 1440, SYSDATE);
WHEN DELETING THEN 
    INSERT INTO auditClient VALUES (:OLD.client_no, :OLD.name, :OLD.bal_due, 'Delete', 1440, SYSDATE);
END CASE;
END;
/

-- To test --

COMMIT; 
--To have a save to rollback to
SELECT * FROM Client_master; 
--View old
UPDATE Client_master SET bal_due = 10000 WHERE client_no = 1;
--Update
DELETE FROM Client_master WHERE client_no = 2;
--Delete
SELECT * FROM auditClient; 
--View output of trigger
ROLLBACK; 
--Rollback to original data

/* 5. Based on the University database Schema in Lab 2, create a view Advisor_Student which is a natural join on Advisor, Student and Instructor tables. 
Create an INSTEAD OF trigger on Advisor_Student to enable the user to delete the corresponding entries in Advisor table. */

DROP VIEW Advisor_Student;

CREATE VIEW Advisor_Student AS 
SELECT Advisor.S_ID, Advisor.I_ID, Student.name S_NAME, Instructor.name I_NAME
FROM Advisor, Student, Instructor WHERE Advisor.S_ID = Student.ID AND Advisor.I_ID = Instructor.ID;

CREATE OR REPLACE TRIGGER delAdvisor
INSTEAD OF DELETE ON Advisor_Student
BEGIN 
    DELETE FROM Advisor WHERE S_ID = :OLD.S_ID AND I_ID = :OLD.I_ID;
END;
/

COMMIT; 
--To have a save to rollback to
SELECT * FROM Advisor; 
SELECT * FROM Advisor_Student; 
--View old
DELETE FROM Advisor_Student WHERE S_ID = 98765 AND I_ID = 98345;
--Delete
SELECT * FROM Advisor; 
--View new
ROLLBACK; 
--Rollback to original data
