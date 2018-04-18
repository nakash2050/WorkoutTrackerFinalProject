import { Resolve, Router, ActivatedRouteSnapshot } from "@angular/router";
import { Workout } from "../_models/workout";
import { WorkoutService } from './../_services/workout.service';
import { Observable } from 'rxjs/Rx';
import { Injectable } from "@angular/core";
import 'rxjs/add/operator/catch'

@Injectable()
export class WorkoutResolver implements Resolve<Workout> {
    constructor(
        private workoutService: WorkoutService,
        private router: Router
    ) { }

    resolve(route: ActivatedRouteSnapshot): Observable<Workout> {
        return this.workoutService.getWorkout(route.params['id']).catch(error => {
            this.router.navigate(['/viewall']);
            return Observable.of(null);
        });
    }
}