
using System;
using System.ComponentModel.DataAnnotations;


namespace WorkoutTracker.Web.ViewModels
{
    public class WorkoutActiveViewModel
    {
        public int WorkoutId { get; set; }

        [Required]
        [StringLength(128)]
        [Display(Name = "Title")]
        public string WorkoutTitle { get; set; }

        public int WorkoutActiveId { get; set; }

        [StringLength(256)]
        [Display(Name = "Note")]
        public string WorkoutNote { get; set; }

        [Display(Name = "Start Date")]
        public DateTime? StartDate { get; set; }

        [Display(Name = "Start Time")]
        public TimeSpan? StartTime { get; set; }

        [Display(Name = "End Date")]
        public DateTime? EndDate { get; set; }

        [Display(Name = "End Time")]
        public TimeSpan? EndTime { get; set; }

        [Display(Name = "Comment")]
        [StringLength(64)]
        public string Comment { get; set; }

        public bool Status { get; set; }
    }
}