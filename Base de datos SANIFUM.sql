-- ============================================
--   BASE DE DATOS SIG SANIFUM - MySQL
-- ============================================


CREATE DATABASE IF NOT EXISTS sig_sanifum;
USE sig_sanifum;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_razon_social VARCHAR(120) NOT NULL,
    rut VARCHAR(12) NOT NULL UNIQUE,
    tipo_cliente VARCHAR(50),
    tipo_contrato VARCHAR(50),
    frecuencia_servicio VARCHAR(50),
    direccion VARCHAR(200),
    comuna VARCHAR(100),
    region VARCHAR(100),
    zona_geografica VARCHAR(100)
);

CREATE TABLE tecnico (
    id_tecnico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    rut VARCHAR(12) NOT NULL UNIQUE,
    especialidad VARCHAR(100),
    zona_asignada VARCHAR(100),
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE servicio (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_plaga VARCHAR(100),
    tipo_servicio VARCHAR(100),
    prioridad VARCHAR(20),
    fecha_programada DATE,
    hora_programada TIME,
    duracion_estimada INT DEFAULT 60,
    estado_servicio VARCHAR(30) DEFAULT 'pendiente',
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE asignacion (
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_servicio INT NOT NULL,
    id_tecnico INT NOT NULL,
    fecha_asignacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado_asignacion VARCHAR(30) DEFAULT 'asignado',
    FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio),
    FOREIGN KEY (id_tecnico) REFERENCES tecnico(id_tecnico)
);

CREATE TABLE factura (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_servicio INT NOT NULL UNIQUE,
    numero_documento VARCHAR(50) UNIQUE,
    fecha_emision DATETIME DEFAULT CURRENT_TIMESTAMP,
    monto INT,
    tipo_documento VARCHAR(20),
    medio_pago VARCHAR(50),
    estado_pago VARCHAR(20) DEFAULT 'pendiente',
    FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
);

CREATE TABLE indicador_servicio (
    id_indicador INT AUTO_INCREMENT PRIMARY KEY,
    id_servicio INT NOT NULL UNIQUE,
    tiempo_respuesta_horas FLOAT,
    cumplimiento_agenda BOOLEAN,
    reprogramado BOOLEAN,
    satisfaccion_cliente_pct INT,
    FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
);

CREATE TABLE historial_servicio (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_servicio INT NOT NULL,
    fecha_evento DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo_evento VARCHAR(50) NOT NULL,
    descripcion TEXT NULL,
    motivo VARCHAR(200) NULL,
    url_evidencia VARCHAR(255) NULL,
    registrado_por VARCHAR(100) NULL,
    CONSTRAINT fk_hist_servicio
      FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
);

ALTER TABLE cliente
ADD COLUMN activo TINYINT(1) NOT NULL DEFAULT 1 AFTER correo;

