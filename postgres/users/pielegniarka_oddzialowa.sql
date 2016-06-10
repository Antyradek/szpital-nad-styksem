CREATE ROLE pielegniarka_oddzialowa LOGIN;

GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE, TRIGGER 
ON Lozka, Hospitalizacje, Hospitalizacje_ambulatoryjne, Pacjenci_oczekujacy, Formularze_zapotrzebowania, dozowania_leku, pozycje_zamowienia  TO pielegniarka_oddzialowa;


GRANT SELECT
ON Pacjenci, Osoby, leki, materialy, oddzialy  TO pielegniarka_oddzialowa;
