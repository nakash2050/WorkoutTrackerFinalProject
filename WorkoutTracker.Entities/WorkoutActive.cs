using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WorkoutTracker.Entities
{
    [Table("workout_active")]
    public class WorkoutActive
    {
        [Key]
        [Column("workout_active_id")]
        public int WorkoutActiveId { get; set; }

        [Column("workout_id")]
        public int WorkoutId { get; set; }

        public WorkoutCollection WorkoutCollection { get; set; }

        [Column("start_date")]
        public DateTime? StartDate { get; set; }

        [Column("start_time")]
        public TimeSpan? StartTime { get; set; }

        [Column("end_date")]
        public DateTime? EndDate { get; set; }

        [Column("end_time")]
        public TimeSpan? EndTime { get; set; }
      
        [Column("comment", TypeName = "varchar")]
        [StringLength(64)]
        public string Comment { get; set; }

        [Column("status")]
        public bool? Status { get; set; }
    }
}
