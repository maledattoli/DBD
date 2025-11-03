/* Cliente = (idCliente, nombre, apellido, DNI, telefono, direccion)
Factura = (nroTicket, total, fecha, hora, idCliente (fk))
Detalle = (nroTicket (fk), idProducto (fk), cantidad, preciounitario)
Producto = (idProducto, nombreP, descripcion, precio, stock)
*/
/*1. Listar datos personales de clientes cuyo apellido comience con el string ‘Pe’. Ordenar por DNI*/
SELECT c.nombre, c.apellido, c.DNI, c.telefono, c.direccion
FROM Cliente c
WHERE (apellido LIKE "Pe%")
/*6. Listar nombre, apellido, DNI, teléfono y dirección de clientes que compraron los productos con
nombre ‘prod1’ y ‘prod2’ pero nunca compraron el producto con nombre ‘prod3’.
*/
(SELECT nombre, DNI, apellido, telefono, direccion
FROM Producto p INNER JOIN Detalle d on (p.idProducto = d.idProducto)
INNER JOIN Factura f on (d.nroTicket = f.nroTicket)
INNER JOIN Cliente c on (f.idCliente = c.idCliente)
WHERE nombreP = 'prod1')  
INTERSECT
(SELECT nombre, dni, apellido, telefono, direccion
FROM Producto p INNER JOIN Detalle d on (p.idProducto = d.idProducto)
INNER JOIN Factura f on (d.nroTicket = f.nroTicket)
INNER JOIN Cliente c on (f.idCliente = c.idCliente)
WHERE nombreP = 'prod2')
EXCEPT
(SELECT nombre, dni, apellido, telefono, direccion
FROM Producto p INNER JOIN Detalle d on (p.idProducto = d.idProducto)
INNER JOIN Factura f on (d.nroTicket = f.nroTicket)
INNER JOIN Cliente c on (f.idCliente = c.idCliente)
WHERE nombreP = 'prod3')

/*7. Listar nroTicket, total, fecha, hora y DNI del cliente, de aquellas facturas donde se haya comprado el producto ‘prod38’ o la factura tenga fecha de 2023*/
(SELECT f.nroTicket, f.total, f.fecha, f.hora, f.DNI
FROM Producto p INNER JOIN Detalle d on (p.idProducto = d.idProducto)
INNER JOIN Factura f on (d.nroTicket = f.nroTicket)
where nombreP = 'prod38' OR f.fecha Between '2023-01-01' AND '2023-12-31')
/* */
/*8. Agregar un cliente con los siguientes datos: nombre:’Jorge Luis’, apellido:’Castor’, DNI: 40578999, teléfono: ‘221-4400789’, dirección:’11 entre 500 y 501 nro:2587’ y el id de cliente: 500002. Se supone que el idCliente 500002 no existe. */
insert into Cliente (idCliente, nombre, apellido, DNI, telefono, direccion)
values (500002, 'Jorge Luis', 'Castor', 40578999, '221-4400789', '11 entre 500 y 501 nro:2587');/*-> nada mas xq se suponme que no existe ese id */

/*9. Listar nroTicket, total, fecha, hora para las facturas del cliente ´Jorge Pérez´ donde no haya
comprado el producto ´Z´*/
SELECT f.nroTicket, f.total, f.fecha, f.hora
from Producto p inner join Detalle d on (p.idProducto = d.idProducto)
inner join Factura f on (d.nroTicket = f.nroTicket)
inner join Cliente c on (f.idCliente = c.idCliente)
where f.idCliente = (
    Select idCliente 
    from Cliente c 
    where c.nombre = 'Jorge' and c.apellido = 'Perez') and 
    f.nroTicket not in /* not exsists?? */(SELECT f.nroTicket /*solo una columna */
                        from Producto p inner join Detalle d on (p.idProducto = d.idProducto)
                        inner join Factura f on (d.nroTicket = f.nroTicket)
                        inner join Cliente c on (f.idCliente = c.idCliente)
                        where p.nombreP = 'Z')

/*10. Listar DNI, apellido y nombre de clientes donde el monto total comprado, teniendo en cuenta
todas sus facturas, supere $100000. */
SELECT c.dni, c.apellido, c.nombre
from Cliente c inner JOIN Factura f on (c.idCliente = f.idCliente) 
group by c.dni, c.apellido, c.nombre
having sum (f.total) > 100000