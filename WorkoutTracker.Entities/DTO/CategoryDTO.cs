﻿using System.ComponentModel.DataAnnotations;

namespace WorkoutTracker.Entities.DTO
{
    public class CategoryDTO
    {
        public int CategoryId { get; set; }

        [Required]
        [StringLength(64)]
        [Display(Name = "Category Name")]
        public string CategoryName { get; set; }
    }
}
