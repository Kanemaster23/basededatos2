-- 1. CREACIÓN DE TABLAS
DROP TABLE IF EXISTS Checkin, Reservas, Vuelos, Pasajeros, Aeropuertos CASCADE;

CREATE TABLE Aeropuertos (
    aer_Id SERIAL PRIMARY KEY,
    aer_Nombre VARCHAR(100),
    aer_Ciudad VARCHAR(50),
    aer_Pais VARCHAR(50),
    aer_Codigo VARCHAR(5) UNIQUE
);

CREATE TABLE Pasajeros (
    pas_Id SERIAL PRIMARY KEY,
    pas_Nombre VARCHAR(100),
    pas_Email VARCHAR(100) UNIQUE,
    pas_Telefono VARCHAR(15),
    pas_FechaNacimiento DATE,
    pas_Documento VARCHAR(20) UNIQUE
);

CREATE TABLE Vuelos (
    vue_Id SERIAL PRIMARY KEY,
    vue_Numero VARCHAR(10) UNIQUE,
    vue_Origen INT,
    vue_Destino INT,
    vue_FechaHoraSalida TIMESTAMP,
    vue_FechaHoraLlegada TIMESTAMP,
    vue_Activo BOOLEAN,
    FOREIGN KEY (vue_Origen) REFERENCES Aeropuertos(aer_Id),
    FOREIGN KEY (vue_Destino) REFERENCES Aeropuertos(aer_Id)
);

CREATE TABLE Reservas (
    res_Id SERIAL PRIMARY KEY,
    res_PasajeroId INT,
    res_VueloId INT,
    res_FechaReserva TIMESTAMP,
    res_Activa BOOLEAN,
    FOREIGN KEY (res_PasajeroId) REFERENCES Pasajeros(pas_Id),
    FOREIGN KEY (res_VueloId) REFERENCES Vuelos(vue_Id)
);

CREATE TABLE Checkin (
    che_Id SERIAL PRIMARY KEY,
    che_ReservalId INT,
    che_FechaHora TIMESTAMP,
    che_Asiento VARCHAR(5),
    che_Equipaje BOOLEAN,
    FOREIGN KEY (che_ReservalId) REFERENCES Reservas(res_Id)
);

-- 2. INSERCIÓN DE DATOS

-- Aeropuertos
INSERT INTO Aeropuertos (aer_Nombre, aer_Ciudad, aer_Pais, aer_Codigo) VALUES
('El Dorado', 'Bogotá', 'Colombia', 'BOG'),
('Ezeiza', 'Buenos Aires', 'Argentina', 'EZE'),
('Barajas', 'Madrid', 'España', 'MAD'),
('JFK', 'New York', 'USA', 'JFK'),
('CDG', 'Paris', 'Francia', 'CDG'),
('Heathrow', 'Londres', 'UK', 'LHR'),
('Changi', 'Singapur', 'Singapur', 'SIN'),
('Haneda', 'Tokio', 'Japón', 'HND'),
('Dubai Intl', 'Dubai', 'EAU', 'DXB'),
('Frankfurt', 'Frankfurt', 'Alemania', 'FRA');

-- Pasajeros
INSERT INTO Pasajeros (pas_Nombre, pas_Email, pas_Telefono, pas_FechaNacimiento, pas_Documento) VALUES
('Juan Pérez', 'juanp@example.com', '123456789', '1990-05-21', 'DOC001'),
('Ana Torres', 'ana@example.com', '234567890', '1985-11-15', 'DOC002'),
('Luis Gómez', 'luisg@example.com', '345678901', '1992-03-08', 'DOC003'),
('María López', 'marial@example.com', '456789012', '1988-07-19', 'DOC004'),
('Carlos Ruiz', 'carlosr@example.com', '567890123', '1995-01-10', 'DOC005'),
('Laura Díaz', 'laurad@example.com', '678901234', '1993-09-25', 'DOC006'),
('Pedro Sánchez', 'pedros@example.com', '789012345', '1991-04-14', 'DOC007'),
('Sofía Ramírez', 'sofiar@example.com', '890123456', '1989-12-30', 'DOC008'),
('Andrés Molina', 'andresm@example.com', '901234567', '1996-06-17', 'DOC009'),
('Valeria Castro', 'valeriac@example.com', '012345678', '1994-08-05', 'DOC010');

-- Vuelos
INSERT INTO Vuelos (vue_Numero, vue_Origen, vue_Destino, vue_FechaHoraSalida, vue_FechaHoraLlegada, vue_Activo) VALUES
('AV001', 1, 2, '2025-06-05 08:00', '2025-06-05 14:00', TRUE),
('AV002', 3, 4, '2025-06-06 10:00', '2025-06-06 18:00', TRUE),
('AV003', 2, 5, '2025-06-07 07:30', '2025-06-07 16:00', TRUE),
('AV004', 6, 1, '2025-06-08 09:00', '2025-06-08 17:30', TRUE),
('AV005', 7, 3, '2025-06-09 11:15', '2025-06-09 19:45', TRUE),
('AV006', 4, 6, '2025-06-10 13:00', '2025-06-10 21:00', TRUE),
('AV007', 5, 8, '2025-06-11 06:45', '2025-06-11 15:10', TRUE),
('AV008', 9, 10, '2025-06-12 14:30', '2025-06-12 22:55', TRUE),
('AV009', 1, 5, '2025-06-13 17:00', '2025-06-14 01:30', TRUE),
('AV010', 8, 9, '2025-06-14 18:00', '2025-06-15 02:15', TRUE);

-- Reservas
INSERT INTO Reservas (res_PasajeroId, res_VueloId, res_FechaReserva, res_Activa) VALUES
(1, 1, '2025-05-25 10:00', TRUE),
(2, 2, '2025-05-26 11:30', TRUE),
(3, 3, '2025-05-27 09:00', TRUE),
(4, 4, '2025-05-28 15:20', TRUE),
(5, 5, '2025-05-29 13:45', TRUE),
(6, 6, '2025-05-30 17:10', TRUE),
(7, 7, '2025-05-31 12:00', TRUE),
(8, 8, '2025-06-01 08:40', TRUE),
(9, 9, '2025-06-02 16:25', TRUE),
(10, 10, '2025-06-03 10:15', TRUE);

-- Checkin
INSERT INTO Checkin (che_ReservalId, che_FechaHora, che_Asiento, che_Equipaje) VALUES
(1, '2025-06-05 06:30', '12A', TRUE),
(2, '2025-06-06 08:30', '10B', TRUE),
(3, '2025-06-07 06:00', '14C', FALSE),
(4, '2025-06-08 07:15', '16D', TRUE),
(5, '2025-06-09 09:10', '11E', TRUE),
(6, '2025-06-10 11:20', '18F', FALSE),
(7, '2025-06-11 05:45', '13A', TRUE),
(8, '2025-06-12 12:15', '19B', TRUE),
(9, '2025-06-13 15:50', '15C', FALSE),
(10, '2025-06-14 16:40', '17D', TRUE);