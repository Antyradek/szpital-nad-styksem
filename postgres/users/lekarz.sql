CREATE ROLE lekarz LOGIN;

GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE, TRIGGER 
ON Wizyty, Lozka, Oddzialy, Hospitalizacje, Hospitalizacje_ambulatoryjne, Pacjenci, Leki, Dozowania_leku TO lekarz ;

GRANT SELECT ON lista_wizyt_pracownika TO lekarz;
