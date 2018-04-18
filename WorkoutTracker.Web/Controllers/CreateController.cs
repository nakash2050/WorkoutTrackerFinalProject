using System.Web.Mvc;
using System.Linq;
using WorkoutTracker.BAL;
using WorkoutTracker.Web.ViewModels;
using System.Collections.Generic;
using WorkoutTracker.Entities.DTO;

namespace WorkoutTracker.Web.Controllers
{
    public class CreateController : Controller
    {
        private readonly CategoryBAL _categoryBAL;
        private readonly WorkoutBAL _workoutBAL;
        private List<CategoryDTO> _categories;
        private WorkoutViewModel _viewModel;

        public CreateController()
        {
            _categoryBAL = new CategoryBAL();
            _workoutBAL = new WorkoutBAL();

            _categories = _categoryBAL.GetAllWorkoutCategories().ToList();
            _viewModel = new WorkoutViewModel()
            {
                Categories = _categories
            };
        }

        // GET: Create
        public ActionResult Index()
        {
            return View("Create", _viewModel);
        }

        [HttpPost]
        public ActionResult Index(WorkoutDTO workout)
        {
            if(ModelState.IsValid)
            {
                if(_workoutBAL.AddWorkout(workout))
                {
                    ViewData["Message"] = "Workout added successfully";
                    ModelState.Clear();
                }
            }

            return View("Create", _viewModel);
        }
    }
}