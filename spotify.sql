-- Active: 1665674772622@@127.0.0.1@3306@test1
DROP DATABASE spotify;

CREATE DATABASE spotify;

USE spotify;

CREATE TABLE usuaris(
    usuari_id INT(11) NOT NULL AUTO_INCREMENT, 
    email VARCHAR(45) NOT NULL UNIQUE, 
    contrassenya VARCHAR(20) NOT NULL, 
    nom_usuari VARCHAR(45) NOT NULL, 
    data_neixement DATE NOT NULL, 
    sexe ENUM('masculi', 'femeni') NOT NULL, 
    pais VARCHAR(45) NOT NULL, 
    codi_Postal VARCHAR(11) NOT NULL, 
    PRIMARY KEY(usuari_id)
);

CREATE TABLE usuaris_premium(
    usuari_premium_id INT(11) NOT NULL AUTO_INCREMENT, 
    id_usuari INT(11) NOT NULL, 
    PRIMARY KEY(usuari_premium_id), 
    FOREIGN KEY(id_usuari) REFERENCES usuaris (usuari_id)
);

CREATE TABLE subscripcions_premium(
    subscripcio_premium_id INT(11) NOT NULL AUTO_INCREMENT,  
    id_usuari_premium INT(11) NOT NULL, 
    data_inici_subscripcio DATE NOT NULL, 
    data_fi_subscripcio DATE NOT NULL, 
    metode_pagament ENUM('targeta', 'paypal') NOT NULL, 
    PRIMARY KEY(subscripcio_premium_id), 
    Foreign Key (id_usuari_premium) REFERENCES usuaris_premium (usuari_premium_id)
);

CREATE TABLE targeta(
    targeta_id INT(11) NOT NULL AUTO_INCREMENT, 
    id_usuari_premium INT(11) NOT NULL, 
    numero_targeta INT(20) NOT NULL, 
    mes_any DATE NOT NULL, 
    codi_seguretat int(3) NOT NULL, 
    PRIMARY KEY(targeta_id), 
    Foreign Key (id_usuari_premium) REFERENCES usuaris_premium(usuari_premium_id)
);

CREATE TABLE paypal(
    paypal_id INT(11) NOT NULL AUTO_INCREMENT, 
    id_usuari_premium INT(11) NOT NULL, 
    nom_usuari VARCHAR(20) NOT NULL, 
    PRIMARY KEY(paypal_id), 
    Foreign Key (id_usuari_premium) REFERENCES usuaris_premium (usuari_premium_id)
);

CREATE TABLE registre_pagaments(
    registre_pagament_id INT(11) NOT NULL AUTO_INCREMENT, 
    id_targeta INT(11) NOT NULL, 
    id_paypal INT(11) NOT NULL, 
    data_pagament DATE NOT NULL, 
    total_pagament DECIMAL(10, 2), 
    PRIMARY KEY(registre_pagament_id), 
    FOREIGN KEY (id_targeta) REFERENCES targeta (targeta_id), 
    FOREIGN KEY (id_paypal) REFERENCES paypal (paypal_id)
);

CREATE TABLE playlists_actives(
    playlist_activa_id INT(11) NOT NULL AUTO_INCREMENT, 
    id_usuari INT(11) NOT NULL, 
    titol VARCHAR(20) NOT NULL, 
    numero_cançons INT(3) NOT NULL, 
    data_creacio TIMESTAMP NOT NULL, 
    PRIMARY KEY (playlist_activa_id), 
    FOREIGN KEY (id_usuari) REFERENCES usuaris (usuari_id)
);

CREATE TABLE playlists_eliminades(
    playlist_eliminada_id INT(11) NOT NULL AUTO_INCREMENT, 
    id_playlist INT(11) NOT NULL, 
    data_eliminacio TIMESTAMP NOT NULL, 
    PRIMARY KEY (playlist_eliminada_id), 
    Foreign Key (id_playlist) REFERENCES playlists_actives(playlist_activa_id)
);

CREATE TABLE artistes(
    artista_id INT(11) NOT NULL AUTO_INCREMENT, 
    nom VARCHAR(20) NOT NULL, 
    img_artista BLOB NOT NULL, 
    PRIMARY KEY (artista_id)
);

CREATE TABLE albums(
    album_id INT(11) NOT NULL AUTO_INCREMENT, 
    id_artista INT(11) NOT NULL, 
    titol VARCHAR(20) NOT NULL, 
    any_publicacio INT(4) NOT NULL,
    portada BLOB NOT NULL, 
    PRIMARY KEY (album_id), 
    Foreign Key (id_artista) REFERENCES artistes(artista_id)
);

CREATE TABLE cançons(
    canço_id int(11) NOT NULL AUTO_INCREMENT, 
    id_album INT(11) NOT NULL, 
    titol VARCHAR(20) NOT NULL, 
    durada VARCHAR(10) NOT NULL, 
    reproduccions INT (11) NOT NULL, 
    PRIMARY KEY (canço_id), 
    Foreign Key (id_album) REFERENCES albums (album_id)
);

CREATE TABLE canço_afegida(
    canço_afegida_id INT(11) NOT NULL AUTO_INCREMENT, 
    id_playlist INT(11) NOT NULL, 
    id_usuari INT(11) NOT NULL, 
    id_canço INT(11) NOT NULL, 
    data_pujada TIMESTAMP NOT NULL, 
    PRIMARY KEY (canço_afegida_id), 
    Foreign Key (id_playlist) REFERENCES playlists_actives(playlist_activa_id), 
    Foreign Key (id_usuari) REFERENCES usuaris(usuari_id), 
    Foreign Key (id_canço) REFERENCES cançons(canço_id)
);

CREATE TABLE artistes_relacionats(
    artista_relacionat_id INT(11) NOT NULL AUTO_INCREMENT, 
    id_artista1 INT(11) NOT NULL, 
    id_artista2 INT(11) NOT NULL, 
    PRIMARY KEY (artista_relacionat_id), 
    Foreign Key (id_artista1) REFERENCES artistes(artista_id), 
    Foreign Key (id_artista2) REFERENCES artistes(artista_id)
);

CREATE TABLE albums_favorits( 
    album_favorit_id INT(11) NOT NULL AUTO_INCREMENT, 
    id_usuari INT(11) NOT NULL, 
    id_album INT(11) NOT NULL, 
    PRIMARY KEY (album_favorit_id), 
    Foreign Key (id_usuari) REFERENCES usuaris(usuari_id), 
    Foreign Key (id_album) REFERENCES albums(album_id)
);

CREATE TABLE cançons_favorites(
    canço_favorita_id INT(11) NOT NULL AUTO_INCREMENT, 
    id_usuari INT(11) NOT NULL, 
    id_canço INT(11) NOT NULL, 
    PRIMARY KEY (canço_favorita_id), 
    Foreign Key (id_usuari) REFERENCES usuaris(usuari_id), 
    Foreign Key (id_canço) REFERENCES cançons(canço_id)
);