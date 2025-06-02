# Disparadores (Triggers) en SQL

## ¿Qué son y para qué sirven?

Los **disparadores** (o *triggers*) son bloques de código SQL que se ejecutan automáticamente en respuesta a ciertos eventos en una tabla o vista. Estos eventos pueden ser:

- `INSERT`
- `UPDATE`
- `DELETE`

Los disparadores se utilizan para **automatizar tareas**, **enforzar reglas de negocio** y **mantener integridad de datos** sin necesidad de intervención manual.

---

## Ventajas y desventajas

### Ventajas

- Automatizan procesos repetitivos.
- Garantizan la integridad de los datos.
- Permiten auditar cambios (por ejemplo, quién modificó un registro).
- Reducen la lógica que debe implementarse desde la aplicación.

### Desventajas

- Pueden complicar la depuración.
- Difíciles de mantener si hay muchos disparadores encadenados.
- Pueden afectar el rendimiento si no están bien diseñados.
- La lógica de negocio queda oculta en la base de datos.

---

## Sintaxis y cómo se utilizan

```sql
CREATE TRIGGER nombre_del_disparador
[BEFORE | AFTER] [INSERT | UPDATE | DELETE]
ON nombre_de_la_tabla
FOR EACH ROW
BEGIN
    -- Código SQL que se ejecuta cuando se dispara
END;

BEFORE o AFTER: indica si se ejecuta antes o después del evento.

FOR EACH ROW: significa que se ejecuta una vez por cada fila afectada.



Ejemplos de utilización de disparadores

* Caso 1: Registro de auditoría
Problema: Se necesita guardar un historial de cambios en la tabla empleados.

Solución: Crear un disparador que inserte en una tabla de auditoría cada vez que un empleado es actualizado.

CREATE TRIGGER log_update_empleado
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_empleados (empleado_id, cambio, fecha)
    VALUES (OLD.id, 'Actualización de datos', NOW());
END;

* Caso 2: Validación de stock
Problema: Evitar que se inserten órdenes con productos fuera de stock.

Solución: Disparador BEFORE INSERT que cancela la orden si no hay stock suficiente.

CREATE TRIGGER validar_stock
BEFORE INSERT ON ordenes
FOR EACH ROW
BEGIN
    IF (SELECT stock FROM productos WHERE id = NEW.producto_id) < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para este producto';
    END IF;
END;

* Caso 3: Actualización automática de fecha de modificación
Problema: Necesitamos que la fecha de modificación se actualice automáticamente al editar un registro.

Solución: Disparador que actualiza el campo fecha_modificacion en cada UPDATE.

CREATE TRIGGER actualizar_fecha_modificacion
BEFORE UPDATE ON clientes
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = NOW();
END;

