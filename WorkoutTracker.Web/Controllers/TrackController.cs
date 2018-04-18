using System.Web.Mvc;

namespace WorkoutTracker.Web.Controllers
{
    public class TrackController : Controller
    {
        // GET: Track
        public ActionResult Index()
        {
            return View("Track");
        }
    }
}