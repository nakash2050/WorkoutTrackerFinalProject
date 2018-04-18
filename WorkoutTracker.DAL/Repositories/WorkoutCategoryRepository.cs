using WorkoutTracker.Entities;
using WorkoutTracker.IRepositories;

namespace WorkoutTracker.DAL.Repositories
{
    public class WorkoutCategoryRepository : Repository<WorkoutCategory>, IWorkoutCategoryRepository
    {
        public WorkoutTrackerContext WorkoutTrackerContext
        {
            get
            {
                return Context as WorkoutTrackerContext;
            }
        }

        public WorkoutCategoryRepository(WorkoutTrackerContext context)
            : base(context)
        {

        }
    }
}
