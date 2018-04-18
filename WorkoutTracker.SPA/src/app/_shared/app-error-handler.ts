import { ErrorHandler, Injector, Injectable } from "@angular/core";
import { BadRequestError } from "./bad-request-error";
import { UnauthorizedError } from "./unauthorized-error";
//import { AlertifyService } from "../_services/alertify.service";

@Injectable()
export class AppErrorHandler implements ErrorHandler {
  constructor(private injector: Injector) {}

  handleError(error: any) {
    // let alertifyService = this.injector.get(AlertifyService);

    // if (error instanceof BadRequestError) {
    // } else if (error instanceof UnauthorizedError) {
    //     alertifyService.error('Authorization has been denied for this request.');
    //   }
  }
}