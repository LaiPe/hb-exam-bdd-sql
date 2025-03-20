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



-- 3b : Ajouter les livres : "Orgueil et Préjugés", "David Copperfield", "Vingt mille lieues sous les mers", "Frankenstein".


-- 3c : Ajouter des emprunts pour que chaque adhérent emprunte chaque chaque livre.


-- 4 : Charles Dickens déménage, mettez à jour son adresse dans la base de données. 


-- 5 : Un livre est empruntable 30 jours, faites une vue qui affiche les personnes qui ont des livres en retard et les livres en question


-- 6 : Créer un trigger qui passe le booléen « disponible » à true si la date de retour d’un livre est précisée


-- 7 : Créer une procédure stockée qui passe le booléen « a_surveiller » à true si une personne a un retard de plus de 30 jours


-- 8 : Mary Shelley arrête son adhésion à la bibliothèque, supprimez son enregistrement de la base de données.


-- 9 : Sur quel(s) champ(s) pourrait-on mettre un index pour optimiser les requêtes et pourquoi ?


-- 10 : La bibliothèque doit se conformer à la RGPD. Quelle requête SQL utiliseriez-vous pour anonymiser la base de données? pour supprimer toute la base de données ?

