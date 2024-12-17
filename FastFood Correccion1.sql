create database FastFoodDB_Correccion
ON
(NAME = 'FastFoodDB_Data',
FILENAME = 'C:\SQL_DB\FastFoodDB_Correccion_Data.mdf',
SIZE=50MB,
MAXSIZE=1GB,
FILEGROWTH=5MB)
LOG ON
(NAME='Carrera_BD_Log',
FILENAME='C:\SQL_DB\FastFoodDB_Correccion_Log.ldf',
SIZE=25MB,
MAXSIZE=256MB,
FILEGROWTH=5MB);

--USAR LA BASE DE DATOS
use FastFoodDB_Correccion;

--tabla categorias
CREATE TABLE categorias (
	CategoriaID INT Primary key identity,
	Nombre VARCHAR (100) NOT NULL 
);

--tabla producto
CREATE TABLE productos (
	ProductoID INT PRIMARY KEY IDENTITY,
	Nombre Varchar (100) NOT NULL,
	CategoriaID INT,
	Precio DECIMAL (10,2) NOT NULL,
	FOREIGN KEY (CategoriaID) references Categorias(CategoriaID)
);

--tabla sucursales
CREATE TABLE sucursales (
	sucursalID INT PRIMARY KEY IDENTITY,
	Nombre Varchar (100) NOT NULL,
	Direccion VARCHAR (100)
);

--tabla empleados
CREATE TABLE Empleados (
	EmpleadoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR (100) NOT NULL,
	Posicion VARCHAR(100) NOT NULL,
	Departamento VARCHAR (100) NOT NULL,
	SucursalID INT,
	ROL VARCHAR (50) NOT NULL,
	FOREIGN KEY (SucursalID) references Sucursales(SucursalID)
);

--tabla clientes
CREATE TABLE Clientes (
	ClienteID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR (100) NOT NULL,
	Direccion VARCHAR (100) NOT NULL
);

--tabla Origen Orden
CREATE TABLE OrigenesOrden (
	OrigenID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR (100) NOT NULL,
);

--tabla tipos de pago
CREATE TABLE TiposPago (
	TipoPagoID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR (100) NOT NULL,
);

--tabla mensajeros
CREATE TABLE Mensajeros (
	MensajeroID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR (255) NOT NULL,
	EsExterno Bit NOT NULL
);

--Tabla Ordenes
CREATE TABLE Ordenes(
	OrdenID INT PRIMARY KEY IDENTITY,
	ClienteID INT,
	EmpleadoID INT,
	SucursalID INT,
	MensajeroID INT,
	TipoPagoID INT,
	OrigenID INT,
	HorarioVenta VARCHAR (50) NOT NULL,
	TotalCompra DECIMAL (10,2) NOT NULL,
	KilometrosRecorrer DECIMAL (10,2),
	FechaDespacho DATETIME,
	FechaEntrega DATETIME,
	FechaOrdenTomada DATETIME NOT NULL, 
	FechaOrdenLista DATETIME NOT NULL,
	FOREIGN KEY (ClienteID) references Clientes(ClienteID),
	FOREIGN KEY (EmpleadoID) references Empleados(EmpleadoID),
	FOREIGN KEY (SucursalID) references Sucursales(SucursalID),
	FOREIGN KEY (MensajeroID) references Mensajeros(MensajeroID),
	FOREIGN KEY (TipoPagoID) references TiposPago(TipoPagoID),
	FOREIGN KEY (OrigenID) references OrigenesOrden(OrigenID),
);

--table Detalles Orden
CREATE TABLE DetalleOrdenes(
	OrdenID INT,
	ProductoID INT,
	Cantidad INT,
	Precio DECIMAL(10,2),
	PRIMARY KEY (OrdenID,ProductoID),
	FOREIGN KEY (OrdenID) references Ordenes(OrdenID),
	FOREIGN KEY (ProductoID) references Productos(ProductoID),
);

USE FastFoodDB_Correccion;

-- Insertar datos en Categorias
INSERT INTO Categorias (Nombre) VALUES
('Comida Rápida'), ('Postres'), ('Bebidas'), ('Ensaladas'), ('Desayunos'),
('Cafetería'), ('Helados'), ('Comida Vegana'), ('Carnes'), ('Pizzas');

Select * from Categorias

-- Insertar datos en Productos
INSERT INTO Productos (Nombre, CategoriaID, Precio) VALUES
('Hamburguesa Deluxe', 1, 9.99), ('Cheeseburger', 1, 7.99), ('Pizza Margarita', 10, 11.99), ('Pizza Pepperoni', 10, 12.99), ('Helado de Chocolate', 7, 2.99),
('Helado de Vainilla', 7, 2.99), ('Ensalada César', 4, 5.99), ('Ensalada Griega', 4, 6.99), ('Pastel de Zanahoria', 2, 3.99), ('Brownie', 2, 2.99);

Select * from Productos

-- Insertar datos en Sucursales
INSERT INTO Sucursales (Nombre, Direccion) VALUES
('Sucursal Central', '1234 Main St'), ('Sucursal Norte', '5678 North St'), ('Sucursal Este', '9101 East St'), ('Sucursal Oeste', '1121 West St'), ('Sucursal Sur', '3141 South St'),
('Sucursal Playa', '1516 Beach St'), ('Sucursal Montaña', '1718 Mountain St'), ('Sucursal Valle', '1920 Valley St'), ('Sucursal Lago', '2122 Lake St'), ('Sucursal Bosque', '2324 Forest St');

Select * from Sucursales

-- Insertar datos en Empleados
INSERT INTO Empleados (Nombre, Posicion, Departamento, SucursalID, Rol) VALUES
('John Doe', 'Gerente', 'Administración', 1, 'Vendedor'), ('Jane Smith', 'Subgerente', 'Ventas', 1, 'Vendedor'), ('Bill Jones', 'Cajero', 'Ventas', 1, 'Vendedor'), ('Alice Johnson', 'Cocinero', 'Cocina', 1, 'Vendedor'), ('Tom Brown', 'Barista', 'Cafetería', 1, 'Vendedor'),
('Emma Davis', 'Repartidor', 'Logística', 1, 'Mensajero'), ('Lucas Miller', 'Atención al Cliente', 'Servicio', 1, 'Vendedor'), ('Olivia García', 'Encargado de Turno', 'Administración', 1, 'Vendedor'), ('Ethan Martinez', 'Mesero', 'Restaurante', 1, 'Vendedor'), ('Sophia Rodriguez', 'Auxiliar de Limpieza', 'Mantenimiento', 1, 'Vendedor');

Select * from Empleados

-- Insertar datos en Clientes
INSERT INTO Clientes (Nombre, Direccion) VALUES
('Cliente Uno', '1000 A Street'), ('Cliente Dos', '1001 B Street'), ('Cliente Tres', '1002 C Street'), ('Cliente Cuatro', '1003 D Street'), ('Cliente Cinco', '1004 E Street'),
('Cliente Seis', '1005 F Street'), ('Cliente Siete', '1006 G Street'), ('Cliente Ocho', '1007 H Street'), ('Cliente Nueve', '1008 I Street'), ('Cliente Diez', '1009 J Street');

Select * from Clientes

-- Insertar datos en OrigenesOrden
INSERT INTO OrigenesOrden (Descripcion) VALUES
('En línea'), ('Presencial'), ('Teléfono'), ('Drive Thru'), ('App Móvil'),
('Redes Sociales'), ('Correo Electrónico'), ('Publicidad'), ('Recomendación'), ('Evento');

Select * from OrigenesOrden

-- Insertar datos en TiposPago
INSERT INTO TiposPago (Descripcion) VALUES
('Efectivo'), ('Tarjeta de Crédito'), ('Tarjeta de Débito'), ('PayPal'), ('Transferencia Bancaria'),
('Criptomonedas'), ('Cheque'), ('Vale de Comida'), ('Cupón de Descuento'), ('Pago Móvil');

Select * from TiposPago

-- Insertar datos en Mensajeros
INSERT INTO Mensajeros (Nombre, EsExterno) VALUES
('Mensajero Uno', 0), ('Mensajero Dos', 1), ('Mensajero Tres', 0), ('Mensajero Cuatro', 1), ('Mensajero Cinco', 0),
('Mensajero Seis', 1), ('Mensajero Siete', 0), ('Mensajero Ocho', 1), ('Mensajero Nueve', 0), ('Mensajero Diez', 1);

Select * from Mensajeros

-- Insertar datos en Ordenes
INSERT INTO Ordenes (ClienteID, EmpleadoID, SucursalID, MensajeroID, TipoPagoID, OrigenID, HorarioVenta, TotalCompra, KilometrosRecorrer, FechaDespacho, FechaEntrega, FechaOrdenTomada, FechaOrdenLista) VALUES
(1, 1, 1, 1, 1, 1, 'Mañana', 50.00, 5.5, '2023-01-10 08:30:00', '2023-01-10 09:00:00', '2023-01-10 08:00:00', '2023-01-10 08:15:00'),
(2, 2, 2, 2, 2, 2, 'Tarde', 75.00, 10.0, '2023-02-15 14:30:00', '2023-02-15 15:00:00', '2023-02-15 13:30:00', '2023-02-15 14:00:00'),
(3, 3, 3, 3, 3, 3, 'Noche', 20.00, 2.0, '2023-03-20 19:30:00', '2023-03-20 20:00:00', '2023-03-20 19:00:00', '2023-03-20 19:15:00'),
(4, 4, 4, 4, 4, 4, 'Mañana', 30.00, 0.5, '2023-04-25 09:30:00', '2023-04-25 10:00:00', '2023-04-25 09:00:00', '2023-04-25 09:15:00'),
(5, 5, 5, 5, 5, 5, 'Tarde', 55.00, 8.0, '2023-05-30 15:30:00', '2023-05-30 16:00:00', '2023-05-30 15:00:00', '2023-05-30 15:15:00'),
(6, 6, 6, 6, 6, 1, 'Noche', 45.00, 12.5, '2023-06-05 20:30:00', '2023-06-05 21:00:00', '2023-06-05 20:00:00', '2023-06-05 20:15:00'),
(7, 7, 7, 7, 7, 2, 'Mañana', 65.00, 7.5, '2023-07-10 08:30:00', '2023-07-10 09:00:00', '2023-07-10 08:00:00', '2023-07-10 08:15:00'),
(8, 8, 8, 8, 8, 3, 'Tarde', 85.00, 9.5, '2023-08-15 14:30:00', '2023-08-15 15:00:00', '2023-08-15 14:00:00', '2023-08-15 14:15:00'),
(9, 9, 9, 9, 9, 4, 'Noche', 95.00, 3.0, '2023-09-20 19:30:00', '2023-09-20 20:00:00', '2023-09-20 19:00:00', '2023-09-20 19:15:00'),
(10, 10, 10, 10, 10, 5, 'Mañana', 100.00, 15.0, '2023-10-25 09:30:00', '2023-10-25 10:00:00', '2023-10-25 09:00:00', '2023-10-25 09:15:00');

Select * from Ordenes

-- Insertar datos en DetalleOrdenes
INSERT INTO DetalleOrdenes (OrdenID, ProductoID, Cantidad, Precio) VALUES
(1, 1, 3, 23.44),
(1, 2, 5, 45.14),
(1, 3, 4, 46.37),
(1, 4, 4, 42.34),
(1, 5, 1, 18.25),
(1, 6, 4, 20.08),
(1, 7, 2, 13.31),
(1, 8, 2, 20.96),
(1, 9, 4, 30.13),
(1, 10, 3, 38.34);

Select * from DetalleOrdenes
--------------------------------------------------------------------------------------------------------------------
-- Aumentar el precio de todos los productos en la categoría 1
UPDATE Productos 
SET Precio = Precio + 1 
WHERE CategoriaID = 1;

-- Cambiar la posición de todos los empleados del departamento 'Cocina' a 'Chef'
UPDATE Empleados 
SET Posicion = 'Chef' 
WHERE Departamento = 'Cocina';

-- Actualizar la dirección de una sucursal específica
UPDATE Sucursales 
SET Direccion = '1234 New Address St' 
WHERE SucursalID = 1;

--ELIMINACIONES DE EJEMPLO (DELETE)

/*1. Eliminar una orden específica
Imaginemos que quieres eliminar una orden específica, 
por ejemplo, la orden con OrdenID = 10. 
Esta operación eliminaría la orden junto con sus detalles asociados 
(deberías asegurarte de eliminar o actualizar cualquier dato relacionado 
para mantener la integridad referencial).*/

DELETE FROM DetalleOrdenes WHERE OrdenID = 10;
DELETE FROM Ordenes WHERE OrdenID = 10;

/*2. Eliminar todos los productos de una categoría específica
Si decides dejar de ofrecer todos los "Postres" 
(supongamos que Categorias.CategoriaID = 2 para "Postres"), 
podrías querer eliminar todos los productos asociados a esa categoría.*/

ALTER TABLE DetalleOrdenes
NOCHECK CONSTRAINT FK__DetalleOr__Produ__6383C8BA;

DELETE FROM Productos WHERE CategoriaID = 2; --ver por que no me la deja ejecutar

--volver a activar las restricciones de clave Externa

Alter Table DetalleOrdenes
Check Constraint FK__DetalleOr__Produ__6383C8BA;

/*Antes de ejecutar este comando, deberías considerar si hay órdenes que incluyen estos 
productos y decidir cómo manejar esas referencias*/


/*3. Eliminar empleados de una sucursal que cerró
Si una sucursal cierra, por ejemplo, 
SucursalID = 10 (Sucursal Bosque), 
podrías necesitar eliminar a todos los empleados asociados con esa sucursal.*/

DELETE FROM Empleados 
WHERE SucursalID = 10;


--------------------------------------------------------------------------------------------


--Cuantos productos diferentes hay en la orden 1
Select * from DetalleOrdenes
select OrdenID, COUNT(distinct ProductoID) AS  CONTEO
FROM DetalleOrdenes
WHERE OrdenID = 1
GROUP BY OrdenID;

--Consulta 1:Cual es la cantidad total de registros unicos en la tabla ordenes?
select COUNT(OrdenID) AS Registros_Unicos
from Ordenes; 

--Consulta 2: Cuantos empleados existen en cada departamento?
select Departamento, 
	COUNT (EmpleadoID) Cantidad
From Empleados
GROUP BY Departamento
ORDER BY cANTIDAD DESC;

USE FastFoodDB_Correccion;

--Consulta 3: Cuantos productos hay por categoria?
Select CategoriaID,
	COUNT(productoID) AS Cantidad
From Productos
GROUP BY CategoriaID
HAVING COUNT (ProductoID) >= 2 

--Consulta 4: Cuantos Clientes se han importado a la tabla de clientes?
SELECT 
	COUNT(clienteID) conteo
FROM Clientes;

/*--Consulta 5: Cuales son las sucursales con un promedio de ventas por orden superior a un valor
especifico (40), ordenadas por el promedio de kilometros recorridos para las entregas de mayor a menor?*/

SELECT SucursalID,
	CAST (AVG(TotalCompra) AS DECIMAL (10,2)) Promedio_Venta,
	format (AVG(KilometrosRecorrer),'0.00') Promedio_kilometros
FROM Ordenes
GROUP BY SucursalID
HAVING AVG (TotalCompra) > 40
ORDER BY avg (KilometrosRecorrer) DESC;

select min(TotalCompra) Minima_compra, Max(TotalCompra) maxima_compra
from Ordenes;

-------------------------------------------------------------------------------------------------

use FastFoodDB_Correccion;

--Pregunta: cual es el total de las ventas (TotalCompra) a nivel global?

SELECT sum (TotalCompra) AS Ventas_Nivel_Global
FROM Ordenes;

--Pregunta: ¿Cuál es el precio promedio de los productos dentro de cada categoría?
SELECT CategoriaID, cAST(AVG(Precio) AS DECIMAL (10,2)) Precio_Promedio
FROM Productos
GROUP BY CategoriaID
ORDER BY Precio_Promedio desc;

--Pregunta: ¿Cuál es el valor de la orden mínima y máxima por cada sucursal?
select SucursalID, min(TotalCompra) minimo, max(TotalCompra) Maximo
FROM Ordenes
GROUP BY SucursalID;

--Pregunta: ¿Cuál es el mayor número de kilómetros recorridos para una entrega?
SELECT Max (KilometrosRecorrer) AS 'Maximo'
FROM Ordenes;

--Pregunta: ¿Cuál es la cantidad promedio de productos por orden?

Select OrdenID, SUM (Cantidad) / COUNT (OrdenID) Promedio
FROM DetalleOrdenes
GROUP BY OrdenID;

Select OrdenID, AVG (Cantidad) AS PromedioCantidadProductos
From DetalleOrdenes
Group BY OrdenID;

--Pregunta: ¿Cuál es el total de ventas por cada tipo de pago?
Select TipoPagoID, SUM(TotalCompra) TotalVenta
From Ordenes
Group BY TipoPagoID
Order BY TotalVenta Desc;

Select*
From TiposPago;

--Pregunta: ¿Cuál sucursal tiene la venta promedio más alta?
Select Top 1 SucursalID, Cast(AVG (TotalCompra) as decimal (10,2)) PromedioVenta
From Ordenes
Group BY SucursalID
Order BY PromedioVenta Desc;

/*--Pregunta: ¿Cuáles son las sucursales que han generado ventas por orden por encima de 
$50?*/

Select sucursalID,
	Sum(TotalCompra) TotalVentas
	From Ordenes
	Group BY SucursalID
	Having Sum (TotalCompra) > 50
	Order BY TotalVentas Desc;

--Pregunta: ¿Cómo se comparan las ventas promedio antes y después del 1 de julio de 2023?


Select 'Antes del 1 de Julio de 2023' AS Periodo,
	Cast(avg(TotalCompra) As decimal (10,2))TotalVenta
From Ordenes
Where FechaOrdenTomada < '2023-07-01'
UNION
Select 'Despues del 1 de Julio de 2023' AS Periodo,
	Cast(avg(TotalCompra) As Decimal (10,2)) TotalVenta
From Ordenes
Where FechaOrdenTomada > '2023-07-01'

/*Pregunta: ¿Durante qué horario del día (mañana, tarde, noche) se registra
la mayor cantidad de ventas, cuál es el valor promedio de estas ventas, y 
cuál ha sido la venta máxima alcanzada?*/

Select Top 1 HorarioVenta, -- sin el top da 3 datos adicionales
	Count(*) AS CantidadVentas,
	cast(AVG(TotalCompra) as decimal (10,2)) PromedioVentas,
	Max(TotalCompra) VentaMaxima
From Ordenes
Group by HorarioVenta
ordER BY CantidadVentas Desc;

use FastFoodDB_Correccion;


/*Pregunta1: ¿Cómo puedo obtener una lista de todos los productos junto con sus categorías?*/

Select * from productos;
Select * from categorias;

Select *
from Productos P
Inner join Categorias C ON (P.CategoriaID = C.CategoriaID);


--Respuesta
Select P.Nombre Producto, C.Nombre Categoria
from Productos P
Inner join Categorias C ON (P.CategoriaID = C.CategoriaID);

Select P.Nombre Producto, C.Nombre Categoria
from Productos P
left join Categorias C ON (P.CategoriaID = C.CategoriaID);

/*Pregunta2: ¿Cómo puedo saber a qué sucursal está asignado cada empleado?*/

Select * from Empleados;
Select * from sucursales;

--Respuesta
select E.Nombre Empleado, S.Nombre Sucursal
from Empleados E
Left join sucursales S ON (E.SucursalID = S.sucursalID)


/*Pregunta3: ¿Existen productos que no tienen una categoría asignada?*/

Select * from productos;
Select * from sucursales;

--Respuesta
Select *
from productos P
Left Join Categorias C ON (P.CategoriaID = C.CategoriaID)
where c.CategoriaID is null;


/*Pregunta4: ¿Cómo puedo obtener un detalle completo de las órdenes, 
incluyendo cliente, empleado que tomó la orden, y el mensajero que la entregó?*/

Select *
from Ordenes O
Left join Clientes C ON (O.ClienteID = C.ClienteID)
Left join Empleados E ON (O.EmpleadoID = E.EmpleadoID)
Left join Mensajeros M ON (O.MensajeroID = M.MensajeroID)

--Respuesta
Select O.OrdenID, C.Nombre Cliente, E.Nombre Empleado, M.Nombre Mensajero
from Ordenes O
Left join Clientes C ON (O.ClienteID = C.ClienteID)
Left join Empleados E ON (O.EmpleadoID = E.EmpleadoID)
Left join Mensajeros M ON (O.MensajeroID = M.MensajeroID)


/*Pregunta5: ¿Cuántos productos de cada tipo se han vendido en cada sucursal?*/


Select * from Ordenes;
Select * from DetalleOrdenes;
Select * from productos;
Select * from sucursales;

Select *
From Ordenes O
Inner join DetalleOrdenes DO ON (O.OrdenID = DO.OrdenID)
Inner join productos P ON (DO.ProductoID = P.ProductoID)
Inner join sucursales S ON (O.SucursalID = S.sucursalID)

--Respuesta
Select S.Nombre Sucursal, P.Nombre Producto, sum (DO.Cantidad) ProductosVendidos
From Ordenes O
Inner join DetalleOrdenes DO ON (O.OrdenID = DO.OrdenID)
Inner join productos P ON (DO.ProductoID = P.ProductoID)
Inner join sucursales S ON (O.SucursalID = S.sucursalID)
Group by S.Nombre, P.Nombre
Order by ProductosVendidos DESC;

/*Eficiencia de los mensajeros: ¿Cuál es el tiempo promedio desde el despacho hasta la entrega de 
los pedidos por los mensajeros?*/

Select *
From Ordenes;

Select avg(DATEDIFF (Minute,FechaDespacho,FechaEntrega)) PromedioTiempoEntrega
From Ordenes
Where MensajeroID IS NOT NULL;


/*Análisis de Ventas por Origen de Orden: ¿Qué canal de ventas genera más ingresos?
Productividad de los Empleados: ¿Cuál es el volumen de ventas promedio gestionado por empleado?*/

Select *
From OrigenesOrden;
Select *
From Ordenes;

Select Top 1 OO.Descripcion Canal, Sum (O.TotalCompra) TotalVenta
From Ordenes O
Inner Join OrigenesOrden OO ON (O.OrigenID=OO.OrigenID)
group by OO.Descripcion
Order by TotalVenta Desc;


/*Productividad de los Empleados: ¿Cuál es el volumen de ventas promedio gestionado por empleado?*/

Select * From Ordenes;
Select * From Ordenes;

Select E.nombre Empleado, Cast(AVG (TotalCompra) as decimal (10,2)) VolumenVentaPromedio
From Ordenes O
Left join Empleados E ON (O.EmpleadoID=E.EmpleadoID)
group by E.Nombre
Order BY VolumenVentaPromedio Desc;


/*Análisis de Demanda por Horario y Día: ¿Cómo varía la demanda de productos a lo largo del día? 

NOTA: 
Esta consulta no puede ser implementada sin una definición clara del horario (mañana, tarde, noche) en 
la base de datos existente. Asumiremos que HorarioVenta refleja esta información correctamente.*/

Select * From Ordenes;

Select * 
From Ordenes O
inner join DetalleOrdenes DO ON (O.OrdenID = DO.OrdenID)

Select O.HorarioVenta Horario, P.Nombre Producto, sum(DO.Cantidad) Demanda
From Ordenes O
inner join DetalleOrdenes DO ON (O.OrdenID = DO.OrdenID)
inner join productos P ON (DO.ProductoID = P.ProductoID)
group by O.HorarioVenta, P.Nombre
Order by O.HorarioVenta, Demanda Desc;


/*Comparación de Ventas Mensuales: ¿Cómo se comparan las ventas mensuales de este 
año con el año anterior?*/

Select *
From Ordenes;


Select YEAR(FechaOrdenTomada) 'Año', MONTH (FechaOrdenTomada) Mes,
Sum (TotalCompra) Venta
From Ordenes
where year (FechaOrdenTomada) >= 2023 and Year (FechaOrdenTomada) <=2024
group by YEAR (FechaOrdenTomada), MONTH(FechaOrdenTomada)
Order by Venta Desc;



/*Análisis de Fidelidad del Cliente: ¿Qué porcentaje de clientes son recurrentes versus nuevos clientes
cada mes? NOTA: La consulta se enfocaría en la frecuencia de órdenes por cliente para inferir la fidelidad.*/

Select C.Nombre, COUNT (*) NumeroOrdenes
from Ordenes O
inner join Clientes C ON (O.ClienteID = C.ClienteID)
Group by C.Nombre
Order by NumeroOrdenes DESC;


