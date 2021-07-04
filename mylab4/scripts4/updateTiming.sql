DROP TABLE IF EXISTS T5

GO
create OR ALTER function idx_func (@x int)
returns int
WITH SCHEMABINDING
as
begin
	DECLARE @ret int;
	if @x%1 = 0
		set @ret = (1+@x)
	else 
		set @ret = (1-@x)
	return @ret
end
GO

Declare @top int
Set @top = 100000


use BROKOLLI
SET NOCOUNT ON 

DROP TABLE IF EXISTS T1
DROP TABLE IF EXISTS T2
DROP TABLE IF EXISTS T3
DROP TABLE IF EXISTS T4
--DROP TABLE IF EXISTS T5
DROP TABLE IF EXISTS arr


Declare @cnt int
Set @cnt = 0

Declare @_F1 int
Set @_F1 = 0

Declare @_F2 varchar(80)
Set @_F2 = ''


create table T1
(
F1 int,
F2 varchar(80)
)

create table T2
(
F1 int,
F2 varchar(80)
)
create index T2_F1_i on T2 (F1)

create table T3
(
F1 int unique,
F2 varchar(80)
)


create table T4
(
F1 int,
F2 varchar(80),
F3 as (abs(F1)+1)
)

create index T4_F1_i on T4(F3)


create table T5
(
F1 int,
F2 varchar(80),
F3 as (dbo.idx_func(F1))
)

create index T5_F1_i on T5(F3)



create table arr
(
	idx int not null,
	F1 int,
	F2 varchar(80)
)


Set @cnt = 0
While @cnt < @top
Begin	
	set @_F1 = ABS(CHECKSUM(NEWID()))
	set @_F2 = convert(varchar(36),newid())
	--if exists (select F1 from arr where F1=@_F1)
	--	Insert Into arr values (@cnt,@_F1,@_F2)
	--else
	--	continue
	Insert Into arr values (@cnt,@_F1,@_F2)
    Set @cnt = @cnt + 1
End


Declare @Time1 datetime2(7)
Declare @Time2 datetime2(7)
Set @cnt = 0


ALTER TABLE arr ADD CONSTRAINT PK_arr PRIMARY KEY CLUSTERED (idx);





---------------- 1 -----------
Set @cnt = 0
While @cnt < @top
Begin	
	select @_F1 = F1, @_F2 = F2 from arr where idx = @cnt
	Insert Into T1 values (@_F1,@_F2)
    Set @cnt = @cnt + 1
End
---------------- 2 -----------
Set @cnt = 0
While @cnt < @top
Begin	
	select @_F1 = F1, @_F2 = F2 from arr where idx = @cnt
	Insert Into T2 values (@_F1,@_F2)
    Set @cnt = @cnt + 1
End
---------------- 3 -----------
Set @cnt = 0
While @cnt < @top
Begin	
	select @_F1 = F1, @_F2 = F2 from arr where idx = @cnt
	Insert Into T3 values (@_F1,@_F2)
    Set @cnt = @cnt + 1
End
---------------- 4 -----------
Set @cnt = 0
While @cnt < @top
Begin	
	select @_F1 = F1, @_F2 = F2 from arr where idx = @cnt
	Insert Into T4 values (@_F1,@_F2)
    Set @cnt = @cnt + 1
End
---------------- 5 -----------
Set @cnt = 0
While @cnt < @top
Begin	
	select @_F1 = F1, @_F2 = F2 from arr where idx = @cnt
	Insert Into T5 values (@_F1,@_F2)
    Set @cnt = @cnt + 1
End




Declare @td1 int
Declare @td2 int
Declare @td3 int
Declare @td4 int
Declare @td5 int
Declare @cnt2 int

Set @td1= 0
Set @td2= 0
Set @td3= 0
Set @td4= 0
Set @td5= 0
Set @cnt2 = 0

While @cnt2 < 6
Begin	


set @Time1  = SYSDATETIME()
update T1 set F1=F1+10
set @Time2  = SYSDATETIME()
set @td1 = @td1+DATEDIFF(microsecond,@Time1,@Time2)
print 'size ' + convert(varchar(20),@top)+ ' Time elapsed T1: '+convert(varchar(36),DATEDIFF(microsecond,@Time1,@Time2),14)


set @Time1  = SYSDATETIME()
update T2 set F1=F1+10
set @Time2  = SYSDATETIME()
set @td2 = @td2+DATEDIFF(microsecond,@Time1,@Time2)
print 'size ' + convert(varchar(20),@top)+ ' Time elapsed T2: '+convert(varchar(36),DATEDIFF(microsecond,@Time1,@Time2),14)


set @Time1  = SYSDATETIME()
update T3 set F1=F1+10
set @Time2  = SYSDATETIME()
set @td3 = @td3+DATEDIFF(microsecond,@Time1,@Time2)
print 'size ' + convert(varchar(20),@top)+ ' Time elapsed T3: '+convert(varchar(36),DATEDIFF(microsecond,@Time1,@Time2),14)

set @Time1  = SYSDATETIME()
update T4 set F1=F1+10
set @Time2  = SYSDATETIME()
set @td4 = @td4+DATEDIFF(microsecond,@Time1,@Time2)
print 'size ' + convert(varchar(20),@top)+ ' Time elapsed T4: '+convert(varchar(36),DATEDIFF(microsecond,@Time1,@Time2),14)

set @Time1  = SYSDATETIME()
update T5 set F1=F1+10
set @Time2  = SYSDATETIME()
set @td5 = @td5+DATEDIFF(microsecond,@Time1,@Time2)
print 'size ' + convert(varchar(20),@top)+ ' Time elapsed T5: '+convert(varchar(36),DATEDIFF(microsecond,@Time1,@Time2),14)


Set @cnt2 = @cnt2 + 1

TRUNCATE TABLE T1
TRUNCATE TABLE T2
TRUNCATE TABLE T3
TRUNCATE TABLE T4
TRUNCATE TABLE T5
End


Set @td1= @td1 / 6
Set @td2= @td2 / 6
Set @td3= @td3 / 6
Set @td4= @td4 / 6
Set @td5= @td5 / 6

print 'Results:'
print @td1
print @td2
print @td3
print @td4
print @td5

