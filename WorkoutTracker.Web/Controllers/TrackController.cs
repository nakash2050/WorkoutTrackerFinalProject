using System.Web.Mvc;
using WorkoutTracker.BAL;

namespace WorkoutTracker.Web.Controllers
{
    public class TrackController : Controller
    {
        private readonly TrackBAL _trackBAL;

        public TrackController()
        {
            _trackBAL = new TrackBAL();
        }

        // GET: Track
        public ActionResult Index()
        {
            return View("Track");
        }

        [HttpGet]
        public ActionResult GetTrackReports()
        {
            var report = _trackBAL.GetTrackerReport();
            return Json(report, JsonRequestBehavior.AllowGet);
        }
    }
}