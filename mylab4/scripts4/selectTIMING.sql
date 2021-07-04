

use BROKOLLI
SET NOCOUNT ON 

DROP TABLE IF EXISTS T1
DROP TABLE IF EXISTS T2
DROP TABLE IF EXISTS arr


Declare @top int
Set @top = 200000

Declare @timesum BIGINT--int
Set @timesum = 0
Declare @timesum2 BIGINT--int
Set @timesum2 = 0

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

SET @cnt=0
While @cnt < @top
Begin	
	set @_F1 = ABS(CHECKSUM(NEWID()))
	set @_F2 = convert(varchar(36),newid())
    Insert Into T1 values (@_F1,@_F2)
    Insert Into T2 values (@_F1,@_F2)
    Set @cnt = @cnt + 1
End
create index T2_F1_i on T2 (F1)



Declare @Time1 datetime2(7)
Declare @Time2 datetime2(7)

Set @cnt = 0


ALTER TABLE arr ADD CONSTRAINT PK_arr PRIMARY KEY CLUSTERED (idx);


Declare @td1 int
Declare @td2 int

Declare @cnt2 int

Set @td1= 0
Set @td2= 0

Set @cnt2 = 0

While @cnt2 < 6
Begin	

Set @cnt = 0
While @cnt < @top
Begin	
	select @_F1 = F1 from arr where idx = @cnt
	set @Time1  = SYSDATETIME()
	--Insert Into T1 values (@_F1,@_F2)
	SELECT @_F2= min(F2) from T1 where F1 = @_F1
	set @Time2  = SYSDATETIME()
	set @timesum= @timesum+DATEDIFF(microsecond,@Time1,@Time2)
    Set @cnt = @cnt + 1
End
set @td1 = @td1+@timesum
print 'sizeIAMHERE ' + convert(varchar(20),@top)+ ' MY Time elapsed T1: '+convert(varchar(36),@timesum)



Set @cnt = 0
While @cnt < @top
Begin	
	select @_F1 = F1 from arr where idx = @cnt
	set @Time1 =SYSDATETIME()
	SELECT @_F2= min(F2) from T2 where T2.F1 = @_F1
	set @Time2 = SYSDATETIME()
	set @timesum2=@timesum2+DATEDIFF(microsecond,@Time1,@Time2)
    Set @cnt = @cnt + 1
End
set @td2 = @td2+@timesum2
print 'size ' + convert(varchar(20),@top)+ ' Time elapsed T2: '+convert(varchar(36),@timesum2)



Set @cnt2 = @cnt2 + 1

TRUNCATE TABLE T1
TRUNCATE TABLE T2
set @timesum=0
set @timesum2=0
End


Set @td1= @td1 / 6
Set @td2= @td2 / 6


print 'Results:'
print @td1
print @td2

