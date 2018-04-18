import { Pipe, PipeTransform } from '@angular/core';
import { Workout } from '../_models/workout';

@Pipe({
  name: 'workoutFilter'
})
export class WorkoutFilterPipe implements PipeTransform {

  transform(workouts: Workout[], filter: string): Workout[] {

    if (!workouts || !filter) {
      return workouts;
    }

    return workouts.filter(workout => this.applyFiler(workout, filter));
  }

  applyFiler(workout: Workout, filter: string) {
    return workout.workoutTitle.trim().toLowerCase().indexOf(filter) >= 0;
  }
}
