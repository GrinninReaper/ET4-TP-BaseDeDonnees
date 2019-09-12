-- Auteur: Anandou CANDASSAMY 
-- Titre: TP NOTE BD

--EXERCICE 1

    --QUESTION 1
EXPLAIN SELECT title
FROM movie
WHERE year < 1900;

/**
On obtient un changement de la méthode de recherche à partir d'un nombre de lignes supérieur à 200. 
Donc à partir de 200 lignes de résultats, le SGBD décide d'utiliser un Seq Scan.
**/


    --QUESTION 2
-- On obtiendra la valeur des minima est des maxima avec:

SELECT MAX(year) FROM movie;
SELECT MIN(year) FROM movie;

/**
Le minimum de year est 1920 et le maximum est 2013.
Donc le SGBD calcule ((2013-1923)/(2013-1920)) * ((2013-1933)/(1920-2013)) = 0.832 pour la première requete
Le SGBD calcul ((2013-2000)/(2013-1920))*((2013-2010)/(1920-2013)) = 0.004 
**/

EXPLAIN SELECT *
FROM movie 
WHERE year >= 1923 AND year < 1933;

EXPLAIN SELECT *
FROM movie 
WHERE year >= 2000 AND year < 2010;

/**
Ces deux requetes montrent que pour la première requete, le SGBD utilise Bitmap Heap Scan.
Pour la deuxième requete il utilise Seq Scan.
On voit que le facteur de réduction semble dire que la deuxième requete renvoie moins de résultat.
Cependant PostGres utilise Bitmap Heap Scan pour la première et Seq Scan pour la deuxième.
PostGres  ignore le calcul du facteur de réduction.
**/


    --QUESTION 3

-- La requete demandé est:
SELECT year, COUNT(*)
FROM movie
GROUP BY year
ORDER BY year;

/**
Le nombre d'occurences des années de l'intervalle 1923-1933 est bcp plus petit que celui des années de l'intervalle 2000-2010. 
Vu les méthodes utilisées par PostGres pour la réponse aux requetes, PostGres a des informations sur les nombres de lignes par valeur pour certains attributs de la table.
**/


    --QUESTION 4
EXPLAIN ANALYSE SELECT * 
FROM movie
WHERE year >= 1920 AND year < 1940;

/**
Pour 1940, PostGres utilise Bitmap Heap Scan
Pour 1960, PostGres utilise Bitmap Heap Scan
Pour 1980, PostGres utilise Bitmap Heap Scan
Pour 1992, PostGres utilise Seq Scan
Pour 1993, PostGres utilise Seq Scan
**/

CLUSTER movie
USING movie_year_index;
ANALYSE movie;

/**
Question 1:
La ligne ANALYSE permet de mettre à jour les statistiques des PostGres pour la table movie.
Sans cette ligne, les statistiques ne seraient pas à jour pour la nouvelle configuration de la table.


Question 2:
Pour les trois premières valeurs le plan de requête montre une utilisation de Index Scan using movie_year_index.
En rendant l'index groupant on permet une lecteur simplifiée des valeurs. 
En effet les tuples sont rangés dans l'ordre des années croissantes dans le disque dur.
L'accès à l'emplacement dans le disque dur demande beaucoup moins de temps. 
Le nombre de pages auquel il est nécessaire d'accéder est beaucoup plus petit.  


Question 3:
Dans le cas 1992, la requête renvoie 373 lignes.
En considérant le pire cas, on peut 
Dans le cas 1993, la requete renvoie 393 lignes.
**/

--EXERCICE 2
    --QUESTION 1

EXPLAIN ANALYSE SELECT *
FROM movie
WHERE year-1950 = 0;

EXPLAIN ANALYSE SELECT *
FROM movie
WHERE year = 1950;

/**
Les deux requêtes envoient le même résultat.
En effet la condition est seulement réécris d'une autre façon.

La première requête met: planning time : 0.219 ms
exec time:0.239 ms

La deuxième requête met: planning time: 0.212 ms
exec time : 0.075 ms

Donc on peut voir que le temps d'exécution de la deuxième requête est nettement inférieur à celui de la première requête.
Cela est du au fait que la première requête demande le résultat d'un calcul. 
Alors que la deuxième requête est seulement la vérification d'une égalité. 
**/


    --QUESTION 2

EXPLAIN ANALYSE SELECT distinct *
FROM people;

EXPLAIN ANALYSE SELECT *
FROM people;

/**
Le résultat des deux requêtes sera le même.
Le distinct est en effet inutile. La seule table de la requête, people, est privilégiée. 
Le SELECT prend tous les attributs de la table donc elle contient la clé primaire de la table.

La première requete met: planning time :0.119 ms
exec time: 10.923 ms
La deuxième requête met: planning time :0.041 ms
exec time: 3.526 ms

Comme attendu sans distinct la deuxième requete est beaucoup plus rapide à l'exécution.
Cette différence est du a la seule différence entre les deux requetes: le distinct.
**/


    --QUESTION 3

EXPLAIN ANALYSE SELECT distinct p.firstname, p.lastname, m.title
FROM people p, movie m, role r
WHERE p.pid = r.pid AND m.mid = r.mid;

EXPLAIN ANALYSE SELECT p.firstname, p.lastname, m.title
FROM people p, movie m, role r
WHERE p.pid = r.pid AND m.mid = r.mid;


/**
Le distinct est nécessaire. En effet, la clause SELECT ne possède aucune des clés primaires des tableaux de la partie WHERE. Ainsi aucune table ne peut être privilégiée et aucune table ne rejoint une table privilégiée. Si le doute subsiste il est possible de taper la requête avec et sans distinct dans le but de voir le nombre de résultats. Les deux requêtes précédentes confirment bien la conjecture. La requete distinct donne un résultat de 14533 lignes tandis que sans le distinct on obtient un résultat de 14535 lignes.
**/


