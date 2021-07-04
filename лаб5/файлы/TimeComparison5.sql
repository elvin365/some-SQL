USE EducCenter;



SET STATISTICS TIME ON;


SELECT (SELECT Chelovek.FIO FROM Chelovek WHERE Chelovek.NumerPassporta = ObuchayushchijsyaNumerPassporta) FIO,AVG(ItogovayaOcenka) as Average
FROM Ocenka 
GROUP BY ObuchayushchijsyaNumerPassporta 
ORDER BY Average DESC ;

SET STATISTICS TIME OFF;  
