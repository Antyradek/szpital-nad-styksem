CREATE OR REPLACE FUNCTION raportLekarstwa() RETURNS integer AS 
$body$
BEGIN

CREATE VIEW raport_lekarstwa AS
  SELECT * FROM Dozowania_Leku_persp_zmat;

RETURN 0;

END
$body$ LANGUAGE plpgsql;
