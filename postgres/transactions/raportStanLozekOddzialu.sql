CREATE OR REPLACE FUNCTION raportStanLozekOddzialu(oddzial_nr int) RETURNS 
TABLE(nazwa_odzz character varying, nr_pacj integer, dat_ur date, nr_hosp integer, przew_czas_pob integer, nr_lozka integer)
AS 
$body$
BEGIN

RETURN QUERY
  SELECT Oddzialy.Nazwa, Pacjenci.Numer, Pacjenci.Data_urodzenia, Hospitalizacje.Numer, Hospitalizacje.Przewidywany_czas_pobytu, Lozka.Numer
  FROM Oddzialy, Pacjenci, Hospitalizacje, Lozka
  WHERE Oddzialy.Numer = oddzial_nr
  AND Oddzialy.Numer = Lozka.Oddzial_Numer
  AND Lozka.Numer = Hospitalizacje.Lozko_Numer
  AND Pacjenci.Numer = Hospitalizacje.Pacjent_Numer;


END
$body$ LANGUAGE plpgsql;
