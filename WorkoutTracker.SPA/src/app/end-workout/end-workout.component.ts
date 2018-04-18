import { Component, OnInit } from "@angular/core";
import { Workout } from "../_models/workout";
import { Router, ActivatedRoute } from "@angular/router";
import { keys } from "../_models/keys";
import { WorkoutService } from "./../_services/workout.service";

@Component({
  selector: "app-end-workout",
  templateUrl: "./end-workout.component.html",
  styleUrls: ["./end-workout.component.css"]
})
export class EndWorkoutComponent implements OnInit {
  workoutId: any;
  workout: Workout;

  constructor(
    private workoutService: WorkoutService,
    private router: Router,
    private route: ActivatedRoute
  ) {}

  ngOnInit() {
    this.route.data.subscribe(data => (this.workout = data["workout"]));
    this.workout.endDate = new Date().toLocaleDateString();
    this.workout.endTime = new Date().toLocaleTimeString("it-IT");
  }

  end(workout: Workout) {
    workout.status = false;
    this.workoutService.endWorkout(workout).subscribe(response => {
      if (response) {
        this.router.navigate(["/viewall"]);
      }
    });
  }

  cancel() {
    this.router.navigate(["/viewall"]);
  }
}
