--PARTE 1
--Creando base de datos
CREATE DATABASE prueba;
--Entrando a la base de datos
\c prueba;
--Creando tabla categoria
CREATE TABLE category(id SERIAL, name VARCHAR(50), description VARCHAR(100), PRIMARY KEY(id));
--Creando tabla clientes
-CREATE TABLE clients(id SERIAL, name VARCHAR(40),rut VARCHAR(10), adress VARCHAR(100), PRIMARY KEY(id));
--Creando tabla factura
CREATE TABLE invoice(n_invoice SERIAL, date DATE, subtotal INT, iva INT, total INT, id_clients INT, PRIMARY KEY(n_invoice), FOREIGN KEY(id_clients) REFERENCES clients(id));
--Creando tabla productos
CREATE TABLE products(id SERIAL, name VARCHAR(40), description VARCHAR(100), id_category INT, unit_price INT, PRIMARY KEY(id), FOREIGN KEY(id_category) REFERENCES category(id));
--Creando tabla intermedia para relacionar factura y productos
CREATE TABLE invoice_products( id SERIAL, id_invoice INT, id_products INT, quantity INT, amount INT, FOREIGN KEY(id_invoice) REFERENCES invoice(n_invoice), FOREIGN KEY (id_products) REFERENCES products(id));

--PARTE 2
--Poblando datos en las tablas, primero clientes
INSERT INTO clients (name, rut, adress) VALUES ('Elvis Teck', '12321421-2', 'Av los Dominicos'), ('Jessica Alba', '26215251-0', 'Calle Santa lucia'), ('George Harris', '10325440-8', 'Av Los Caobos'), ('Andres Villanueva', '14858901-2', 'Av Los Cedros'), ('Armando Mesa', '20123456-7', 'Pasaje Huechuraba');
--Consultando tabla creada
SELECT * FROM clients;
--Poblando tabla de productos
INSERT INTO category(name, description) VALUES ('Calzado', 'Calzado deportivo para caballeros'), ('Mochilas', 'Mochilas para deportes y gym'), ('Ropa', 'Rospa deportiva para caballeros');
--Corrigiendo error de typeo en descripcion
UPDATE category SET description = 'Ropa deportiva para caballeros' WHERE id=3;
--Agregando productos
INSERT INTO products(name, description, id_category, unit_price) VALUES ('Shoes Nike AirMax', 'Calzado del año 2019 por linea AirMax', 1, 10), ('Adidas Retro', 'Calzado clasico de los años 90', 1, 25), ('Adidas Fullstack', 'Modelo original de Desafio Latam', 1, 20), ('Mochila Gym', 'Mochila 36L para ropa y calzado', 2, 60), ('Bolso de mano', 'Bolso para celular y cosas pequeñas', 2, 18), ('Polera Nike', 'Talla M tela impermeable', 3, 10), ('Polera manga larga', 'Talla L tela Algondon', 3, 12), ('Sudadera Adidas', 'Talla M tela polar con capucha', 3, 20);
--Agregando facturas
INSERT INTO invoice(date, id_clients) VALUES ('2020-11-18', 1), ('2020-12-01', 1), ('2020-12-28', 2), ('2021-01-03', 2), ('2021-01-07', 2), ('2021-01-14', 3), ('2021-01-22', 4), ('2021-02-04', 4), ('2021-02-14', 4), ('2021-02-21', 4);
--Agregando datos de productos vendidos, en tabla intermedia
INSERT INTO invoice_products(id_invoice, id_products, quantity, amount) VALUES (1,3,1,20),(1,6,2,20), (2,1,1,10),(2,7,2,24),(2,2,1,25), (3,8,1,20),(3,3,2,40),(3,6,1,10), (4,3,1,20),(4,6,2,20), (5,3,1,20),(5,8,2,40),(5,1,1,10), (6,4,4,240), (7,8,1,20),(7,4,1,60), (8,1,1,10),(8,8,2,40),(8,6,1,10), (9,3,1,20),(9,2,1,25),(9,5,1,18),(9,6,2,20), (10,5,6,108);
--Agregando datos a las facturas
UPDATE invoice SET subtotal = 40, iva = 8, total = 48 WHERE n_invoice=1;
UPDATE invoice SET subtotal = 59, iva = 11, total = 70 WHERE n_invoice=2;
UPDATE invoice SET subtotal = 70, iva = 13, total = 83 WHERE n_invoice=3;
UPDATE invoice SET subtotal = 40,iva = 8, total = 48 WHERE n_invoice=4;
UPDATE invoice SET subtotal = 70, iva = 13, total = 83 WHERE n_invoice=5;
UPDATE invoice SET subtotal = 240, iva = 46, total = 286 WHERE n_invoice=6;
UPDATE invoice SET subtotal = 80, iva = 15, total = 95 WHERE n_invoice=7;
UPDATE invoice SET subtotal = 60, iva = 11, total = 71 WHERE n_invoice=8;
UPDATE invoice SET subtotal = 83, iva = 16, total = 99 WHERE n_invoice=9;
UPDATE invoice SET subtotal = 108, iva = 21, total = 129 WHERE n_invoice=10;

--PARTE 3
--¿Que cliente realizó la compra más cara?
SELECT clients.name AS compra_mas_cara, invoice.total FROM clients INNER JOIN invoice ON clients.id = invoice.id_clients ORDER BY invoice.total DESC LIMIT 1;
--¿Que cliente pagó sobre 100 de monto?
SELECT clients.name AS compras_sobre_100 FROM clients INNER JOIN invoice ON clients.id = invoice.id_clients WHERE invoice.total > 100;
--¿Cuantos clientes han comprado el producto 6.
SELECT COUNT(invoice.id_clients) AS Compras_producto_6 FROM invoice INNER JOIN invoice_products ON invoice.n_invoice = invoice_products.id_invoice WHERE invoice_products.id_products = 6;

