import { Resolve, ActivatedRouteSnapshot, Router } from "@angular/router";
import { TrackService } from "../_services/track.service";
import { Observable } from "rxjs/Rx";
import "rxjs/add/operator/catch";
import { Injectable } from '@angular/core';

@Injectable()
export class TrackResolver implements Resolve<any> {
  constructor(
      private trackService: TrackService,
      private router: Router
    ) {}

  resolve(route: ActivatedRouteSnapshot): Observable<any> {
    return this.trackService.getCReportData().catch(error => {
      return Observable.of(null);
    });
  }
}
