
## Descripción del Proyecto
El proyecto "Gestión de Parques Naturales" es una base de datos diseñada para administrar la información relacionada con parques naturales, incluyendo entidades, departamentos, áreas, especies, personal, vehículos, proyectos, visitantes, alojamientos y reservas. Su objetivo es optimizar la gestión de recursos naturales, el seguimiento del personal, los proyectos de conservación y las visitas turísticas.
## Instalación y Configuración: Instrucciones Paso a Paso
A continuación, te detallo cómo configurar el entorno, cargar la base de datos y ejecutar los scripts SQL para el proyecto "Gestión de Parques Naturales". Estas instrucciones incluyen cómo ejecutar ddl.sql para generar la estructura, cargar datos con dml.sql, y trabajar con consultas, procedimientos almacenados, funciones, eventos
## Crear la Base de Datos
CREATE DATABASE parque;
## Selecciona la base de datos recién creada
USE parque;
## Abre el archivo ddl.sql en el editor.
## Selecciona todo el contenido y haz clic en "Ejecutar" (ícono de rayo).
## Ejecutar Consultas
Con la base de datos parque seleccionada (USE parque;), escribe o pega una consulta en el editor de tu cliente SQL
ejemplo : SELECT nombre, fecha_declaracion FROM Parques;
## Usa el comando CALL con el nombre del procedimiento y sus parámetros
ejemplo : CALL agregarparque(1, 'Parque Norte', '2025-01-01');
## Ejecutar Funciones
Usa SELECT con el nombre de la función y sus parámetros.
ejemplo : SELECT inventarioespecie(1);
## Consideraciones Finales:

Asegúrate de que los archivos SQL (ddl.sql, dml.sql, etc.) estén en el directorio correcto o ajusta las rutas si es necesario.
Si encuentras errores de permisos, verifica que el usuario MySQL tenga los privilegios adecuados (por ejemplo, GRANT ALL ON parque.* TO 'usuario'@'localhost';).
