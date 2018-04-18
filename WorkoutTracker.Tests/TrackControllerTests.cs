using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WorkoutTracker.API.Controllers;
using AutoMapper;
using System.Web.Http;
using System.Web.Http.Results;
using WorkoutTracker.Entities.DTO;

namespace WorkoutTracker.Tests
{
    [TestClass]
    public class TrackControllerTests
    {
        private static TrackController _trackController;

        [ClassInitialize]
        public static void Initialize(TestContext context)
        {
            _trackController = new TrackController();

            Mapper.Reset();
            Mapper.Initialize(config =>
            {
                config.AddProfile<MappingProfile>();
            });
        }

        [TestMethod]
        public void GetTrackResults_All_ReturnsValidResults()
        {
            IHttpActionResult actionResult = _trackController.Get();
            var contentResult = actionResult as OkNegotiatedContentResult<TrackDTO>;

            Assert.IsNotNull(contentResult);
            Assert.IsNotNull(contentResult.Content);
        }
    }
}
