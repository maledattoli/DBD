/*1*/
select idLibro, titulo, autor, precio, stock
from Libro l 
where precio>2300

/*2*/
select nroVenta, total,fecha,hora,idCliente
from Venta v 
where fecha between '2023-01-01' and '2023-12-31'

/*3*/
select nombre, apellido,dni, telefono,direccion
from Cliente c inner join Venta v on (c.idCliente = v.idCliente)
where fecha >='2022-01-01' and fecha <='2022-12-31'
except
select nombre, apellido,dni, telefono,direccion
from Cliente c inner join Venta v on (c.idCliente = v.idCliente)
where fecha <'2022-01-01' or fecha >'2022-12-31'
/*4*/
select titulo, autor, precio, count(dv.idLibro)
from libro l left join DetalleVenta dv on (l.idLibro = dv.idLibro) left join Venta v on (l.nroVenta = v.nroVenta)
group by l.idLibro

/*5*/
select distinct v.nroVenta, v.total, v.fecha, v.hora, c.dni
from Venta v natural join Cliente c natural join DetalleVenta d
where d.preciounitario>1000