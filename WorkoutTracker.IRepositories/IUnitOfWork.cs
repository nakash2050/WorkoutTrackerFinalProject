using System;

namespace WorkoutTracker.IRepositories
{
    public interface IUnitOfWork : IDisposable
    {
        IWorkoutCategoryRepository WorkoutCategory { get; }

        IWorkoutCollectionRepository WorkoutCollection { get; }

        IWorkoutActiveRepository WorkoutActive { get; }

        int Complete();
    }
}
