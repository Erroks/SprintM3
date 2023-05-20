-- Creación base de datos tienda telovendo para sprint n3.

CREATE DATABASE telovendo_sprint3;
use telovendo_sprint3

-- Creación de usuario admin.

CREATE USER 'telovendo_sprint3'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON * . * TO 'telovendo_sprint3'@'localhost';
FLUSH PRIVILEGES;

-- Creación tablas de información relaciona

CREATE TABLE `supplier` (
  `id_supplier` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_category` int(8) NOT NULL,
  `representante` varchar(40) NOT NULL,
  `corporacion` varchar(40) NOT NULL,
  `correo` varchar(40) NOT NULL,
  FOREIGN KEY (`id_category`) REFERENCES `category`(`id_category`)
);

CREATE TABLE `category` (
  `id_category` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name_category` varchar(40) NOT NULL
);


CREATE TABLE `product` (
  `id_product` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_category` int(8) NOT NULL,
  `name` varchar(40) NOT NULL,
  `color` varchar(12) NOT NULL,
  `price` int(10) NOT NULL,
  `stockGlobal` int(3) NOT NULL,
  FOREIGN KEY (`id_category`) REFERENCES `category`(`id_category`)
);

CREATE TABLE `Contact` (
  `id_number` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_supplier` int(8) NOT NULL,
  `nombre_recibe` varchar(40) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  FOREIGN KEY (`id_supplier`) REFERENCES `supplier`(`id_supplier`)
);

CREATE TABLE `rompeProvProduct` (
  `id_rompePP` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_supplier` int(8) NOT NULL,
  `id_product` int(8) NOT NULL,
  `stocksupplier` int(3) NOT NULL,
  FOREIGN KEY (`id_product`) REFERENCES `product`(`id_product`),
  FOREIGN KEY (`id_supplier`) REFERENCES `supplier`(`id_supplier`)
);

CREATE TABLE `client` (
  `id_client` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `last_name` varchar(40) NOT NULL,
  `address` varchar(40) NOT NULL
);


CREATE TABLE `rompeClientProduct` (
  `id_rompeCP` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_product` int(8) NOT NULL,
  `id_client` int(8) NOT NULL,
  FOREIGN KEY (`id_product`) REFERENCES `product`(`id_product`),
  FOREIGN KEY (`id_client`) REFERENCES `client`(`id_client`)
);

-- Carga de registros a cada tabla

INSERT INTO category (name_category) VALUES
('laptop'),
('impresoras'),
('television'),
('smartphone'),
('Electrónica y Computación');

INSERT INTO supplier (id_category, representante, corporacion, correo) VALUES
(1, 'Luisa Vega', 'HP', 'luisa.vega@hp.com'),
(1, 'Alejandro Morales', 'Apple', 'alejandro.morales@apple.com'),
(1, 'Valentina Gómez', 'Lenovo', 'valentina.gomez@lenovo.com'),
(2, 'Gabriel Torres', 'Microsoft', 'gabriel.torres@microsoft.com'),
(2, 'Camila Ramírez', 'Sony', 'camila.ramirez@sony.com'),
(2, 'Sebastián Castro', 'LG', 'sebastian.castro@lg.com'),
(2, 'Carolina Paredes', 'Acer', 'carolina.paredes@acer.com'),
(4, 'Pablo Herrera', 'Toshiba', 'pablo.herrera@toshiba.com');

INSERT INTO client (name, last_name, address) VALUES
('Julian', 'Perez', 'Ohiggins 34'),
('Manuel', 'Cid', 'pasaje 4'),
('Felipe', 'Sanchez', 'San martin 88'),
('Raul', 'Bilbao', 'Carrera 12'),
('Maria', 'Flores', 'Pratt 93');

INSERT INTO product (id_category, name, color, price, stockGlobal) VALUES
(1, 'Notebook lenovo legion y520', 'negro', '700000',25),
(1, 'Notebook hp omen', 'Blanco', '650000',50),
(2, 'Impresora laser Kyocera', 'Negro', '120000',45),
(4, 'iPhone 14 ProMax', 'Negro', '1000000',33),
(2, 'Impresora cartucho Kyocera', 'Blanco', '100000',58),
(1, 'Notebook Dell Alien 5', 'Azul', '12000000',70),
(4, 'Galaxy S23', 'Azul', '1000000',100),
(4, 'Galaxy A23', 'Negro', '700000',65),
(2, 'Impresora laser Epson', 'Azul', '250000',50),
(2, 'Impresora cartucho Epson', 'Azul', '700000',80),
(1, 'Notebook Dell Alienware R15', 'Azul', '2000000',5);

INSERT INTO contact (id_supplier, nombre_recibe, phone_number) VALUES
(1,'Carlos','1234567890'),
(1,'Sofía', '9876543210'),
(2, 'Andrés', '4567890123'),
(2, 'María', '8901234567'),
(3, 'Alejandra', '2345678901'),
(3, 'Javier', '6789012345'),
(4, 'Laura', '0123456789'),
(4, 'Roberto', '5678901234'),
(5, 'Isabel', '9012345678'),
(5, 'Pedro', '3456789012'),
(6, 'Miguel', '56965545676'),
(6, 'Antonio', '3654646466'),
(6, 'Francisca R.', '456778745'),
(7, 'Jazmin', '225345663'),
(7, 'Elson', '85456373654'),
(8, 'Luis', '4566745647'),
(8, 'Claudio', '678474647');

INSERT INTO rompeProvProduct (id_supplier,id_product,stocksupplier) VALUES 
(1,1,10),
(1,2,30),
(1,6,50),
(2,1,15),
(2,2,20),
(2,6,20),
(3,4,33),
(4,3,45),
(4,5,58),
(5,9,30),
(5,10,60),
(6,9,15),
(6,10,5),
(7,9,5),
(7,10,15),
(8,6,100),
(8,7,65),
(1,11,5);

-- Cuál es la categoría de productos que más se repite.

SELECT cat.name_category, COUNT(prod.id_category) AS RepeticionCategoria, cat.id_category AS codigoCat
FROM product AS prod
INNER JOIN category AS cat ON prod.id_category = cat.id_category
GROUP BY cat.name_category, cat.id_category
ORDER BY RepeticionCategoria DESC;


-- Cuáles son los productos con mayor stock

SELECT prod.name, prod.stockGlobal
FROM product AS prod
GROUP BY prod.name, prod.stockGlobal
ORDER BY prod.stockGlobal DESC;

-- Qué color de producto es más común en nuestra tienda.

SELECT color, SUM(stockGlobal) AS stock_total
FROM product
GROUP BY color
ORDER BY stock_total DESC;

-- Cual o cuales son los proveedores con menor stock de productos.

SELECT prov.representante, SUM(rompepp.stocksupplier) AS totalStockProveedor
FROM rompeProvProduct rompepp
INNER JOIN supplier prov ON rompepp.id_supplier = prov.id_supplier
GROUP BY prov.representante
ORDER BY totalStockProveedor ASC;


-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.

SELECT id_category, SUM(stockGlobal) AS stock_total
FROM product
GROUP BY id_category
ORDER BY stock_total ASC;

