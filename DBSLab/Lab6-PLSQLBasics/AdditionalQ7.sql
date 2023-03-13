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