/*1*/
select m.matricula, m.dni, m.nombre, m.apellido, m.telefono, m.email
from Medico m 
where m.nombre = 'García'

/*2*/
select p.dni, p.nombre, p.apellido
from Paciente p inner join Atenciones a on (p.dni = a.dni)
except 
select p.dni, p.nombre, p.apellido
from Paciente p inner join Atenciones a on (p.dni = a.dni)
where between a.fecha ='2024-01-01' and a.fecha= '2024-12-31'
/*3 listar dni nombre y apellido de los pacientes atendidos por todos los medicos especializados en cardiologia*/
select p.dni, p.nombre, p.apellido
from Paciente p
where not exists (
    select m.matricula
    from Medico m
    where m.especialidad = 'cardiologia'
    and not exists (
        select a.dni
        from Atenciones a
        where a.dni = p.dni
        and a.matricula = m.matricula
    )
)
/*4- listar para cada especialidad nopmbre, y cantidad de medicos que se especializan en ella puede haber especialidades sin medicos*/
select e.nombreE, count(m.matricula)
from Medico m inner join MedicosEspecialidades me on (m.matricula = me.matricula)
inner join Especialidad e on (me.idEspecialidad = e.idEspecialidad)
group by e.idEspecialidad, e.nombreE
/*5 listar matricula, nombre, apellido y dni del medico o medicos con mas atenciones realizadas*/

select m.matricula, p.dni, p.nombre, p.apellido
from Medico m inner join Atenciones a on (m.matricula = a.matricula)
group by matricula, p.dni, p.nombre, p.apellido
having count (*)>= all (
    select count (*) 
    from Atencipones a
    group by a.matricula
)