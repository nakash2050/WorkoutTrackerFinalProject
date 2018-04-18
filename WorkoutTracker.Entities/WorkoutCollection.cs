using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WorkoutTracker.Entities
{
    [Table("workout_collection")]
    public class WorkoutCollection
    {
        [Key]
        [Column("workout_id")]
        public int WorkoutId { get; set; }

        [Column("workout_title", TypeName = "varchar")]
        [StringLength(128)]
        [Required]
        public string WorkoutTitle { get; set; }

        [Column("workout_note", TypeName = "varchar")]
        [StringLength(256)]
        public string WorkoutNote { get; set; }

        [Column("calories_burn_per_min")]        
        public decimal CaloriesBurntPerMin { get; set; }

        [Column("category_id")]
        public int CategoryId { get; set; }

        public WorkoutCategory WorkoutCategory { get; set; }
    }
}
