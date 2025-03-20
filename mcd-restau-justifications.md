- Entité 'TypeCuisine' : Dans le sujet : "... Il est important d'enregistrer son nom, sa date de naissance, **les** types de cuisine qu'il maîtrise ..."

- Cardinalité 'Chef' vers 'Avoir' (1,n) : Un chef doit forcément avoir au moins un type de cuisine dans lequel il est spécialisé.

- Cardinalité 'Restaurant' vers 'Employer' (0,n) : Un restaurant doit au minimum employer un chef afin de pouvoir fonctionner. Cependant, dans le cas d'un licenciement de l'unique chef d'un restaurant, besoin de pouvoir avoir 0 chef pour un restaurant, donc (0,n).
