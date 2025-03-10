USE parque;

-- 1. Listar todos los parques ordenados por nombre
SELECT P.nombre, P.fecha_declaracion
FROM Parques P
ORDER BY P.nombre;
-- 2. Parques declarados antes de 1980
SELECT nombre, fecha_declaracion
FROM Parques
WHERE fecha_declaracion < '1980-01-01'
ORDER BY fecha_declaracion;
-- 3. parques en el departamento de antioquia
SELECT p.nombre AS parque
FROM Parques p
JOIN Departamentos_Parques dp ON p.id_parque = dp.id_parque
WHERE dp.id_departamento = 1;
 -- 4. nombre de departamento con sus entidades encargadas
SELECT D.nombre AS Departamento,  E.nombre AS Entidad 
from Departamentos D
join Entidades E ON D.id_entidad = E.id_entidad;
-- 5. Numero de parques por departamento
SELECT D.nombre AS departamento, COUNT(DP.id_parque) AS Cantidad
FROM Departamentos D
LEFT JOIN Departamentos_Parques DP ON D.id_departamento = DP.id_departamento
GROUP BY D.id_departamento, D.nombre
ORDER BY Cantidad DESC;
-- 6. Parques sin alojamientos
SELECT P.nombre
FROM Parques P
LEFT JOIN Alojamientos A ON P.id_parque = A.id_parque
WHERE A.id_alojamiento IS NULL;
-- 7. Parques declarados en la decada de 1970
SELECT P.nombre, P.fecha_declaracion
FROM Parques P
WHERE fecha_declaracion BETWEEN '1970-01-01' AND '1979-12-31'
ORDER BY fecha_declaracion;

-- 8. Parques con áreas mayores a 2000
SELECT P.nombre AS parque, A.nombre AS area, A.extension
FROM Parques P
JOIN Areas A ON P.id_parque = A.id_parque
WHERE A.extension > 2000
ORDER BY A.extension DESC;
-- 9. Parques con personal asignado
SELECT DISTINCT P.nombre AS parque
FROM Parques P
JOIN Areas A ON P.id_parque = A.id_parque
JOIN Personal PE ON A.id_area = PE.id_area
ORDER BY P.nombre;
-- 10. parques mas antiguos
SELECT nombre, fecha_declaracion
FROM Parques
ORDER BY fecha_declaracion
LIMIT 5;
-- 11. Departamentos con sus respectivos parques 
SELECT D.nombre AS Departamento, P.nombre AS Parque
FROM Departamentos D
JOIN Departamentos_Parques DP ON DP.id_departamento = D.id_departamento 
JOIN Parques P ON DP.id_parque  = P.id_parque;
-- 12. parques en el departamento de santander
SELECT P.nombre AS parque
FROM Parques P
JOIN Departamentos_Parques DP ON P.id_parque = DP.id_parque
WHERE DP.id_departamento = 8;
-- 13. parques en el departamento de nariño
SELECT P.nombre AS parque
FROM Parques P
JOIN Departamentos_Parques DP ON P.id_parque = DP.id_parque
WHERE DP.id_departamento = 10;
-- 14. Parques declarados antes de 1990
SELECT nombre, fecha_declaracion
FROM Parques
WHERE fecha_declaracion < '1990-01-01'
ORDER BY fecha_declaracion;
-- 15. entidad del departamento de santander
SELECT D.nombre AS Departamento,  E.nombre AS Entidad 
from Departamentos D
join Entidades E ON D.id_entidad = E.id_entidad
WHERE D.nombre  = 'santander';
-- 16. entidad del departamento de nariño
SELECT D.nombre AS Departamento,  E.nombre AS Entidad 
from Departamentos D
join Entidades E ON D.id_entidad = E.id_entidad
WHERE D.nombre  = 'nariño';
-- 17. entidad del departamento de antioquia
SELECT D.nombre AS Departamento,  E.nombre AS Entidad 
from Departamentos D
join Entidades E ON D.id_entidad = E.id_entidad
WHERE D.nombre  = 'antioquia';
-- 18. Areas con especies animales
SELECT A.nombre AS area, COUNT(E.id_especie) AS numero
FROM Areas A
LEFT JOIN Especies E ON A.id_area = E.id_area
WHERE E.tipo = 'animal'
GROUP BY A.id_area, A.nombre
ORDER BY numero DESC;
-- 19. Areas con especies vegetales
SELECT A.nombre AS area, COUNT(E.id_especie) AS numero
FROM Areas A
LEFT JOIN Especies E ON A.id_area = E.id_area
WHERE E.tipo = 'vegetal'
GROUP BY A.id_area, A.nombre
ORDER BY numero DESC;
-- 20. Areas sin especies registradas
SELECT A.nombre AS area, P.nombre AS parque
FROM Areas A
LEFT JOIN Especies E ON A.id_area = E.id_area
JOIN Parques P ON A.id_parque = P.id_parque
WHERE E.id_especie IS NULL;
-- 21. Areas con más de 1000
SELECT P.nombre AS parque, A.nombre AS area, A.extension
FROM Parques P
JOIN Areas A ON P.id_parque = A.id_parque
WHERE A.extension > 1000
ORDER BY A.extension DESC;
-- 22. Especies vegetales por parque
SELECT P.nombre AS parque, COUNT(E.id_especie) AS Numero
FROM Parques P
JOIN Areas A ON P.id_parque = A.id_parque
JOIN Especies E ON A.id_area = E.id_area
WHERE E.tipo = 'vegetal'
GROUP BY P.id_parque, P.nombre
ORDER BY Numero DESC;
-- 23. Especies animales por parque
SELECT P.nombre AS parque, COUNT(E.id_especie) AS Numero
FROM Parques P
JOIN Areas A ON P.id_parque = A.id_parque
JOIN Especies E ON A.id_area = E.id_area
WHERE E.tipo = 'animal'
GROUP BY P.id_parque, P.nombre
ORDER BY Numero DESC;
-- 24. Especies minerales por parque
SELECT P.nombre AS parque, COUNT(E.id_especie) AS Numero
FROM Parques P
JOIN Areas A ON P.id_parque = A.id_parque
JOIN Especies E ON A.id_area = E.id_area
WHERE E.tipo = 'mineral'
GROUP BY P.id_parque, P.nombre
ORDER BY Numero DESC;
-- 25. Áreas con minerales
SELECT A.nombre AS area, E.denominacion_vulgar AS mineral
FROM Areas A
JOIN Especies E ON A.id_area = E.id_area
WHERE E.tipo = 'mineral'
ORDER BY A.nombre;
-- 26. Áreas con animales
SELECT A.nombre AS area, E.denominacion_vulgar AS mineral
FROM Areas A
JOIN Especies E ON A.id_area = E.id_area
WHERE E.tipo = 'animal'
ORDER BY A.nombre;
-- 27. areas con especies en peligro
SELECT A.nombre AS area, E.denominacion_vulgar AS especie, E.numero_inventario
FROM Areas A
JOIN Especies E ON A.id_area = E.id_area
WHERE E.numero_inventario < 20
ORDER BY E.numero_inventario;
-- 28. Parques con más especies
SELECT P.nombre AS parque, COUNT(E.id_especie) AS numero
FROM Parques P
JOIN Areas A ON P.id_parque = A.id_parque
JOIN Especies E ON A.id_area = E.id_area
GROUP BY P.id_parque, P.nombre
ORDER BY numero DESC
LIMIT 5;
-- 29 reservas por alojamiento 
SELECT A.nombre AS alojamiento, COUNT(R.id_reserva) AS numero
FROM alojamientos A
LEFT JOIN Reservas R ON A.id_alojamiento = R.id_alojamiento
GROUP BY A.id_alojamiento, A.nombre
ORDER BY numero DESC;
-- 30 Visitantes con reservas en 2025
SELECT V.nombre, COUNT(R.id_reserva) AS numero
FROM Visitantes V
JOIN Reservas R ON V.id_visitante = R.id_visitante
WHERE R.fecha_inicio LIKE '2025%'
GROUP BY V.id_visitante, V.nombre
ORDER BY numero DESC;
-- 31 Reservas por alojamiento
SELECT A.nombre AS alojamiento, COUNT(R.id_reserva) AS numero
FROM Alojamientos A
LEFT JOIN Reservas R ON A.id_alojamiento = R.id_alojamiento
GROUP BY A.id_alojamiento, A.nombre
ORDER BY numero DESC;
-- 32 Visitantes por profesión
SELECT V.profesion, COUNT(*) AS cantidad
FROM Visitantes V
GROUP BY profesion
ORDER BY cantidad DESC;
-- 33. Visitantes biólogos con reservas
SELECT V.nombre, A.nombre AS alojamiento
FROM Visitantes V
JOIN Reservas R ON V.id_visitante = R.id_visitante
JOIN Alojamientos A ON R.id_alojamiento = A.id_alojamiento
WHERE V.profesion = 'Biólogo'
ORDER BY V.nombre;
-- 34. Visitantes turistas con reservas
SELECT V.nombre, A.nombre AS alojamiento
FROM Visitantes V
JOIN Reservas R ON V.id_visitante = R.id_visitante
JOIN Alojamientos A ON R.id_alojamiento = A.id_alojamiento
WHERE V.profesion = 'turistas'
ORDER BY V.nombre;
-- 35. Visitantes fotógrafos con reservas
SELECT V.nombre, A.nombre AS alojamiento
FROM Visitantes V
JOIN Reservas R ON V.id_visitante = R.id_visitante
JOIN Alojamientos A ON R.id_alojamiento = A.id_alojamiento
WHERE V.profesion = 'Fotógrafa'
ORDER BY V.nombre;
-- 36. Visitantes que van por turismo 
SELECT V.nombre
FROM Visitantes V
WHERE V.profesion = 'Turista';
-- 37. Visitantes que son ecologistas 
SELECT V.nombre
FROM Visitantes V
WHERE V.profesion = 'Ecologista';
-- 37. Visitantes que son ingenieros 
SELECT V.nombre
FROM Visitantes V
WHERE V.profesion = 'Ingeniero';
-- 38. Visitantes sin reservas
SELECT V.nombre, V.profesion
FROM Visitantes V
LEFT JOIN Reservas R ON V.id_visitante = R.id_visitante
WHERE R.id_reserva IS NULL
ORDER BY V.nombre;
-- 39. Alojamientos más reservados
SELECT A.nombre AS alojamiento, P.nombre AS parque, COUNT(R.id_reserva) AS numero
FROM Alojamientos A
JOIN Parques P ON A.id_parque = P.id_parque
LEFT JOIN Reservas R ON A.id_alojamiento = R.id_alojamiento
GROUP BY A.id_alojamiento, A.nombre, P.nombre
ORDER BY numero DESC
LIMIT 5;
-- 40. Duración total de reservas por visitante
SELECT V.nombre, SUM(DATEDIFF(R.fecha_fin, R.fecha_inicio)) AS dias
FROM Visitantes V
JOIN Reservas R ON V.id_visitante = R.id_visitante
GROUP BY V.id_visitante, V.nombre
ORDER BY dias DESC;
-- 41. Proyectos finalizados antes de 2025
SELECT nombre, periodo_fin
FROM Proyectos P
WHERE P.periodo_fin < '2025-01-01'
ORDER BY periodo_fin;
-- 42. Los tres investigadores con más proyectos
SELECT PER.nombre AS investigador, COUNT(IP.id_proyecto) AS numero
FROM Personal PER
JOIN Investigadores_Proyectos IP ON PER.id_personal = IP.id_personal
GROUP BY PER.id_personal, PER.nombre
ORDER BY numero DESC 
LIMIT 3;
-- 43. Los tres investigadores con menos proyectos
SELECT PER.nombre AS investigador, COUNT(IP.id_proyecto) AS numero
FROM Personal PER
JOIN Investigadores_Proyectos IP ON PER.id_personal = IP.id_personal
GROUP BY PER.id_personal, PER.nombre
ORDER BY numero ASC
LIMIT 3;
-- 44. Proyectos con presupuesto mayor a 30 millones
SELECT nombre, presupuesto
FROM Proyectos P
WHERE P.presupuesto > 30000000
ORDER BY presupuesto DESC;
-- 45. Proyectos con mayor presupuesto
SELECT nombre, presupuesto
FROM Proyectos P
ORDER BY presupuesto DESC
LIMIT 3;
-- 46. Proyectos con menor presupuesto
SELECT nombre, presupuesto
FROM Proyectos P
ORDER BY presupuesto ASC
LIMIT 4;
-- 47. Proyectos con un presupuesto igual a 18.000.000
SELECT nombre, presupuesto
FROM Proyectos P
WHERE P.presupuesto = 18000000;
-- 48. Duración promedio de proyectos
SELECT AVG(DATEDIFF(P.periodo_fin, P.periodo_inicio)) AS promedio 
FROM Proyectos P;
-- 49. Proyecto sin especie asociada 
SELECT P.nombre
FROM Proyectos P
LEFT JOIN Proyectos_Especies PE ON P.id_proyecto = PE.id_proyecto
WHERE PE.id_especie IS NULL;
-- 50. Presupuesto total por investigador
SELECT PER.nombre AS investigador, SUM(P.presupuesto) AS presupuesto_total
FROM Personal PER
JOIN Investigadores_Proyectos IP ON PER.id_personal = IP.id_personal
JOIN Proyectos P ON IP.id_proyecto = P.id_proyecto
GROUP BY PER.id_personal, PER.nombre
ORDER BY presupuesto_total DESC;
-- 51. Investigador con menos presupuesto 
SELECT PER.nombre AS investigador, SUM(P.presupuesto) AS presupuesto_total
FROM Personal PER
JOIN Investigadores_Proyectos IP ON PER.id_personal = IP.id_personal
JOIN Proyectos P ON IP.id_proyecto = P.id_proyecto
GROUP BY PER.id_personal, PER.nombre
ORDER BY presupuesto_total ASC
LIMIT 1;
-- 52. Proyectos activos en marzo 2025
SELECT P.nombre, P.periodo_inicio, P.periodo_fin
FROM Proyectos P
WHERE '2025-03-01' BETWEEN P.periodo_inicio AND P.periodo_fin
ORDER BY P.periodo_fin;
-- 53. Personal más antiguo por tipo
SELECT tipo, MIN(id_personal) AS menor, nombre
FROM Personal P
GROUP BY tipo, P.nombre
ORDER BY tipo;
-- 54. Vehículos de camionetas
SELECT P.nombre AS personal, V.marca
FROM Personal P
JOIN Vehiculos V ON P.id_personal = V.id_personal
WHERE V.tipo = 'Camioneta';
-- 55. Vehículos de motos
SELECT P.nombre AS personal, V.marca
FROM Personal P
JOIN Vehiculos V ON P.id_personal = V.id_personal
WHERE V.tipo = 'Moto'; 
-- 56. Vehículos de marca Jeep
SELECT P.nombre AS personal, V.marca
FROM Personal P
JOIN Vehiculos V ON P.id_personal = V.id_personal
WHERE V.marca = 'Jeep'; 
-- 57. Motos de marca KTM (nota: cambiaste de "Jeep" a "KTM" en el comentario)
SELECT P.nombre AS personal, V.marca
FROM Personal P
JOIN Vehiculos V ON P.id_personal = V.id_personal
WHERE V.marca = 'KTM'; 
-- 58. Sueldo de personal
SELECT P.nombre, P.sueldo, P.tipo
FROM Personal P
ORDER BY P.sueldo DESC;
-- 59. Personal con sueldo mayor a 2.000.000
SELECT P.nombre, P.sueldo, P.tipo
FROM Personal P
WHERE P.sueldo > 2000000.00
ORDER BY P.sueldo DESC;
-- 60. Empleado con el mayor sueldo 
SELECT P.nombre, P.sueldo, P.tipo
FROM Personal P
ORDER BY P.sueldo DESC
LIMIT 1;
-- 61. Empleado con el menor sueldo
SELECT P.nombre, P.sueldo, P.tipo
FROM Personal P
ORDER BY P.sueldo ASC
LIMIT 1;
-- 62. Personal asignado a entradas 
SELECT P.nombre AS personal, E.numero AS entrada
FROM Personal P
JOIN Entradas E ON P.id_entrada = E.id_entrada
ORDER BY E.numero;
-- 63. Vehículos por personal de vigilancia
SELECT P.nombre AS personal, COUNT(V.id_vehiculo) AS numero
FROM Personal P
LEFT JOIN Vehiculos V ON P.id_personal = V.id_personal
WHERE P.tipo = '002'
GROUP BY P.id_personal, P.nombre
ORDER BY numero DESC;
-- 64. Personal con especialidad
SELECT P.nombre, P.especialidad, P.sueldo
FROM Personal P
WHERE P.especialidad IS NOT NULL
ORDER BY P.sueldo DESC;
-- 65. Total de sueldos por equipo de trabajo
SELECT P.tipo, SUM(P.sueldo) AS sueldo_total
FROM Personal P
GROUP BY P.tipo
ORDER BY sueldo_total DESC;
-- 66. Cuanto personal hay por tipo de tareas 
SELECT P.tipo, COUNT(*) AS cantidad
FROM Personal P
GROUP BY P.tipo
ORDER BY cantidad DESC;
-- 67. Reservas con mayor días
SELECT V.nombre AS visitante, A.nombre AS alojamiento, DATEDIFF(R.fecha_fin, R.fecha_inicio) AS dias
FROM Visitantes V
JOIN Reservas R ON V.id_visitante = R.id_visitante
JOIN Alojamientos A ON R.id_alojamiento = A.id_alojamiento
ORDER BY dias DESC
LIMIT 5;
-- 68. Personal que cuida vehículos y también tiene proyectos
SELECT DISTINCT PER.nombre AS personal, V.marca AS vehiculo, PR.nombre AS proyecto
FROM Personal PER
LEFT JOIN Vehiculos V ON PER.id_personal = V.id_personal
JOIN Investigadores_Proyectos IP ON PER.id_personal = IP.id_personal
JOIN Proyectos PR ON IP.id_proyecto = PR.id_proyecto
ORDER BY PER.nombre;
-- 69. Visitantes con reservas en parques con especies vegetales
SELECT DISTINCT V.nombre AS visitante, P.nombre AS parque, E.tipo
FROM Visitantes V
JOIN Reservas R ON V.id_visitante = R.id_visitante
JOIN Alojamientos A ON R.id_alojamiento = A.id_alojamiento
JOIN Parques P ON A.id_parque = P.id_parque
JOIN Areas AR ON P.id_parque = AR.id_parque
JOIN Especies E ON AR.id_area = E.id_area
WHERE E.tipo = 'vegetal'
ORDER BY V.nombre;
-- 70. Visitantes con reservas en parques con especies animales
SELECT DISTINCT V.nombre AS visitante, P.nombre AS parque, E.tipo
FROM Visitantes V
JOIN Reservas R ON V.id_visitante = R.id_visitante
JOIN Alojamientos A ON R.id_alojamiento = A.id_alojamiento
JOIN Parques P ON A.id_parque = P.id_parque
JOIN Areas AR ON P.id_parque = AR.id_parque
JOIN Especies E ON AR.id_area = E.id_area
WHERE E.tipo = 'animal'
ORDER BY V.nombre;
-- 71. Visitantes con reservas en parques con especies minerales
SELECT DISTINCT V.nombre AS visitante, P.nombre AS parque, E.tipo
FROM Visitantes V
JOIN Reservas R ON V.id_visitante = R.id_visitante
JOIN Alojamientos A ON R.id_alojamiento = A.id_alojamiento
JOIN Parques P ON A.id_parque = P.id_parque
JOIN Areas AR ON P.id_parque = AR.id_parque
JOIN Especies E ON AR.id_area = E.id_area
WHERE E.tipo = 'mineral'
ORDER BY V.nombre;
-- 72. Parques con personal y alojamientos 
SELECT P.nombre AS parque, COUNT(PER.id_personal) AS numeropersonal, COUNT(A.id_alojamiento) AS numeroalojamientos
FROM Parques P
LEFT JOIN Areas AR ON P.id_parque = AR.id_parque
LEFT JOIN Personal PER ON AR.id_area = PER.id_area
LEFT JOIN Alojamientos A ON P.id_parque = A.id_parque
GROUP BY P.id_parque, P.nombre
ORDER BY numeropersonal DESC, numeroalojamientos DESC;
-- 73. Parque sin personal y sin alojamientos 
SELECT P.nombre AS parque, COUNT(PER.id_personal) AS numeropersonal, COUNT(A.id_alojamiento) AS numeroalojamientos
FROM Parques P
LEFT JOIN Areas AR ON P.id_parque = AR.id_parque
LEFT JOIN Personal PER ON AR.id_area = PER.id_area
LEFT JOIN Alojamientos A ON P.id_parque = A.id_parque
GROUP BY P.id_parque, P.nombre
HAVING COUNT(PER.id_personal) = 0;
-- 74. Parques con más reservas y personal
SELECT P.nombre AS parque, COUNT(R.id_reserva) AS numeroreservas, COUNT(PER.id_personal) AS numeropersonal
FROM Parques P
LEFT JOIN Alojamientos A ON P.id_parque = A.id_parque
LEFT JOIN Reservas R ON A.id_alojamiento = R.id_alojamiento
LEFT JOIN Areas AR ON P.id_parque = AR.id_parque
LEFT JOIN Personal PER ON AR.id_area = PER.id_area
GROUP BY P.id_parque, P.nombre
ORDER BY numeroreservas DESC, numeropersonal DESC;
-- 75. Parques con especies y alojamientos ecológicos
SELECT P.nombre AS parque, COUNT(E.id_especie) AS num_especies, COUNT(AL.id_alojamiento) AS num_alojamientos
FROM Parques P
LEFT JOIN Areas A ON P.id_parque = A.id_parque
LEFT JOIN Especies E ON A.id_area = E.id_area
LEFT JOIN Alojamientos AL ON P.id_parque = AL.id_parque
WHERE AL.categoria = 'Ecológica'
GROUP BY P.id_parque, P.nombre
ORDER BY num_especies DESC;
-- 76. Personal con sueldo mayor al promedio de su tipo
SELECT P1.nombre, P1.sueldo, P1.tipo
FROM Personal P1
WHERE P1.sueldo > (SELECT AVG(sueldo)
                   FROM Personal P2
                   WHERE P2.tipo = P1.tipo)
ORDER BY P1.sueldo DESC;
-- 77. Proyectos con presupuesto mayor al promedio
SELECT P.nombre, P.presupuesto
FROM Proyectos P
WHERE P.presupuesto > (SELECT AVG(presupuesto) FROM Proyectos)
ORDER BY P.presupuesto DESC;
-- 78. Parques con alojamientos más grandes que el promedio
SELECT P.nombre AS parque, A.nombre AS alojamiento, A.capacidad
FROM Parques P
JOIN Alojamientos A ON P.id_parque = A.id_parque
WHERE A.capacidad > (SELECT AVG(capacidad) FROM Alojamientos)
ORDER BY A.capacidad DESC;
-- 79. Especies con inventario mayor al promedio por tipo
SELECT E.denominacion_vulgar, E.numero_inventario, E.tipo
FROM Especies E
WHERE E.numero_inventario > (SELECT AVG(numero_inventario)
                             FROM Especies E2
                             WHERE E2.tipo = E.tipo)
ORDER BY E.numero_inventario DESC;
-- 80. Número total de reservas por mes
SELECT MONTH(R.fecha_inicio) AS mes, COUNT(*) AS num_reservas
FROM Reservas R
GROUP BY MONTH(R.fecha_inicio)
ORDER BY mes;
-- 81. Descripción de tipo de especie
SELECT E.tipo, COUNT(*) AS cantidad, SUM(E.numero_inventario) AS total_individuos
FROM Especies E
GROUP BY E.tipo
ORDER BY cantidad DESC;
-- 82. Sueldo promedio por especialidad
SELECT P.especialidad, AVG(P.sueldo) AS sueldo_promedio
FROM Personal P
WHERE P.especialidad IS NOT NULL
GROUP BY P.especialidad
ORDER BY sueldo_promedio DESC;
-- 83. Capacidad de alojamientos
SELECT P.nombre AS parque, SUM(A.capacidad) AS capacidad_total
FROM Parques P
LEFT JOIN Alojamientos A ON P.id_parque = A.id_parque
GROUP BY P.id_parque, P.nombre
ORDER BY capacidad_total DESC;
-- 84. Duración de los proyectos
SELECT P.nombre, DATEDIFF(P.periodo_fin, P.periodo_inicio) AS duracion
FROM Proyectos P
ORDER BY duracion DESC;
-- 85. Proyecto que más dura
SELECT P.nombre, DATEDIFF(P.periodo_fin, P.periodo_inicio) AS duracion
FROM Proyectos P
ORDER BY duracion DESC
LIMIT 1;
-- 86. Proyecto que menos dura
SELECT P.nombre, DATEDIFF(P.periodo_fin, P.periodo_inicio) AS duracion
FROM Proyectos P
ORDER BY duracion ASC
LIMIT 1;
-- 87 cantidad de vehiculos por marca 
SELECT marca, COUNT(*) AS cantidad
FROM Vehiculos
GROUP BY marca
ORDER BY cantidad DESC;
-- 88 cantidad de vehiculos por tipo
SELECT tipo, COUNT(*) AS cantidad
FROM Vehiculos
GROUP BY tipo
ORDER BY cantidad DESC;
-- 87 cantidad de vehiculos por marca 
SELECT SUM(cantidad) AS total_vehiculos
FROM (
    SELECT COUNT(*) AS cantidad
    FROM Vehiculos
    GROUP BY marca
) AS subquery;
-- 88 parques con mayores reservas
SELECT P.nombre AS parque, COUNT(R.id_reserva) AS num_reservas
FROM Parques P
JOIN Alojamientos A ON P.id_parque = A.id_parque
JOIN Reservas R ON A.id_alojamiento = R.id_alojamiento
GROUP BY P.id_parque, P.nombre
ORDER BY num_reservas DESC
LIMIT 5;
-- 89 Personal por ciudad
SELECT SUBSTRING_INDEX(direccion, ',', -1) AS ciudad, COUNT(*) AS num_personal
FROM Personal
GROUP BY ciudad
ORDER BY num_personal DESC;
-- 90 Inversión total en proyectos por año
SELECT YEAR(periodo_inicio) AS año, SUM(presupuesto) AS inversion_total
FROM Proyectos
GROUP BY YEAR(periodo_inicio)
ORDER BY año;
-- 91 Lista los 5 proyectos con más investigadores asignados
SELECT P.id_proyecto, P.nombre, COUNT(IP.id_personal) AS numero
FROM Proyectos P
JOIN Investigadores_Proyectos IP ON P.id_proyecto = IP.id_proyecto
GROUP BY P.id_proyecto, P.nombre
ORDER BY numero DESC
LIMIT 5;
-- 92. 3 áreas con más tipos diferentes de especies
SELECT A.id_area, A.nombre, COUNT(DISTINCT E.tipo) AS tipos_especies
FROM Areas A
JOIN Especies E ON A.id_area = E.id_area
GROUP BY A.id_area, A.nombre
ORDER BY tipos_especies DESC
LIMIT 3;
-- 93 Muestra personal de Gestión
SELECT nombre, sueldo
FROM Personal
WHERE tipo = '001'
ORDER BY sueldo DESC;
-- 94 Muestra Personal Investigador
SELECT nombre, sueldo
FROM Personal
WHERE tipo = '004'
ORDER BY sueldo DESC;
-- 95 muestra los alojamientos para mas de 5 personas
SELECT nombre, capacidad
FROM Alojamientos
WHERE capacidad > 5
ORDER BY capacidad ASC;
-- 96 nombre de visitantes que comiencen por M
SELECT id_visitante, nombre
FROM Visitantes
WHERE nombre LIKE 'M%'
ORDER BY nombre;
-- 97 nombre de visitantes que comiencen por C
SELECT id_visitante, nombre
FROM Visitantes
WHERE nombre LIKE 'C%'
ORDER BY nombre;
-- 98 muestra las entradas del parque tayrona 
SELECT numero
FROM Entradas
WHERE id_parque = 1
ORDER BY numero;
-- 99 muestra las entradas del parque la playa
SELECT numero
FROM Entradas
WHERE id_parque = 16
ORDER BY numero;
-- 100 mostrar lo vehiculos motos 
SELECT marca, id_personal
FROM Vehiculos
WHERE tipo = 'Moto'
ORDER BY marca;









