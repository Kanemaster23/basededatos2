-- ========================
-- 1. Tabla: empleados
-- ========================
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    puesto VARCHAR(50),
    salario NUMERIC,
    fecha_ingreso DATE
);

INSERT INTO empleados (nombre, puesto, salario, fecha_ingreso) VALUES
('Ana Torres', 'Analista', 3000, '2020-05-10'),
('Luis Díaz', 'Desarrollador', 4000, '2019-08-12'),
('Carlos Ruiz', 'Administrador', 4500, '2021-03-01'),
('Laura Gómez', 'Tester', 2800, '2022-01-20'),
('Pedro León', 'Diseñador', 3200, '2023-04-17');

-- ========================
-- 2. Tabla: auditoria_empleados
-- ========================
CREATE TABLE auditoria_empleados (
    id SERIAL PRIMARY KEY,
    empleado_id INT,
    cambio TEXT,
    fecha TIMESTAMP
);

-- ========================
-- Disparador 1: log de actualizaciones
-- ========================
CREATE OR REPLACE FUNCTION log_update_empleado()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_empleados (empleado_id, cambio, fecha)
    VALUES (OLD.id, 'Actualización de datos', NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_update_empleado
AFTER UPDATE ON empleados
FOR EACH ROW
EXECUTE FUNCTION log_update_empleado();

-- ========================
-- 3. Tabla: productos
-- ========================
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    stock INT
);

INSERT INTO productos (nombre, stock) VALUES
('Mouse', 10),
('Teclado', 5),
('Monitor', 3),
('Laptop', 2),
('Cámara', 1);

-- ========================
-- 4. Tabla: ordenes
-- ========================
CREATE TABLE ordenes (
    id SERIAL PRIMARY KEY,
    producto_id INT,
    cantidad INT,
    fecha TIMESTAMP DEFAULT NOW()
);

-- ========================
-- Disparador 2: validación de stock
-- ========================
CREATE OR REPLACE FUNCTION validar_stock()
RETURNS TRIGGER AS $$
DECLARE
    stock_actual INT;
BEGIN
    SELECT stock INTO stock_actual FROM productos WHERE id = NEW.producto_id;
    IF stock_actual < NEW.cantidad THEN
        RAISE EXCEPTION 'Stock insuficiente para este producto';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_stock
BEFORE INSERT ON ordenes
FOR EACH ROW
EXECUTE FUNCTION validar_stock();

-- ========================
-- 5. Tabla: clientes
-- ========================
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100),
    fecha_creacion DATE,
    fecha_modificacion TIMESTAMP
);

INSERT INTO clientes (nombre, correo, fecha_creacion, fecha_modificacion) VALUES
('Sandra M.', 'sandra@mail.com', '2022-01-01', NOW()),
('David R.', 'david@mail.com', '2021-12-12', NOW()),
('Rosa P.', 'rosa@mail.com', '2023-03-05', NOW()),
('Juan C.', 'juan@mail.com', '2020-08-09', NOW()),
('Nora Q.', 'nora@mail.com', '2024-04-15', NOW());

-- ========================
-- Disparador 3: actualización automática de fecha_modificacion
-- ========================
CREATE OR REPLACE FUNCTION actualizar_fecha_modificacion()
RETURNS TRIGGER AS $$
BEGIN
    NEW.fecha_modificacion := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_actualizar_fecha
BEFORE UPDATE ON clientes
FOR EACH ROW
EXECUTE FUNCTION actualizar_fecha_modificacion();