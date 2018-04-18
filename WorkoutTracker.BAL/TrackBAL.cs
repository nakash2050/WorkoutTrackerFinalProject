using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WorkoutTracker.DAL;
using WorkoutTracker.DAL.Repositories;
using WorkoutTracker.Entities;
using WorkoutTracker.Entities.DTO;

namespace WorkoutTracker.BAL
{
    public class TrackBAL
    {
        public TrackDTO GetTrackerReport()
        {
            TrackDTO trackDTO = null;

            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                trackDTO = new TrackDTO();
                var wtDs = unitOfWork.WorkoutActive.GetTotalWorkoutTimesReport();

                if (wtDs != null && wtDs.Tables.Count > 0)
                {
                    trackDTO.TotalWorkoutTimeOfDay = wtDs.Tables[0].Rows.Count > 0 ? Convert.ToInt32(wtDs.Tables[0].Rows[0]["TotalTimeInMinutes"]) : 0;
                    trackDTO.TotalWorkoutTimeOfWeek = wtDs.Tables[1] != null && wtDs.Tables[1].Rows.Count > 0 ? Convert.ToInt32(wtDs.Tables[1].Rows[0]["TotalTimeInMinutes"]) : 0;
                    trackDTO.TotalWorkoutTimeOfMonth = wtDs.Tables[2] != null && wtDs.Tables[2].Rows.Count > 0 ? Convert.ToInt32(wtDs.Tables[2].Rows[0]["TotalTimeInMinutes"]) : 0;
                }

                var dataSet = unitOfWork.WorkoutActive.GetTotalCaloriesReport();
                if(dataSet != null && dataSet.Tables.Count > 0)
                {
                    DataTable dt = dataSet.Tables[0];
                    trackDTO.TotalCaloriesBurntPerWeek = dt.AsEnumerable()
                        .Select(row => new TotalCalories() { Duration = Convert.ToString(row["Duration"]), TotalCaloriesBurnt = Convert.ToString(row["TotalCaloriesBurnt"]) });

                    if(dataSet.Tables.Count > 1)
                    {
                        dt = dataSet.Tables[1];
                        trackDTO.TotalCaloriesBurntPerMonth = dt.AsEnumerable()
                            .Select(row => new TotalCalories() { Duration = Convert.ToString(row["Duration"]), TotalCaloriesBurnt = Convert.ToString(row["TotalCaloriesBurnt"]) });
                    }

                    if (dataSet.Tables.Count > 2)
                    {
                        dt = dataSet.Tables[2];
                        trackDTO.TotalCaloriesBurntPerYear = dt.AsEnumerable()
                            .Select(row => new TotalCalories() { Duration = Convert.ToString(row["Duration"]), TotalCaloriesBurnt = Convert.ToString(row["TotalCaloriesBurnt"]) });
                    }
                }

            }

            return trackDTO;
        }
    }
}
