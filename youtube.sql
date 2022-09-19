-- Active: 1663598297600@@127.0.0.1@3306@youtube
DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube;
USE youtube;
CREATE TABLE usuarios(
    usuario_id INT(11) NOT NULL AUTO_INCREMENT, 
    email VARCHAR(45) NOT NULL UNIQUE, 
    pasword VARCHAR(20) NOT NULL, 
    nombre_usuario VARCHAR(30) NOT NULL, 
    fecha_nacimiento DATE NOT NULL, 
    sexo ENUM('masculino', 'femenino') NOT NULL, 
    pais VARCHAR(30) NOT NULL, 
    codigo_postal INT(20) NOT NULL, 
    PRIMARY KEY(usuario_id)
);

CREATE TABLE videos(
    video_id INT(11) NOT NULL AUTO_INCREMENT, 
    id_usuario INT(11) NOT NULL,
    fecha_subida DATETIME NOT NULL, 
    titulo VARCHAR(45) NOT NULL, 
    descripcion VARCHAR(250), 
    grandaria DECIMAL(10, 2), 
    nombre_arxivo VARCHAR(45) NOT NULL, 
    duracion TIME NOT NULL,  
    thumbnail_url VARCHAR(250) NOT NULL, 
    reproducciones INT(11) NOT NULL, 
    likes INT(11) NOT NULL, 
    dislikes INT(11) NOT NULL, 
    estado ENUM('publico', 'oculto', 'privado') NOT NULL, 


    PRIMARY KEY(video_id), 
    FOREIGN KEY(id_usuario) REFERENCES usuarios (usuario_id) 
);

CREATE TABLE etiquetas(
    etiqueta_id INT(11) NOT NULL AUTO_INCREMENT, 
    nombre VARCHAR(45) NOT NULL, 
    id_video INT(11) NOT NULL,
    PRIMARY KEY(etiqueta_id),
    Foreign Key (id_video) REFERENCES videos (video_id)  
);

CREATE TABLE canales(
    canal_id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    fecha_creacion DATETIME NOT NULL,
    id_usuario INT(11) NOT NULL,
    PRIMARY KEY (canal_id),
    Foreign Key (id_usuario) REFERENCES usuarios (usuario_id)
);

CREATE TABLE subscripcion_canales(
    subscripcion_id INT(11) NOT NULL AUTO_INCREMENT,
    id_canal INT(11) NOT NULL,
    id_usuario INT(11) NOT NULL,
    PRIMARY KEY (subscripcion_id),
    Foreign Key (id_canal) REFERENCES canales (canal_id),
    Foreign Key (id_usuario) REFERENCES usuarios (usuario_id)
);

CREATE TABLE likes_video(
    likes_video_id INT(11) NOT NULL AUTO_INCREMENT,
    id_video INT(11) NOT NULL,
    id_usuario INT(11) NOT NULL,
    like_dislike ENUM('like', 'dislike') NOT NULL,
    fecha_like DATETIME NOT NULL,
    PRIMARY KEY (likes_video_id),
    Foreign Key (id_video) REFERENCES videos (video_id),
    Foreign Key (id_usuario) REFERENCES usuarios (usuario_id)
);

CREATE TABLE playlists(
    playlist_id INT(11) NOT NULL AUTO_INCREMENT,
    id_usuario INT(11) NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    fecha_creacion DATETIME NOT NULL,
    estado ENUM('publica', 'privada'),
    PRIMARY KEY (playlist_id),
    Foreign Key (id_usuario) REFERENCES usuarios (usuario_id)
);

CREATE TABLE videos_en_playlist(
    id_playlist INT(11) NOT NULL,
    id_video INT(11) NOT NULL,
    Foreign Key (id_playlist) REFERENCES playlists (playlist_id),
    Foreign Key (id_video) REFERENCES videos (video_id)
);

CREATE TABLE comentarios(
    comentario_id INT(11) NOT NULL AUTO_INCREMENT,
    id_usuario INT(11) NOT NULL,
    id_video INT(11) NOT NULL,
    texto_comentario VARCHAR(250) NOT NULL,
    fecha_hora DATETIME NOT NULL,
    PRIMARY KEY (comentario_id),
    Foreign Key (id_usuario) REFERENCES usuarios (usuario_id),
    Foreign Key (id_video) REFERENCES videos (video_id)
);

CREATE TABLE likes_comentario(
    likes_comentario_id INT(11) NOT NULL AUTO_INCREMENT,
    id_comentario INT(11) NOT NULL,
    id_usuario INT(11) NOT NULL,
    like_dislike ENUM('like', 'dislike') NOT NULL,
    fecha_like DATETIME NOT NULL,
    PRIMARY KEY (likes_comentario_id),
    Foreign Key (id_comentario) REFERENCES comentarios (comentario_id),
    Foreign Key (id_usuario) REFERENCES usuarios (usuario_id)
);