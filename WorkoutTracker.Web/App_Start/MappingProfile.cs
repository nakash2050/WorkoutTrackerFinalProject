using AutoMapper;
using WorkoutTracker.Entities;
using WorkoutTracker.Entities.DTO;
using WorkoutTracker.Web.ViewModels;

namespace WorkoutTracker.Web.App_Start
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<CategoryDTO, WorkoutCategory>();
            CreateMap<WorkoutCategory, CategoryDTO>();
            CreateMap<WorkoutDTO, WorkoutCollection>();
            CreateMap<WorkoutCollection, WorkoutDTO>();
            CreateMap<WorkoutActive, WorkoutActiveDTO>();
            CreateMap<WorkoutActiveDTO, WorkoutActive>();
            CreateMap<WorkoutDTO, WorkoutActiveViewModel>();
            CreateMap<WorkoutActiveViewModel, WorkoutActiveDTO>();
        }
    }
}