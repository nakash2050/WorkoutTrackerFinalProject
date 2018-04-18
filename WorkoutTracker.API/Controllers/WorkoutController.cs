using System.Web.Http;
using WorkoutTracker.BAL;
using WorkoutTracker.Entities.DTO;

namespace WorkoutTracker.API.Controllers
{
    [RoutePrefix("api/workout")]
    public class WorkoutController : ApiController
    {
        private readonly WorkoutBAL _workoutBAL;

        public WorkoutController()
        {
            _workoutBAL = new WorkoutBAL();
        }

        public IHttpActionResult Get()
        {
            var result = _workoutBAL.GetAllWorkouts();
            return Ok(result);
        }

        public IHttpActionResult Get(int id)
        {
            var result = _workoutBAL.GetWorkout(id);

            if (result == null)
                return NotFound();

            return Ok(result);
        }

        public IHttpActionResult Post(WorkoutDTO workoutDTO)
        {
            if (!ModelState.IsValid)
                return BadRequest();

            var result = _workoutBAL.AddWorkout(workoutDTO);
            return Ok(result);
        }

        public IHttpActionResult Put(int id, WorkoutDTO workoutDTO)
        {
            if (!ModelState.IsValid)
                return BadRequest();

            var result = _workoutBAL.UpdateWorkout(id, workoutDTO);
            return Ok(result);
        }

        public IHttpActionResult Delete(int id)
        {
            var result = _workoutBAL.DeleteWorkout(id);
            return Ok(result);
        }

        [HttpPost]
        [Route("start")]
        public IHttpActionResult StartWorkout(WorkoutActiveDTO workoutActiveDTO)
        {
            if (!ModelState.IsValid)
                return BadRequest();

            var result = _workoutBAL.StartWorkout(workoutActiveDTO);
            return Ok(result);
        }

        [HttpPost]
        [Route("end")]
        public IHttpActionResult EndWorkout(WorkoutActiveDTO workoutActiveDTO)
        {
            if (!ModelState.IsValid)
                return BadRequest();

            var result = _workoutBAL.EndWorkout(workoutActiveDTO);
            return Ok(result);
        }
    }
}
