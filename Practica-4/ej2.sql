/* Localidad = (codigoPostal, nombreL, descripcion, nroHabitantes)
Arbol = (nroArbol, especie, anios, calle, nro, codigoPostal(fk))
Podador = (DNI, nombre, apellido, telefono, fnac, codigoPostalVive(fk))
Poda = (codPoda, fecha, DNI(fk), nroArbol(fk))*/
/* */
/*1. Listar especie, años, calle, nro y localidad de árboles podados por el podador ‘Juan Perez’ y por
el podador ‘Jose Garcia’. */
(SELECT DISTINCT a.especie, a.anios, a.calle, a.nro, l.nombreL
from Localidad l 
inner Join Arbol a on (l.codigoPostal = a.codigoPostal)
inner join Poda pd on ( a.nroArbol = pd.nroArbol)
inner join Podador pdd on (pd.ndi =pdd.dni)
where po.nombre = 'Juan' and po.apellido = 'Perez')
INTERSECT
(SELECT DISTINCT a.especie, a.anios, a.calle, a.nro, l.nombreL
from Localidad l 
inner Join Arbol a on (l.codigoPostal = a.codigoPostal)
inner join Poda pd on ( a.nroArbol = pd.nroArbol)
inner join Podador pdd on (pd.ndi =pdd.dni)
where po.nombre = 'Jose' and po.apellido = 'Garcia')

/* como se cual con cual*/

/* 2. Reportar DNI, nombre, apellido, fecha de nacimiento y localidad donde viven de aquellos
podadores que tengan podas realizadas durante 2023.
*/
SELECT DISTINCT /*creo q iria aca xq sino se repiten si realizo mas de una poda en 2023 */ pdd.dni, pdd.apellido, pdd.fnac, l.nombreL
FROM Localidad l 
inner Join Podador pdd on (l.codigoPostal = pdd.codigoPostalVive)
inner join Poda pd on (pdd.dni = pd.dni)
where pd.fecha Between '2023-01-01' AND '2023-12-31'

/*3. Listar especie, años, calle, nro y localidad de árboles que no fueron podados nunca */
SELECT a.especie, a.anios, a.calle, a.nro, l.nombreL
from Localida l inner join Arbol a on (l.codigoPostal = a.codigoPostal)
left join Poda pd on ( a.nroArbol = pd.nroArbol)
where pd.nroArbol is null  

/*4. Reportar especie, años,calle, nro y localidad de árboles que fueron podados durante 2022 y no
fueron podados durante 2023. */
/*intersect lo comun y union restar*/
/*uso distinct cuando se que se repiten filas como uso arboles y poda se repetiria el numero de arbol asi que uso distimct y ademas si hay intersect union, etc no se usa */
(SELECT  a.especie, a.anios, a.calle, a.nro, l.nombreL
FROM Localidad l inner join Arbol a on (l.codigoPostal = a.codigoPostal)
inner join Poda pd on (a.nroArbol = pd.nroArbol)
where pd.fecha Between '2022-01-01' AND '2022-12-31')
except
(SELECT  a.especie, a.anios, a.calle, a.nro, l.nombreL
FROM Localidad l inner join Arbol a on (l.codigoPostal = a.codigoPostal)
inner join Poda pd on (a.nroArbol = pd.nroArbol)
where pd.fecha NOT exists Between '2023-01-01' AND '2023-12-31')

/*OR ---->>??? */ 

(SELECT  a.especie, a.anios, a.calle, a.nro, l.nombreL
FROM Localidad l inner join Arbol a on (l.codigoPostal = a.codigoPostal)
where exists(select pd.nroArbol 
            from Poda pd 
            where (pd.nroArbol = a.nroArbol) and (pd.fecha Between '2022-01-01' AND '2022-12-31')) and not exists
(select pd.nroArbol 
from Poda pd 
where (pd.nroArbol = a.nroArbol) and (pd.fecha Between '2023-01-01' AND '2023-12-31' )) )

/* */