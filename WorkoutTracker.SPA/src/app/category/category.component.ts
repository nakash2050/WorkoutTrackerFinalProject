import { Component, OnInit } from '@angular/core';
import { Category } from '../_models/category';
import { BsModalRef } from 'ngx-bootstrap/modal';
import { Router } from '@angular/router';
import { Form, FormGroup } from '@angular/forms';
import { CategoryService } from './../_services/category.service';
import * as _ from 'underscore';

@Component({
  selector: 'app-category',
  templateUrl: './category.component.html',
  styleUrls: ['./category.component.css']
})
export class CategoryComponent implements OnInit {

  categories: Array<Category>;
  mCategory: string;
  isValidRoute: boolean;

  constructor(
    private categoryService: CategoryService,
    private router: Router
  ) { }

  ngOnInit() {
    this.isValidRoute = (this.router.url == '/category');
    this.categoryService.getCategories()
      .subscribe(response => this.categories = <Array<Category>>response);
  }

  deleteCategory(category: Category) {
    this.categoryService.deleteCategory(category.categoryId)
      .subscribe(response => {
        if (response) {
          this.categories = _.without(this.categories, _.findWhere(this.categories, category));
        }
      });
  }

  submit(category) {
    this.categoryService.addCategory(category.value)
      .subscribe(response => this.categories = response);

    category.reset();
  }

  isEditOrSave(category: Category) {
    const isEdit = this.categories.filter(cat => cat.categoryId == category.categoryId)[0].isEdit;
    this.categories.filter(cat => cat.categoryId == category.categoryId)[0].isEdit = !isEdit;
    if (!isEdit) {
      document.getElementById('spn' + category.categoryId.toString()).focus();
    } else {
      this.categoryService.updateCategory(category)
        .subscribe(resp => resp, error => {
        });
    }
  }
}
