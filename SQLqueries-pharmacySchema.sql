INSERT INTO products (product_id,product_name,unit,taxing,batch_num,manufactured_date,import_date,expire_date,manufacturer,comment,id) VALUES (606,'Aldosterone',4,0.25,51617,2020/06/09,2020/07/10,2024/05/03,21,NIL,0);

INSERT INTO manufacturers
(manufacture_id,manufacture_name,manufacture_license,address) VALUES (21,'Biotech Manufacturing','AX2221334','234 Baylane chicago');

INSERT INTO inventory(inventory_id,product_id,bbunit,stripunit,tcvunit,bbcost,stripcost,tcvcost,bbprice,stripprice,tcvprice,id) VALUES (111,606,4,05,21,12.43,11.56,13.45,12.22,11.45,13.50,0);

INSERT INTO products (product_id,product_name,unit,taxing,batch_num,manufactured_date,import_date,expire_date,manufacturer,comment,id) VALUES (501,'Antacids',3,0.5,22112,2019/05/09,2019/06/10,2023/05/04,24,NIL,0);

INSERT INTO manufacturers
(manufacture_id,manufacture_name,manufacture_license,address) VALUES (24,'Biopharm Manufacturing','CZ2221334','122 Trampoline pkway Illinois');

INSERT INTO inventory(inventory_id,product_id,bbunit,stripunit,tcvunit,bbcost,stripcost,tcvcost,bbprice,stripprice,tcvprice,id) VALUES (333,501,3,03,24,11.43,12.56,11.45,13.22,12.45,14.50,0);

INSERT INTO products (product_id,product_name,unit,taxing,batch_num,manufactured_date,import_date,expire_date,manufacturer,comment,id) VALUES (231,'Echinocandins',10,0.75,62728,2021/02/07,2021/03/04,2024/02/03,43,NIL,0);

INSERT INTO manufacturers
(manufacture_id,manufacture_name,manufacture_license,address) VALUES (43,'AbbVie Manufacturing','BM2421334','111 Bridgeview Texas');

INSERT INTO inventory(inventory_id,product_id,bbunit,stripunit,tcvunit,bbcost,stripcost,tcvcost,bbprice,stripprice,tcvprice,id) VALUES (156,231,8,09,33,15.43,16.56,16.45,15.60,14.22,14.43,0);

INSERT INTO customers(customer_id,address_id,first_name,last_name,phone) VALUES (712,06,'Rahul','Chowdary','5267275411');

INSERT INTO addresses(address_id,city,state,country) VALUES (06,'Chesapeake','Illinois','United States');


UPDATE doctors SET phone='9628633728' WHERE doctor_id=2341;

UPDATE customers SET last_name='Himanshu' WHERE customer_id=1246;

UPDATE addresses SET country='India' WHERE address_id=41460;

UPDATE medicine_orders SET med_id=2222256 WHERE order_id=12 AND customers_id=1245;

UPDATE payment_detail SET quantity_ordered=10,price_each=20.55 WHERE payment_id=32134556;

UPDATE products SET comment='Not available';

UPDATE prescription_items SET quantity=30 WHERE prescription_id=231765231 AND medicine_id=2123;

UPDATE prescription SET doctor_id=3215 WHERE prescription_id=231765231 AND customer_id=1246;

UPDATE inventory SET bbunit=22,bbcost=8.55,bbprice=9.10 WHERE inventory_id=111 AND product_id=606;

UPDATE manufacturers SET manufacture_name='AbbVie and Biogen' WHERE manufacture_name='AbbVie Manufacturing';


DELETE FROM prescription_items WHERE prescription_id=231765231 AND medicine_id=3521;

DELETE FROM products WHERE product_id=231;


ALTER TABLE prescription_items ADD COLUMN comments varchar(100) NULL;

ALTER TABLE products ADD COLUMN InStock INT NOT NULL AFTER manufacturer;

ALTER TABLE products DELETE COLUMN id;

ALTER TABLE prescription ADD COLUMN Patient_Name varchar(50) NOT NULL AFTER customer_id;

ALTER TABLE payment_detail ADD COLUMN amount_to_be_paid double NOT NULL AFTER price_each;


SELECT c1.customer_id,c1.address_id,c1.first_name,c1.last_name,c1.phone,a1.address_id,a1.city,a1.state,a1.country
FROM customers AS c1
INNER JOIN addresses AS a1
ON c1.address_id=a1.address_id;

SELECT p1.payment_id,p1.order_id,p1.quantity_ordered,p1.price_each,p1.amount_to_be_paid,p1.pay_mode_id,p2.payment_mode_id
,p2.payment_name,
p2.cheque_num,p2.cheque_date,
p2.bank,p2.payment_mode FROM payment_detail AS p1
LEFT JOIN payment AS p2
ON p1.pay_mode_id=p2.payment_mode_id;

SELECT m1.manufacture_id,m1.manufacture_name,m1.manufacture_license,m1.address,m2.product_id,m2.product_name,m2.unit,
m2.taxing,m2.batch_num,m2.manufactured_date,m2.import_date,m2.expire_date,m2.manufacturer,m2.comment
FROM manufacturers AS m1
RIGHT JOIN products AS m2 ON
m1.manufacture_id=m2.manufacturer;

SELECT * FROM products LEFT JOIN inventory ON products.product_id=inventory.product_id
UNION
SELECT * FROM products RIGHT JOIN inventory ON products.product_id=inventory.product_id;

SELECT * FROM customers LEFT JOIN medicine_orders ON customers.customer_id=medicine_orders.customers_id
LEFT JOIN prescription ON customers.customer_id=prescription.customer_id;

SELECT COUNT(product_id)
FROM products GROUP BY(manufacturer);

SELECT COUNT(product_name)
FROM products WHERE unit>5 GROUP BY(product_id);

SELECT SUM(unit) FROM products GROUP BY(product_id);

SELECT AVG(amt_paid) FROM medicine_orders GROUP BY(customers_id);

SELECT MIN(price_each) FROM payment_detail GROUP BY(prod_id);

SELECT MAX(quantity_ordered) FROM payment_detail GROUP BY(order_id);

SELECT COUNT(manufacture_id),manufacture_name FROM manufacturers GROUP BY manufacture_name HAVING COUNT(manufacture_id)>0;

SELECT SUM(bbprice),product_id FROM inventory GROUP BY product_id HAVING bbcost>12;

SELECT AVG(BBUNIT),stripunit,tcvunit FROM inventory GROUP BY inventory_id HAVING stripunit<06 AND tcvunit<30;

SELECT COUNT(customer_id),first_name,last_name,phone FROM customers GROUP BY customer_id HAVING phone= '7578307432' AND COUNT(customer_id)>0;

SELECT COUNT(medication_id), medication_name,medication_cost FROM medication GROUP BY medication_name HAVING medication_cost>25 OR COUNT(medication_id)>0;

SELECT AVG(discount),cutomers_id,amount_paid FROM medicine_orders GROUP BY customers_id HAVING payment_mode>0 AND AVG(discount)>2;

SELECT prescription_id,customer_id,doctor_id FROM prescription GROUP BY customer_id HAVING doctor_id=3215;

SELECT customer_id,first_name,last_name,addresses.address_id,doctor.doctor_id,prescription.prescription_id,prescription_items.medicine_id,prescription_items.quantity,medication.medication_name,medication.medication_cost,medicine_orders.order_id,medicine_orders.payment_mode,medicine_orders.amount_paid,medicine_orders.status,payment_detail.prod_id,payment_detail.quantity_ordered,payment_detail.price_each,payment_detail.pay_mode_id,payment.payment_name,payment.Cheque_num,payment.cheque_date,payment.bank,payment.payment_mode,products.product_name,products.import_date,products.expire_date,products.manufacturer,manufacturers.manufacture_name,manufacturers.manufacture_license,manufacturers.address,inventory.inventory_id,inventory.bbunit,inventory.stripunit,inventory.tcvunit,inventory.bbcost,inventory.stripcost,inventory.tcvcost,inventory.bbprice,inventory.stripprice,inventory.tcvprice FROM customers JOIN addresses ON customers.address_id=addresses.address_id JOIN doctors ON customers.doctor_id=doctors.doctor_id JOIN prescription ON doctors.doctor_id = prescription.doctor_id JOIN prescription_items ON prescription.prescription_id=prescription_items.prescription_id JOIN medication ON prescription_items.medicine_id=medication.medication_id JOIN medicine_orders ON medication.medication_id=medicine_orders.med_id JOIN payment_detail ON medicine_orders.order_id=payment_detail.order_id JOIN payment ON payment_detail.pay_mode_id=payment.payment_mode_id JOIN products ON payment_detail.prod_id=products.product_id 
JOIN manufacturers ON products.manufacturer=manufacturers.manufacture_id JOIN inventory ON products.product_id=inventory.product_id;
 
