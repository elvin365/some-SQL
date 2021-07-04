USE EducCenter


--Declare @Time1 datetime2(7)
--Declare @Time2 datetime2(7)
--Declare @timediff int
--set @Time1=SYSDATETIME()
--SET STATISTICS TIME ON;  
 
--SELECT T1.FIO, T2.ItogovayaOcenka FROM

--(SELECT DISTINCT (SELECT Chelovek.FIO FROM Chelovek WHERE Chelovek.NumerPassporta = ObuchayushchijsyaNumerPassporta) FIO  FROM Ocenka) T1
--LEFT JOIN 
  
--(SELECT (SELECT Chelovek.FIO FROM Chelovek WHERE Chelovek.NumerPassporta = ObuchayushchijsyaNumerPassporta) FIO ,ItogovayaOcenka FROM Ocenka WHERE ZHurnal_OcenokKursNazvanie='Литература') T2
--ON T2.FIO=T1.FIO; 

--SET STATISTICS TIME OFF;  


--set @Time2=SYSDATETIME()

--set @timediff=DATEDIFF(MILLISECOND,@Time1,@Time2)

--print 'Time elapsed ' + convert(varchar(36),@timediff)



-----------------------optimized
go

--Declare @Time1 datetime2(7)
--Declare @Time2 datetime2(7)
--Declare @timediff int
--set @Time1=SYSDATETIME();


--WITH T1 AS (SELECT DISTINCT (SELECT Chelovek.FIO FROM Chelovek WHERE Chelovek.NumerPassporta = ObuchayushchijsyaNumerPassporta) FIO  FROM Ocenka),
--	 T2 as (SELECT (SELECT Chelovek.FIO FROM Chelovek WHERE Chelovek.NumerPassporta = ObuchayushchijsyaNumerPassporta) FIO ,ItogovayaOcenka FROM Ocenka WHERE ZHurnal_OcenokKursNazvanie='Литература'),
--	 JOINED AS (SELECT T1.FIO, T2.ItogovayaOcenka FROM T1 LEFT JOIN T2 ON T2.FIO=T1.FIO)
--SELECT * FROM JOINED;



--set @Time2=SYSDATETIME()

--set @timediff=DATEDIFF(MILLISECOND,@Time1,@Time2)

--print 'Time elapsed ' + convert(varchar(36),@timediff)

--Declare @Time1 datetime2(7)
--Declare @Time2 datetime2(7)
--Declare @timediff int
--set @Time1=SYSDATETIME();

--SET STATISTICS TIME ON;  


SELECT DISTINCT FIO, ItogovayaOcenka 
from Chelovek 
left join Ocenka 
on NumerPassporta = ObuchayushchijsyaNumerPassporta and ZHurnal_OcenokKursNazvanie=N'Литература' -- не забывайте про N'' для nvarchar!

--SET STATISTICS TIME OFF;  


--set @Time2=SYSDATETIME()

--set @timediff=DATEDIFF(MILLISECOND,@Time1,@Time2)

--print 'Time elapsed ' + convert(varchar(36),@timediff)