CREATE ROLE dyrektor_personalny LOGIN;

GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE, TRIGGER 
ON Pracownicy, Rodzaje_umowy, Stany_cywilne, Typy_pokrewienstwa, Pracownicy_na_oddziale, Kwalifikacje, Doswiadczenia_zawodowe TO dyrektor_personalny ;
