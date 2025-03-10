
create database parque;
use parque;
CREATE TABLE Entidades (
    id_entidad INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Departamentos (
    id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_entidad INT,
    FOREIGN KEY (id_entidad) REFERENCES Entidades(id_entidad)
);


CREATE TABLE Parques (
    id_parque INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    fecha_declaracion DATE NOT NULL
);


CREATE TABLE Departamentos_Parques (
    id_departamento INT,
    id_parque INT,
    PRIMARY KEY (id_departamento, id_parque),
    FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento),
    FOREIGN KEY (id_parque) REFERENCES Parques(id_parque)
);


CREATE TABLE Areas (
    id_area INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    extension DECIMAL(10,2) NOT NULL,
    id_parque INT,
    FOREIGN KEY (id_parque) REFERENCES Parques(id_parque)
);


CREATE TABLE Especies (
    id_especie INT PRIMARY KEY AUTO_INCREMENT,
    denominacion_cientifica VARCHAR(100) NOT NULL,
    denominacion_vulgar VARCHAR(100),
    tipo ENUM('vegetal', 'animal', 'mineral') NOT NULL,
    numero_inventario INT NOT NULL,
    id_area INT,
    FOREIGN KEY (id_area) REFERENCES Areas(id_area)
);


CREATE TABLE Entradas (
    id_entrada INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(20) NOT NULL,
    id_parque INT,
    FOREIGN KEY (id_parque) REFERENCES Parques(id_parque)
);


CREATE TABLE Personal (
    id_personal INT PRIMARY KEY AUTO_INCREMENT,
    cedula VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(15),
    movil VARCHAR(15),
    sueldo DECIMAL(10,2) NOT NULL,
    tipo ENUM('001', '002', '003', '004') NOT NULL,
    id_area INT NULL,
    id_entrada INT NULL,
    especialidad VARCHAR(50) NULL,
    FOREIGN KEY (id_area) REFERENCES Areas(id_area),
    FOREIGN KEY (id_entrada) REFERENCES Entradas(id_entrada)
);


CREATE TABLE Vehiculos (
    id_vehiculo INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    id_personal INT,
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal)
);


CREATE TABLE Proyectos (
    id_proyecto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    presupuesto DECIMAL(15,2) NOT NULL,
    periodo_inicio DATE NOT NULL,
    periodo_fin DATE NOT NULL
);


CREATE TABLE Investigadores_Proyectos (
    id_personal INT,
    id_proyecto INT,
    PRIMARY KEY (id_personal, id_proyecto),
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal),
    FOREIGN KEY (id_proyecto) REFERENCES Proyectos(id_proyecto)
);


CREATE TABLE Proyectos_Especies (
    id_proyecto INT,
    id_especie INT,
    PRIMARY KEY (id_proyecto, id_especie),
    FOREIGN KEY (id_proyecto) REFERENCES Proyectos(id_proyecto),
    FOREIGN KEY (id_especie) REFERENCES Especies(id_especie)
);


CREATE TABLE Visitantes (
    id_visitante INT PRIMARY KEY AUTO_INCREMENT,
    cedula VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    profesion VARCHAR(50)
);

-- Crear tabla Alojamientos
CREATE TABLE Alojamientos (
    id_alojamiento INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    id_parque INT,
    FOREIGN KEY (id_parque) REFERENCES Parques(id_parque)
);

-- Crear tabla Reservas
CREATE TABLE Reservas (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_visitante INT,
    id_alojamiento INT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    FOREIGN KEY (id_visitante) REFERENCES Visitantes(id_visitante),
    FOREIGN KEY (id_alojamiento) REFERENCES Alojamientos(id_alojamiento)
);

