using System.Linq;
using AutoMapper;
using System.Collections.Generic;
using WorkoutTracker.DAL;
using WorkoutTracker.DAL.Repositories;
using WorkoutTracker.Entities;
using WorkoutTracker.Entities.DTO;

namespace WorkoutTracker.BAL
{
    public class CategoryBAL
    {
        public bool AddWorkoutCategory(CategoryDTO categoryDTO)
        {
            var category = Mapper.Map<WorkoutCategory>(categoryDTO);

            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                unitOfWork.WorkoutCategory.Add(category);
                var result = unitOfWork.Complete();
                return result == 1;
            }
        }

        public CategoryDTO GetWorkoutCategory(int id)
        {
            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                var result = unitOfWork.WorkoutCategory.Get(id);
                var category = Mapper.Map<CategoryDTO>(result);
                return category;
            }
        }

        public IEnumerable<CategoryDTO> GetAllWorkoutCategories()
        {
            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                var result = unitOfWork.WorkoutCategory.GetAll().OrderByDescending(category => category.CategoryId)
                    .Select(Mapper.Map<WorkoutCategory, CategoryDTO>);
                return result;
            }
        }

        public bool UpdateWorkoutCategory(int id, CategoryDTO categoryDTO)
        {
            int result = 0;

            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                var categoryInDB = unitOfWork.WorkoutCategory.Get(id);

                if (categoryInDB != null)
                {
                    categoryDTO.CategoryId = id;
                    Mapper.Map(categoryDTO, categoryInDB);
                    result = unitOfWork.Complete();
                }

                return result == 1;
            }
        }

        public bool DeleteWorkoutCategory(int id)
        {
            int result = 0;

            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                var catg = unitOfWork.WorkoutCategory.Get(id);

                if (catg != null)
                {
                    unitOfWork.WorkoutCategory.Remove(catg);
                    result = unitOfWork.Complete();
                }

                return result == 1;
            }
        }
    }
}
