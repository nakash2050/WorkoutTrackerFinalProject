import { Component, OnInit } from '@angular/core';
import { Workout } from '../_models/workout';
import { Router } from '@angular/router';
import { WorkoutService } from './../_services/workout.service';
import { Subscription } from 'rxjs/Subscription';
import * as _ from 'underscore';

@Component({
  selector: 'app-view-all',
  templateUrl: './view-all.component.html',
  styleUrls: ['./view-all.component.css']
})
export class ViewAllComponent implements OnInit {

  workouts: Workout[] = [];

  constructor(
    private workoutService: WorkoutService,
    private router: Router
  ) { }

  ngOnInit() {
    this.workoutService.getAllWorkouts()
      .subscribe(response => this.workouts = response);
  }

  editWorkout(id) {
    this.router.navigate(['/editworkout', id]);
  }

  deleteWorkout(workout: Workout) {
    this.workoutService.deleteWorkout(workout.workoutId)
      .subscribe(response => {
        if (response) {
          this.workouts = _.without(this.workouts, _.findWhere(this.workouts, workout));
        }
      });
  }

  start(id) {
    this.router.navigate(['/startworkout', id]);
  }

  end(id) {
    this.router.navigate(['/endworkout', id]);
  }
}
