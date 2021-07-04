USE EducCenter;

--SELECT Chelovek.FIO FROM Chelovek 
--JOIN
--(SELECT P.NumerPassporta FROM Prepodavatel AS P
-- JOIN --даёт из названий курсов номера пасппаротов

--(SELECT  b.ZHurnal_OcenokKursNazvanie FROM Ocenka b -- все курсы
--EXCEPT  -- минус
--SELECT a.ZHurnal_OcenokKursNazvanie FROM Ocenka a WHERE a.PromezhutochnyeOcenka1<=3 OR a.PromezhutochnyeOcenka2<=3 OR a.PromezhutochnyeOcenka3<=3 OR 
-- a.ItogovayaOcenka<=3) Raznost  -- таблица, где хотя бы 1 тройка

-- ON P.RaspisanieKursNazvanie=Raznost.ZHurnal_OcenokKursNazvanie) Pass
-- ON Pass.NumerPassporta=Chelovek.NumerPassporta;


-- SELECT  b.ZHurnal_OcenokKursNazvanie FROM Ocenka b -- все курсы
--EXCEPT  -- минус
--SELECT a.ZHurnal_OcenokKursNazvanie FROM Ocenka a WHERE a.PromezhutochnyeOcenka1<=3 OR a.PromezhutochnyeOcenka2<=3 OR a.PromezhutochnyeOcenka3<=3 OR 
-- a.ItogovayaOcenka<=3


 -- SELECT  * FROM Ocenka as tmp WHERE NOT EXISTS
	--(
	--	SELECT * FROM Ocenka as tmp2
	--	WHERE tmp2.PromezhutochnyeOcenka1>3 AND tmp2.PromezhutochnyeOcenka2>3 AND tmp2.PromezhutochnyeOcenka3>3 AND tmp2.ItogovayaOcenka>3
	--)

--SELECT  b.ZHurnal_OcenokKursNazvanie FROM Ocenka b -- все курсы
--EXCEPT  -- минус
--SELECT a.ZHurnal_OcenokKursNazvanie FROM Ocenka a 
--GROUP BY a.ZHurnal_OcenokKursNazvanie 
--HAVING MIN(a.PromezhutochnyeOcenka1)<=3 OR MIN(a.PromezhutochnyeOcenka2)<=3 OR MIN(a.PromezhutochnyeOcenka3)<=3 OR MIN(a.ItogovayaOcenka)<=3

--оптимизированный
SELECT Chelovek.FIO FROM Chelovek 
JOIN
(SELECT P.NumerPassporta FROM Prepodavatel AS P
 JOIN --даёт из названий курсов номера пасппаротов

--(SELECT  b.ZHurnal_OcenokKursNazvanie FROM Ocenka b -- все курсы
--EXCEPT  -- минус
(SELECT a.ZHurnal_OcenokKursNazvanie FROM Ocenka a 
GROUP BY a.ZHurnal_OcenokKursNazvanie 
HAVING MIN(a.PromezhutochnyeOcenka1)>3 AND MIN(a.PromezhutochnyeOcenka2)>3 AND MIN(a.PromezhutochnyeOcenka3)>3 AND MIN(a.ItogovayaOcenka)>3) Raznost

 ON P.RaspisanieKursNazvanie=Raznost.ZHurnal_OcenokKursNazvanie) Pass
 ON Pass.NumerPassporta=Chelovek.NumerPassporta;


 