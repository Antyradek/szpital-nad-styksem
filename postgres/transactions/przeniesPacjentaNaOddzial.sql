CREATE FUNCTION przeniesPacjentaNaOddzial(in int) RETURNS integer AS 
$body$
BEGIN

DELETE FROM Pacjenci_oczekujacy as p WHERE p.Pacjent_Numer = $1;

INSERT INTO Hospitalizacje VALUES(2000, '2016-06-08', 90, null, $1, (SELECT l.Numer FROM Lozka as l WHERE l.Numer NOT IN (SELECT h.Lozko_Numer FROM Hospitalizacje as h) LIMIT 1));

RETURN 0;

END
$body$ LANGUAGE plpgsql;
