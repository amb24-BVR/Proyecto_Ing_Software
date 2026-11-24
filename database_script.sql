-- Activar la verificación de llaves foráneas en SQLite (desactivada por defecto)
PRAGMA foreign_keys = ON;

-- 1. Tabla Administrador
CREATE TABLE IF NOT EXISTS Administrador (
    id_admin INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_usuario TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE
);

-- 2. Tabla Honey_Token
CREATE TABLE IF NOT EXISTS Honey_Token (
    id_token INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_objeto TEXT NOT NULL,
    tipo_token TEXT NOT NULL,
    estado TEXT NOT NULL,
    fecha_creacion TEXT NOT NULL,
    id_admin INTEGER NOT NULL,
    FOREIGN KEY (id_admin) REFERENCES Administrador(id_admin)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 3. Tabla WhiteList
CREATE TABLE IF NOT EXISTS WhiteList (
    id_white INTEGER PRIMARY KEY AUTOINCREMENT,
    ip_white TEXT NOT NULL UNIQUE,
    descripcion TEXT,
    fecha_agregado TEXT NOT NULL,
    id_admin INTEGER NOT NULL,
    FOREIGN KEY (id_admin) REFERENCES Administrador(id_admin)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 4. Tabla Alerta_Evento
CREATE TABLE IF NOT EXISTS Alerta_Evento (
    id_alerta INTEGER PRIMARY KEY AUTOINCREMENT,
    id_token INTEGER NOT NULL,
    ip_origen TEXT NOT NULL,
    tipo_actividad TEXT NOT NULL,
    fecha_hora TEXT NOT NULL,
    FOREIGN KEY (id_token) REFERENCES Honey_Token(id_token)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- 5. Tabla BlackList
CREATE TABLE IF NOT EXISTS BlackList (
    id_black INTEGER PRIMARY KEY AUTOINCREMENT,
    ip_origen TEXT NOT NULL,
    id_token INTEGER NOT NULL,
    estado TEXT NOT NULL,
    fecha_bloqueo TEXT NOT NULL,
    FOREIGN KEY (id_token) REFERENCES Honey_Token(id_token)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);