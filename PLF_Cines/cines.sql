-- object: Pelicula | type: TABLE --
CREATE TABLE Pelicula (
    nombrePelicula varchar(50) NOT NULL,
    sinopsis varchar(500) NOT NULL,
    paginaOficial varchar(50),
    tituloOriginal varchar(50),
    genero varchar(50) NOT NULL,
    nacionalidad varchar(50) NOT NULL,
    duracion integer NOT NULL,
    anho integer NOT NULL,
    distribuidora varchar(50),
    director varchar(50) NOT NULL,
    clasificacionEdad smallint NOT NULL,
    otrosDatos varchar(200) NOT NULL,
    actores varchar(200) NOT NULL,
    url_image varchar(500) NOT NULL,
    url_video varchar(500) NOT NULL,
    CONSTRAINT PK_Pelicula PRIMARY KEY (nombrePelicula)
);

-- object: Sala | type: TABLE --
CREATE TABLE Sala (
    nombreSala varchar(20) NOT NULL,
    filas smallint NOT NULL,
    columnas smallint NOT NULL,
    nombrePelicula_Pelicula varchar(50), -- Nueva columna
    CONSTRAINT PK_Sala PRIMARY KEY (nombreSala)
);

-- object: Entrada | type: TABLE --
CREATE TABLE Entrada (
    idEntrada varchar(10) NOT NULL,
    fecha date NOT NULL,
    hora time NOT NULL,
    fila smallint NOT NULL,
    columna smallint NOT NULL,
    nombreSala_Sala varchar(20),
    CONSTRAINT PK_Entrada PRIMARY KEY (idEntrada, fila, columna)
);
-- object: Usuario | type: TABLE --
CREATE TABLE Usuario (
    nombre varchar(50) NOT NULL,
    apellidos varchar(50) NOT NULL,
    contrasenha varchar(50) NOT NULL,
    email varchar(50) NOT NULL,
    fechaNacimiento date NOT NULL,
    CONSTRAINT PK_Usuario PRIMARY KEY (email)
);

-- object: Reserva | type: TABLE --
CREATE TABLE Reserva (
    numeroRef varchar(20) NOT NULL,
    email_Usuario varchar(50),
    idEntrada_Entrada varchar(10),
    fila_Entrada smallint NOT NULL,
    columna_Entrada smallint NOT NULL,
    CONSTRAINT PK_Reserva PRIMARY KEY (numeroRef),
    CONSTRAINT EntradaReserva_fk FOREIGN KEY (idEntrada_Entrada, fila_Entrada, columna_Entrada)
    REFERENCES Entrada (idEntrada, fila, columna)
);

-- object: Comentario | type: TABLE --
CREATE TABLE Comentario (
    texto varchar(1000) NOT NULL,
    valoracion smallint NOT NULL,
    fechaComentario date NOT NULL,
    email_Usuario varchar(50) NOT NULL,
    nombrePelicula_Pelicula varchar(50)
);

--object: Tarjeta | type: TABLE --
CREATE TABLE Tarjeta (
    numeroTarjeta varchar(25) NOT NULL,
    nombreTitular varchar(50) NOT NULL,
    fechaExpiracion varchar(10) NOT NULL,
    codigoSeguridad varchar(3) NOT NULL,
    email_Usuario varchar(50) NOT NULL,
    CONSTRAINT PK_Tarjeta PRIMARY KEY (numeroTarjeta),
    CONSTRAINT FK_Tarjeta_Usuario FOREIGN KEY (email_Usuario) REFERENCES Usuario (email)
);

-- object: SalaPelicula_fk | type: CONSTRAINT --
ALTER TABLE Sala ADD CONSTRAINT SalaPelicula_fk FOREIGN KEY (nombrePelicula_Pelicula)
REFERENCES Pelicula (nombrePelicula);

-- object: SalaEntrada_fk | type: CONSTRAINT --
ALTER TABLE Entrada ADD CONSTRAINT SalaEntrada_fk FOREIGN KEY (nombreSala_Sala)
REFERENCES Sala (nombreSala);

-- object: UsuarioReserva_fk | type: CONSTRAINT --
ALTER TABLE Reserva ADD CONSTRAINT UsuarioReserva_fk FOREIGN KEY (email_Usuario)
REFERENCES Usuario (email);

-- object: EntradaReserva_fk | type: CONSTRAINT --
--ALTER TABLE Reserva ADD CONSTRAINT EntradaReserva_fk FOREIGN KEY (idEntrada_Entrada, fila_Entrada, columna_Entrada)
--REFERENCES Entrada (idEntrada, fila, columna);

-- object: ComentarioUsuario_fk | type: CONSTRAINT --
ALTER TABLE Comentario ADD CONSTRAINT ComentarioUsuario_fk FOREIGN KEY (email_Usuario)
REFERENCES Usuario (email);

-- object: ComentarioPelicula_fk | type: CONSTRAINT --
ALTER TABLE Comentario ADD CONSTRAINT ComentarioPelicula_fk FOREIGN KEY (nombrePelicula_Pelicula)
REFERENCES Pelicula (nombrePelicula);


--IMPORTS--

-- Películas

INSERT INTO Pelicula (nombrePelicula, sinopsis, paginaOficial, tituloOriginal, genero, nacionalidad, duracion, anho, distribuidora, director, clasificacionEdad, otrosDatos, actores, url_image, url_video)
VALUES ('El Padrino', 'Un poderoso drama criminal que sigue la vida de la familia Corleone en el mundo del crimen organizado.', 'https://example.com/godfather', 'Il Padrino', 'Crimen, Drama', 'Estados Unidos', 175, 1972, 'Paramount Pictures', 'Francis Ford Coppola', 18, 'Ganadora de 3 premios Oscar.', 'Marlon Brando, Al Pacino, James Caan','images/ElPadrino.jpeg', 'https://www.youtube.com/embed/iOyQx7MXaz0?si=nuCJfNniJoPzuQTb');

INSERT INTO Pelicula (nombrePelicula, sinopsis, paginaOficial, tituloOriginal, genero, nacionalidad, duracion, anho, distribuidora, director, clasificacionEdad, otrosDatos, actores, url_image, url_video)
VALUES ('Cadena Perpetua', 'La historia de un hombre inocente encarcelado que encuentra esperanza y amistad en Shawshank.', 'https://example.com/shawshank', 'Shawshank Redemption', 'Drama', 'Estados Unidos', 142, 1994, 'Columbia Pictures', 'Frank Darabont', 15, 'Basada en la novela de Stephen King.', 'Tim Robbins, Morgan Freeman', 'images/CadenaPerpetua.jpeg', 'https://www.youtube.com/embed/4u87tmlj4oE?si=n318897_-rDPVLzP');

INSERT INTO Pelicula (nombrePelicula, sinopsis, paginaOficial, tituloOriginal, genero, nacionalidad, duracion, anho, distribuidora, director, clasificacionEdad, otrosDatos, actores, url_image, url_video)
VALUES ('El Caballero Oscuro', 'Batman se enfrenta a su némesis, el Joker, en un juego de ingenio que amenaza Gotham City.', 'https://example.com/darkknight', 'The Dark Knight', 'Acción, Crimen, Drama', 'Estados Unidos', 152, 2008, 'Warner Bros.', 'Christopher Nolan', 16, 'Ganadora de 2 premios Oscar.', 'Christian Bale, Heath Ledger, Aaron Eckhart', 'images/CaballeroOscuro.jpeg', 'https://www.youtube.com/embed/9MEuGQtM9wA?si=A5YSZGVuwDCtK83o');

INSERT INTO Pelicula (nombrePelicula, sinopsis, paginaOficial, tituloOriginal, genero, nacionalidad, duracion, anho, distribuidora, director, clasificacionEdad, otrosDatos, actores, url_image, url_video)
VALUES ('Cars', 'En un mundo donde los autos son seres vivos, el aspirante a corredor Rayo McQueen termina en un pequeño pueblo llamado Radiador Springs. Aprendiendo lecciones valiosas de amistad y humildad, Rayo descubre el verdadero significado de la velocidad.', 'https://www.paginaoficial.com/cars', 'Cars', 'Animación', 'Estadounidense', 120, 2006, 'Pixar', 'John Lasseter', 3, 'Datos adicionales sobre la película Cars.', 'Owen Wilson, Bonnie Hunt', 'images/Cars.png', 'https://www.youtube.com/embed/nuQDFYpPUh4?si=owxKwSIVF6QzUeh1');

INSERT INTO Pelicula (nombrePelicula, sinopsis, paginaOficial, tituloOriginal, genero, nacionalidad, duracion, anho, distribuidora, director, clasificacionEdad, otrosDatos, actores, url_image, url_video)
VALUES ('Cars 2', 'Rayo McQueen y su amigo Mate se ven envueltos en una misión internacional de espionaje cuando son reclutados para participar en el Grand Prix Mundial. Intrigas, giros y vueltas esperan a nuestros héroes mientras luchan contra una misteriosa amenaza.', 'https://www.paginaoficial.com/cars2', 'Cars 2', 'Animación', 'Estadounidense', 130, 2011, 'Pixar', 'John Lasseter', 3, 'Datos adicionales sobre la película Cars 2.', 'Owen Wilson, Larry the Cable Guy', 'images/Cars2.png', 'https://www.youtube.com/embed/oGpIMRq1O3k?si=UUSOoOjMZg_RPptk');

INSERT INTO Pelicula (nombrePelicula, sinopsis, paginaOficial, tituloOriginal, genero, nacionalidad, duracion, anho, distribuidora, director, clasificacionEdad, otrosDatos, actores, url_image, url_video)
VALUES ('Cars 3', 'Con una nueva generación de corredores amenazando su posición, Rayo McQueen se embarca en un emocionante viaje de redescubrimiento y superación. Con la ayuda de entrenadores y nuevos amigos, Rayo intenta volver al ruedo y dejar su marca.', 'https://www.paginaoficial.com/cars3', 'Cars 3', 'Animación', 'Estadounidense', 110, 2017, 'Pixar', 'Brian Fee', 3, 'Datos adicionales sobre la película Cars 3.', 'Owen Wilson, Cristela Alonzo', 'images/Cars3.png', 'https://www.youtube.com/embed/wtmW9rSRIzU?si=MttED7g2UgQk5A08');

INSERT INTO Pelicula (nombrePelicula, sinopsis, paginaOficial, tituloOriginal, genero, nacionalidad, duracion, anho, distribuidora, director, clasificacionEdad, otrosDatos, actores, url_image, url_video)
VALUES ('Kung Fu Panda', 'Po, un torpe oso panda, sueña con convertirse en un hábil guerrero de kung fu. Su vida da un giro cuando es elegido accidentalmente para cumplir una antigua profecía. Po se embarca en una aventura cómica y emocionante para aprender las artes marciales y salvar el Valle de la Paz.', 'https://www.paginaoficial.com/kungfupanda', 'Kung Fu Panda', 'Animación', 'Estadounidense', 95, 2008, 'DreamWorks Animation', 'Mark Osborne, John Stevenson', 3, 'Datos adicionales sobre la película Kung Fu Panda.', 'Jack Black, Angelina Jolie', 'images/KunfuPanda.png', 'https://www.youtube.com/embed/vRhMIpFu-Zw?si=Hwgor3iZaTcqtmz4');

INSERT INTO Pelicula (nombrePelicula, sinopsis, paginaOficial, tituloOriginal, genero, nacionalidad, duracion, anho, distribuidora, director, clasificacionEdad, otrosDatos, actores, url_image, url_video)
VALUES ('One Piece', 'Monkey D. Luffy y su valiente tripulación emprenden un viaje épico en busca del legendario tesoro conocido como "One Piece". Enfrentándose a peligros, enemigos y desafíos, Luffy se esfuerza por convertirse en el Rey de los Piratas.', 'https://www.paginaoficial.com/onepiece', 'One Piece', 'Animación', 'Japonesa', 120, 2022, 'Toei Animation', 'Eiichiro Oda', 12, 'Datos adicionales sobre la película One Piece.', 'Mayumi Tanaka, Kazuya Nakai', 'images/OnePiece.png', 'https://www.youtube.com/embed/CWrJQzm0diI?si=tzF0AIbtEib0kGCV');

INSERT INTO Pelicula (nombrePelicula, sinopsis, paginaOficial, tituloOriginal, genero, nacionalidad, duracion, anho, distribuidora, director, clasificacionEdad, otrosDatos, actores, url_image, url_video)
VALUES ('Rocky', 'Rocky Balboa, un boxeador de Filadelfia con pocas oportunidades, recibe la oportunidad de enfrentarse al campeón de peso pesado Apollo Creed. Aunque inicialmente es considerado como un oponente fácil, Rocky se prepara para la pelea de su vida, demostrando coraje y determinación.', 'https://www.paginaoficial.com/rocky', 'Rocky', 'Drama', 'Estadounidense', 120, 1976, 'United Artists', 'John G. Avildsen', 12, 'Datos adicionales sobre la película Rocky.', 'Sylvester Stallone, Talia Shire, Burgess Meredith', 'images/Rocky.png', 'https://www.youtube.com/embed/Vb-Bx2YkIPA?si=UZigoaMfxKRR6Hy8');

-- Puedes agregar más películas según sea necesario...

-- Salas
INSERT INTO Sala (nombreSala, filas, columnas, nombrePelicula_Pelicula)
VALUES ('Sala 1', 10, 15, 'El Padrino');

INSERT INTO Sala (nombreSala, filas, columnas, nombrePelicula_Pelicula)
VALUES ('Sala 2', 8, 12, 'Cadena Perpetua');

INSERT INTO Sala (nombreSala, filas, columnas, nombrePelicula_Pelicula)
VALUES ('Sala 3', 12, 20, 'El Caballero Oscuro');

-- Entradas
INSERT INTO Entrada (idEntrada, fecha, hora, fila, columna, nombreSala_Sala)
VALUES ('E1', '2023-01-01', '12:00:00', 5, 10, 'Sala 1');

INSERT INTO Entrada (idEntrada, fecha, hora, fila, columna, nombreSala_Sala)
VALUES ('E2', '2023-01-02', '15:30:00', 3, 8, 'Sala 2');

INSERT INTO Entrada (idEntrada, fecha, hora, fila, columna, nombreSala_Sala)
VALUES ('E3', '2023-01-03', '18:45:00', 8, 15, 'Sala 3');

-- Usuarios
INSERT INTO Usuario (nombre, apellidos, contrasenha, email, fechaNacimiento)
VALUES ('Administrador', ' ', 'admin123', 'admin@example.com', '1990-05-15');

INSERT INTO Usuario (nombre, apellidos, contrasenha, email, fechaNacimiento)
VALUES ('Rafael', 'Gonzalez', 'rafa123', 'rafael@example.com', '1990-05-15');

INSERT INTO Usuario (nombre, apellidos, contrasenha, email, fechaNacimiento)
VALUES ('Maria', 'Lopez', '12345', 'maria@example.com', '1985-09-22');

INSERT INTO Usuario (nombre, apellidos, contrasenha, email, fechaNacimiento)
VALUES ('Carlos', 'Martinez', '12345', 'carlos@example.com', '1995-12-10');

-- Reservas

INSERT INTO Reserva (numeroRef, email_Usuario, idEntrada_Entrada, fila_Entrada, columna_Entrada)
VALUES ('R1', 'rafael@example.com', 'E1', 5, 10);

INSERT INTO Reserva (numeroRef, email_Usuario, idEntrada_Entrada, fila_Entrada, columna_Entrada)
VALUES ('R2', 'maria@example.com', 'E2', 3, 8);

INSERT INTO Reserva (numeroRef, email_Usuario, idEntrada_Entrada, fila_Entrada, columna_Entrada)
VALUES ('R3', 'carlos@example.com', 'E3', 8, 15);

-- Comentarios
INSERT INTO Comentario (texto, valoracion, fechaComentario, email_Usuario, nombrePelicula_Pelicula)
VALUES ('Una obra maestra, actuaciones increíbles.', 5, '2023-01-05', 'rafael@example.com', 'El Padrino');

INSERT INTO Comentario (texto, valoracion, fechaComentario, email_Usuario, nombrePelicula_Pelicula)
VALUES ('Emocionante de principio a fin.', 4, '2023-01-06', 'maria@example.com', 'Cadena Perpetua');

INSERT INTO Comentario (texto, valoracion, fechaComentario, email_Usuario, nombrePelicula_Pelicula)
VALUES ('Efectos visuales asombrosos.', 4, '2023-01-07', 'carlos@example.com', 'El Caballero Oscuro');

-- Tarjetas
INSERT INTO Tarjeta (numeroTarjeta, nombreTitular, fechaExpiracion, codigoSeguridad, email_Usuario)
VALUES ('1111222233334444', 'Rafael Gonzalez', '2024-08-31', '456', 'rafael@example.com');

INSERT INTO Tarjeta (numeroTarjeta, nombreTitular, fechaExpiracion, codigoSeguridad, email_Usuario)
VALUES ('4444555566667777', 'Maria Lopez', '2023-11-30', '987', 'maria@example.com');

INSERT INTO Tarjeta (numeroTarjeta, nombreTitular, fechaExpiracion, codigoSeguridad, email_Usuario)
VALUES ('7777888899990000', 'Carlos Martinez', '2023-09-30', '345', 'carlos@example.com');

