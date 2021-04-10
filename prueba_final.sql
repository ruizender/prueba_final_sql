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
CREATE TABLE products(id SERIAL, NAME varchar(40), description VARCHAR(100), id_category INT, unit_price INT, PRIMARY KEY(id), FOREIGN KEY(id_category) REFERENCES category(id));
--Creando tabla intermedia para relacionar factura y productos
CREATE TABLE invoice_products( id SERIAL, id_invoice INT, id_products INT, quantity INT, amount INT, FOREIGN KEY(id_invoice) REFERENCES invoice(n_invoice), FOREIGN KEY (id_products) REFERENCES products(id));
--