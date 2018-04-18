using System.ComponentModel.DataAnnotations;

namespace WorkoutTracker.Entities.DTO
{
    public class CategoryDTO
    {
        public int CategoryId { get; set; }

        [Required]
        [StringLength(64)]
        public string CategoryName { get; set; }
    }
}
