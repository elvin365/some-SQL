USE POTATO;
DROP TABLE IF EXISTS [dbo].[T_Log]
DROP TABLE IF EXISTS #tblSizes

CREATE TABLE [dbo].[T_Log](
	[Date_Time] [datetime2](7) NOT NULL,
	[Employer] [nvarchar](255)  NOT NULL,
	[Action] [nvarchar](1024) NOT NULL,
	PRIMARY KEY([Date_Time], [Employer])
) ON [PRIMARY]
GO


create table #tblSizes(
    [name] varchar(50),
    [rows] int,
    [reserved] varchar(50),
    [data] varchar(50),
    [index_size] varchar(50),
    [unused] varchar(50)
    )

Declare @date [datetime2](7)
Set @date = '2023-03-03 00:00:00'--(select max(Date_Time)  from T_Log)    --'2023-03-11 23:59:00'

Declare @cnt int
Set @cnt = 0

Declare @top int
Set @top = 83 -- шаг


insert into #tblSizes([name], [rows], [reserved], [data], [index_size], [unused])
        exec sp_spaceused T_Log
--самый первый рисунок
--While @cnt < 10--1000*1000*10
--Begin	
--   Set @date = DATEADD(second,1,@date)
--   Insert Into T_Log values (@date,'Андреев Алексей Альбертович', 'Литература')
--   Print @date
--   Set @cnt = @cnt + 1
--  -- If(@cnt % 100000 = 0 )

-- --  	if(@cnt% @top = 0)
--	--	insert into #tblSizes([name], [rows], [reserved], [data], [index_size], [unused])
-- --       exec sp_spaceused T_Log		

--	--if(@cnt% @top = 1)
--	--begin
--	--	insert into #tblSizes([name], [rows], [reserved], [data], [index_size], [unused])
-- --       exec sp_spaceused T_Log	
--	--	 Set @top = @top *4
--	--end
--End

-- первая таблица для поиска конца первого экстента
--While @cnt < 100000--1000*1000*10
--Begin	
--   Set @date = DATEADD(second,1,@date)
--   Insert Into T_Log values (@date,'Андреев Алексей Альбертович', 'Литература')
--   Print @date
--   Set @cnt = @cnt + 1
--   --If(@cnt % 100000 = 0 )

--   	if(@cnt% @top = 0)
--		insert into #tblSizes([name], [rows], [reserved], [data], [index_size], [unused])
--        exec sp_spaceused T_Log		

--	if(@cnt% @top = 1)
--	begin
--		insert into #tblSizes([name], [rows], [reserved], [data], [index_size], [unused])
--        exec sp_spaceused T_Log	
--		 --Set @top = @top *4
--	end
--End

--увеличение числа значений в несколько раз (6)
--While @cnt < 100000--1000*1000*10
--Begin	
--   Set @date = DATEADD(second,1,@date)
--   Insert Into T_Log values (@date,'Андреев Алексей Альбертович', 'Литература')
--   Print @date
--   Set @cnt = @cnt + 1
--   --If(@cnt % 100000 = 0 )

--   	if(@cnt% @top = 0)
--		insert into #tblSizes([name], [rows], [reserved], [data], [index_size], [unused])
--        exec sp_spaceused T_Log		

--	if(@cnt% @top = 1)
--	begin
--		insert into #tblSizes([name], [rows], [reserved], [data], [index_size], [unused])
--        exec sp_spaceused T_Log	
--		 Set @top = @top *4
--	end
--End






insert into #tblSizes([name], [rows], [reserved], [data], [index_size], [unused])
        exec sp_spaceused T_Log

select * from #tblSizes order by 1
drop table #tblSizes

select top(10) * from T_Log
--select * from T_Log
GO 

DROP TABLE IF EXISTS [dbo].[T_Log] --очистка таблицы перед пунтком 7


