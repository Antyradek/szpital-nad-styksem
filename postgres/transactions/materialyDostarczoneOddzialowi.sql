CREATE OR REPLACE FUNCTION materialyDostarczoneOddzialowi(nr_oddzialu integer, data_od date, data_do date) RETURNS 
TABLE(oddz_nazw character varying, nr_form integer, form_data date, mat_nr integer, mat_nazwa character varying, mat_opis character varying)
AS
$body$

BEGIN

RETURN QUERY
  SELECT Oddzialy.Nazwa, Formularze_zapotrzebowania.Numer, Formularze_zapotrzebowania.Data_zgloszenia, Materialy.Numer, Materialy.Nazwa, Materialy.Opis 
  FROM Oddzialy, Formularze_zapotrzebowania, Pozycje_zamowienia, Materialy
  WHERE Oddzialy.Numer = nr_oddzialu
  AND Oddzialy.Numer = Formularze_zapotrzebowania.Oddzial_Numer
  AND Formularze_zapotrzebowania.Numer = Pozycje_zamowienia.Formularz
  AND Pozycje_zamowienia.Material_Numer = Materialy.Numer
  AND Formularze_zapotrzebowania.Data_otrzymania > data_od
  AND Formularze_zapotrzebowania.Data_otrzymania < data_do;

END
$body$ LANGUAGE plpgsql;

