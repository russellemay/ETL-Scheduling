SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[StartStepJobs]
	@step varchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	declare step_jobs_csr cursor for 
	select c.name, job_id
	from msdb.dbo.sysjobs j
		join msdb.dbo.syscategories c on c.category_id = j.category_id
		--join msdb.dbo.sysjobactivity ja on ja.job_id = j.job_id
	where c.name = @step

	declare @category varchar(50)
		, @jobid varchar(50)
	
	open step_jobs_csr;
	fetch next from step_jobs_csr into @category, @jobid
	while @@fetch_status = 0
	begin
		exec msdb.dbo.sp_start_job @job_id = @jobid

		fetch next from step_jobs_csr into @category, @jobid
	end

	close step_jobs_csr;
	deallocate step_jobs_csr;

END

GO


