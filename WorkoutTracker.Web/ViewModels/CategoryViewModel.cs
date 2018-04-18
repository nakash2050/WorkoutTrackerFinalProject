using System.Collections.Generic;
using WorkoutTracker.Entities.DTO;

namespace WorkoutTracker.Web.ViewModels
{
    public class CategoryViewModel
    {
        public IEnumerable<CategoryDTO> Categories { get; set; }

        public CategoryDTO Category { get; set; }

        public bool IsModal { get; set; }
    }
}