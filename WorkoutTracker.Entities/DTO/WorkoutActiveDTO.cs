using System;
using System.ComponentModel.DataAnnotations;


namespace WorkoutTracker.Entities.DTO
{
    public class WorkoutActiveDTO
    {
        [Required]
        public int WorkoutId { get; set; }

        public int WorkoutActiveId { get; set; }

        public DateTime? StartDate { get; set; }

        public TimeSpan? StartTime { get; set; }

        public DateTime? EndDate { get; set; }

        public TimeSpan? EndTime { get; set; }

        [StringLength(64)]
        public string Comment { get; set; }

        public bool Status { get; set; }
    }
}
