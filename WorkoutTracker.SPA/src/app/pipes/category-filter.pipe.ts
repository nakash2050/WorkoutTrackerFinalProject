import { Pipe, PipeTransform } from '@angular/core';
import { Category } from './../_models/category';

@Pipe({
  name: 'categoryFilter'
})
export class CategoryFilterPipe implements PipeTransform {

  transform(categories: Category[], filter: string): Category[] {
    if (!categories || !filter) {
      return categories;
    }

    return categories.filter(category => this.applyFilter(category, filter));
  }

  applyFilter(category: Category, filter: string): boolean {
    return category.categoryName.toLowerCase().trim().indexOf(filter) >= 0;
  }
}
