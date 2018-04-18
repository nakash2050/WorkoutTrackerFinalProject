using System;
using System.Linq;
using System.Collections.Generic;
using WorkoutTracker.Entities;
using WorkoutTracker.Entities.DTO;
using WorkoutTracker.IRepositories;

namespace WorkoutTracker.DAL.Repositories
{
    public class WorkoutCollectionRepository : Repository<WorkoutCollection>, IWorkoutCollectionRepository
    {
        public WorkoutTrackerContext WorkoutTrackerContext
        {
            get
            {
                return Context as WorkoutTrackerContext;
            }
        }

        public WorkoutCollectionRepository(WorkoutTrackerContext context) :
            base(context)
        {

        }
    }
}
