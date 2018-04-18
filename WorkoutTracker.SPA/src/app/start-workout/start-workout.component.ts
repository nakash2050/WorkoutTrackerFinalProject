import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { Workout } from '../_models/workout';
import { keys } from '../_models/keys';
import { WorkoutService } from './../_services/workout.service';

@Component({
  selector: 'app-start-workout',
  templateUrl: './start-workout.component.html',
  styleUrls: ['./start-workout.component.css']
})
export class StartWorkoutComponent implements OnInit {

  workoutId: any;
  workout: Workout;

  constructor(
    private workoutService: WorkoutService,
    private router: Router,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.route.data.subscribe(data => this.workout = data['workout']);
    this.workout.startDate = new Date().toLocaleDateString();
    this.workout.startTime = new Date().toLocaleTimeString('it-IT');
    this.workout.endDate = null;
    this.workout.endTime = null;
  }

  start(workout: Workout) {
    workout.status = true;
    this.workoutService.startWorkout(workout)
      .subscribe(response => {
        if (response) {
          this.router.navigate(['/viewall']);
        }
      });
  }

  cancel() {
    this.router.navigate(['/viewall']);
  }
}
