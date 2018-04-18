import { Directive, EventEmitter, Input, Output, ElementRef } from '@angular/core';

@Directive({
  selector: '[contentEditableModel]',
  host: {
    '(blur)': 'onEdit()',
    '(keyup)': 'onEdit()'
  }
})
export class ContentEditableModelDirective {

  @Input('contentEditableModel') model: any;
  @Output('contentEditableModelChange') update = new EventEmitter();

  constructor(
    private elementRef: ElementRef
  ) {
  }

  ngOnChanges(changes) {
    if (changes.model.isFirstChange())
      this.refreshView();
  }

  onEdit() {
    var value = this.elementRef.nativeElement.innerText
    this.update.emit(value)
  }

  private refreshView() {
    this.elementRef.nativeElement.textContent = this.model
  }

}
