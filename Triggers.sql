-- Trigger: Actualizar Stock al Realizar una Venta
DELIMITER $$

CREATE TRIGGER ActualizarStockDespuesDeVenta
AFTER INSERT ON DetalleVenta
FOR EACH ROW
BEGIN
    UPDATE Producto
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END $$

DELIMITER ;
