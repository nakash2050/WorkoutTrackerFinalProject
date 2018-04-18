using AutoMapper;
using WorkoutTracker.Entities;
using WorkoutTracker.Entities.DTO;

namespace WorkoutTracker.Tests
{
    class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<CategoryDTO, WorkoutCategory>();
            CreateMap<WorkoutCategory, CategoryDTO>();
            CreateMap<WorkoutDTO, WorkoutCollection>();
            CreateMap<WorkoutCollection, WorkoutDTO>();
            CreateMap<WorkoutActive, WorkoutActiveDTO>();
            CreateMap<WorkoutActiveDTO, WorkoutActive>();
        }
    }
}
