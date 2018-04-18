using System.Data.Entity;
using WorkoutTracker.Entities;

namespace WorkoutTracker.DAL
{
    public class WorkoutTrackerContext : DbContext
    {
        public WorkoutTrackerContext() :
            base("name=WorkoutTrackerContext")
        {

        }

        public virtual DbSet<WorkoutCategory> WorkoutCategory { get; set; }

        public virtual DbSet<WorkoutCollection> WorkoutCollection { get; set; }

        public virtual DbSet<WorkoutActive> WorkoutActive { get; set; }
    }
}
