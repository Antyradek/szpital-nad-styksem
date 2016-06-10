CREATE ROLE dyrektor_medyczny LOGIN;

GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE, TRIGGER 
ON Pracownicy, Pracownicy_na_oddziale, Oddzialy, Lozka, Leki, Materialy, Dostawcy, Dostawy, Hospitalizacje, Hospitalizacje_ambulatoryjne TO dyrektor_medyczny;

