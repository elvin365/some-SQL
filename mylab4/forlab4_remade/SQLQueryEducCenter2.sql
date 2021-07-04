IF NOT EXISTS
(
SELECT * FROM sys.databases
WHERE name='EducCenter'
)
BEGIN
CREATE DATABASE EducCenter;
END
USE EducCenter;
--IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Obuchenie') DROP TABLE Obuchenie
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Ocenka') DROP TABLE Ocenka
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Obrazovanie') DROP TABLE Obrazovanie
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Rating_Obuchayushchijsya') DROP TABLE Rating_Obuchayushchijsya
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Obuchayushchjisya_Kursam') DROP TABLE Obuchayushchjisya_Kursam
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Rejting_Prepodavatelya') DROP TABLE Rejting_Prepodavatelya
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Prepodavatel_Kursov') DROP TABLE Prepodavatel_Kursov
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Oborudovanie_Kursov') DROP TABLE Oborudovanie_Kursov
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Rating_Obuchayushchegosya') DROP TABLE Rating_Obuchayushchegosya
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Spravochnik_Rating') DROP TABLE Spravochnik_Rating
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Obuchayushchijsya') DROP TABLE Obuchayushchijsya
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Prepodavatel') DROP TABLE Prepodavatel
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'ZHurnal_Ocenok') DROP TABLE ZHurnal_Ocenok
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Chelovek') DROP TABLE Chelovek
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Spravochnik_oborudovanie') DROP TABLE Spravochnik_oborudovanie
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'RaspisanieZanyatij') DROP TABLE RaspisanieZanyatij
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Kursi') DROP TABLE Kursi
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'Kabineti') DROP TABLE Kabineti






CREATE TABLE Chelovek				
(
NumerPassporta NVARCHAR(200) PRIMARY KEY NOT NULL CHECK (NumerPassporta!=''), -- так как NULL и пустая строка это разные вещи
FIO NVARCHAR(200) UNIQUE NOT NULL CHECK(FIO !='')
);
CREATE INDEX Chel_idx ON Chelovek (FIO)






CREATE TABLE Spravochnik_Rating			
(
	Uroven INT NOT NULL PRIMARY KEY CHECK(Uroven>0) 
);







CREATE TABLE Kursi					
(
	Nazvanie NVARCHAR(200) NOT NULL PRIMARY KEY CHECK(Nazvanie!=''),
	Annotaciya NVARCHAR(200) NULL ,--аннотация,
	Dlitelnost_po_vremeni int NOT NULL,
	Stoimost MONEY UNIQUE NOT NULL,
	Kursi_Nazvanie NVARCHAR(200) NOT NULL CHECK(Kursi_Nazvanie!=''),
	FOREIGN KEY (Kursi_Nazvanie)  REFERENCES Kursi(Nazvanie), --ссылка на самого себя
	--CHECK(Dlitelnost_po_vremeni > 250 AND Stoimost > 500000) --250ч - 1 сем


);
--Добавляем ограничение check к существующей таблице
ALTER TABLE Kursi ADD CONSTRAINT Semestr CHECK(Dlitelnost_po_vremeni > 250 AND Stoimost > 50000); --250ч - 1 сем




CREATE TABLE ZHurnal_Ocenok --Журнал_Оценок					
(
	KursNazvanie NVARCHAR(200) NOT NULL PRIMARY KEY CHECK (KursNazvanie!=''),
	--PromezhutochnyeOcenki INT NOT NULL CHECK (PromezhutochnyeOcenki>0),--ПромежуточныеОценки
	SdannyeZadaniya NVARCHAR(200) NULL,--cданные задания
	--ItogovayaOcenka int NOT NULL CHECK (ItogovayaOcenka>0),
	FOREIGN KEY (KursNazvanie)  REFERENCES Kursi(Nazvanie),
);



CREATE TABLE Obuchayushchijsya --Обучающийся									
(
	NumerPassporta NVARCHAR(200) PRIMARY KEY NOT NULL CHECK (NumerPassporta!=''), -- так как NULL и пустая строка это разные вещи
	FOREIGN KEY (NumerPassporta)  REFERENCES Chelovek(NumerPassporta),
	Sovershennoletie BIT NOT NULL, --совершеннолетие
	ZakonnyePredstaviteli NVARCHAR(200) UNIQUE NOT NULL, --Законные представители
	KursNazvanie NVARCHAR(200) NOT NULL CHECK (KursNazvanie!=''),
	FOREIGN KEY (KursNazvanie)  REFERENCES ZHurnal_Ocenok(KursNazvanie),

	--CHECK (Sovershennoletie <=0 AND ZakonnyePredstaviteli !='') --Обучающийся не может быть несовершеннолетним и без закон. представ 
);
-----
--CREATE TABLE Obuchenie
--(
--	Id INT IDENTITY PRIMARY KEY,
--	ObuchayushchijsyaNumerPassporta NVARCHAR(200) NOT NULL CHECK (ObuchayushchijsyaNumerPassporta!=''),
--	FOREIGN KEY (ObuchayushchijsyaNumerPassporta) REFERENCES Obuchayushchijsya(NumerPassporta)

--);
-----
----
CREATE TABLE Ocenka
(
	Id INT IDENTITY ,--PRIMARY KEY,
	PromezhutochnyeOcenka1 INT NOT NULL CHECK (PromezhutochnyeOcenka1>0),--ПромежуточныеОценки
	PromezhutochnyeOcenka2 INT NOT NULL CHECK (PromezhutochnyeOcenka2>0),--ПромежуточныеОценки
	PromezhutochnyeOcenka3 INT NOT NULL CHECK (PromezhutochnyeOcenka3>0),--ПромежуточныеОценки
	ItogovayaOcenka int NOT NULL CHECK (ItogovayaOcenka>0),
	ZHurnal_OcenokKursNazvanie NVARCHAR(200) NOT NULL CHECK (ZHurnal_OcenokKursNazvanie!=''),
	CONSTRAINT FOREIGN_KursNazvanie FOREIGN KEY (ZHurnal_OcenokKursNazvanie)  REFERENCES ZHurnal_Ocenok(KursNazvanie),
	ObuchayushchijsyaNumerPassporta NVARCHAR(200)  NOT NULL CHECK (ObuchayushchijsyaNumerPassporta!=''),
	--FOREIGN KEY (ObuchayushchijsyaNumerPassporta) REFERENCES Obuchayushchijsya(NumerPassporta)
	CONSTRAINT PRIMARY_KEY_Id PRIMARY KEY(Id)
	
);
CREATE INDEX ObuchNumPass on Ocenka (ObuchayushchijsyaNumerPassporta) --новый простой индекс
----
CREATE TABLE Rating_Obuchayushchijsya --Рейтинг_Обучающегося			
(
	ObuchayushchijsyaNomerPasporta NVARCHAR(200)  NOT NULL CHECK (ObuchayushchijsyaNomerPasporta!=''), -- так как NULL и пустая строка это разные вещи
	FOREIGN KEY (ObuchayushchijsyaNomerPasporta)  REFERENCES Obuchayushchijsya(NumerPassporta),
	SpravochnikRatingUroven INT NOT NULL CHECK(SpravochnikRatingUroven >0),
	FOREIGN KEY (SpravochnikRatingUroven)  REFERENCES Spravochnik_Rating(Uroven),
	PRIMARY KEY(ObuchayushchijsyaNomerPasporta,SpravochnikRatingUroven),
);
CREATE TABLE Obuchayushchjisya_Kursam --Обучающйися_Курсам				
(
	ObuchayushchijsyaNomerPasporta NVARCHAR(200)  NOT NULL CHECK (ObuchayushchijsyaNomerPasporta!=''), -- так как NULL и пустая строка это разные вещи
	FOREIGN KEY (ObuchayushchijsyaNomerPasporta)  REFERENCES Obuchayushchijsya(NumerPassporta),
	KursiNazvanie NVARCHAR(200) NOT NULL CHECK (KursiNazvanie!=''),
	FOREIGN KEY (KursiNazvanie)  REFERENCES Kursi(Nazvanie),
	PRIMARY KEY(ObuchayushchijsyaNomerPasporta,KursiNazvanie)

);

CREATE TABLE Kabineti												
(
	Nomer INT NOT NULL PRIMARY KEY CHECK (Nomer >0),
	TipKabineta NVARCHAR(200) NULL
);

CREATE TABLE RaspisanieZanyatij--РасписаниеЗанятий						
(
	Id INT IDENTITY,
	KursNazvanie NVARCHAR(200) NOT NULL PRIMARY KEY CHECK (KursNazvanie!=''),
	FOREIGN KEY (KursNazvanie)  REFERENCES Kursi(Nazvanie) ON DELETE CASCADE,
	--VremyaNachala TIMESTAMP NOT NULL,
	VremyaNachala INT,
	VremyaOkonchaniya TIME NOT NULL,
	KabNomer INT NOT NULL CHECK(KabNomer>0),
	--PRIMARY KEY(KursNazvanie,VremyaNachala),
	FOREIGN KEY (KabNomer)  REFERENCES Kabineti(Nomer) ON DELETE CASCADE
	
);
CREATE TABLE Prepodavatel				
(
	NumerPassporta NVARCHAR(200) PRIMARY KEY NOT NULL CHECK (NumerPassporta!=''), -- так как NULL и пустая строка это разные вещи
	FOREIGN KEY (NumerPassporta)  REFERENCES Chelovek(NumerPassporta),
	Kvalifikaciya NVARCHAR(200) UNIQUE NOT NULL, -- Квалификация
	PredydushcheeMestoRaboty NVARCHAR(200) NULL, --Предыдущее место работы
	Zarplata MONEY NOT NULL CHECK (Zarplata >0 ),
	RaspisanieKursNazvanie NVARCHAR(200) NOT NULL ,--FK 
	FOREIGN KEY (RaspisanieKursNazvanie)  REFERENCES RaspisanieZanyatij(KursNazvanie),
	ZHurnalOcenokKursNazvanie NVARCHAR(200) NOT NULL CHECK (ZHurnalOcenokKursNazvanie!=''), --ЖурналОценокКурсНазвание
	FOREIGN KEY (ZHurnalOcenokKursNazvanie)  REFERENCES ZHurnal_Ocenok(KursNazvanie),

);

CREATE TABLE Obrazovanie			
(
	PrepodavatelNomerPasporta NVARCHAR(200)  NOT NULL CHECK (PrepodavatelNomerPasporta!=''), -- так как NULL и пустая строка это разные вещи
	FOREIGN KEY (PrepodavatelNomerPasporta)  REFERENCES Prepodavatel(NumerPassporta),
	NomerDokumentaObObrazovanii NVARCHAR(200) NOT NULL, --НомерДокументаОбОбразовании
	Specialnost NVARCHAR(200) NOT NULL CHECK(Specialnost !=''),--Специальность
	Stazh int NULL, --стаж
	PRIMARY KEY(PrepodavatelNomerPasporta,NomerDokumentaObObrazovanii)

);
CREATE TABLE Rejting_Prepodavatelya --Рейтинг_Преподавателя							
(
	PrepodavatelNomerPasporta NVARCHAR(200)  NOT NULL CHECK (PrepodavatelNomerPasporta!=''), -- так как NULL и пустая строка это разные вещи
	FOREIGN KEY (PrepodavatelNomerPasporta)  REFERENCES Prepodavatel(NumerPassporta),
	SpravochnikRatingUroven INT NOT NULL CHECK(SpravochnikRatingUroven >0),
	FOREIGN KEY (SpravochnikRatingUroven)  REFERENCES Spravochnik_Rating(Uroven),
	PRIMARY KEY(PrepodavatelNomerPasporta,SpravochnikRatingUroven),
);
CREATE TABLE Prepodavatel_Kursov --Преподаватель_Курсам								
(
	PrepodavatelNomerPassporta NVARCHAR(200)  NOT NULL CHECK (PrepodavatelNomerPassporta!=''), -- так как NULL и пустая строка это разные вещи
	FOREIGN KEY (PrepodavatelNomerPassporta)  REFERENCES Prepodavatel(NumerPassporta),
	KursiNazvanie NVARCHAR(200) NOT NULL CHECK (KursiNazvanie!=''),
	FOREIGN KEY (KursiNazvanie)  REFERENCES Kursi(Nazvanie),
	PRIMARY KEY(PrepodavatelNomerPassporta,KursiNazvanie)
);





CREATE TABLE Spravochnik_oborudovanie				
(
	Nazvanie NVARCHAR(200) NOT NULL PRIMARY KEY
);

CREATE TABLE Oborudovanie_Kursov						
(
	KursiNazvanie NVARCHAR(200) NOT NULL, --PK,
	FOREIGN KEY (KursiNazvanie)  REFERENCES Kursi(Nazvanie),
	Spravochnik_oborudovanie_Nazvanie NVARCHAR(200) NOT NULL ,--PK
	FOREIGN KEY (Spravochnik_oborudovanie_Nazvanie)  REFERENCES Spravochnik_oborudovanie(Nazvanie),
	PRIMARY KEY(KursiNazvanie,Spravochnik_oborudovanie_Nazvanie)

);

CREATE TABLE Rating_Obuchayushchegosya				
(
	KabinetNomer INT NOT NULL, --PK,
	FOREIGN KEY (KabinetNomer)  REFERENCES Kabineti(Nomer),
	Spravochnik_oborudovanie_Nazvanie NVARCHAR(200) NOT NULL ,--PK
	FOREIGN KEY (Spravochnik_oborudovanie_Nazvanie)  REFERENCES Spravochnik_oborudovanie(Nazvanie),
	PRIMARY KEY(KabinetNomer,Spravochnik_oborudovanie_Nazvanie)

);

