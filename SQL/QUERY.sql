SELECT
    "D"."D1" AS "Domanda1",
    "D"."D2" AS "Domanda2",
    "D"."D3" AS "Domanda3",
    "R"."R1" AS "Risposta1",
    "R"."R2" AS "Risposta2",
    "R"."R3" AS "Risposta3"
FROM
    "Museo"."Storia" AS "S"
JOIN
    "Museo"."Parte" USING ("ID_Storia")
JOIN
    "Museo"."Opera" USING ("Codice_Opera")
JOIN
    "Museo"."Domande" AS "D" USING ("Codice_Opera")
JOIN
    "Museo"."Risposte" AS "R" USING ("Codice_Opera")
WHERE
    "S"."ID_Storia" = 1
    AND "S"."Email" = 'mario@email.com'
    AND "S"."Email" = "R"."Email";


SELECT
    "Artista"."Nome",
    "Artista"."Cognome",
    COUNT("Storia"."ID_Storia") AS "NumeroStorie",
    CASE WHEN "Artista"."Data_Morte" IS NULL THEN 'NO' ELSE 'SI' END AS "ArtistaDeceduto",
    AVG(EXTRACT(EPOCH FROM ("Storia"."TSTPF" - "Storia"."TSTPI")) / 60) AS "DurataMediaStoria (minuti)"
FROM
    "Museo"."Artista"
JOIN
    "Museo"."Opera" ON "Artista"."Codice_Artista" = "Opera"."Codice_Artista"
JOIN
    "Museo"."Parte" ON "Opera"."Codice_Opera" = "Parte"."Codice_Opera"
JOIN
    "Museo"."Storia" ON "Parte"."ID_Storia" = "Storia"."ID_Storia"
GROUP BY
    "Artista"."Nome",
    "Artista"."Cognome",
	"ArtistaDeceduto"
ORDER BY
    "NumeroStorie" ASC;