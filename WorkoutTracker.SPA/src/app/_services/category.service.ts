import { Injectable } from '@angular/core';
import { DataService } from './../_shared/data.service';
import { Http } from '@angular/http';
import { Category } from './../_models/category';

@Injectable()
export class CategoryService extends DataService {
  private controllerName: string = "category";

  constructor(http: Http) {
    super(http);
  }

  getCategories() {
    return this.get(this.controllerName);
  }

  addCategory(category: Category) {
    return this.post(this.controllerName, category);
  }

  updateCategory(category: Category) {
    return this.update(this.controllerName + '/' + category.categoryId, category);
  }

  deleteCategory(categoryId) {
    return this.delete(this.controllerName + '/' + categoryId);
  }
}
