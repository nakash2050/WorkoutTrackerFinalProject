******Workout Tracker MVC Application*******
1. Open the WorkoutTracker.sln.
2. Need to change the Connection String in the following folders:
	WorkoutTracker.Web - Web.config
	WorkoutTracker.Tests - App.config
	Connection String:
	<add name="WorkoutTrackerContext" connectionString="Data Source=DELL\SQLEXPRESS;Initial Catalog=WorkoutTrackerDemo;Integrated Security=True;" providerName="System.Data.SqlClient" />
3. Build the solution
4. I have used Code First Migration of Entity Framework. If the connection string is correct, accessing the application should automatically
   create the database and execute the SQL Stored Procedures.
5. If the above does not work, I have placed the SQL scripts in the "WorkoutTracker.StoredProcedures" folder. Please run "SQL_Init_Script.sql" script first
   and then execute the SPs.
6. I have used Repository Pattern with Entity framework for data access.
7. The MVC project is in WorkoutTracker.Web folder.
8. Screenshots document is available in the same directory as this Readme.txt file.


