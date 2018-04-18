USE [WorkoutTrackerDemo]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_GetTotalCaloriesReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
  DROP PROCEDURE [dbo].[sp_GetTotalCaloriesReport]
END
GO

CREATE PROCEDURE sp_GetTotalCaloriesReport
AS
BEGIN
	--Day
	SELECT SUBSTRING(Duration, 1, 3) Duration, ISNULL(SUM(CaloriesBurnt),0) TotalCaloriesBurnt FROM 
		(SELECT 
			DATENAME(dw, start_date) Duration, 
			(calories_burn_per_min * SUM(DATEDIFF(MINUTE, start_time, end_time))) CaloriesBurnt
		FROM [dbo].[workout_collection] WC
		JOIN [dbo].[workout_active] WA
			ON WC.workout_id = WA.workout_id
		WHERE WA.end_date IS NOT NULL AND WA.end_time IS NOT NULL
		GROUP BY DATENAME(dw, start_date), calories_burn_per_min) AS TBL
	GROUP BY DURATION

	--Week
	SELECT 'Week ' + CAST(Duration AS VARCHAR) Duration, ISNULL(SUM(CaloriesBurnt),0) TotalCaloriesBurnt FROM 
		(SELECT 
			DATEPART(WEEK, start_date)-DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM,0, start_date), 0))+ 1 Duration, 
			(calories_burn_per_min * SUM(DATEDIFF(MINUTE, start_time, end_time))) CaloriesBurnt
		FROM [dbo].[workout_collection] WC
		JOIN [dbo].[workout_active] WA
			ON WC.workout_id = WA.workout_id
		WHERE WA.end_date IS NOT NULL AND WA.end_time IS NOT NULL
		GROUP BY DATEPART(WEEK, start_date)-DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM,0, start_date), 0))+ 1, calories_burn_per_min) AS TBL
	GROUP BY DURATION

	--Year
	SELECT 'Y' + CAST(Duration AS VARCHAR) Duration, ISNULL(SUM(CaloriesBurnt),0) TotalCaloriesBurnt FROM 
		(SELECT 
			DATEPART(MONTH, start_date) Duration, 
			(calories_burn_per_min * SUM(DATEDIFF(MINUTE, start_time, end_time))) CaloriesBurnt
		FROM [dbo].[workout_collection] WC
		JOIN [dbo].[workout_active] WA
			ON WC.workout_id = WA.workout_id
		WHERE WA.end_date IS NOT NULL AND WA.end_time IS NOT NULL
		GROUP BY DATEPART(MONTH, start_date), calories_burn_per_min) AS TBL
	GROUP BY DURATION
END
