use EducCenter;

 --4--------------Вывести список ФИО преподавателей, которые никогда не выставляли ни одной оценки ниже 3

--Declare @Time1 datetime2(7)
--Declare @Time2 datetime2(7)
--Declare @cnt int


--set @cnt=0
--set @Time1=SYSDATETIME()
--While @cnt<100
--Begin
--SET STATISTICS TIME ON;  


--SELECT Chelovek.FIO FROM Chelovek 
--JOIN
--(SELECT P.NumerPassporta FROM Prepod AS P
-- JOIN --даёт из названий курсов номера пасппаротов

--(SELECT  b.ZHurnal_OcenokKursNazvanie FROM Ocenka b -- все курсы
--EXCEPT  -- минус
--SELECT a.ZHurnal_OcenokKursNazvanie FROM Ocenka a WHERE a.PromezhutochnyeOcenka1<=3 OR a.PromezhutochnyeOcenka2<=3 OR a.PromezhutochnyeOcenka3<=3 OR 
-- a.ItogovayaOcenka<=3) Raznost  -- таблица, где хотя бы 1 тройка

-- ON P.RaspisanieKursNazvanie=Raznost.ZHurnal_OcenokKursNazvanie) Pass 
-- ON Pass.NumerPassporta=Chelovek.NumerPassporta 

--SET STATISTICS TIME OFF;  

--set @cnt=@cnt+1
--END
--set @Time2=SYSDATETIME()

--print ' Time elapsed for query from 2 lab: '+convert(varchar(36),DATEDIFF(MILLISECOND,@Time1,@Time2)/10,14)




--(SELECT  b.ZHurnal_OcenokKursNazvanie FROM Ocenka b -- все курсы
--EXCEPT  -- минус
--SELECT a.ZHurnal_OcenokKursNazvanie FROM Ocenka a WHERE a.PromezhutochnyeOcenka1<=3 OR a.PromezhutochnyeOcenka2<=3 OR a.PromezhutochnyeOcenka3<=3 OR 
-- a.ItogovayaOcenka<=3)
-- -- тут остаются предметы без троек





-- (SELECT P.NumerPassporta FROM Prepodavatel AS P
-- JOIN --даёт из названий курсов номера пасппаротов

---- тут остаются предметы без троек
--(SELECT  b.ZHurnal_OcenokKursNazvanie FROM Ocenka b -- все курсы
--EXCEPT  -- минус
--SELECT a.ZHurnal_OcenokKursNazvanie FROM Ocenka a WHERE a.PromezhutochnyeOcenka1<=3 OR a.PromezhutochnyeOcenka2<=3 OR a.PromezhutochnyeOcenka3<=3 OR 
-- a.ItogovayaOcenka<=3) Raznost  
-- -- тут остаются предметы без троек


-- ON P.RaspisanieKursNazvanie=Raznost.ZHurnal_OcenokKursNazvanie) 
-- -- тогда берем паспорта только тех, предметы которых совпали с "безтроечными" предметами
--SET STATISTICS TIME ON;  

--SELECT Chelovek.FIO FROM Chelovek 
--JOIN
--(SELECT P.NumerPassporta FROM Prepod AS P
-- JOIN --даёт из названий курсов номера пасппаротов

--(SELECT  b.ZHurnal_OcenokKursNazvanie FROM Ocenka b 
--WHERE b.PromezhutochnyeOcenka1<=3 
--OR b.PromezhutochnyeOcenka2<=3 
--OR b.PromezhutochnyeOcenka3<=3 
--OR b.ItogovayaOcenka<=3) Raznost  

--ON P.RaspisanieKursNazvanie=Raznost.ZHurnal_OcenokKursNazvanie) Pass
-- ON Pass.NumerPassporta=Chelovek.NumerPassporta;

--SET STATISTICS TIME OFF;  






SET STATISTICS TIME ON;  



SELECT Chelovek.FIO FROM Chelovek 
JOIN
(SELECT P.NumerPassporta FROM Prepod AS P
 JOIN --даёт из названий курсов номера пасппаротов

--(SELECT  b.ZHurnal_OcenokKursNazvanie FROM Ocenka b -- все курсы
--EXCEPT  -- минус
(SELECT a.ZHurnal_OcenokKursNazvanie FROM Ocenka a 
GROUP BY a.ZHurnal_OcenokKursNazvanie 
HAVING MIN(a.PromezhutochnyeOcenka1)>3 AND MIN(a.PromezhutochnyeOcenka2)>3 AND MIN(a.PromezhutochnyeOcenka3)>3 AND MIN(a.ItogovayaOcenka)>3) Raznost

 ON P.RaspisanieKursNazvanie=Raznost.ZHurnal_OcenokKursNazvanie) Pass
 ON Pass.NumerPassporta=Chelovek.NumerPassporta;


 SET STATISTICS TIME OFF;  
