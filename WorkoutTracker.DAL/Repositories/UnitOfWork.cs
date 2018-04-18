using WorkoutTracker.IRepositories;

namespace WorkoutTracker.DAL.Repositories
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly WorkoutTrackerContext _context;

        public UnitOfWork(WorkoutTrackerContext context)
        {
            _context = context;
            WorkoutCategory = new WorkoutCategoryRepository(context);
            WorkoutActive = new WorkoutActiveRepository(context);
            WorkoutCollection = new WorkoutCollectionRepository(context);
        }

        public IWorkoutActiveRepository WorkoutActive { get; private set; }

        public IWorkoutCategoryRepository WorkoutCategory { get; private set; }

        public IWorkoutCollectionRepository WorkoutCollection { get; private set; }

        public int Complete()
        {
            return _context.SaveChanges();
        }

        public void Dispose()
        {
            _context.Dispose();
        }
    }
}
