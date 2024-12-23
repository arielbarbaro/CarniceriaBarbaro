-- Función: Calcular Total de Venta
DELIMITER //

CREATE FUNCTION CalcularTotalVenta(id_venta INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(d.subtotal) INTO total
    FROM DetalleVenta d
    WHERE d.id_venta = id_venta;
    RETURN total;
END //

DELIMITER ;
