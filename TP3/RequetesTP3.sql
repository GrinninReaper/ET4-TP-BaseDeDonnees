//1
SELECT email
FROM auteur 
WHERE nomAut = 'Buneman' 
    AND prenomAut = 'Peter';

//2
SELECT article.*
FROM tp_sql.aecrit AS aecrit, tp_sql.auteur AS auteur
WHERE auteur.nomAut = 'Davidson' 
    AND auteur.prenomAut = 'Susan' 
    AND auteur.email = aecrit.email;

//3
SELECT u1.nomLabo AS nm1, u2.nomLabo as nm2 
FROM tp_sql.urllabo u1, tp_sql.urllabo u2
WHERE u1.url = u2.url 
    AND u1.nomLabo < u2.nomLabo;

//4
SELECT auteur.email, auteur.prenomAut, auteur.nomAut
FROM tp_sql.auteur AS auteur, tp_sql.aecrit AS aecrit
WHERE aecrit.titre IN[
    SELECT aecrit.titre
    FROM tp_sql.aecrit NATURAL JOIN tp_sql.auteur
    WHERE prenomAut = 'Susan'
        AND nomAut = 'Davidson'];


***CORRECTION***
SELECT auteur2.email, auteur2.nomAut, auteur2.prenomAut
FROM auteur as auteur1, auteur as auteur2, aecrit as aecrit1, aecrit as aecrit2
WHERE auteur1.email = aecrit1.mail AND auteur1.nomAut = 'Davidson' AND auteur1.prenomAut = 'Susan' //auteur1 = Susan
    AND aecrit1.titre = aecrit2.titre //les articles de Susas
    AND auteur2.email = aecrit2.email //les co-auteurs
    AND auteur1.email != auteur2.email; //ne pas renvoyer Susan

//5
SELECT email, COUNT(nomLabo)
FROM tp_sql.travaille AS travaille
GROUP BY email;

//6
SELECT auteur.nomAut, auteur.prenomAut
FROM tp_sql.annot annot, tp_sql.auteur auteur
WHERE annot.email = auteur.email;


***CORRECTION***
SELECT distinct email
FROM tp_sql.annot;

//7
SELECT auteur.nomAut, auteur.prenomAut
FROM tp_sql.annot annot, tp_sql.auteur auteur
WHERE annot.email = auteur.email
GROUP BY auteur.email
HAVING COUNT(distinct annot.titre) > 3;

***CORRECTION***
SELECT distinct email
FROM annot
GROUP BY email
HAVING(COUNT DISTINCT titre > 3);

//8
SELECT AVG(APourNote.note)
FROM tp_sql.APourNote AS APourNote, tp_sql.auteur AS auteur
WHERE APourNote.email = auteur.email
    AND auteur.nomAut = 'Segoufin'
    AND auteur.prenomAut = 'Luc';

//9
SELECT AVG(APourNote.note)
FROM tp_sql.aecrit AS aecrit,tp_sql.APourNote as APourNote
WHERE aecrit.email = APourNote.email
    AND aecrit.titre = ApourNote.titre
GROUP BY APourNote.titre;

***CORRECTION***
SELECT APourNote.titre,AVG(APourNote.note)
FROM tp_sql.aecrit AS aecrit,tp_sql.APourNote as APourNote
WHERE aecrit.email = APourNote.email
    AND aecrit.titre = ApourNote.titre
GROUP BY APourNote.titre;
//IMPORTANT : Ce qui est dans le GROUP BY doit etre dans le SELECT

//10
SELECT aecrit.email
FROM tp_sql.annot as annot, tp_sql.aecrit as aecrit
WHERE annot.email NOT IN [SELECT aecrit.email
                            FROM tp_sql.aecrit as aecrit
                            WHERE 


***CORRECTION***
SELECT distinct email
FROM annot
EXCEPT
SELECT distinct aecrit.email
FROM aecrit, annot
WHERE aecrit.email = annot.email
    AND aecrit;tire = annot.titre;

//11
SELECT email
FROM tp_sql.APourNote as APourNote
WHERE APourNote.note = MAX(APourNote.note)
GROUP By APourNote.titre;

***CORRECTION***
SELECT email
FROM tp_sql.APourNote as APourNote
WHERE APourNote.note = SELECT MAX(APourNote.note)
                           FROM APourNote;
//IMPORTANT: Jamais mettre de max dans le where

//12
SELECT annot.email
FROM tp_sql.annot as annot, tp_sql.aecrit as aecrit
WHERE aecrit.email = 'susan@cis.upenn.edu'
    AND annot.titre = aecrit.titre
MINUS
SELECT annot.email
FROM tp_sql.annot as annot, tp_sql.aecrit as aecrit
WHERE aecrit.email <> 'susan@cis.upenn.edu';

//13
SELECT annot.email
FROM tp_sql.annot as annot
EXCEPT
(
SELECT annot.email
FROM tp_sql.annot as annot, tp_sql.aecrit as aecrit
WHERE aecrit.email = 'susan@cis.upenn.edu'
    AND annot.titre = aecrit.titre;
MINUS
SELECT annot.email
FROM tp_sql.annot as annot, tp_sql.aecrit as aecrit
WHERE aecrit.email <> 'susan@cis.upenn.edu'
);

//14
IMPOSSIBLE AVEC LES INSTRUCTIONS DE BASE DE SQL
ESSAYER AVEC PL/SQL, CURSOR, PRIOR BY...
ON PEUT CHERCHER LA TABLE POUR DÉCOUBLER LES TABLEAU AUTANT DE FOIS QU'IL FAUT MAIS C TRICHER
DANS UN RÉSEAU PETIT MONDE IL DOIT ETRE POSSIBLE DE SE LIMITER A 10 DEDOUBLEMENTS 









