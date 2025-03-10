
use parque;
-- 1 Cuenta el número total de individuos de especies en un área específica
DELIMITER //
CREATE FUNCTION inventarioarea(p_id_area INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_inventario INT;
    SELECT SUM(numero_inventario) INTO total_inventario
    FROM Especies
    WHERE id_area = p_id_area;
    RETURN IFNULL(total_inventario, 0);
END //
DELIMITER ;
-- Uso: SELECT inventarioarea(1);

-- 2Cuenta el número total de individuos de un tipo de especie (ejemplo: 'animal')
DELIMITER //
CREATE FUNCTION inventariotipo(p_tipo VARCHAR(20))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_inventario INT;
    SELECT SUM(numero_inventario) INTO total_inventario
    FROM Especies
    WHERE tipo = p_tipo;
    RETURN IFNULL(total_inventario, 0);
END //
DELIMITER ;
-- Uso: SELECT inventariotipo('animal');

-- 3 Cuenta cuántos alojamientos hay en un parque específico
DELIMITER //
CREATE FUNCTION alojamientos(p_id_parque INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_alojamientos INT;
    SELECT COUNT(*) INTO total_alojamientos
    FROM Alojamientos
    WHERE id_parque = p_id_parque;
    RETURN total_alojamientos;
END //
DELIMITER ;
-- Uso: SELECT alojamientos(1);
-- 4 Calcula el promedio de sueldos del personal en un área
DELIMITER //
CREATE FUNCTION sueldo_promedio(p_id_area INT)
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(15,2);
    SELECT AVG(sueldo) INTO promedio
    FROM Personal
    WHERE id_area = p_id_area;
    RETURN IFNULL(promedio, 0);
END //
DELIMITER ;
-- Uso: SELECT sueldo_promedio(1);
-- 5 Cuenta cuántos vehículos están asignados a un empleado
DELIMITER //
CREATE FUNCTION vehiculospersonal(p_id_personal INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_vehiculos INT;
    SELECT COUNT(*) INTO total_vehiculos
    FROM Vehiculos
    WHERE id_personal = p_id_personal;
    RETURN total_vehiculos;
END //
DELIMITER ;
-- Uso: SELECT vehiculospersonal(1);
-- 6 Suma el presupuesto de todos los proyectos activos en una fecha dada
DELIMITER //
CREATE FUNCTION presupuestoactivos(p_fecha DATE)
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE totalpresupuesto DECIMAL(15,2);
    SELECT SUM(presupuesto) INTO totalpresupuesto
    FROM Proyectos
    WHERE p_fecha BETWEEN periodo_inicio AND periodo_fin;
    RETURN IFNULL(totalpresupuesto, 0);
END //
DELIMITER ;
-- Uso: SELECT presupuestoactivos('2025-03-15');

-- 7 Suma la capacidad de todos los alojamientos en un parque
DELIMITER //
CREATE FUNCTION capacidadalojamientos(p_id_parque INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalcapacidad INT;
    SELECT SUM(capacidad) INTO totalcapacidad
    FROM Alojamientos
    WHERE id_parque = p_id_parque;
    RETURN IFNULL(totalcapacidad, 0);
END //
DELIMITER ;
-- Uso: SELECT capacidadalojamientos(1);

-- 8 Cuenta cuántas entradas tiene un parque
DELIMITER //
CREATE FUNCTION entradasparque(p_id_parque INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalentradas INT;
    SELECT COUNT(*) INTO totalentradas
    FROM Entradas
    WHERE id_parque = p_id_parque;
    RETURN totalentradas;
END //
DELIMITER ;
-- Uso: SELECT entradasparque(1);

-- 9 Cuenta cuántos empleados están asignados a una entrada
DELIMITER //
CREATE FUNCTION personalentrada(p_id_entrada INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalpersonal INT;
    SELECT COUNT(*) INTO totalpersonal
    FROM Personal
    WHERE id_entrada = p_id_entrada;
    RETURN totalpersonal;
END //
DELIMITER ;
-- Uso: SELECT personalentrada(1);
-- 10 Cuenta cuántas especies están asociadas a un proyecto
DELIMITER //
CREATE FUNCTION especiesproyecto(p_id_proyecto INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalespecies INT;
    SELECT COUNT(*) INTO totalespecies
    FROM Proyectos_Especies
    WHERE id_proyecto = p_id_proyecto;
    RETURN totalespecies;
END //
DELIMITER ;
-- Uso: SELECT especiesproyecto(1);

-- 11 Cuenta cuántos investigadores están asignados a un proyecto
DELIMITER //
CREATE FUNCTION investigadoresproyecto(p_id_proyecto INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalinvestigadores INT;
    SELECT COUNT(*) INTO totalinvestigadores
    FROM Investigadores_Proyectos
    WHERE id_proyecto = p_id_proyecto;
    RETURN totalinvestigadores;
END //
DELIMITER ;
-- Uso: SELECT investigadoresproyecto(1);

-- 12 Devuelve el sueldo más alto de un tipo de personal
DELIMITER //
CREATE FUNCTION sueldomaximo(p_tipo VARCHAR(3))
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE maxsueldo DECIMAL(15,2);
    SELECT MAX(sueldo) INTO maxsueldo
    FROM Personal
    WHERE tipo = p_tipo;
    RETURN IFNULL(maxsueldo, 0);
END //
DELIMITER ;
-- Uso: SELECT sueldomaximo('001');

