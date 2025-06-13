CREATE DATABASE SistemaLacteosSanJose;
GO

USE SistemaLacteosSanJose;
GO

CREATE TABLE ProductoLacteo (
    id_producto INT PRIMARY KEY IDENTITY(1,1),
    tipo_producto VARCHAR(50) NOT NULL,
    fecha_produccion DATE NOT NULL,
    lote VARCHAR(30),
    conservantes VARCHAR(100)
);


CREATE TABLE CondicionAmbiental (
    id_condicion INT PRIMARY KEY IDENTITY(1,1),
    id_producto INT,
    temperatura FLOAT,
    humedad FLOAT,
    ph FLOAT,
    fecha_registro DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES ProductoLacteo(id_producto)
);

CREATE TABLE EstimacionVidaUtil (
    id_estimacion INT PRIMARY KEY IDENTITY(1,1),
    id_producto INT,
    vida_util_dias INT,
    fecha_estimacion DATE NOT NULL,
    metodo_modelo VARCHAR(50),
    FOREIGN KEY (id_producto) REFERENCES ProductoLacteo(id_producto)
);

CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100),
    rol VARCHAR(50)
);






-- PRODUCTOS L�CTEOS
INSERT INTO ProductoLacteo (tipo_producto, fecha_produccion, lote, conservantes)
VALUES
('Queso', '2025-05-01', 'L001', 'Sal'),
('Yogurt', '2025-05-02', 'L002', '�cido l�ctico'),
('Mantequilla', '2025-05-03', 'L003', 'Ninguno'),
('Queso', '2025-05-04', 'L004', 'Ninguno'),
('Yogurt', '2025-05-05', 'L005', 'Estabilizante'),
('Mantequilla', '2025-05-06', 'L006', 'Sal'),
('Queso', '2025-05-07', 'L007', 'Cloruro de calcio'),
('Yogurt', '2025-05-08', 'L008', 'Ninguno'),
('Mantequilla', '2025-05-09', 'L009', '�cido s�rbico'),
('Queso', '2025-05-10', 'L010', 'Ninguno');

-- CONDICIONES AMBIENTALES (producto_id del 1 al 10)
INSERT INTO CondicionAmbiental (id_producto, temperatura, humedad, ph, fecha_registro)
VALUES
(1, 10.5, 72.0, 6.3, '2025-05-01'),
(2, 4.2, 60.5, 4.6, '2025-05-02'),
(3, 6.1, 52.0, 5.3, '2025-05-03'),
(4, 12.0, 75.0, 6.1, '2025-05-04'),
(5, 5.0, 63.0, 4.7, '2025-05-05'),
(6, 7.2, 54.0, 5.1, '2025-05-06'),
(7, 11.5, 70.0, 6.2, '2025-05-07'),
(8, 4.0, 58.0, 4.4, '2025-05-08'),
(9, 6.5, 55.0, 5.0, '2025-05-09'),
(10, 13.0, 74.0, 6.0, '2025-05-10');

-- ESTIMACIONES (vida �til seg�n condiciones)
INSERT INTO EstimacionVidaUtil (id_producto, vida_util_dias, fecha_estimacion, metodo_modelo)
VALUES
(1, 21, '2025-05-01', 'RegresionLineal'),
(2, 14, '2025-05-02', 'RegresionLineal'),
(3, 31, '2025-05-03', 'RegresionLineal'),
(4, 18, '2025-05-04', 'RegresionLineal'),
(5, 13, '2025-05-05', 'RegresionLineal'),
(6, 29, '2025-05-06', 'RegresionLineal'),
(7, 22, '2025-05-07', 'RegresionLineal'),
(8, 15, '2025-05-08', 'RegresionLineal'),
(9, 27, '2025-05-09', 'RegresionLineal'),
(10, 17, '2025-05-10', 'RegresionLineal');

-- REPETIMOS CON M�S VARIEDAD (productos 11 a 30)
INSERT INTO ProductoLacteo (tipo_producto, fecha_produccion, lote, conservantes)
VALUES
('Queso', '2025-05-11', 'L011', 'Sal'),
('Yogurt', '2025-05-12', 'L012', '�cido l�ctico'),
('Mantequilla', '2025-05-13', 'L013', 'Sal'),
('Queso', '2025-05-14', 'L014', 'Ninguno'),
('Yogurt', '2025-05-15', 'L015', 'Estabilizante'),
('Mantequilla', '2025-05-16', 'L016', 'Ninguno'),
('Queso', '2025-05-17', 'L017', 'Cloruro de calcio'),
('Yogurt', '2025-05-18', 'L018', 'Ninguno'),
('Mantequilla', '2025-05-19', 'L019', '�cido s�rbico'),
('Queso', '2025-05-20', 'L020', 'Ninguno'),
('Queso', '2025-05-21', 'L021', 'Sal'),
('Yogurt', '2025-05-22', 'L022', '�cido l�ctico'),
('Mantequilla', '2025-05-23', 'L023', 'Sal'),
('Queso', '2025-05-24', 'L024', 'Ninguno'),
('Yogurt', '2025-05-25', 'L025', 'Estabilizante'),
('Mantequilla', '2025-05-26', 'L026', 'Ninguno'),
('Queso', '2025-05-27', 'L027', 'Cloruro de calcio'),
('Yogurt', '2025-05-28', 'L028', 'Ninguno'),
('Mantequilla', '2025-05-29', 'L029', '�cido s�rbico'),
('Queso', '2025-05-30', 'L030', 'Ninguno');

-- CONDICIONES y ESTIMACIONES para productos del 11 al 30
DECLARE @i INT = 11;
WHILE @i <= 30
BEGIN
    INSERT INTO CondicionAmbiental (id_producto, temperatura, humedad, ph, fecha_registro)
    VALUES (@i, 
           ROUND(RAND() * 10 + 4, 1),  -- temp entre 4 y 14
           ROUND(RAND() * 25 + 50, 1), -- humedad entre 50 y 75
           ROUND(RAND() * 2 + 4, 1),   -- pH entre 4.0 y 6.0
           DATEADD(DAY, @i, '2025-05-01'));

    INSERT INTO EstimacionVidaUtil (id_producto, vida_util_dias, fecha_estimacion, metodo_modelo)
    VALUES (@i, 
            ROUND(RAND() * 20 + 10, 0), 
            DATEADD(DAY, @i, '2025-05-01'), 
            'RegresionLineal');

    SET @i = @i + 1;
END;


SELECT * FROM ProductoLacteo;
SELECT * FROM CondicionAmbiental;
SELECT * FROM EstimacionVidaUtil;



