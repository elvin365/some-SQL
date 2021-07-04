USE EducCenter;

DROP TABLE IF EXISTS arr;
-- студенты
--create table arr
--(
--	NumPass varchar(11),
--	FIO varchar(80),
--	PromezhutochnyeOcenka1 int,
--	PromezhutochnyeOcenka2 int,
--	PromezhutochnyeOcenka3 int,
--	ItogovayaOcenka int,
--	ZHurnal_OcenokKursNazvanie varchar(80), --название курса
--)

Declare @_NumPass varchar(11)
Set @_NumPass = ''

Declare @_FIO varchar(80)
Set @_FIO = ''

Declare @_PromezhutochnyeOcenka1 int
Set @_PromezhutochnyeOcenka1 = 0

Declare @_PromezhutochnyeOcenka2 int
Set @_PromezhutochnyeOcenka2 = 0

Declare @_PromezhutochnyeOcenka3 int
Set @_PromezhutochnyeOcenka3 = 0

Declare @_ItogovayaOcenka int
Set @_ItogovayaOcenka = 0

Declare @_ZHurnal_OcenokKursNazvanie varchar(80)
Set @_ZHurnal_OcenokKursNazvanie = ''

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
		END;
	IF @RandNumForSubject = 2
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='История'
		END;
	IF @RandNumForSubject = 3
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='Литература'
		END;
	IF @RandNumForSubject = 4
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='География'
		END;
	IF @RandNumForSubject = 5
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='Базовая'+'Информатика'
		END;
	IF @RandNumForSubject = 6
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='Биология'
		END;
	IF @RandNumForSubject = 7
		BEGIN
			set @_ZHurnal_OcenokKursNazvanie='Химия'
		END;
	set @_PromezhutochnyeOcenka1 = ABS(CHECKSUM(NEWID())) %2+4--ABS(CHECKSUM(NEWID())) % 5+1
	set @_PromezhutochnyeOcenka2 = ABS(CHECKSUM(NEWID())) %2+4--ABS(CHECKSUM(NEWID())) % 5+1
	set @_PromezhutochnyeOcenka3 = ABS(CHECKSUM(NEWID())) %2+4--ABS(CHECKSUM(NEWID())) % 5+1
	set @_ItogovayaOcenka = (@_PromezhutochnyeOcenka1+@_PromezhutochnyeOcenka2+@_PromezhutochnyeOcenka3)/3


    Insert Into Chelovek values (@_NumPass,@_FIO)

	Insert Into Ocenka values (@_PromezhutochnyeOcenka1,@_PromezhutochnyeOcenka2,@_PromezhutochnyeOcenka3,@_ItogovayaOcenka,@_ZHurnal_OcenokKursNazvanie,@_NumPass)


    Set @cnt = @cnt + 1
End




