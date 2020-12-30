SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MainStart]

AS
BEGIN

	SET NOCOUNT ON;

	exec StartStepJobs 'Daily.ETL.Step1'
	WAITFOR DELAY '00:00:02' -- Give the jobs a chance to start
	exec WaitForStepJobs 'Daily.ETL.Step1'

	exec StartStepJobs 'Daily.ETL.Step2'
	WAITFOR DELAY '00:00:02' -- Give the jobs a chance to start
	exec WaitForStepJobs 'Daily.ETL.Step2'

	exec StartStepJobs 'Daily.ETL.Step3'
	WAITFOR DELAY '00:00:02' -- Give the jobs a chance to start
	exec WaitForStepJobs 'Daily.ETL.Step3'

	exec StartStepJobs 'Daily.ETL.Step4'
	WAITFOR DELAY '00:00:02' -- Give the jobs a chance to start
	exec WaitForStepJobs 'Daily.ETL.Step4'

	exec StartStepJobs 'Daily.ETL.Step5'
	WAITFOR DELAY '00:00:02' -- Give the jobs a chance to start
	exec WaitForStepJobs 'Daily.ETL.Step5'

END
GO


