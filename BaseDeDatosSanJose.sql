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






-- PRODUCTOS LÁCTEOS
INSERT INTO ProductoLacteo (tipo_producto, fecha_produccion, lote, conservantes)
VALUES
('Queso', '2025-05-01', 'L001', 'Sal'),
('Yogurt', '2025-05-02', 'L002', 'Ácido láctico'),
('Mantequilla', '2025-05-03', 'L003', 'Ninguno'),
('Queso', '2025-05-04', 'L004', 'Ninguno'),
('Yogurt', '2025-05-05', 'L005', 'Estabilizante'),
('Mantequilla', '2025-05-06', 'L006', 'Sal'),
('Queso', '2025-05-07', 'L007', 'Cloruro de calcio'),
('Yogurt', '2025-05-08', 'L008', 'Ninguno'),
('Mantequilla', '2025-05-09', 'L009', 'Ácido sórbico'),
('Queso', '2025-05-10', 'L010', 'Ninguno'),
('Mantequilla', '2025-05-09', 'L009', 'Ácido sórbico'),
('Queso', '2025-05-10', 'L010', 'Ninguno'),
('Manjar', '2025-05-11', 'L011', 'Azúcar'),
('Natilla', '2025-05-12', 'L012', 'Canela'),
('Queso con orégano', '2025-05-13', 'L013', 'Orégano'),
('Yogurt', '2025-05-14', 'L014', 'Estabilizante'),
('Mantequilla', '2025-05-15', 'L015', 'Sal'),
('Manjar', '2025-05-16', 'L016', 'Ácido cítrico'),
('Queso', '2025-05-17', 'L017', 'Sal'),
('Yogurt', '2025-05-18', 'L018', 'Ácido láctico'),
('Mantequilla', '2025-05-19', 'L019', 'Ninguno'),
('Queso', '2025-05-20', 'L020', 'Cloruro de calcio'),
('Yogurt', '2025-05-21', 'L021', 'Ninguno'),
('Mantequilla', '2025-05-22', 'L022', 'Sal'),
('Manjar', '2025-05-23', 'L023', 'Azúcar'),
('Natilla', '2025-05-24', 'L024', 'Canela'),
('Queso con orégano', '2025-05-25', 'L025', 'Orégano'),
('Queso', '2025-05-26', 'L026', 'Sal'),
('Yogurt', '2025-05-27', 'L027', 'Ácido láctico'),
('Mantequilla', '2025-05-28', 'L028', 'Sal'),
('Manjar', '2025-05-29', 'L029', 'Ácido cítrico'),
('Natilla', '2025-05-30', 'L030', 'Canela'),
('Queso con orégano', '2025-05-31', 'L031', 'Orégano'),
('Yogurt', '2025-06-01', 'L032', 'Estabilizante'),
('Mantequilla', '2025-06-02', 'L033', 'Sal'),
('Queso', '2025-06-03', 'L034', 'Cloruro de calcio'),
('Manjar', '2025-06-04', 'L035', 'Azúcar'),
('Natilla', '2025-06-05', 'L036', 'Canela'),
('Queso con orégano', '2025-06-06', 'L037', 'Orégano'),
('Yogurt', '2025-06-07', 'L038', 'Ácido láctico'),
('Mantequilla', '2025-06-08', 'L039', 'Ácido sórbico'),
('Queso', '2025-06-09', 'L040', 'Sal'),
('Yogurt', '2025-06-10', 'L041', 'Ninguno'),
('Mantequilla', '2025-06-11', 'L042', 'Sal'),
('Manjar', '2025-06-12', 'L043', 'Ácido cítrico'),
('Queso', '2025-06-13', 'L044', 'Cloruro de calcio'),
('Yogurt', '2025-06-14', 'L045', 'Estabilizante'),
('Mantequilla', '2025-06-15', 'L046', 'Sal'),
('Manjar', '2025-06-16', 'L047', 'Azúcar'),
('Queso', '2025-06-17', 'L048', 'Ninguno'),
('Yogurt', '2025-06-18', 'L049', 'Ácido láctico'),
('Mantequilla', '2025-06-19', 'L050', 'Ninguno'),
('Queso', '2025-06-20', 'L051', 'Sal'),
('Yogurt', '2025-06-21', 'L052', 'Ninguno'),
('Mantequilla', '2025-06-22', 'L053', 'Sal'),
('Manjar', '2025-06-23', 'L054', 'Azúcar'),
('Natilla', '2025-06-24', 'L055', 'Canela'),
('Queso con orégano', '2025-06-25', 'L056', 'Orégano'),
('Queso', '2025-06-26', 'L057', 'Sal'),
('Yogurt', '2025-06-27', 'L058', 'Ácido láctico'),
('Mantequilla', '2025-06-28', 'L059', 'Sal'),
('Manjar', '2025-06-29', 'L060', 'Ácido cítrico'),
('Natilla', '2025-06-30', 'L061', 'Canela'),
('Queso con orégano', '2025-07-01', 'L062', 'Orégano'),
('Yogurt', '2025-07-02', 'L063', 'Estabilizante'),
('Mantequilla', '2025-07-03', 'L064', 'Sal'),
('Queso', '2025-07-04', 'L065', 'Cloruro de calcio'),
('Manjar', '2025-07-05', 'L066', 'Azúcar'),
('Natilla', '2025-07-06', 'L067', 'Canela'),
('Queso con orégano', '2025-07-07', 'L068', 'Orégano'),
('Yogurt', '2025-07-08', 'L069', 'Ácido láctico'),
('Mantequilla', '2025-07-09', 'L070', 'Ácido sórbico'),
('Queso', '2025-07-10', 'L071', 'Sal'),
('Yogurt', '2025-07-11', 'L072', 'Ninguno'),
('Mantequilla', '2025-07-12', 'L073', 'Sal'),
('Manjar', '2025-07-13', 'L074', 'Ácido cítrico'),
('Queso', '2025-07-14', 'L075', 'Cloruro de calcio'),
('Yogurt', '2025-07-15', 'L076', 'Estabilizante'),
('Mantequilla', '2025-07-16', 'L077', 'Sal'),
('Manjar', '2025-07-17', 'L078', 'Azúcar'),
('Queso', '2025-07-18', 'L079', 'Ninguno'),
('Yogurt', '2025-07-19', 'L080', 'Ácido láctico'),
('Mantequilla', '2025-07-20', 'L081', 'Ninguno'),
('Queso', '2025-07-21', 'L082', 'Sal'),
('Yogurt', '2025-07-22', 'L083', 'Ninguno'),
('Mantequilla', '2025-07-23', 'L084', 'Sal'),
('Manjar', '2025-07-24', 'L085', 'Azúcar'),
('Natilla', '2025-07-25', 'L086', 'Canela'),
('Queso con orégano', '2025-07-26', 'L087', 'Orégano'),
('Queso', '2025-07-27', 'L088', 'Sal'),
('Yogurt', '2025-07-28', 'L089', 'Ácido láctico'),
('Mantequilla', '2025-07-29', 'L090', 'Sal'),
('Manjar', '2025-07-30', 'L091', 'Ácido cítrico'),
('Natilla', '2025-07-31', 'L092', 'Canela'),
('Queso con orégano', '2025-08-01', 'L093', 'Orégano'),
('Yogurt', '2025-08-02', 'L094', 'Estabilizante'),
('Mantequilla', '2025-08-03', 'L095', 'Sal'),
('Queso', '2025-08-04', 'L096', 'Cloruro de calcio'),
('Yogurt', '2025-08-05', 'L097', 'Ácido láctico'),
('Manjar', '2025-08-06', 'L098', 'Azúcar');

SELECT * FROM ProductoLacteo;


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
(10, 13.0, 74.0, 6.0, '2025-05-10'),
(11, 10.0, 71.0, 6.2, '2025-05-11'),
(12, 4.1, 61.0, 4.5, '2025-05-12'),
(13, 6.3, 53.5, 5.4, '2025-05-13'),
(14, 11.9, 74.5, 6.0, '2025-05-14'),
(15, 5.2, 62.5, 4.8, '2025-05-15'),
(16, 7.4, 56.0, 5.2, '2025-05-16'),
(17, 10.9, 69.5, 6.1, '2025-05-17'),
(18, 4.3, 59.0, 4.6, '2025-05-18'),
(19, 6.7, 55.5, 5.1, '2025-05-19'),
(20, 12.8, 73.5, 5.9, '2025-05-20'),

(21, 10.7, 72.2, 6.3, '2025-05-21'),
(22, 4.4, 60.8, 4.6, '2025-05-22'),
(23, 6.0, 51.9, 5.2, '2025-05-23'),
(24, 12.1, 75.2, 6.0, '2025-05-24'),
(25, 5.1, 63.1, 4.7, '2025-05-25'),
(26, 7.1, 54.2, 5.0, '2025-05-26'),
(27, 11.4, 70.2, 6.2, '2025-05-27'),
(28, 4.2, 58.3, 4.3, '2025-05-28'),
(29, 6.6, 54.8, 5.0, '2025-05-29'),
(30, 13.1, 74.1, 6.1, '2025-05-30'),

(31, 10.6, 70.1, 6.2, '2025-05-31'),
(32, 4.0, 60.0, 4.5, '2025-06-01'),
(33, 6.2, 52.5, 5.4, '2025-06-02'),
(34, 12.2, 76.0, 6.1, '2025-06-03'),
(35, 5.3, 64.0, 4.8, '2025-06-04'),
(36, 7.3, 55.3, 5.3, '2025-06-05'),
(37, 11.3, 69.8, 6.0, '2025-06-06'),
(38, 4.5, 57.9, 4.4, '2025-06-07'),
(39, 6.8, 55.7, 5.0, '2025-06-08'),
(40, 12.9, 73.7, 6.0, '2025-06-09'),

(41, 10.2, 71.3, 6.3, '2025-06-10'),
(42, 4.6, 61.2, 4.6, '2025-06-11'),
(43, 6.4, 53.3, 5.5, '2025-06-12'),
(44, 11.8, 75.1, 6.1, '2025-06-13'),
(45, 5.0, 62.0, 4.7, '2025-06-14'),
(46, 7.0, 55.0, 5.1, '2025-06-15'),
(47, 11.6, 70.3, 6.3, '2025-06-16'),
(48, 4.7, 59.5, 4.5, '2025-06-17'),
(49, 6.9, 56.2, 5.2, '2025-06-18'),
(50, 13.2, 74.3, 6.1, '2025-06-19'),
(51, 10.3, 72.5, 6.3, '2025-06-20'),
(52, 4.8, 60.9, 4.5, '2025-06-21'),
(53, 6.1, 51.5, 5.3, '2025-06-22'),
(54, 12.0, 75.6, 6.0, '2025-06-23'),
(55, 5.2, 63.3, 4.9, '2025-06-24'),
(56, 7.2, 55.1, 5.2, '2025-06-25'),
(57, 11.5, 70.6, 6.2, '2025-06-26'),
(58, 4.9, 58.1, 4.6, '2025-06-27'),
(59, 6.7, 55.9, 5.1, '2025-06-28'),
(60, 13.3, 73.9, 6.0, '2025-06-29'),
(61, 10.8, 71.5, 6.2, '2025-06-30'),
(62, 4.3, 61.7, 4.4, '2025-07-01'),
(63, 6.0, 52.1, 5.3, '2025-07-02'),
(64, 12.1, 75.3, 6.1, '2025-07-03'),
(65, 5.1, 63.4, 4.8, '2025-07-04'),
(66, 7.0, 54.7, 5.1, '2025-07-05'),
(67, 11.2, 70.4, 6.0, '2025-07-06'),
(68, 4.2, 59.3, 4.3, '2025-07-07'),
(69, 6.5, 55.8, 5.0, '2025-07-08'),
(70, 13.0, 74.2, 6.0, '2025-07-09'),

(71, 10.9, 72.1, 6.4, '2025-07-10'),
(72, 4.1, 60.6, 4.5, '2025-07-11'),
(73, 6.3, 52.6, 5.2, '2025-07-12'),
(74, 11.7, 75.8, 6.1, '2025-07-13'),
(75, 5.4, 63.8, 4.7, '2025-07-14'),
(76, 7.3, 55.6, 5.0, '2025-07-15'),
(77, 11.1, 70.0, 6.3, '2025-07-16'),
(78, 4.0, 57.5, 4.6, '2025-07-17'),
(79, 6.9, 56.3, 5.1, '2025-07-18'),
(80, 13.4, 74.8, 6.2, '2025-07-19'),

(81, 10.1, 71.2, 6.3, '2025-07-20'),
(82, 4.6, 60.3, 4.4, '2025-07-21'),
(83, 6.4, 53.7, 5.4, '2025-07-22'),
(84, 11.9, 75.5, 6.0, '2025-07-23'),
(85, 5.3, 64.2, 4.8, '2025-07-24'),
(86, 7.5, 55.9, 5.2, '2025-07-25'),
(87, 11.0, 70.9, 6.1, '2025-07-26'),
(88, 4.8, 58.7, 4.5, '2025-07-27'),
(89, 6.6, 55.4, 5.0, '2025-07-28'),
(90, 13.1, 73.4, 6.1, '2025-07-29'),

(91, 10.5, 72.6, 6.3, '2025-07-30'),
(92, 4.4, 60.1, 4.5, '2025-07-31'),
(93, 6.2, 51.6, 5.2, '2025-08-01'),
(94, 12.3, 76.3, 6.2, '2025-08-02'),
(95, 5.0, 63.0, 4.9, '2025-08-03'),
(96, 7.1, 54.9, 5.3, '2025-08-04'),
(97, 11.6, 70.7, 6.2, '2025-08-05'),
(98, 4.9, 59.4, 4.6, '2025-08-06'),
(99, 6.7, 55.2, 5.0, '2025-08-07'),
(100, 13.5, 74.0, 6.0, '2025-08-08');

SELECT * FROM CondicionAmbiental;

-- ESTIMACIONES (vida útil según condiciones)
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
(10, 17, '2025-05-10', 'RegresionLineal'),
(11, 24, '2025-05-11', 'RegresionLineal'),
(12, 12, '2025-05-12', 'RegresionLineal'),
(13, 30, '2025-05-13', 'RegresionLineal'),
(14, 19, '2025-05-14', 'RegresionLineal'),
(15, 13, '2025-05-15', 'RegresionLineal'),
(16, 28, '2025-05-16', 'RegresionLineal'),
(17, 23, '2025-05-17', 'RegresionLineal'),
(18, 16, '2025-05-18', 'RegresionLineal'),
(19, 26, '2025-05-19', 'RegresionLineal'),
(20, 18, '2025-05-20', 'RegresionLineal');



SELECT * FROM EstimacionVidaUtil;

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








