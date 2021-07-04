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
use BROKOLLI
SET NOCOUNT ON 

DROP TABLE IF EXISTS T1
DROP TABLE IF EXISTS T2
DROP TABLE IF EXISTS T3
DROP TABLE IF EXISTS T4
--DROP TABLE IF EXISTS T5
DROP TABLE IF EXISTS arr


Declare @top int
Set @top = 100000

Declare @timesum int
Set @timesum = 0

Declare @timesum2 int
Set @timesum2 = 0

Declare @timesum3 int
Set @timesum3 = 0
Declare @timesum4 int
Set @timesum4 = 0

Declare @timesum5 int
Set @timesum5 = 0


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
    Insert Into arr values (@cnt,@_F1,@_F2)
    Set @cnt = @cnt + 1
End


Declare @Time1 datetime2(7)
Declare @Time2 datetime2(7)

Set @cnt = 0


ALTER TABLE arr ADD CONSTRAINT PK_arr PRIMARY KEY CLUSTERED (idx);


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

Set @cnt = 0
--set @Time1  = SYSDATETIME()
While @cnt < @top
Begin	
	select @_F1 = F1, @_F2 = F2 from arr where idx = @cnt
	set @Time1  = SYSDATETIME()
	Insert Into T1 values (@_F1,@_F2)
	set @Time2  = SYSDATETIME()
	set @timesum= @timesum+DATEDIFF(microsecond,@Time1,@Time2)
    Set @cnt = @cnt + 1
End
--set @Time2  = SYSDATETIME()
set @td1 = @td1+@timesum
print 'size ' + convert(varchar(20),@top)+ ' Time elapsed T1: '+convert(varchar(36),@timesum)


Set @cnt = 0
--set @Time1  = SYSDATETIME()
While @cnt < @top
Begin	
	select @_F1 = F1, @_F2 = F2 from arr where idx = @cnt
	set @Time1  = SYSDATETIME()
	Insert Into T2 values (@_F1,@_F2)
	set @Time2  = SYSDATETIME()
	set @timesum2= @timesum2+DATEDIFF(microsecond,@Time1,@Time2)
    Set @cnt = @cnt + 1
End
--set @Time2  = SYSDATETIME()
set @td2 = @td2+ @timesum2
print 'size ' + convert(varchar(20),@top)+ ' Time elapsed T2: '+convert(varchar(36),@timesum2)


Set @cnt = 0
--set @Time1  = SYSDATETIME()
While @cnt < @top
Begin	
	select @_F1 = F1, @_F2 = F2 from arr where idx = @cnt
	set @Time1  = SYSDATETIME()
	Insert Into T3 values (@_F1,@_F2)
	set @Time2  = SYSDATETIME()
	set @timesum3= @timesum3+DATEDIFF(microsecond,@Time1,@Time2)
    Set @cnt = @cnt + 1
End
--set @Time2  = SYSDATETIME()
set @td3 = @td3 +@timesum3
print 'size ' + convert(varchar(20),@top)+ ' Time elapsed T3: '+convert(varchar(36),@timesum3)

Set @cnt = 0
--set @Time1  = SYSDATETIME()
While @cnt < @top
Begin	
	select @_F1 = F1, @_F2 = F2 from arr where idx = @cnt
	set @Time1  = SYSDATETIME()
	Insert Into T4 values (@_F1,@_F2)
	set @Time2  = SYSDATETIME()
	set @timesum4= @timesum4+DATEDIFF(microsecond,@Time1,@Time2)
    Set @cnt = @cnt + 1
End
--set @Time2  = SYSDATETIME()
set @td4 =  @td4 +@timesum4
print 'size ' + convert(varchar(20),@top)+ ' Time elapsed T4: '+convert(varchar(36),@timesum4)

Set @cnt = 0
--set @Time1  = SYSDATETIME()
While @cnt < @top
Begin	
	select @_F1 = F1, @_F2 = F2 from arr where idx = @cnt
	set @Time1  = SYSDATETIME()
	Insert Into T5 values (@_F1,@_F2)
	set @Time2  = SYSDATETIME()
	set @timesum5= @timesum5+DATEDIFF(microsecond,@Time1,@Time2)
    Set @cnt = @cnt + 1
End
--set @Time2  = SYSDATETIME()
set @td5 = @td5+@timesum5
print 'size ' + convert(varchar(20),@top)+ ' Time elapsed T5: '+convert(varchar(36),@timesum5)

Set @cnt2 = @cnt2 + 1

TRUNCATE TABLE T1
TRUNCATE TABLE T2
TRUNCATE TABLE T3
TRUNCATE TABLE T4
TRUNCATE TABLE T5
set @timesum=0
set @timesum2=0
set @timesum3=0
set @timesum4=0
set @timesum5=0
print ' '
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