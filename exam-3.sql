-- 1 Lister tous les plats avec un prix inférieur à 20 €.
SELECT * FROM dishes WHERE price < 20;

-- 2 Lister tous les plats des restaurants de cuisine Française et de cuisine Italienne en utilisant IN.


-- 3 Lister tous les ingrédients du Bœuf Bourguignon. 
SELECT * FROM ingredients WHERE dish_id = 1;


-- 4 Lister tous les chefs (leur nom uniquement) et leurs restaurants (leur nom uniquement).
SELECT c.name AS "Nom du chef", r.name AS "Nom du restaurant" FROM chefs c 
LEFT JOIN restaurants r ON c.restaurant_id = r.id;


-- 5 Lister les chefs et le nombre de plats qu'ils ont créés.
SELECT chefs.*, COUNT(*) AS dishes_count FROM dishes 
JOIN chefs ON dishes.chef_id = chefs.id
GROUP BY chefs.id;

-- 6 Lister les chefs qui ont créé plus d'un plat.
SELECT chefs.* FROM dishes 
JOIN chefs ON dishes.chef_id = chefs.id
GROUP BY chefs.id
HAVING COUNT(*) > 1;

-- 7 Calculez le nombre de chefs ayant créé un seul plat.


-- 8 Calculez le nombre de plats pour chaque type de cuisine.


-- 9 Calculez le prix moyen des plats par type de cuisine.


-- 10 Trouver le prix moyen des plats créés par chaque chef, en incluant seulement les chefs ayant créé plus de 2 plats

