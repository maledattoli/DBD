/* Banda = (-codigoB-, nombreBanda, genero_musical, anio_creacion)
Integrante = (-DNI-, nombre, apellido, dirección, email, fecha_nacimiento, codigoB(fk))
Escenario = (-nroEscenario-, nombre_escenario, ubicación, cubierto, m2, descripción)
Recital = (-fecha, hora, nroEscenario (fk)-, codigoB (fk))
*/
/* 1. Listar DNI, nombre, apellido,dirección y email de integrantes nacidos entre 1980 y 1990 y que
hayan realizado algún recital durante 2023.
*/
(select i.dni, i.nombre, i.apellido, i.direccion, i.email
from Integrante i 
where i.fecha_nacimiento Between '1980-01-01' AND '1990-12-31')
intersect
(Select i.dni, i.nombre, i.apellido, i.direccion, i.email
from Integrante i inner JOIN Banda b on (i.codigoB = b.codigoB)
inner join Recital r on (b.codigoB = r.codigoB)
where r.fecha Between '2023-01-01' AND '2023-12-31' )
/* 2. Reportar nombre, género musical y año de creación de bandas que hayan realizado recitales
durante 2023, pero no hayan tocado durante 2022 .
*/
(select b.nombreBanda, b.genero_musical, b.anio_creacion
from Banda b inner Join Recital r on (b.codigoB =r.codigoB)
where r.fecha BETWEEN '2023-01-01'AND '2023-12-31' )
except 
(select b.nombreBanda, b.genero_musical, b.anio_creacion
from Banda b inner Join Recital r on (b.codigoB =r.codigoB)
where r.fecha BETWEEN '2022-01-01'AND '2022-12-31')
/* 3. Listar el cronograma de recitales del día 04/12/2023. Se deberá listar nombre de la banda que
ejecutará el recital, fecha, hora, y el nombre y ubicación del escenario correspondiente.*/
(select b.nombreBanda, r.fecha, r.hora, e.nombre_escenario, e.ubicacion
from Escenario e inner join Recital r on (e.nroEscenario = r.nroEscenario)
inner join Banda b on (r.codigoB = b.codigoB)
where r.fecha = '2023-12-04')
order by r.hora /*----> x las moscas ?*/
/* 4. Listar DNI, nombre, apellido,email de integrantes que hayan tocado en el escenario con nombre
‘Gustavo Cerati’ y en el escenario con nombre ‘Carlos Gardel’*/
(select i.dni,i.nombre, i.apellido, i.email
from Integrante i /* integrante xq es lo que me pide el resultado */
inner Join Banda b on (i.codigoB = b.codigoB)
inner join Recital r on (b.codigoB = r.codigoB)
inner join Escenario e on (r.nroEscenario = e.nroEscenario)
where e.nombre_escenario = 'Gustavo Cerati')
intersect
(select i.dni,i.nombre, i.apellido, i.email
from Integrante i 
inner Join Banda b on (i.codigoB = b.codigoB)
inner join Recital r on (b.codigoB = r.codigoB)
inner join Escenario e on (r.nroEscenario = e.nroEscenario)
where e.nombre_escenario = 'Carlos Gardel')
/* 5. Reportar nombre, género musical y año de creación de bandas que tengan más de 5 integrantes.
*/
select b.nombreBanda, b.genero_musical, b.anio_creacion
from Banda b inner join Integrante i on (b.codigoB = i.codigoB)
group by b.codigoB, b.nombreBanda, b.genero_musical, b.anio_creacion
having count(b.codigoB) > 5
/*6. Listar nombre de escenario, ubicación y descripción de escenarios que solo tuvieron recitales
con el género musical rock and roll. Ordenar por nombre de escenario
 */
(select e.nombre_escenario, e.ubicacion, e.descripcion
from Banda b inner join Recital r on (b.codigoB = r.codigoB)
inner JOIN Escenario e on (r.nroEscenario = e.nroEscenario)
where b.genero_musical = 'rock and roll')
Except 
(select e.nombre_escenario, e.ubicacion, e.descripcion
from Banda b inner join Recital r on (b.codigoB = r.codigoB)
inner JOIN Escenario e on (r.nroEscenario = e.nroEscenario)
where b.genero_musical <> 'rock and roll')
order by e.nombre_escenario         /*si agarro todo solo pongo el nombre de la cplumna final sino asi????? */
/*7. Listar nombre, género musical y año de creación de bandas que hayan realizado recitales en
escenarios cubiertos durante 2023.// cubierto es true, false según corresponda */
select /*en 2023 */
intersect
select /* cubierto*/
/*8. Reportar para cada escenario, nombre del escenario y cantidad de recitales durante 2024. */
/* 9. Modificar el nombre de la banda ‘Mempis la Blusera’ a: ‘Memphis la Blusera’.
*/
/* */
