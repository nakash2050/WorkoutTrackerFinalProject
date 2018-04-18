import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { Workout } from '../_models/workout';
import { keys } from '../_models/keys';
import { Category } from '../_models/category';
import { Observable } from 'rxjs/Observable';
import { BsModalService, BsModalRef } from 'ngx-bootstrap/modal';
import { Subscription } from 'rxjs/Subscription';
import 'rxjs/add/observable/combineLatest';
import { CategoryComponent } from '../category/category.component';
import { WorkoutService } from './../_services/workout.service';
import { CategoryService } from './../_services/category.service';

@Component({
  selector: 'app-edit-workout',
  templateUrl: './edit-workout.component.html',
  styleUrls: ['./edit-workout.component.css']
})
export class EditWorkoutComponent implements OnInit {

  categories: Category[];
  workoutId: any;
  workout: Workout;
  subscriptions: Subscription[] = [];
  bsModalRef: BsModalRef;

  constructor(
    private workoutService: WorkoutService,
    private categoryService: CategoryService,
    private router: Router,
    private route: ActivatedRoute,
    private modalService: BsModalService,
    private changeDetection: ChangeDetectorRef) { }

  ngOnInit() {
    this.categoryService.getCategories()
      .subscribe(response => this.categories = response);

    this.route.data.subscribe(data => {
      this.workout = data['workout'];
    });
  }

  update(workout) {
    this.workoutService.updateWorkout(workout)
      .subscribe(response => {
        if (response) {
          this.router.navigate(['/viewall']);
        }
      });
  }

  cancel() {
    this.router.navigate(['/viewall']);
  }

  openModalWithComponent() {
    const _combine = Observable.combineLatest(
      this.modalService.onHidden
    ).subscribe(() => this.changeDetection.markForCheck());

    this.subscriptions.push(
      this.modalService.onHidden.subscribe((reason: string) => {
        this.categoryService.getCategories()
          .subscribe(response => this.categories = response);

        this.unsubscribe();
      })
    );

    this.subscriptions.push(_combine);

    this.bsModalRef = this.modalService.show(CategoryComponent, null);
  }

  unsubscribe() {
    this.subscriptions.forEach((subscription: Subscription) => {
      subscription.unsubscribe();
    });
    this.subscriptions = [];
  }
}
