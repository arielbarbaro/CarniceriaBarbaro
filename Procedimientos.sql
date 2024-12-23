-- Procedimiento: Obtener ventas por cliente
DELIMITER //

CREATE PROCEDURE ObtenerVentasPorCliente(IN cliente_id INT)
BEGIN
    SELECT v.id_venta, v.fecha, v.total
    FROM Venta v
    WHERE v.id_cliente = cliente_id;
END //


DELIMITER ;
