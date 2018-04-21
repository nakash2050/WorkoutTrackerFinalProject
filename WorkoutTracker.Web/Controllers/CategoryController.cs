using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using WorkoutTracker.BAL;
using WorkoutTracker.Entities.DTO;
using WorkoutTracker.Web.ViewModels;

namespace WorkoutTracker.Web.Controllers
{
    public class CategoryController : Controller
    {
        private readonly CategoryBAL _categoryBAL;
        private IEnumerable<CategoryDTO> _categories;
        private CategoryViewModel _categoryViewModel;

        public CategoryController()
        {
            _categoryBAL = new CategoryBAL();
            _categories = _categoryBAL.GetAllWorkoutCategories();
            _categoryViewModel = new CategoryViewModel()
            {
                Categories = _categories
            };
        }

        // GET: Category
        public ActionResult Index()
        {
            Session["Categories"] = _categories;
            return View("Category", _categoryViewModel);
        }

        [HttpPost]
        public ActionResult Index(CategoryDTO category)
        {
            if (ModelState.IsValid)
            {
                var result = _categoryBAL.AddWorkoutCategory(category);
                ModelState.Clear();
            }

            _categories = _categoryBAL.GetAllWorkoutCategories();
            _categoryViewModel = new CategoryViewModel()
            {
                Categories = _categories
            };

            Session["Categories"] = _categories;
            return View("Category", _categoryViewModel);
        }

        [HttpGet]
        public ActionResult CategoryFilter(string title)
        {
            if (Session["Categories"] != null)
            {
                var categories = Session["Categories"] as IEnumerable<CategoryDTO>;
                var filteredCategories = categories.Where(category => category.CategoryName.ToLower().Contains(title.ToLower()));
                _categoryViewModel = new CategoryViewModel() { Categories = filteredCategories };
            }

            return PartialView("_Categories", _categoryViewModel);
        }

        [HttpGet]
        public ActionResult DeleteCategory(int id)
        {
            if(_categoryBAL.DeleteWorkoutCategory(id))
            {
                _categories = _categoryBAL.GetAllWorkoutCategories();
                Session["Categories"] = _categories;
            }
            else
            {
                _categories = Session["categories"] as IEnumerable<CategoryDTO>;
            }

            _categoryViewModel = new CategoryViewModel() { Categories = _categories };
            return PartialView("_Categories", _categoryViewModel);
        }

        [HttpPost]
        public ActionResult UpdateCategory(CategoryDTO category)
        {
            if(ModelState.IsValid)
            {
                if(_categoryBAL.UpdateWorkoutCategory(category.CategoryId, category))
                {
                    _categories = _categoryBAL.GetAllWorkoutCategories();
                    Session["Categories"] = _categories;
                }
                else
                {
                    _categories = Session["categories"] as IEnumerable<CategoryDTO>;
                }
            }

            _categoryViewModel = new CategoryViewModel() { Categories = _categories };
            return PartialView("_Categories", _categoryViewModel);
        }

        public ActionResult CategoryModal(int id)
        {
            Session["Categories"] = null;

            _categories = _categoryBAL.GetAllWorkoutCategories();
            _categoryViewModel = new CategoryViewModel()
            {
                Categories = _categories,
                IsModal = id == 1         
            };

            Session["Categories"] = _categories;
            return PartialView("Category", _categoryViewModel);
        }

        public ActionResult CategoryModalAdd(CategoryDTO category)
        {
            if (ModelState.IsValid)
            {
                var result = _categoryBAL.AddWorkoutCategory(category);
                ModelState.Clear();

                _categories = _categoryBAL.GetAllWorkoutCategories();
                _categoryViewModel = new CategoryViewModel()
                {
                    Categories = _categories,
                    IsModal = true
                };

                Session["Categories"] = _categories;
                return PartialView("_Categories", _categoryViewModel);
            }

            return Json(new { errors = ModelState.Select(x => x.Value.Errors).Where(y => y.Count > 0).FirstOrDefault() });
        }

        [HttpGet]
        public ActionResult GetAllCategories()
        {
            return Json(new { categories = _categories }, JsonRequestBehavior.AllowGet);
        }
    }
}