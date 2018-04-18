using System.Collections.Generic;
using System.Web.Http;
using System.Web.Http.Results;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WorkoutTracker.API.Controllers;
using AutoMapper;
using WorkoutTracker.Entities.DTO;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System;

namespace WorkoutTracker.Tests
{
    [TestClass]
    public class WorkoutControllerTests
    {
        private static WorkoutController _workoutController;
        private static CategoryController _categoryController;

        [ClassInitialize()]
        public static void Initialize(TestContext context)
        {
            _workoutController = new WorkoutController();
            _categoryController = new CategoryController();

            Mapper.Reset();
            Mapper.Initialize(config =>
            {
                config.AddProfile<MappingProfile>();
            });
        }

        [TestMethod]
        public void ValidateWorkoutModel_InvalidWorkoutTitle_ReturnsFalse()
        {
            var categoryDTO = new WorkoutDTO()
            {
                WorkoutTitle = string.Empty
            };

            var context = new System.ComponentModel.DataAnnotations.ValidationContext(categoryDTO, null, null);
            var results = new List<ValidationResult>();
            var isModelStateValid = Validator.TryValidateObject(categoryDTO, context, results, true);

            Assert.IsFalse(isModelStateValid);
        }

        [TestMethod]
        public void AddNewWorkout_ValidWorkout_ReturnsTrue()
        {
            IHttpActionResult actionResult = _categoryController.Get();
            var contentResult = actionResult as OkNegotiatedContentResult<IOrderedEnumerable<CategoryDTO>>;

            Assert.IsNotNull(contentResult);
            Assert.IsNotNull(contentResult.Content);

            var category = contentResult.Content.FirstOrDefault();

            var workout = new WorkoutDTO()
            {
                WorkoutTitle = "Workout Title",
                WorkoutNote = "Workout Note",
                CategoryId = category.CategoryId
            };

            IHttpActionResult postActionResult = _workoutController.Post(workout);
            var postContentResult = postActionResult as OkNegotiatedContentResult<bool>;

            Assert.IsNotNull(postActionResult);
            Assert.IsNotNull(postContentResult.Content);
            Assert.IsTrue(postContentResult.Content);
        }

        [TestMethod]
        public void GetWorkout_PassWorkoutId_ReturnsValidWorkout()
        {
            IHttpActionResult actionResult = _workoutController.Get();
            var contentResult = actionResult as OkNegotiatedContentResult<IEnumerable<WorkoutDTO>>;

            Assert.IsNotNull(contentResult);
            Assert.IsNotNull(contentResult.Content);

            var workout = contentResult.Content.FirstOrDefault();

            IHttpActionResult getActionResult = _workoutController.Get(workout.WorkoutId);
            var getContentResult = getActionResult as OkNegotiatedContentResult<WorkoutDTO>;

            Assert.IsNotNull(getContentResult);
            Assert.IsNotNull(getContentResult.Content);
            Assert.AreEqual(workout.WorkoutId, getContentResult.Content.WorkoutId);
        }

        [TestMethod]
        public void GetWorkouts_All_ReturnsAllWorkouts()
        {
            IHttpActionResult actionResult = _workoutController.Get();
            var contentResult = actionResult as OkNegotiatedContentResult<IEnumerable<WorkoutDTO>>;

            Assert.IsNotNull(contentResult);
            Assert.IsNotNull(contentResult.Content);
        }

        [TestMethod]
        public void UpdateWorkout_ValidWorkout_ReturnsTrue()
        {
            IHttpActionResult actionResult = _workoutController.Get();
            var contentResult = actionResult as OkNegotiatedContentResult<IEnumerable<WorkoutDTO>>;

            if (contentResult != null)
            {
                var workout = contentResult.Content.FirstOrDefault();
                workout.WorkoutTitle = String.Format("Updated Workout Title {0}", new Random().Next());

                IHttpActionResult updateActionResult = _workoutController.Put(workout.WorkoutId, workout);
                var updateContentResult = updateActionResult as OkNegotiatedContentResult<bool>;

                Assert.IsNotNull(contentResult);
                Assert.IsTrue(updateContentResult.Content);

                IHttpActionResult getActionResult = _workoutController.Get(workout.WorkoutId);
                var getContentResult = getActionResult as OkNegotiatedContentResult<WorkoutDTO>;

                Assert.IsNotNull(getContentResult);
                Assert.AreEqual(workout.WorkoutTitle, getContentResult.Content.WorkoutTitle);
            }
        }

        [TestMethod]
        public void DeleteWorkout_ValidWorkout_ReturnsTrue()
        {
            IHttpActionResult actionResult = _workoutController.Get();
            var contentResult = actionResult as OkNegotiatedContentResult<IEnumerable<WorkoutDTO>>;

            if (contentResult != null)
            {
                var workout = contentResult.Content.FirstOrDefault();

                IHttpActionResult deleteActionResult = _workoutController.Delete(workout.WorkoutId);
                var deleteContentResult = deleteActionResult as OkNegotiatedContentResult<bool>;

                Assert.IsNotNull(contentResult);
                Assert.IsTrue(deleteContentResult.Content);

                IHttpActionResult getActionResult = _workoutController.Get(workout.WorkoutId);
                var getContentResult = getActionResult as OkNegotiatedContentResult<WorkoutDTO>;

                Assert.IsNull(getContentResult);                
            }
        }
    }
}