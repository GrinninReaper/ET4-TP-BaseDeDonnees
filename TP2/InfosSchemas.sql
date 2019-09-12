TABLE article (titre,resume,typeArticle);

TABLE siteweb(url);

TABLE auteur (email, nomAut, prenomAut, urlAuteur);

TABLE  utilisateur (email);

TABLE laboratoire(nomLabo, sigle,adresse);

TABLE support (nomSup, typeSupport);	

TABLE tag (libelle);

TABLE aecrit (titre,email);

TABLE supportArticle (titre,nomSup,annee);

TABLE travaille (email,nomLabo);

TABLE annot (email,titre,libelle);

TABLE APourNote(email,titre,note);

TABLE urllabo (nomLabo, url);

