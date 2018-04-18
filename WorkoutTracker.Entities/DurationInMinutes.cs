using System.ComponentModel.DataAnnotations;

namespace WorkoutTracker.Entities
{
    public class DurationInMinutes
    {
        public int Duration { get; set; }

        public int TotalTimeInMinutes { get; set; }
    }
}
