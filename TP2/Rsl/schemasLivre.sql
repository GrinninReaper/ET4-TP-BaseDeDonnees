CREATE TABLE tp_sql.article(
    titre varchar(255),
    resume varchar(20000),
    typeArticle varchar (255),
    PRIMARY KEY (titre)
);

CREATE TABLE tp_sql.siteweb(
    url varchar(255),
    PRIMARY KEY (url)
);

CREATE TABLE tp_sql.auteur(
    email varchar(255),
    nomAut varchar(255),
    prenomAt varchar(255),
    urlAuteur varchar(255),
    PRIMARY KEY  (email)
);

CREATE TABLE tp_sql.utilisateur(
    email varchar(255),
    PRIMARY KEY (email)
);

CREATE TABLE tp_sql.laboratoire(
    nomLabo varchar(255),
    sigle varchar(255),
    adresse varchar(255),
    PRIMARY KEY (nomLabo)
);

CREATE TABLE tp_sql.support(
    nomSup varchar(255),
    typeSupport varchar(255),
    PRIMARY KEY (nomSup)
);

CREATE TABLE tp_sql.tag(
    libelle varchar(255),
    PRIMARY KEY (libelle)
);

CREATE TABLE tp_sql.aecrit(
    titre varchar (255),
    email varchar(255),
    PRIMARY KEY (titre,email),
    FOREIGN KEY (titre)  REFERENCES tp_sql.article(titre),
    FOREIGN KEY (email) REFERENCES tp_sql.auteur(email)
);

CREATE TABLE tp_sql.supportArticle(
    titre varchar(255),
    nomSup varchar(255),
    annee int,
    PRIMARY KEY (titre, nomSup),
    FOREIGN KEY (titre) REFERENCES tp_sql.auteur(email)
);

CREATE TABLE tp_sql.travaille(
    email varchar(255),
    nomLabo varchar(255),
    PRIMARY KEY (email, nomLabo),
    FOREIGN KEY (email) REFERENCES tp_sql.auteur(email)
);

CREATE TABLE tp_sql.annot(
    email varchar(255),
    titre varchar(255),
    libelle varchar(255),
    PRIMARY KEY (email, titre),
    FOREIGN KEY (email) REFERENCES tp_sql.utilisateur(email),
    FOREIGN KEY (libelle) REFERENCES tp_sql.tag(libelle)
);

CREATE TABLE tp_sql.APourNote(
    email varchar(255),
    titre varchar(255),
    note int,
    PRIMARY KEY (email, titre),
    FOREIGN KEY (email) REFERENCES tp_sql.utilisateur(email)
);

CREATE TABLE tp_sql.urllabo(
    nomLabo varchar(255),
    url varchar(255),
    PRIMARY KEY (nomLabo),
    FOREIGN KEY (nomLabo) REFERENCES tp_sql.laboratoire(nomLabo)
);
