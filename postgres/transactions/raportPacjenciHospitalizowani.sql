CREATE OR REPLACE FUNCTION raportPacjenciHospitalizowani() RETURNS integer AS 
$body$
BEGIN

CREATE VIEW raport_pacjenci_hospitalizowani AS
  SELECT Osoby.Imie, Osoby.Nazwisko, Hospitalizacje.Data_umieszczenia_na_oddziale, Lozka.Numer as Lozko
  FROM Osoby, Oddzialy, Pacjenci, Hospitalizacje, Lozka
  WHERE Hospitalizacje.Pacjent_Numer = Pacjenci.Numer
  AND Hospitalizacje.Lozko_Numer = Lozka.Numer
  AND Lozka.Oddzial_Numer = Oddzialy.Numer
  AND Osoby.Numer = Pacjenci.Numer;

RETURN 0;

END
$body$ LANGUAGE plpgsql;
