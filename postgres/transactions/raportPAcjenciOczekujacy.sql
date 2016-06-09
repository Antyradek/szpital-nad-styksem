CREATE OR REPLACE FUNCTION raportPacjenciOczekujacy() RETURNS integer AS 
$body$
BEGIN

CREATE VIEW raport_pacjenci_oczekujacy AS
  SELECT Pacjenci.Numer, Pacjenci.Data_urodzenia, Pacjenci.Plec, Pacjenci_oczekujacy.Data_umieszczenia, Oddzialy.Nazwa
  FROM Oddzialy, Pacjenci_oczekujacy, Pacjenci
  WHERE Oddzialy.Numer = Pacjenci_oczekujacy.Oddzial_Numer 
  AND Pacjenci_oczekujacy.Pacjent_Numer = Pacjenci.Numer;

RETURN 0;

END
$body$ LANGUAGE plpgsql;
