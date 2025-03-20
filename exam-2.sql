/*  RAPPEL CONCEPTION :

adhérents(id_adhérent, nom, adresse, date_inscription, a_surveiller)
livres(isbn, titre, auteur, année_publication, disponible)
emprunts(#id_adhérent, #isbn, date_emprunt, date_retour)

*/

-- 1a : Créer la base de données « bibliotheque » en UTF8. 
CREATE DATABASE IF NOT EXISTS bibliotheque 
CHARACTER SET utf8
COLLATE utf8_general_ci;

-- 1b : Créer les 3 tables en respectant les contraintes de relation et de référence. Les # ne doivent pas paraître dans le nom des champs.
USE bibliotheque;
DROP TABLE IF EXISTS adherents, livres, emprunts;

CREATE TABLE adherents (
    id_adherent INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    adresse VARCHAR(200) NOT NULL,
    date_inscription DATE NOT NULL,
    a_surveiller BOOLEAN NOT NULL
);

CREATE TABLE livres (
    isbn INT NOT NULL PRIMARY KEY,
    titre VARCHAR(200) NOT NULL,
    auteur VARCHAR(200) NOT NULL,
    annee_publication INT NOT NULL,
    disponible BOOLEAN NOT NULL
);

CREATE TABLE emprunts (
    id_adherent INT NOT NULL REFERENCES adherents(id),
    isbn INT NOT NULL REFERENCES livres(id),
    PRIMARY KEY (id_adherent, isbn),
    date_emprunt DATE NOT NULL,
    date_retour DATE NOT NULL
);

-- 2 : Créer un utilisateur « bibliothecaire » avec le mot de passe « secret » ayant accès uniquement à cette base de données bibliotheque avec tous les droits.
CREATE USER 'bibliothecaire'@'localhost'
IDENTIFIED BY "secret";

GRANT ALL PRIVILEGES ON bibliotheque.* TO 'bibliothecaire'@'localhost';

FLUSH PRIVILEGES; 


-- 3a : Ajouter les adhérents : Jane Austen, Charles Dickens, Jules Verne, Mary Shelley. 
INSERT INTO adherents (nom, adresse, date_inscription, a_surveiller) VALUES
("Jane Austen", "3 rue des pâquerettes, Clermont-Ferrand, France", '2020-04-05', FALSE),
("Charles Dickens", "10 Downing Street, Londres, Royaume-Uni", '2021-06-15', FALSE),
("Jules Verne", "2 allée des explorateurs, Nantes, France", '2019-09-20', FALSE),
("Mary Shelley", "5 boulevard des créatures, Genève, Suisse", '2022-01-10', FALSE);


-- 3b : Ajouter les livres : "Orgueil et Préjugés", "David Copperfield", "Vingt mille lieues sous les mers", "Frankenstein".
INSERT INTO livres (isbn, titre, auteur, annee_publication, disponible) VALUES
(123456, "Orgueil et Préjugés", "Jane Austen", 1813, TRUE),
(234567, "David Copperfield", "Charles Dickens", 1850, TRUE),
(345678, "Vingt mille lieues sous les mers", "Jules Verne", 1870, TRUE),
(456789, "Frankenstein", "Mary Shelley", 1818, TRUE);



-- 3c : Ajouter des emprunts pour que chaque adhérent emprunte chaque livre.
INSERT INTO emprunts (id_adherent, isbn, date_emprunt, date_retour) VALUES
(1, 123456, '2024-03-01', '2024-03-15'),
(1, 234567, '2024-03-02', '2024-03-16'),
(1, 345678, '2024-03-03', '2024-03-17'),
(1, 456789, '2024-03-04', '2024-03-18'),

(2, 123456, '2024-03-05', '2024-03-19'),
(2, 234567, '2024-03-06', '2024-03-20'),
(2, 345678, '2024-03-07', '2024-03-21'),
(2, 456789, '2024-03-08', '2024-03-22'),

(3, 123456, '2024-03-09', '2024-03-23'),
(3, 234567, '2024-03-10', '2024-03-24'),
(3, 345678, '2024-03-11', '2024-03-25'),
(3, 456789, '2024-03-12', '2024-03-26'),

(4, 123456, '2024-03-13', '2024-03-27'),
(4, 234567, '2024-03-14', '2024-03-28'),
(4, 345678, '2024-03-15', '2024-03-29'),
(4, 456789, '2024-03-16', '2024-03-30');


-- 4 : Charles Dickens déménage, mettez à jour son adresse dans la base de données. 
UPDATE adherents
SET adresse = "221B Baker Street, Londres, Royaume-Uni"
WHERE id = 2;


-- 5 : Un livre est empruntable 30 jours, faites une vue qui affiche les personnes qui ont des livres en retard et les livres en question


-- 6 : Créer un trigger qui passe le booléen « disponible » à true si la date de retour d’un livre est précisée


-- 7 : Créer une procédure stockée qui passe le booléen « a_surveiller » à true si une personne a un retard de plus de 30 jours


-- 8 : Mary Shelley arrête son adhésion à la bibliothèque, supprimez son enregistrement de la base de données.


-- 9 : Sur quel(s) champ(s) pourrait-on mettre un index pour optimiser les requêtes et pourquoi ?


-- 10 : La bibliothèque doit se conformer à la RGPD. Quelle requête SQL utiliseriez-vous pour anonymiser la base de données? pour supprimer toute la base de données ?

