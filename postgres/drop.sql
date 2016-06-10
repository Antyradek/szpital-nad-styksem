-- Usuń wszystkie dane z bazy, możesz także usunąć całą bazę, ale tak jest bardziej kontrolowane
DROP TABLE	Osoby	CASCADE;
DROP TABLE	Lekarze_rodzinni	CASCADE;
DROP TABLE	Pacjenci	CASCADE;
DROP TABLE	Pracownicy	CASCADE;
DROP TABLE	Rodzaje_pracownikow	CASCADE;
DROP TABLE	Stany_cywilne	CASCADE;
DROP TABLE	Typy_pokrewienstwa	CASCADE;
DROP TABLE	Rodzaje_umowy	CASCADE;
DROP TABLE	Kwalifikacje	CASCADE;
DROP TABLE	Doswiadczenia_zawodowe	CASCADE;
DROP TABLE	Zatrudnienia	CASCADE;
DROP TABLE	Pokrewienstwa	CASCADE;
DROP TABLE	Wizyty	CASCADE;
DROP TABLE	Oddzialy	CASCADE;
DROP TABLE	Pacjenci_oczekujacy	CASCADE;
DROP TABLE	Lozka	CASCADE;
DROP TABLE	Pracownicy_na_oddziale	CASCADE;
DROP TABLE	Dostawcy	CASCADE;
DROP TABLE	Materialy	CASCADE;
DROP TABLE	Dostawy	CASCADE;
DROP TABLE	Leki	CASCADE;
DROP TABLE	Dozowania_leku	CASCADE;
DROP TABLE	Formularze_zapotrzebowania	CASCADE;
DROP TABLE	Pozycje_zamowienia	CASCADE;
DROP TABLE	Hospitalizacje	CASCADE;
DROP TABLE	Hospitalizacje_ambulatoryjne	CASCADE;

DROP FUNCTION denorm_wizyty();
DROP FUNCTION denorm_pacjenci_oczekujacy();
DROP FUNCTION denorm_dozowania_leku();
DROP FUNCTION agreguj_formularze_zapotrzebowania();
DROP FUNCTION dekoduj_dozowania_leku();
DROP MATERIALIZED VIEW Dozowania_Leku_persp_zmat;

