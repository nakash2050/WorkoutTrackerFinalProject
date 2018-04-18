using AutoMapper;
using System.Collections.Generic;
using System.Linq;
using WorkoutTracker.DAL;
using WorkoutTracker.DAL.Repositories;
using WorkoutTracker.Entities;
using WorkoutTracker.Entities.DTO;

namespace WorkoutTracker.BAL
{
    public class WorkoutBAL
    {
        public bool AddWorkout(WorkoutDTO workoutDTO)
        {
            var workout = Mapper.Map<WorkoutCollection>(workoutDTO);

            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                unitOfWork.WorkoutCollection.Add(workout);
                var result = unitOfWork.Complete();
                return result == 1;
            }
        }

        public IEnumerable<WorkoutDTO> GetAllWorkouts()
        {
            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                var result = from w in unitOfWork.WorkoutCollection.GetAll()
                             join a in unitOfWork.WorkoutActive.GetAll()
                             on w.WorkoutId equals a.WorkoutId
                             into t
                             from b in t.DefaultIfEmpty(new WorkoutActive())
                             orderby w.WorkoutId descending
                             select new WorkoutDTO()
                             {
                                 WorkoutId = w.WorkoutId,
                                 WorkoutTitle = w.WorkoutTitle,
                                 WorkoutNote = w.WorkoutNote,
                                 CaloriesBurntPerMin = w.CaloriesBurntPerMin,
                                 CategoryId = w.CategoryId,
                                 Status = b.Status.HasValue ? b.Status.Value : false
                             };

                return result;
            }
        }

        public WorkoutDTO GetWorkout(int id)
        {
            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                var result = unitOfWork.WorkoutCollection.Get(id);
                var workout = Mapper.Map<WorkoutDTO>(result);
                return workout;
            }
        }

        public bool UpdateWorkout(int id, WorkoutDTO workoutDTO)
        {
            int result = 0;

            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                var workoutInDB = unitOfWork.WorkoutCollection.Get(id);

                if (workoutInDB != null)
                {
                    workoutDTO.WorkoutId = id;
                    Mapper.Map(workoutDTO, workoutInDB);
                    result = unitOfWork.Complete();
                }

                return result == 1;
            }
        }

        public bool DeleteWorkout(int id)
        {
            int result = 0;

            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                var workoutInDB = unitOfWork.WorkoutCollection.Get(id);

                if (workoutInDB != null)
                {
                    unitOfWork.WorkoutCollection.Remove(workoutInDB);
                    result = unitOfWork.Complete();
                }

                return result == 1;
            }
        }

        public bool StartWorkout(WorkoutActiveDTO workoutActiveDTO)
        {
            int result = 0;

            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                WorkoutActive workoutActive = null;
                var workoutInDB = unitOfWork.WorkoutActive.GetWorkoutByWorkoutId(workoutActiveDTO.WorkoutId);

                if(workoutInDB == null)
                {
                    workoutActive = Mapper.Map<WorkoutActive>(workoutActiveDTO);
                    unitOfWork.WorkoutActive.Add(workoutActive);
                }
                else
                {
                    workoutActiveDTO.WorkoutActiveId = workoutInDB.WorkoutActiveId;
                    Mapper.Map(workoutActiveDTO, workoutInDB);
                }

                result = unitOfWork.Complete();
                return result == 1;
            }
        }

        public bool EndWorkout(WorkoutActiveDTO workoutActiveDTO)
        {
            int result = 0;

            using (var unitOfWork = new UnitOfWork(new WorkoutTrackerContext()))
            {
                var workoutInDB = unitOfWork.WorkoutActive.GetWorkoutByWorkoutId(workoutActiveDTO.WorkoutId);

                if (workoutInDB != null)
                {
                    workoutInDB.EndDate = workoutActiveDTO.EndDate;
                    workoutInDB.EndTime = workoutActiveDTO.EndTime;
                    workoutInDB.Comment = workoutActiveDTO.Comment;
                    workoutInDB.Status = workoutActiveDTO.Status;
                    result = unitOfWork.Complete();
                }

                return result == 1;
            }
        }
    }
}
