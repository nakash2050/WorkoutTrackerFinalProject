using AutoMapper;
using System.Collections.Generic;
using System.Web.Mvc;
using WorkoutTracker.BAL;
using WorkoutTracker.Entities.DTO;
using WorkoutTracker.Web.ViewModels;

namespace WorkoutTracker.Web.Controllers
{
    public class ViewAllController : Controller
    {
        private readonly WorkoutBAL _workoutBAL;
        private readonly CategoryBAL _categoryBAL;

        private IEnumerable<WorkoutDTO> _workouts;
        private IEnumerable<CategoryDTO> _categories;

        private WorkoutViewModel _workoutViewModel;

        public ViewAllController()
        {
            _workoutBAL = new WorkoutBAL();
            _categoryBAL = new CategoryBAL();

            _workouts = _workoutBAL.GetAllWorkouts();
            _categories = _categoryBAL.GetAllWorkoutCategories();

            _workoutViewModel = new WorkoutViewModel()
            {
                Workouts = _workouts,
                Categories = _categories
            };
        }

        public ActionResult Index()
        {
            return View("ViewAll", _workoutViewModel);
        }

        public ActionResult EditWorkout(int id)
        {
            _workoutViewModel.Workout = _workoutBAL.GetWorkout(id);
            return View("Edit", _workoutViewModel);
        }

        public ActionResult DeleteWorkout(int id)
        {
            var isWorkoutDeleted = _workoutBAL.DeleteWorkout(id);

            if (isWorkoutDeleted)
            {
                var workouts = _workoutBAL.GetAllWorkouts();
                _workoutViewModel = new WorkoutViewModel()
                {
                    Workouts = workouts
                };
            }

            return PartialView("ViewAll", _workoutViewModel);
        }

        public ActionResult StartWorkout(int id)
        {
            var workoutDTO = _workoutBAL.GetWorkout(id);
            var workout = Mapper.Map<WorkoutActiveViewModel>(workoutDTO);
            return View("Start", workout);
        }
        [HttpPost]
        public ActionResult StartWorkout(WorkoutActiveViewModel workoutModel)
        {
            if (ModelState.IsValid)
            {
                workoutModel.Status = true;
                var workoutActiveDTO = Mapper.Map<WorkoutActiveDTO>(workoutModel);
                var result = _workoutBAL.StartWorkout(workoutActiveDTO);
                if(result)
                {
                    return RedirectToAction("Index");
                }
            }

            return RedirectToAction("StartWorkout", workoutModel.WorkoutId);
        }

        public ActionResult EndWorkout(int id)
        {
            return View();
        }

        [HttpPost]
        public ActionResult UpdateWorkout(WorkoutDTO workout)
        {
            if(ModelState.IsValid)
            {
                if(_workoutBAL.UpdateWorkout(workout.WorkoutId, workout))
                {
                    return RedirectToAction("Index");
                }
            }

            return View("Edit", _workoutViewModel);
        }
    }
}