USE POTATO;
--7 часть ----------секцирование средствами субд
--DROP TABLE IF EXISTS [dbo].[T_Log] --очистка таблицы перед пунтком 7


----заполнение миллионом уникальных значений
--CREATE TABLE [dbo].[T_Log](
--	[Date_Time] [datetime2](7) NOT NULL,
--	[Employer] [nvarchar](255)  NOT NULL,
--	[Action] [nvarchar](1024) NOT NULL,
--	--PRIMARY KEY([Date_Time], [Employer]) убираем праймари кей для того,чтобы появилась куча
--)-- ON [PRIMARY]
--GO

---- переменная - начальная дата
--Declare @date [datetime2](7)
--Set @date = '2023-03-03 00:00:00'  

---- переменная счётчик для управления числом записей
--Declare @cnt int
--Set @cnt = 0

--While @cnt < 1000000
--Begin
--   -- инкремент даты на 1 секунду
--   Set @date = DATEADD(second,1,@date)

--   -- инкремент счётчика
--   Set @cnt = @cnt + 1

--   -- вставка новой уникальноц записи
--   Insert Into T_Log values (@date,'Андреев Алексей Альбертович', 'Чтение')
--End

-- --всё вставили

-- select Date_Time from T_Log
 
  --поиск по точной записи в куче без примари кей без секцирования
 --set statistics time on
 --select Date_Time from T_Log where Date_Time = '2023-03-08 19:31:09.000001'
 --set statistics time off



 --первая секция
 --set statistics time on
 --select Date_Time from T_Log where Date_Time = '2023-03-08 15:52:00.000001'
 --set statistics time off



 --граница секций 
 --set statistics time on
 --select Date_Time from T_Log where Date_Time = '2023-03-08 19:30:04.000001'
 --set statistics time off


 --вторая секция
 --set statistics time on
 --select Date_Time from T_Log where Date_Time = '2023-03-08 20:53:30.000001'
 --set statistics time off


 



