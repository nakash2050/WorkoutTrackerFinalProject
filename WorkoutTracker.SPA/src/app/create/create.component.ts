import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { Category } from '../_models/category';
import { BsModalService } from 'ngx-bootstrap/modal';
import { BsModalRef } from 'ngx-bootstrap/modal/bs-modal-ref.service';
import { CategoryComponent } from './../category/category.component';
import { Observable } from 'rxjs/Observable';
import { Subscription } from 'rxjs/Subscription';
import 'rxjs/add/observable/combineLatest';
import { CategoryService } from './../_services/category.service';
import { WorkoutService } from './../_services/workout.service';

@Component({
  selector: 'app-create',
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.css']
})
export class CreateComponent implements OnInit {

  bsModalRef: BsModalRef;
  subscriptions: Subscription[] = [];
  calories: any = 0;
  categories: Category[] = [];
  isWorkoutAdded: boolean;

  constructor(
    private workoutService: WorkoutService,
    private categoryService: CategoryService,
    private modalService: BsModalService,
    private changeDetection: ChangeDetectorRef
  ) { }

  ngOnInit() {
    this.categoryService.getCategories()
      .subscribe(response => this.categories = response);
  }

  addCalories() {
    this.calories = (this.calories * 10 + 0.1 * 10) / 10
  }

  subtractCalories() {
    if (this.calories > 0) {
      this.calories = (this.calories * 10 - 0.1 * 10) / 10
    }
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

  submit(form) {
    this.workoutService.addWorkout(form.value)
      .subscribe(
        response => this.isWorkoutAdded = response
      );
    form.reset();
  }
}
