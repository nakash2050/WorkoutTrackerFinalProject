using System.Linq;
using System.Collections.Generic;
using System.Web.Http;
using WorkoutTracker.BAL;
using WorkoutTracker.Entities.DTO;

namespace WorkoutTracker.API.Controllers
{
    public class CategoryController : ApiController
    {
        private readonly CategoryBAL _categoryBAL;

        public CategoryController()
        {
            _categoryBAL = new CategoryBAL();
        }
                
        public IHttpActionResult Get()
        {
            var result = _categoryBAL.GetAllWorkoutCategories().OrderByDescending(category => category.CategoryId);
            return Ok(result);
        }

        public IHttpActionResult Get(int id)
        {
            var result = _categoryBAL.GetWorkoutCategory(id);

            if (result == null)
                return NotFound();

            return Ok(result);
        }

        public IHttpActionResult Post(CategoryDTO categoryDTO)
        {
            IEnumerable<CategoryDTO> categories = null;

            if (!ModelState.IsValid)
                return BadRequest();

            var result = _categoryBAL.AddWorkoutCategory(categoryDTO);
            if (result)
            {
                categories = _categoryBAL.GetAllWorkoutCategories().OrderByDescending(category => category.CategoryId);
            }

            return Ok(categories);
        }

        public IHttpActionResult Put(int id, CategoryDTO categoryDTO)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var result = _categoryBAL.UpdateWorkoutCategory(id, categoryDTO);
            return Ok(result);
        }

        public IHttpActionResult Delete(int id)
        {
            var result = _categoryBAL.DeleteWorkoutCategory(id);
            return Ok(result);
        }
    }
}
