INSERT INTO "Museo"."Persona" ("Email", "Nome", "Cognome", "Data_Nascita", "Genere", "Password")
VALUES
    ('mario@email.com', 'Mario', 'Rossi', '1990-01-15', 'M', B'0'::bit(1024)),
    ('maria@email.com', 'Maria', 'Bianchi', '1985-05-20', 'F', B'1'::bit(1024)),
    ('luigi@email.com', 'Luigi', 'Verdi', '1982-09-30', 'M', B'10'::bit(1024)),
    ('giovanna@email.com', 'Giovanna', 'Neri', '1995-03-10', 'F', B'11'::bit(1024)),
    ('andrea@email.com', 'Andrea', 'Gialli', '1998-12-05', 'M', B'100'::bit(1024)),
    ('pippo@email.com', 'Pippo', 'Verdi', '1987-08-12', 'M', B'101'::bit(1024)),
    ('pluto@email.com', 'Pluto', 'Bianchi', '1992-03-25', 'M', B'110'::bit(1024));


INSERT INTO "Museo"."Utente" ("Email")
VALUES
    ('mario@email.com'),
    ('maria@email.com'),
    ('luigi@email.com'),
    ('giovanna@email.com'),
    ('andrea@email.com'),
    ('pippo@email.com');

INSERT INTO "Museo"."Curatore" ("Email")
VALUES
    ('pippo@email.com'),
    ('andrea@email.com');


INSERT INTO "Museo"."Gruppo" ("Supervisore", "Titolo")
VALUES
    ('mario@email.com', 'Gruppo 1'),
    ('maria@email.com', 'Gruppo 2');


INSERT INTO "Museo"."Appartiene" ("Email", "Supervisore")
VALUES
    ('mario@email.com', 'mario@email.com'),
    ('luigi@email.com', 'mario@email.com'),
    ('giovanna@email.com', 'maria@email.com'),
    ('maria@email.com', 'maria@email.com');


INSERT INTO "Museo"."Artista" ("Nome", "Cognome", "Data_Nascita", "Data_Morte", "Stile_Pittorico")
VALUES
    ('Leonardo', 'da Vinci', '1452-04-15', '1519-05-02', 'Rinascimento'),
    ('Vincent', 'van Gogh', '1853-03-30', '1890-07-29', 'Post-Impressionismo'),
    ('Pablo', 'Picasso', '1881-10-25', '1973-04-08', 'Cubismo'),
    ('Claude', 'Monet', '1840-11-14', '1926-12-05', 'Impressionismo'),
    ('Frida', 'Kahlo', '1907-07-06', '1954-07-13', 'Surrealismo');

INSERT INTO "Museo"."Opera" ("Titolo", "Anno", "Materiale", "Tecnica", "Descrizione", "Codice_Artista")
VALUES
    ('La Gioconda', '1503', 'Olio su tavola', 'Pittura ad olio', 'Ritratto di Lisa Gherardini', 1),
    ('Notte stellata', '1889', 'Olio su tela', 'Pittura ad olio', 'Paesaggio notturno con stelle', 2),
    ('Guernica', '1937', 'Olio su tela', 'Pittura ad olio', 'Rappresentazione della Guerra Civile Spagnola', 3),
    ('Ninfee', '1914', 'Olio su tela', 'Pittura ad olio', 'Serie di dipinti raffiguranti ninfee', 4),
    ('Le Due Frida', '1939', 'Olio su tela', 'Pittura ad olio', 'Autoritratto di Frida Kahlo', 5);


INSERT INTO "Museo"."Storia" ("Titolo", "TSTPI", "TSTPF", "Email", "eliminata")
VALUES
    ('Storia 1', '2023-01-10 14:00:00', '2023-01-10 15:00:00', 'mario@email.com', false);


INSERT INTO "Museo"."Parte" ("ID_Storia", "Codice_Opera", "Pagina")
VALUES
    (1, 1, 1),
    (1, 2, 2),
    (1, 3, 3);

INSERT INTO "Museo"."Commento" ("Email", "ID_Storia", "Commento")
VALUES
    ('maria@email.com', 1, 'Adoro questa opera!'),
    ('luigi@email.com', 1, 'Un capolavoro assoluto!'),
    ('giovanna@email.com', 1, 'Incredibile lavoro!'),
    ('andrea@email.com', 1, 'Molto ispirante!');

INSERT INTO "Museo"."Voto" ("Email", "ID_Storia", "Voto")
VALUES
    ('maria@email.com', 1, 8),
    ('luigi@email.com', 1, 7),
    ('giovanna@email.com', 1, 9),
    ('andrea@email.com', 1, 8);

INSERT INTO "Museo"."Domande" ("Codice_Opera", "D1", "D2", "D3")
VALUES
    (1, 'Mi ricorda', 'Mi fa pensare a', 'Mi fa sentire'),
    (2, 'Mi ricorda', 'Mi fa pensare a', 'Mi fa sentire'),
    (3, 'Mi ricorda', 'Mi fa pensare a', 'Mi fa sentire'),
    (4, 'Mi ricorda', 'Mi fa pensare a', 'Mi fa sentire'),
    (5, 'Mi ricorda', 'Mi fa pensare a', 'Mi fa sentire');

INSERT INTO "Museo"."Risposte" ("Email", "Codice_Opera", "R1", "R2", "R3")
VALUES
    ('pippo@email.com', 1, 'Giovinezza', 'Mare', 'Felice'),
    ('luigi@email.com', 2, 'Giovinezza', 'Mare', 'Felice'),
    ('mario@email.com', 3, 'Giovinezza', 'Mare', 'Felice'),
    ('maria@email.com', 4, 'Giovinezza', 'Mare', 'Felice'),
    ('andrea@email.com', 5, 'Giovinezza', 'Mare', 'Felice');


INSERT INTO "Museo"."Emoji" ("Email", "Codice_Opera", "Unicode", "PosX", "PosY")
VALUES
    ('mario@email.com', 3, '😊', 40, 20),
    ('pluto@email.com', 4, '👍', 70, 50),
    ('andrea@email.com', 5, '❤️', 30, 10),
    ('pippo@email.com', 1, '😂', 25, 15),
    ('luigi@email.com', 2, '🎉', 60, 40);


INSERT INTO "Museo"."HashTag" ("Email", "Codice_Opra", "Tag", "PosX", "PosY")
VALUES
    ('pippo@email.com', 3, 'Sorriso', 10, 5),
    ('pluto@email.com', 4, 'Approvato', 40, 30),
    ('mario@email.com', 5, 'Amore', 5, 15),
    ('andrea@email.com', 1, 'Ridere', 20, 10),
    ('maria@email.com', 2, 'Festeggiare', 50, 35);


INSERT INTO "Museo"."Etichetta" ("Email", "Codice_Opera", "Testo", "PosX", "PosY")
VALUES
    ('pippo@email.com', 3, 'Gioia', 35, 25),
    ('mario@email.com', 4, 'Bravo!', 65, 45),
    ('andrea@email.com', 5, 'Bello', 15, 20),
    ('pluto@email.com', 1, 'Divertente', 30, 18),
    ('maria@email.com', 2, 'Festoso', 55, 38);

