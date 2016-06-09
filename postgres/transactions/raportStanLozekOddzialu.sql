CREATE OR REPLACE FUNCTION raportStanLozekOddzialu(in int) RETURNS integer AS 
$body$
BEGIN

CREATE VIEW raport_stan_lozek_oddzialu AS
  SELECT Pacjenci.Numer, Pacjenci.Data_urodzenia, Pacjenci.Plec, Hospitalizacje.Numer, Hospitalizacje.Przewidywany_czas_pobytu, Lozka.Numer, Oddzialy.Numer, Oddzialy.Nazwa
  FROM Oddzialy, Pacjenci, Hospitalizacje, Lozka
  WHERE Oddzialy.Numer = $1
  AND Oddzialy.Numer = Lozka.Oddzial_Numer
  AND Lozka.Numer = Hospitalizacje.Lozko_Numer
  AND Pacjenci.Numer = Hospitaliacje.Pacjent_Numer;

RETURN 0;

END
$body$ LANGUAGE plpgsql;
