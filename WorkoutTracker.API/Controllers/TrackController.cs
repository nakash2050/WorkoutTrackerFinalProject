using System.Web.Http;
using WorkoutTracker.BAL;

namespace WorkoutTracker.API.Controllers
{
    public class TrackController : ApiController
    {
        private readonly TrackBAL _trackBAL;

        public TrackController()
        {
            _trackBAL = new TrackBAL();
        }

        public IHttpActionResult Get()
        {
            var result = _trackBAL.GetTrackerReport();
            return Ok(result);
        }
    }
}
