-- 1 : Créer la base de données et les tables
CREATE DATABASE promotion CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE promotion;

CREATE TABLE etudiants (
    id_etudiant INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    moyenne DECIMAL(4,2)
);

CREATE TABLE matieres (
    code_mat VARCHAR(10) PRIMARY KEY,
    libelle_mat VARCHAR(100) NOT NULL,
    coeff_mat DECIMAL(3,1) NOT NULL
);

CREATE TABLE etudiants_matieres (
    id_etudiant INT,
    code_mat VARCHAR(10),
    date_eval DATE NOT NULL,
    note DECIMAL(4,2) NOT NULL,
    PRIMARY KEY (id_etudiant, code_mat),
    FOREIGN KEY (id_etudiant) REFERENCES etudiants(id_etudiant) ON DELETE CASCADE,
    FOREIGN KEY (code_mat) REFERENCES matieres(code_mat) ON DELETE CASCADE
);

-- 2 : Création de l'utilisateur "prof"
CREATE USER 'prof'@'localhost' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON promotion.* TO 'prof'@'localhost';
FLUSH PRIVILEGES;