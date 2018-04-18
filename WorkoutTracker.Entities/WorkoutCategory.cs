using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WorkoutTracker.Entities
{
    [Table("workout_category")]
    public class WorkoutCategory
    {
        [Key]
        [Column("category_id")]
        public int CategoryId { get; set; }

        [Column("category_name", TypeName = "varchar")]
        [StringLength(64)]
        [Required]
        public string CategoryName { get; set; }
    }
}
