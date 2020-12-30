SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[WaitForStepJobs]
	@step varchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	declare @JobsRunning int

	select @JobsRunning = count(*) 
	from msdb.dbo.sysjobs j
		join msdb.dbo.syscategories c on c.category_id = j.category_id
		join msdb.dbo.sysjobactivity ja on ja.job_id = j.job_id
	where c.name = @step
		and ja.start_execution_date < getdate()
		and ja.stop_execution_date is null

	while @JobsRunning > 0
	begin

		WAITFOR DELAY '00:00:05';

		select @JobsRunning = count(*) 
		from msdb.dbo.sysjobs j
			join msdb.dbo.syscategories c on c.category_id = j.category_id
			join msdb.dbo.sysjobactivity ja on ja.job_id = j.job_id
		where c.name = @step
			and ja.start_execution_date < getdate()
			and ja.stop_execution_date is null
	end

END
GO


