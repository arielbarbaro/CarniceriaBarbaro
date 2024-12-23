-- Vista: Ventas Detalladas
CREATE VIEW VistaVentasDetalladas AS
SELECT v.id_venta, v.fecha, c.nombre AS cliente, p.nombre AS producto, dv.cantidad, dv.subtotal
FROM Venta v
JOIN Cliente c ON v.id_cliente = c.id_cliente
JOIN DetalleVenta dv ON v.id_venta = dv.id_venta
JOIN Producto p ON dv.id_producto = p.id_producto;
