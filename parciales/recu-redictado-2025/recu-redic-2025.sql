/*1*/
Select id_mascota, nombre, especie, raza, f_nac, dni_cliente 
from Mascota m inner join Aplicacion_Vacuna a_v on (id_mascota = id_mascota)
where nombreV = 'Tripe Felina' and precio <10000
/*2*/
Select id_mascota, nombre, especie, raza, f_nac, dni_cliente 
from Mascota m inner join Consulta c on (id_mascota = id_mascota)
except
Select id_mascota, nombre, especie, raza, f_nac, dni_cliente 
from Mascota m inner join Consulta c on (id_mascota=id_mascota)
where fecha between '2025-01-01' and '2025-12-31'
/*3*/
select nombre,apellido,dtelefono, count(m.id_mascota)/*cuento las que hay*/
from Mascota m inner join Cliente c (dni = dni)
where 
group by c.dni
having count(m.id_mascota) >2 /*mas de 2*/
order by count(m.id_mascota) desc /*lo ordeno por las q hay mas*/
/*4*/
select id_mascota, nombre, especie, raza, f_nac, dni_cliente
from Mascota m inner join Consulta c on (id_amscota = id_mascota)
inner join Aplicaion_Vacuna a_v on (m.id_mascota = a_v.idMascota)
where diagnistico = 'rabia'
except 
select id_mascota, nombre, especie, raza, f_nac, dni_cliente
from Mascota m inner join Consulta c on (id_amscota = id_mascota)
inner join Aplicacion_Vacuna a_v on (m.id_mascota = a_v.idMascota)
where nombreV = 'Antirrabica'
/*5*/
insert into (Mascota (123452, pepito, gato, felino, callejero, '2022-05-10', 123456789))