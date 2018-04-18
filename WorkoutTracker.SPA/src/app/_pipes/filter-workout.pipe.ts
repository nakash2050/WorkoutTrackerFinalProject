import { Pipe, PipeTransform } from '@angular/core';
import { Workout } from '../_models/workout';

@Pipe({
  name: 'filterWorkout'
})
export class FilterWorkoutPipe implements PipeTransform {
  filteredWorkouts: Workout[] = [];

  transform(value: Workout[], filter?: string): Workout[] {
    if(!value || !filter){
      return value;
    }
    
    return value.filter((item: Workout) => this.applyFilter(item, filter));
  }

  applyFilter(workout: Workout, filter: string): boolean {   
      if(workout.workoutTitle.toLowerCase().indexOf(filter) >= 0){
        return true;
      } else {
        return false;
      }    
    }
}
