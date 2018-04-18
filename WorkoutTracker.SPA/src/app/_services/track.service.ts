import { Injectable } from '@angular/core';
import { DataService } from './../_shared/data.service';
import { Http } from '@angular/http';
import { Category } from './../_models/category';

@Injectable()
export class TrackService extends DataService {
  private controllerName: string = "track";

  constructor(http: Http) {
    super(http);
  }

  getCReportData() {
    return this.get(this.controllerName);
  }
}
