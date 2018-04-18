USE [WorkoutTrackerDemo]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_GetTotalWorkoutTimesReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
  DROP PROCEDURE [dbo].[sp_GetTotalWorkoutTimesReport]
END
GO


CREATE PROCEDURE [dbo].[sp_GetTotalWorkoutTimesReport]
AS
BEGIN
	SELECT DATEPART(DAY,start_date) Duration, ISNULL(SUM(DATEDIFF(MINUTE, start_time, end_time)),0) AS TotalTimeInMinutes
	FROM [dbo].[workout_active]
	WHERE DATEPART(DAY, start_date) = DATEPART(DAY, GETDATE())
	GROUP BY DATEPART(DAY, start_date)

	SELECT DATEPART(WEEK, start_date) Duration, ISNULL(SUM(DATEDIFF(MINUTE, start_time, end_time)),0) AS TotalTimeInMinutes
	FROM [dbo].[workout_active]
	WHERE DATEPART(WEEK, start_date) = DATEPART(WEEK, GETDATE())
	GROUP BY DATEPART(WEEK, start_date)

	SELECT DATEPART(MONTH, start_date) Duration, ISNULL(SUM(DATEDIFF(MINUTE, start_time, end_time)),0) AS TotalTimeInMinutes
	FROM [dbo].[workout_active]
	WHERE DATEPART(MONTH, start_date) = DATEPART(MONTH, GETDATE())
	GROUP BY DATEPART(MONTH, start_date)
END
