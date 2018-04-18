using System.Collections.Generic;
using System.Data;
using WorkoutTracker.Entities;

namespace WorkoutTracker.IRepositories
{
    public interface IWorkoutActiveRepository : IRepository<WorkoutActive>
    {
        WorkoutActive GetWorkoutByWorkoutId(int id);

        DataSet GetTotalWorkoutTimesReport();

        DataSet GetTotalCaloriesReport();
    }
}
