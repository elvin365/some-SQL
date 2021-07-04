USE EducCenter;
GO

WITH T1 AS (SELECT DISTINCT (SELECT Chelovek.FIO FROM Chelovek WHERE Chelovek.NumerPassporta = ObuchayushchijsyaNumerPassporta) FIO  FROM Ocenka),
	 T2 as (SELECT (SELECT Chelovek.FIO FROM Chelovek WHERE Chelovek.NumerPassporta = ObuchayushchijsyaNumerPassporta) FIO ,ItogovayaOcenka FROM Ocenka WHERE ZHurnal_OcenokKursNazvanie='Литература'),
	 JOINED AS (SELECT T1.FIO, T2.ItogovayaOcenka FROM T1 LEFT JOIN T2 ON T2.FIO=T1.FIO)
SELECT * FROM JOINED;

go

