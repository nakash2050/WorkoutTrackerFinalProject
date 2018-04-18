using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Linq;
using WorkoutTracker.Entities;
using WorkoutTracker.IRepositories;

namespace WorkoutTracker.DAL.Repositories
{
    public class WorkoutActiveRepository : Repository<WorkoutActive>, IWorkoutActiveRepository
    {
        public WorkoutTrackerContext WorkoutTrackerContext
        {
            get
            {
                return Context as WorkoutTrackerContext;
            }
        }

        public WorkoutActiveRepository(WorkoutTrackerContext context) :
            base(context)
        {

        }

        public WorkoutActive GetWorkoutByWorkoutId(int id)
        {
            return WorkoutTrackerContext.WorkoutActive.Where(workout => workout.WorkoutId == id).FirstOrDefault();
        }

        public DataSet GetTotalWorkoutTimesReport()
        {
            DataSet ds = null;
            string commandText = "[dbo].[sp_GetTotalWorkoutTimesReport]";

            using (var db = new WorkoutTrackerContext())
            {
                var cmd = db.Database.Connection.CreateCommand();
                cmd.CommandText = commandText;

                try
                {
                    db.Database.Connection.Open();
                    var reader = cmd.ExecuteReader();

                    ds = new DataSet();

                    while (!reader.IsClosed && reader.HasRows)
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        ds.Tables.Add(dt);
                    }
                }
                finally
                {
                    db.Database.Connection.Close();
                }
            }

            return ds;
        }

        public DataSet GetTotalCaloriesReport()
        {
            DataSet ds = null;
            string commandText = "[dbo].[sp_GetTotalCaloriesReport]";

            using (var db = new WorkoutTrackerContext())
            {
                var cmd = db.Database.Connection.CreateCommand();
                cmd.CommandText = commandText;

                try
                {
                    db.Database.Connection.Open();
                    var reader = cmd.ExecuteReader();

                    ds = new DataSet();

                    while (!reader.IsClosed && reader.HasRows)
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        ds.Tables.Add(dt);
                    }
                }
                finally
                {
                    db.Database.Connection.Close();
                }
            }

            return ds;
        }
    }
}
