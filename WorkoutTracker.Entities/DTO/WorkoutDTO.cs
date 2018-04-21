using System;
using System.ComponentModel.DataAnnotations;

namespace WorkoutTracker.Entities.DTO
{
    public class WorkoutDTO
    {
        public int WorkoutId { get; set; }

        [Required(ErrorMessage = "Title is required")]
        [StringLength(128)]
        [Display(Name = "Title")]
        public string WorkoutTitle { get; set; }

        [StringLength(256)]
        [Display(Name = "Note")]
        public string WorkoutNote { get; set; }

        [Display(Name = "Calories Burnt Per Min")]
        public decimal CaloriesBurntPerMin { get; set; }

        [Display(Name = "Category")]
        public int CategoryId { get; set; }

        public bool Status { get; set; }
    }
}
