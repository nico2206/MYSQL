use parque;
-- 1. Limpieza de reservas antiguas

DELIMITER //
CREATE EVENT limpiezareservas
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-03-10 00:00:00'
DO
BEGIN
    DELETE FROM Reservas
    WHERE fecha_fin < DATE_SUB(NOW(), INTERVAL 1 YEAR);
END //
DELIMITER ;
-- 2. Incremento anual de sueldos
DELIMITER //
CREATE EVENT incrementosueldos
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-03-10 00:00:00'
DO
BEGIN
    UPDATE Personal
    SET sueldo = sueldo * 1.05;
END //
DELIMITER ;
-- 3. Reporte semanal de visitantes
CREATE TABLE ReporteVisitantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    semana INT,
    total_visitantes INT,
    fecha DATETIME
);
DELIMITER //
CREATE EVENT reportevisitantessemanal
ON SCHEDULE EVERY 1 WEEK
STARTS '2025-03-10 00:00:00'
DO
BEGIN
    INSERT INTO ReporteVisitantes (semana, total_visitantes, fecha)
    SELECT WEEK(NOW()), COUNT(*), NOW()
    FROM Visitantes;
END //
DELIMITER ;
-- 4. Revisión de proyectos finalizados
DELIMITER //
CREATE EVENT archivaproyectos
ON SCHEDULE EVERY 1 WEEK
STARTS '2025-03-10 00:00:00'
DO
BEGIN
    INSERT INTO Historico_Proyectos (id_proyecto, nombre, presupuesto, fecha_eliminacion)
    SELECT id_proyecto, nombre, presupuesto, NOW()
    FROM Proyectos
    WHERE periodo_fin < NOW();
    DELETE FROM Proyectos WHERE periodo_fin < NOW();
END //
DELIMITER ;
-- 5 Aumenta el inventario de especies en 5% cada mes
DELIMITER //
CREATE EVENT actualizainventario
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-03-10 00:00:00'
DO
BEGIN
    UPDATE Especies
    SET numero_inventario = numero_inventario * 1.05;
END //
DELIMITER ;

-- 6 Aumenta un 2% los sueldos menores a 1M cada 15 días
DELIMITER //
CREATE EVENT incrementasueldos
ON SCHEDULE EVERY 2 WEEK
STARTS '2025-03-12 00:00:00'
DO
BEGIN
    UPDATE Personal
    SET sueldo = sueldo * 1.02
    WHERE sueldo < 1000000;
END //
DELIMITER ;

-- 7 Reduce un 1% el presupuesto de proyectos no iniciados
DELIMITER //
CREATE EVENT reducepresupuesto
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-03-20 00:00:00'
DO
BEGIN
    UPDATE Proyectos
    SET presupuesto = presupuesto * 0.99
    WHERE periodo_inicio > NOW();
END //
DELIMITER ;

-- 8. Reporte de personal por tipo
CREATE TABLE ReportePersonal (
    id_reporte INT AUTO_INCREMENT PRIMARY KEY,
    tipo INT NOT NULL, -- Tipo de personal (001, 002, etc.)
    cantidad INT NOT NULL, -- Cantidad de empleados de ese tipo
    fecha DATETIME NOT NULL -- Fecha en que se generó el reporte
);
DELIMITER //
CREATE EVENT ev_reporte_personal
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-03-10 00:00:00'
DO
BEGIN
    INSERT INTO ReportePersonal (tipo, cantidad, fecha)
    SELECT tipo, COUNT(*), NOW()
    FROM Personal
    GROUP BY tipo;
END //
DELIMITER ;

-- 9. Revisión de vehículos
CREATE TABLE MantenimientoVehiculos (
    id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    fecha DATETIME NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id_vehiculo) ON DELETE CASCADE
);
DELIMITER //
CREATE EVENT ev_revision_vehiculos
ON SCHEDULE EVERY 6 MONTH
STARTS '2025-06-01 00:00:00'
DO
BEGIN
    INSERT INTO MantenimientoVehiculos (id_vehiculo, fecha)
    SELECT id_vehiculo, NOW()
    FROM Vehiculos;
END //
DELIMITER ;

-- 10. Alerta de proyectos costosos
CREATE TABLE Notificaciones (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    mensaje VARCHAR(255) NOT NULL,
    fecha DATETIME NOT NULL
);
DELIMITER //
CREATE EVENT alertapresupuestos
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-03-20 00:00:00'
DO
BEGIN
    INSERT INTO Notificaciones (mensaje, fecha)
    SELECT CONCAT('Proyecto costoso: ', nombre, ' - ', presupuesto), NOW()
    FROM Proyectos
    WHERE presupuesto > 50000000.00;
END //
DELIMITER ;

-- 11. Limpieza de visitantes inactivos
DELIMITER //
CREATE EVENT limpiezavisitantes
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-03-28 00:00:00'
DO
BEGIN
    DELETE FROM Visitantes
    WHERE id_visitante NOT IN (SELECT id_visitante FROM Reservas WHERE fecha_inicio > DATE_SUB(NOW(), INTERVAL 2 YEAR));
END //
DELIMITER ;

-- 12. Reporte de reservas mensuales
CREATE TABLE ReporteReservas (
    id_reporte INT AUTO_INCREMENT PRIMARY KEY,
    mes INT NOT NULL,
    total_reservas INT NOT NULL,
    fecha DATETIME NOT NULL
);
DELIMITER //
CREATE EVENT reportedereservas
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-03-10 00:00:00'
DO
BEGIN
    INSERT INTO ReporteReservas (mes, total_reservas, fecha)
    SELECT MONTH(NOW()), COUNT(*), NOW()
    FROM Reservas
    WHERE MONTH(fecha_inicio) = MONTH(NOW());
END //
DELIMITER ;

-- 13 Elimina visitantes sin reservas cada 3 meses
DELIMITER //
CREATE EVENT limpiavisitantes
ON SCHEDULE EVERY 3 MONTH
STARTS '2025-06-01 00:00:00'
DO
BEGIN
    DELETE FROM Visitantes
    WHERE id_visitante NOT IN (SELECT id_visitante FROM Reservas);
END //
DELIMITER ;

-- 14 Reduce capacidad en 1 si supera 10 cada semana
DELIMITER //
CREATE EVENT reducecapacidad
ON SCHEDULE EVERY 1 WEEK
STARTS '2025-03-11 00:00:00'
DO
BEGIN
    UPDATE Alojamientos
    SET capacidad = capacidad - 1
    WHERE capacidad > 10;
END //
DELIMITER ;
-- 15 Aumenta en 2 el inventario de especies con menos de 5 individuos
DELIMITER //
CREATE EVENT aumentainventario
ON SCHEDULE EVERY 2 WEEK
STARTS '2025-03-13 00:00:00'
DO
BEGIN
    UPDATE Especies
    SET numero_inventario = numero_inventario + 2
    WHERE numero_inventario < 5;
END //
DELIMITER ;
-- 16. Reporte de alojamientos ocupados
CREATE TABLE ReporteAlojamientos (
    id_reporte INT AUTO_INCREMENT PRIMARY KEY,
    mes INT NOT NULL,
    ocupados INT NOT NULL,
    fecha DATETIME NOT NULL
);
DELIMITER //
CREATE EVENT reportealojamientos
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-03-10 00:00:00'
DO
BEGIN
    INSERT INTO ReporteAlojamientos (mes, ocupados, fecha)
    SELECT MONTH(NOW()), COUNT(*), NOW()
    FROM Reservas r
    JOIN Alojamientos a ON r.id_alojamiento = a.id_alojamiento
    WHERE NOW() BETWEEN r.fecha_inicio AND r.fecha_fin;
END //
DELIMITER ;

-- 17. Limpieza de proyectos antiguos
DELIMITER //
CREATE EVENT Limpiezaproyectos
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-12-31 00:00:00'
DO
BEGIN
    DELETE FROM Proyectos
    WHERE periodo_fin < DATE_SUB(NOW(), INTERVAL 3 YEAR);
END //
DELIMITER ;

-- 18. Revisión de entradas
CREATE TABLE ReporteEntradas (
    id_reporte INT AUTO_INCREMENT PRIMARY KEY,
    numero_entrada INT NOT NULL,
    personal_asignado INT NOT NULL,
    fecha DATETIME NOT NULL
);
DELIMITER //
CREATE EVENT reporteentradas
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-03-10 00:00:00'
DO
BEGIN
    INSERT INTO ReporteEntradas (numero_entrada, personal_asignado, fecha)
    SELECT e.numero, COUNT(p.id_personal), NOW()
    FROM Entradas e
    LEFT JOIN Personal p ON e.id_entrada = p.id_entrada
    GROUP BY e.numero;
END //
DELIMITER ;

-- 19 Borra reservas finalizadas hace más de 3 meses
DELIMITER //
CREATE EVENT eliminareservasmes
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-04-15 00:00:00'
DO
BEGIN
    DELETE FROM Reservas
    WHERE fecha_fin < DATE_SUB(NOW(), INTERVAL 3 MONTH);
END //
DELIMITER ;

-- 20 Reduce un 2% el presupuesto de proyectos menores a 5.000.000
DELIMITER //
CREATE EVENT reducepresupuesto2
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-03-20 00:00:00'
DO
BEGIN
    UPDATE Proyectos
    SET presupuesto = presupuesto * 0.98
    WHERE presupuesto < 5000000;
END //
DELIMITER ;