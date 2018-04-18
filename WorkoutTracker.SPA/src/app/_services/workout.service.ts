import { Injectable } from '@angular/core';
import { Http } from '@angular/http';
import { DataService } from './../_shared/data.service';
import { Workout } from './../_models/workout';

@Injectable()
export class WorkoutService extends DataService {
  private controllerName: string = "workout";

  constructor(http: Http) {
    super(http);
  }

  getAllWorkouts() {
    return this.get(this.controllerName);
  }

  getWorkout(id) {
    return this.get(this.controllerName + '/' + id);
  }

  addWorkout(workout: Workout) {
    return this.post(this.controllerName, workout);
  }

  updateWorkout(workout: Workout) {
    return this.update(this.controllerName + '/' + workout.workoutId, workout);
  }

  deleteWorkout(id) {
    return this.delete(this.controllerName + '/' + id);
  }

  startWorkout(workout: Workout) {
    return this.post(this.controllerName + '/start', workout);
  }

  endWorkout(workout: Workout) {
    return this.post(this.controllerName + '/end', workout);
  }
}
