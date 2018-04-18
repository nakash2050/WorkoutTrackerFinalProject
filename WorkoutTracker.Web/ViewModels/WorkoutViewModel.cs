using System.Collections.Generic;
using WorkoutTracker.Entities;
using WorkoutTracker.Entities.DTO;

namespace WorkoutTracker.Web.ViewModels
{
    public class WorkoutViewModel
    {
        public IEnumerable<CategoryDTO> Categories { get; set; }
       
        public WorkoutDTO Workout { get; set; }

        public IEnumerable<WorkoutDTO> Workouts { get; set; }
    }
}