INSERT INTO "Museo"."Artista" ("Nome", "Cognome", "Data_Nascita", "Data_Morte", "Stile_Pittorico")
VALUES
    ('Franchino', 'Er Criminale', '1978-04-12', null, 'Postrealismo');

INSERT INTO "Museo"."Opera" ("Titolo", "Anno", "Materiale", "Tecnica", "Descrizione", "Codice_Artista")
VALUES
    ('Carbo Crema Pistacchisa', '2021', 'Farina e Acqua', 'Impasto', 'Pizza bassa e scrocchiarella della tradizione Romana', 6),
    ('Il Supplì anemico', '2022', 'Farina, Acqua e Riso', 'Impasto', 'Supplì anemico perchè hanno risparmiato sul sugo', 6);

INSERT INTO "Museo"."Storia" ("Titolo", "TSTPI", "TSTPF", "Email", "eliminata")
VALUES
    ('Er Pokè magnatelo te', '2023-01-10 16:00:00', '2023-01-10 16:05:00', 'giovanna@email.com', false);

INSERT INTO "Museo"."Parte" ("ID_Storia", "Codice_Opera", "Pagina")
VALUES
    (2, 6, 1),
    (2, 7, 2);