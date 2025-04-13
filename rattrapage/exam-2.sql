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

-- 3a : Ajout des étudiants
INSERT INTO etudiants (nom, prenom, moyenne) VALUES
('Skywalker', 'Luke', NULL),
('Organa', 'Leia', NULL),
('Solo', 'Han', NULL),
('Kenobi', 'Obi-wan', NULL);

-- 3b : Ajout des matières
INSERT INTO matieres (code_mat, libelle_mat, coeff_mat) VALUES
('BDD', 'Conception de BDD', 2.0),
('ADMIN', 'Admin BDD', 1.5),
('SQL', 'SQL', 2.5);

-- 3c : Ajout des notes
INSERT INTO etudiants_matieres (id_etudiant, code_mat, date_eval, note) VALUES
(1, 'BDD', '2025-04-01', 14.5),
(1, 'ADMIN', '2025-04-02', 15.0),
(1, 'SQL', '2025-04-03', 16.5),
(2, 'BDD', '2025-04-01', 17.0),
(2, 'ADMIN', '2025-04-02', 16.0),
(2, 'SQL', '2025-04-03', 18.0),
(3, 'BDD', '2025-04-01', 13.5),
(3, 'ADMIN', '2025-04-02', 12.0),
(3, 'SQL', '2025-04-03', 14.0),
(4, 'BDD', '2025-04-01', 15.5),
(4, 'ADMIN', '2025-04-02', 16.5),
(4, 'SQL', '2025-04-03', 17.0);

-- 4 : Modification du nom de famille de Leia
UPDATE etudiants SET nom = 'Solo' WHERE nom = 'Organa' AND prenom = 'Leia';

-- 5 : Suppression d'obi-wan Kenobi
DELETE FROM etudiants WHERE nom = 'Kenobi' AND prenom = 'Obi-wan';

-- 6 : Création du trigger de vérification de date
DELIMITER //
CREATE TRIGGER check_date_eval BEFORE INSERT ON etudiants_matieres
FOR EACH ROW
BEGIN
    IF NEW.date_eval > CURRENT_DATE() THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = "La date d'éval ne peut pas être dans le futur";
    END IF;
END //
DELIMITER ;

-- 8 : index ?

-- id_etudiant et code_mat dans la table etudiants_matieres sont déjà des index car ils font partie de la clé primaire et des clés étrangères.

-- On pourrait ajouter un index sur le champ nom dans la table etudiants car nous faisons souvent des recherches par nom d'étudiant.

-- Un index sur date_eval dans la table etudiants_matieres serait utile si on effectue des requêtes qui filtrent par date d'évaluation.


-- 9 : Requête RGPD
-- on peut conserver la structure et supprimer uniquement les données personnelles

DELETE FROM etudiants;
-- Les notes dans etudiants_matieres seront automatiquement supprimées grâce à ON DELETE CASCADE
