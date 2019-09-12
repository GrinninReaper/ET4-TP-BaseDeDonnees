SELECT email
FROM tp_sql.article AS tA
WHERE tA.nomAut = 'Buneman' AND tA.prenomAut = 'Buneman';

SELECT distinct aecrit.titre
FROM tp_sql.aecrit AS article, tp_sql.auteur AS auteur
WHERE auteur.nomAut = 'Davidson' AND auteur.prenomAut = 'Susan' AND auteur.email = aecrit.email;

SELECT nomAut, prenomAut
FROM tp_sql.auteur as auteur, 
WHERE 
