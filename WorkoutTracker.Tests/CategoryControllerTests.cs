using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WorkoutTracker.Entities.DTO;
using AutoMapper;
using WorkoutTracker.API.Controllers;
using System.Web.Http;
using System.Web.Http.Results;
using System.Collections.Generic;
using System.Linq;
using System.ComponentModel.DataAnnotations;

namespace WorkoutTracker.Tests
{
    [TestClass]
    public class CategoryControllerTests
    {        
        private static CategoryController _categoryController;

        [ClassInitialize]
        public static void Initialize(TestContext context)
        {
            _categoryController = new CategoryController();

            Mapper.Reset();
            Mapper.Initialize(config =>
            {
                config.AddProfile<MappingProfile>();
            });
        }

        [TestMethod]
        public void AddNewWorkoutCategory_ValidCategory_ReturnsTrue()
        {
            var category = new CategoryDTO()
            {
                CategoryName = "Category1"
            };

            IHttpActionResult actionResult = _categoryController.Post(category);
            var contentResult = actionResult as OkNegotiatedContentResult<IEnumerable<CategoryDTO>>;

            Assert.IsNotNull(contentResult);
            Assert.IsNotNull(contentResult.Content);
        }


        [TestMethod]
        public void GetCategories_All_ReturnsAllCategories()
        {
            IHttpActionResult actionResult = _categoryController.Get();
            var contentResult = actionResult as OkNegotiatedContentResult<IOrderedEnumerable<CategoryDTO>>;

            Assert.IsNotNull(contentResult);
            Assert.IsNotNull(contentResult.Content);
        }

        [TestMethod]
        public void GetWorkoutCategory_PassCategoryId_ReturnsValidCategory()
        {
            IHttpActionResult actionResult = _categoryController.Get();
            var contentResult = actionResult as OkNegotiatedContentResult<IOrderedEnumerable<CategoryDTO>>;

            Assert.IsNotNull(contentResult);
            Assert.IsNotNull(contentResult.Content);

            var category = contentResult.Content.FirstOrDefault();

            IHttpActionResult getActionResult = _categoryController.Get(category.CategoryId);
            var getContentResult = getActionResult as OkNegotiatedContentResult<CategoryDTO>;

            Assert.IsNotNull(getContentResult);
            Assert.IsNotNull(getContentResult.Content);
            Assert.AreEqual(category.CategoryId, getContentResult.Content.CategoryId);
        }

        [TestMethod]
        public void ValidateWorkoutCategoryModel_ValidCategory_ReturnsTrue()
        {
            var categoryDTO = new CategoryDTO()
            {
                CategoryName = "Category"
            };

            var context = new System.ComponentModel.DataAnnotations.ValidationContext(categoryDTO, null, null);
            var results = new List<ValidationResult>();
            var isModelStateValid = Validator.TryValidateObject(categoryDTO, context, results, true);

            Assert.IsTrue(isModelStateValid);
        }

        [TestMethod]
        public void UpdateWorkout_ValidCategory_ReturnsTrue()
        {
            IHttpActionResult actionResult = _categoryController.Get();
            var contentResult = actionResult as OkNegotiatedContentResult<IEnumerable<CategoryDTO>>;

            if (contentResult != null)
            {
                var category = contentResult.Content.FirstOrDefault();
                category.CategoryName = String.Format("Category Title {0}", new Random().Next());

                IHttpActionResult updateActionResult = _categoryController.Put(category.CategoryId, category);
                var updateContentResult = updateActionResult as OkNegotiatedContentResult<bool>;

                Assert.IsNotNull(contentResult);
                Assert.IsTrue(updateContentResult.Content);

                IHttpActionResult getActionResult = _categoryController.Get(category.CategoryId);
                var getContentResult = getActionResult as OkNegotiatedContentResult<CategoryDTO>;

                Assert.IsNotNull(getContentResult);
                Assert.AreEqual(category.CategoryName, getContentResult.Content.CategoryName);
            }
        }

        [TestMethod]
        public void DeleteWorkout_ValidCategory_ReturnsTrue()
        {
            IHttpActionResult actionResult = _categoryController.Get();
            var contentResult = actionResult as OkNegotiatedContentResult<IEnumerable<CategoryDTO>>;

            if (contentResult != null)
            {
                var category = contentResult.Content.FirstOrDefault();

                IHttpActionResult deleteActionResult = _categoryController.Delete(category.CategoryId);
                var deleteContentResult = deleteActionResult as OkNegotiatedContentResult<bool>;

                Assert.IsNotNull(contentResult);
                Assert.IsTrue(deleteContentResult.Content);

                IHttpActionResult getActionResult = _categoryController.Get(category.CategoryId);
                var getContentResult = getActionResult as OkNegotiatedContentResult<CategoryDTO>;

                Assert.IsNull(getContentResult);
            }
        }

        [TestMethod]
        public void ValidateWorkoutCategoryModel_InvalidCategoryName_ReturnsFalse()
        {
            var categoryDTO = new CategoryDTO()
            {
                CategoryName = string.Empty
            };

            var context = new System.ComponentModel.DataAnnotations.ValidationContext(categoryDTO, null, null);
            var results = new List<ValidationResult>();
            var isModelStateValid = Validator.TryValidateObject(categoryDTO, context, results, true);

            Assert.IsFalse(isModelStateValid);
        }

        [TestMethod]
        public void ValidateWorkoutCategoryModel_InvalidCategoryNameStringLength_ReturnsFalse()
        {
            var categoryDTO = new CategoryDTO()
            {
                CategoryName = "aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffggggg"
            };

            var context = new System.ComponentModel.DataAnnotations.ValidationContext(categoryDTO, null, null);
            var results = new List<ValidationResult>();
            var isModelStateValid = Validator.TryValidateObject(categoryDTO, context, results, true);

            Assert.IsFalse(isModelStateValid);
        }
    }
}
