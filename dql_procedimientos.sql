use parque;
-- 1 Inserta un nuevo parque en la tabla Parques
DELIMITER //
CREATE PROCEDURE agregarparque (
    IN p_id_parque INT,
    IN p_nombre VARCHAR(100),
    IN p_fecha_declaracion Date
)
BEGIN
    INSERT INTO Parques (id_parque, nombre, fecha_declaracion)
    VALUES (p_id_parque, p_nombre, p_fecha_declaracion);
END //
DELIMITER ;
-- Uso: CALL agregarparque(1, 'Parque Norte', '1990-03-05'); 

-- 2 Borra un parque por su ID
DELIMITER //
CREATE PROCEDURE eliminarparque (
    IN p_id_parque INT
)
BEGIN
    DELETE FROM Parques
    WHERE id_parque = p_id_parque;
END //

-- 2 Inserta una nueva especie en la tabla Especies
DELIMITER //

CREATE PROCEDURE agregarespecie (
    IN p_denominacion_cientifica VARCHAR(100),
    IN p_denominacion_vulgar VARCHAR(100),
    IN p_tipo ENUM('vegetal', 'animal', 'mineral'),
    IN p_inventario INT,
    IN p_id_area INT
)
BEGIN
    INSERT INTO Especies (denominacion_cientifica, denominacion_vulgar, tipo, numero_inventario, id_area)
    VALUES (p_denominacion_cientifica, p_denominacion_vulgar, p_tipo, p_inventario, p_id_area);
END //

DELIMITER ;
-- USO CALL agregarespecie('Panthera onca', 'Jaguar', 'animal', 20, 1);
-- 3 Inserta un nuevo empleado en la tabla Personal
DELIMITER //

CREATE PROCEDURE sp_agregar_personal (
    IN p_cedula VARCHAR(20),
    IN p_nombre VARCHAR(100),
    IN p_direccion VARCHAR(200),
    IN p_telefono VARCHAR(15),
    IN p_movil VARCHAR(15),
    IN p_sueldo DECIMAL(10,2),
    IN p_tipo ENUM('001', '002', '003', '004'),
    IN p_id_area INT,
    IN p_id_entrada INT,
    IN p_especialidad VARCHAR(50)
)
BEGIN
    -- Verificar que la cédula no exista
    IF (SELECT COUNT(*) FROM Personal WHERE cedula = p_cedula) > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La cédula ya está registrada.';
    ELSE
        -- Insertar el nuevo personal
        INSERT INTO Personal (cedula, nombre, direccion, telefono, movil, sueldo, tipo, id_area, id_entrada, especialidad)
        VALUES (p_cedula, p_nombre, p_direccion, p_telefono, p_movil, p_sueldo, p_tipo, p_id_area, p_id_entrada, p_especialidad);
    END IF;
END //

DELIMITER ;
-- 4 Inserta un nuevo empleado en la tabla Personal
DELIMITER //
CREATE PROCEDURE agregarpersonal (
    IN p_id_personal INT,
    IN p_cedula VARCHAR(20),
    IN p_nombre VARCHAR(100),
    IN p_sueldo DECIMAL(10,2),
    IN p_tipo ENUM('001', '002', '003', '004')
)
BEGIN
    INSERT INTO Personal (id_personal, cedula, nombre, sueldo, tipo)
    VALUES (p_id_personal, p_cedula, p_nombre, p_sueldo, p_tipo);
END //
DELIMITER
-- USO CALL agregarpersonal(52, '123422378', 'Juan Pérez', 1200.50, '001');
-- 5 cambiar sueldo 
DELIMITER //
CREATE PROCEDURE actualizarsueldo (
    IN p_id_personal INT,
    IN p_nuevo_sueldo DECIMAL(10,2)
)
BEGIN
    UPDATE Personal
    SET sueldo = p_nuevo_sueldo
    WHERE id_personal = p_id_personal;
END //
DELIMITER ;
-- uso CALL actualizarsueldo(1, 1500.75);
-- 6. reducir presupuesto
DELIMITER //
CREATE PROCEDURE reducirpresupuesto (
    IN p_id_proyecto INT
)
BEGIN
    UPDATE Proyectos
    SET presupuesto = presupuesto * 0.95
    WHERE id_proyecto = p_id_proyecto;
END //
DELIMITER ;
-- Uso: CALL reducirpresupuesto(1);
-- 7 insertar alojamiento 
DELIMITER //
CREATE PROCEDURE agregaralojamiento (
    IN p_id_alojamiento INT,
    IN p_nombre VARCHAR(100),
    IN p_capacidad INT,
    IN p_categoria VARCHAR(50)
)
BEGIN
    INSERT INTO Alojamientos (id_alojamiento, nombre, capacidad, categoria)
    VALUES (p_id_alojamiento, p_nombre, p_capacidad, p_categoria);
END //
DELIMITER ;
-- uso: CALL sp_agregar_alojamiento(1, 'Cabaña Sol', 5, 'Ecológica');
-- 8. cambia la capacidad de alojamientos 
DELIMITER //
CREATE PROCEDURE actualizarcapacidad (
    IN p_id_alojamiento INT,
    IN p_nueva_capacidad INT
)
BEGIN
    UPDATE Alojamientos
    SET capacidad = p_nueva_capacidad
    WHERE id_alojamiento = p_id_alojamiento;
END //
DELIMITER ;
-- uso CALL actualizarcapacidad(1, 8);
-- 9 Inserta un nuevo visitante en la tabla Visitantes

DELIMITER //
CREATE PROCEDURE agregarvisitante (
    IN p_id_visitante INT,
    IN p_cedula VARCHAR(20),
    IN p_nombre VARCHAR(100)
)
BEGIN
    INSERT INTO Visitantes (id_visitante, cedula, nombre)
    VALUES (p_id_visitante, p_cedula, p_nombre);
END //
DELIMITER ;
-- Uso: CALL agregarvisitante(1, '98765432', 'María Gómez');
-- 10 Cambia el nombre de un visitante
DELIMITER //
CREATE PROCEDURE actualizarnombre (
    IN p_id_visitante INT,
    IN p_nuevo_nombre VARCHAR(100)
)
BEGIN
    UPDATE Visitantes
    SET nombre = p_nuevo_nombre
    WHERE id_visitante = p_id_visitante;
END //
DELIMITER ;
-- Uso: CALL actualizarnombre(1, 'María López');










