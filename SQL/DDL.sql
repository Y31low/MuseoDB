CREATE SCHEMA IF NOT EXISTS "Museo";

CREATE TABLE IF NOT EXISTS "Museo"."Persona"
(
    "Email" character varying(320) COLLATE pg_catalog."default" NOT NULL,
    "Nome" character varying(20) COLLATE pg_catalog."default",
    "Cognome" character varying(30) COLLATE pg_catalog."default",
    "Data_Nascita" date,
    "Genere" character(1) COLLATE pg_catalog."default",
    "Password" bit varying(1024),
    CONSTRAINT "Persona_pkey" PRIMARY KEY ("Email"),
    CONSTRAINT "Persona_Genere_check" CHECK ("Genere" = 'M'::bpchar OR "Genere" = 'F'::bpchar) NOT VALID
);

CREATE TABLE IF NOT EXISTS "Museo"."Utente"
(
    "Email" character varying(320) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Utente_pkey" PRIMARY KEY ("Email"),
    CONSTRAINT "Utente_Email_fkey" FOREIGN KEY ("Email")
        REFERENCES "Museo"."Persona" ("Email") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Museo"."Curatore"
(
    "Email" character varying(320) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Curatore_pkey" PRIMARY KEY ("Email"),
    CONSTRAINT "Curatore_Email_fkey" FOREIGN KEY ("Email")
        REFERENCES "Museo"."Utente" ("Email") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Museo"."Gruppo"
(
    "Supervisore" character varying(320) COLLATE pg_catalog."default" NOT NULL,
    "Titolo" character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Gruppo_pkey" PRIMARY KEY ("Supervisore"),
    CONSTRAINT "Gruppo_Supervisore_fkey" FOREIGN KEY ("Supervisore")
        REFERENCES "Museo"."Utente" ("Email") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "Museo"."Appartiene"
(
    "Email" character varying(320) COLLATE pg_catalog."default" NOT NULL,
    "Supervisore" character varying(320) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Appartiene_pkey" PRIMARY KEY ("Email", "Supervisore"),
    CONSTRAINT "Appartiene_Email_fkey" FOREIGN KEY ("Email")
        REFERENCES "Museo"."Persona" ("Email") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Appartiene_Supervisore_fkey" FOREIGN KEY ("Supervisore")
        REFERENCES "Museo"."Gruppo" ("Supervisore") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE SEQUENCE "Museo"."Artista_Codice_Artista_seq" AS integer increment by 1;

CREATE TABLE IF NOT EXISTS "Museo"."Artista"
(
    "Codice_Artista" integer NOT NULL DEFAULT nextval('"Museo"."Artista_Codice_Artista_seq"'::regclass),
    "Nome" character varying(20) COLLATE pg_catalog."default" NOT NULL,
    "Cognome" character varying(30) COLLATE pg_catalog."default" NOT NULL,
    "Data_Nascita" date,
    "Data_Morte" date,
    "Stile_Pittorico" character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Artista_pkey" PRIMARY KEY ("Codice_Artista")
);

CREATE SEQUENCE "Museo"."Opera_Codice_Opera_seq" AS integer increment by 1;

CREATE TABLE IF NOT EXISTS "Museo"."Opera"
(
    "Codice_Opera" integer NOT NULL DEFAULT nextval('"Museo"."Opera_Codice_Opera_seq"'::regclass),
    "Titolo" character varying(30) COLLATE pg_catalog."default" NOT NULL,
    "Anno" integer NOT NULL,
    "Materiale" character varying(50) COLLATE pg_catalog."default" NOT NULL,
    "Tecnica" character varying(30) COLLATE pg_catalog."default" NOT NULL,
    "Descrizione" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "Codice_Artista" integer NOT NULL,
    CONSTRAINT "Opera_pkey" PRIMARY KEY ("Codice_Opera"),
    CONSTRAINT "Opera_Codice_Artista_fkey" FOREIGN KEY ("Codice_Artista")
        REFERENCES "Museo"."Artista" ("Codice_Artista") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE SEQUENCE "Museo"."Storia_ID_Storia_seq" AS integer increment by 1;

CREATE TABLE IF NOT EXISTS "Museo"."Storia"
(
    "ID_Storia" integer NOT NULL DEFAULT nextval('"Museo"."Storia_ID_Storia_seq"'::regclass),
    "Titolo" character varying(30) COLLATE pg_catalog."default",
    "TSTPI" timestamp without time zone,
    "TSTPF" timestamp without time zone,
    "Email" character varying(320) COLLATE pg_catalog."default",
    eliminata boolean DEFAULT true,
    CONSTRAINT "Storia_pkey" PRIMARY KEY ("ID_Storia"),
    CONSTRAINT "Storia_Email_fkey" FOREIGN KEY ("Email")
        REFERENCES "Museo"."Utente" ("Email") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Museo"."Parte"
(
    "ID_Storia" integer NOT NULL,
    "Codice_Opera" integer NOT NULL,
    "Pagina" smallint NOT NULL,
    CONSTRAINT "Parte_pkey" PRIMARY KEY ("ID_Storia", "Codice_Opera"),
    CONSTRAINT "Parte_Codice_Opera_fkey" FOREIGN KEY ("Codice_Opera")
        REFERENCES "Museo"."Opera" ("Codice_Opera") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Parte_ID_Storia_fkey" FOREIGN KEY ("ID_Storia")
        REFERENCES "Museo"."Storia" ("ID_Storia") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Museo"."Commento"
(
   "Email" character varying(320) COLLATE pg_catalog."default" NOT NULL,
    "ID_Storia" integer NOT NULL,
    "Commento" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Commento_pkey" PRIMARY KEY ("Email", "ID_Storia"),
        CONSTRAINT "Commento_ID_Storia_fkey" FOREIGN KEY ("ID_Storia")
        REFERENCES "Museo"."Storia" ("ID_Storia") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Commento_Email_fkey" FOREIGN KEY ("Email")
        REFERENCES "Museo"."Persona" ("Email") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Museo"."Voto"
(
    "Email" character varying(320) COLLATE pg_catalog."default" NOT NULL,
    "ID_Storia" integer NOT NULL,
    "Voto" smallint NOT NULL,
    CONSTRAINT "Voto_pkey" PRIMARY KEY ("Email", "ID_Storia"),
    CONSTRAINT "Voto_Email_fkey" FOREIGN KEY ("Email")
        REFERENCES "Museo"."Persona" ("Email") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Voto_ID_Storia_fkey" FOREIGN KEY ("ID_Storia")
        REFERENCES "Museo"."Storia" ("ID_Storia") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Voto_Voto_check" CHECK ("Voto" >= 0 OR "Voto" <= 10)
);

CREATE TABLE IF NOT EXISTS "Museo"."Domande"
(
    "Codice_Opera" integer NOT NULL,
    "D1" character varying(30) COLLATE pg_catalog."default" NOT NULL,
    "D2" character varying(30) COLLATE pg_catalog."default" NOT NULL,
    "D3" character varying(30) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Domande_pkey" PRIMARY KEY ("Codice_Opera"),
    CONSTRAINT "Domande_Codice_Opera_fkey" FOREIGN KEY ("Codice_Opera")
        REFERENCES "Museo"."Opera" ("Codice_Opera") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Museo"."Risposte"
(
    "Email" character varying(320) COLLATE pg_catalog."default" NOT NULL,
    "Codice_Opera" integer NOT NULL,
    "R1" character varying(40) COLLATE pg_catalog."default" NOT NULL,
    "R2" character varying(40) COLLATE pg_catalog."default" NOT NULL,
    "R3" character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Risposte_pkey" PRIMARY KEY ("Email", "Codice_Opera"),
    CONSTRAINT "Risposte_Codice_Opera_fkey" FOREIGN KEY ("Codice_Opera")
        REFERENCES "Museo"."Opera" ("Codice_Opera") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Risposte_Email_fkey" FOREIGN KEY ("Email")
        REFERENCES "Museo"."Utente" ("Email") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Museo"."Emoji"
(
    "Email" character varying(320) COLLATE pg_catalog."default" NOT NULL,
    "Codice_Opera" integer NOT NULL,
    "Unicode" character varying(2) COLLATE pg_catalog."default" NOT NULL,
    "PosX" integer NOT NULL,
    "PosY" integer NOT NULL,
    CONSTRAINT "Emoji_pkey" PRIMARY KEY ("Email", "Codice_Opera"),
    CONSTRAINT "Emoji_Codice_Opera_fkey" FOREIGN KEY ("Codice_Opera")
        REFERENCES "Museo"."Opera" ("Codice_Opera") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Emoji_Email_fkey" FOREIGN KEY ("Email")
        REFERENCES "Museo"."Persona" ("Email") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Museo"."HashTag"
(
    "Email" character varying(320) COLLATE pg_catalog."default" NOT NULL,
    "Codice_Opra" integer NOT NULL,
    "Tag" character varying(80) COLLATE pg_catalog."default" NOT NULL,
    "PosX" integer NOT NULL,
    "PosY" integer NOT NULL,
    CONSTRAINT "HashTag_pkey" PRIMARY KEY ("Email", "Codice_Opra"),
    CONSTRAINT "HashTag_Codice_Opra_fkey" FOREIGN KEY ("Codice_Opra")
        REFERENCES "Museo"."Opera" ("Codice_Opera") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "HashTag_Email_fkey" FOREIGN KEY ("Email")
        REFERENCES "Museo"."Persona" ("Email") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Museo"."Etichetta"
(
    "Email" character varying(320) COLLATE pg_catalog."default" NOT NULL,
    "Codice_Opera" integer NOT NULL,
    "Testo" character varying(120) COLLATE pg_catalog."default" NOT NULL,
    "PosX" integer NOT NULL,
    "PosY" integer NOT NULL,
    CONSTRAINT "Etichetta_pkey" PRIMARY KEY ("Email", "Codice_Opera"),
    CONSTRAINT "Etichetta_Codice_Opera_fkey" FOREIGN KEY ("Codice_Opera")
        REFERENCES "Museo"."Opera" ("Codice_Opera") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Etichetta_Email_fkey" FOREIGN KEY ("Email")
        REFERENCES "Museo"."Persona" ("Email") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);