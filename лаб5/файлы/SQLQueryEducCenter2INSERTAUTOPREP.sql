USE EducCenter;
DROP TABLE IF EXISTS Prepod;
-- преподаватели вставка
create table Prepod
(
	Id INT IDENTITY ,
	NumerPassporta NVARCHAR(200) NOT NULL,
	Kvalifikaciya NVARCHAR(200)   NOT NULL,
	PredydushcheeMestoRaboty NVARCHAR(200) NULL, --Предыдущее место работы
	Zarplata int NOT NULL CHECK (Zarplata >0 ),
	RaspisanieKursNazvanie NVARCHAR(200) NOT NULL ,
	ZHurnalOcenokKursNazvanie NVARCHAR(200) NOT NULL CHECK (ZHurnalOcenokKursNazvanie!='')
)
create index Prepod_idx on Prepod (NumerPassporta,RaspisanieKursNazvanie)



Declare @_NumPass varchar(11)
Set @_NumPass = ''

Declare @_FIO varchar(80)
Set @_FIO = ''

Declare @_Zarplata int
Set @_Zarplata = 0

Declare @_Kvalifikaciya varchar(80)
Set @_Kvalifikaciya = ''

Declare @_PredydushcheeMestoRaboty varchar(80)
Set @_PredydushcheeMestoRaboty = ''


Declare @_ZHurnal_OcenokKursNazvanie varchar(80)
Set @_ZHurnal_OcenokKursNazvanie = ''

Declare @_RaspisanieKursNazvanie varchar(80)
Set @_RaspisanieKursNazvanie=''

Declare @RandNumForSubject int
Set @RandNumForSubject=0






Declare @top int 
Set @top = 1000000

Declare @cnt int
Set @cnt = 0

While @cnt < @top
Begin	
	set @_NumPass = convert(varchar(36),newid())
	set @_FIO = convert(varchar(36),newid())
	set @RandNumForSubject = ABS(CHECKSUM(NEWID())) % 7+1
	IF @RandNumForSubject = 1
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='Matematica'
			set @_RaspisanieKursNazvanie='Matematica'
		END;
	IF @RandNumForSubject = 2
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='История'
			set @_RaspisanieKursNazvanie='История'
		END;
	IF @RandNumForSubject = 3
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='Литература'
			set @_RaspisanieKursNazvanie='Литература'
		END;
	IF @RandNumForSubject = 4
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='География'
			set @_RaspisanieKursNazvanie='География'
		END;
	IF @RandNumForSubject = 5
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='Базовая'+'Информатика'
			set @_RaspisanieKursNazvanie='Базовая'+'Информатика'
		END;
	IF @RandNumForSubject = 6
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='Биология'
			set @_RaspisanieKursNazvanie='Биология'
		END;
	IF @RandNumForSubject = 7
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='Химия'
			set @_RaspisanieKursNazvanie='Химия'
		END;
	set @_Zarplata = ABS(CHECKSUM(NEWID())) %14+1
	set @_Kvalifikaciya = convert(varchar(36),newid())
	set @_PredydushcheeMestoRaboty = convert(varchar(36),newid())


    Insert Into Chelovek values (@_NumPass,@_FIO)

	Insert Into Prepod values (@_NumPass,@_Kvalifikaciya,@_PredydushcheeMestoRaboty,@_Zarplata,@_RaspisanieKursNazvanie,@_ZHurnal_OcenokKursNazvanie)



    Set @cnt = @cnt + 1
End

--alter index all on Prepod rebuild
--GO
--update statistics Prepod with fullscan
--GO


