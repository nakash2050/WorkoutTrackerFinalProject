using System.Collections.Generic;

namespace WorkoutTracker.Entities.DTO
{
    public class TrackDTO
    {
        public int TotalWorkoutTimeOfDay { get; set; }

        public int TotalWorkoutTimeOfWeek { get; set; }

        public int TotalWorkoutTimeOfMonth { get; set; }

        public IEnumerable<TotalCalories> TotalCaloriesBurntPerWeek { get; set; }

        public IEnumerable<TotalCalories> TotalCaloriesBurntPerMonth { get; set; }

        public IEnumerable<TotalCalories> TotalCaloriesBurntPerYear { get; set; }
    }
}
