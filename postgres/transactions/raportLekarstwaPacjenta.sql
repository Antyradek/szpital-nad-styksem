CREATE OR REPLACE FUNCTION raportLekarstwa() RETURNS integer AS 
$body$
BEGIN

CREATE VIEW raport_lekarstwa AS
SELECT Pacjent_Imie,Pacjent_Nazwisko,Materialy_Nazwa,Liczba_jednostek_na_dobe,Data_poczatkowa,Data_koncowa,Materialy_Opis 
FROM Dozowania_Leku;

RETURN 0;

END
$body$ LANGUAGE plpgsql;
