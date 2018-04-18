using System;
using System.ComponentModel.DataAnnotations;

namespace WorkoutTracker.Entities.DTO
{
    public class WorkoutDTO
    {
        public int WorkoutId { get; set; }

        [Required]
        [StringLength(128)]        
        public string WorkoutTitle { get; set; }

        [StringLength(256)]
        public string WorkoutNote { get; set; }

        public decimal CaloriesBurntPerMin { get; set; }

        public int CategoryId { get; set; }

        public bool Status { get; set; }
    }
}
