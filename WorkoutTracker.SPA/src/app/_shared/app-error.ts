export class AppError {
    originalError: any;

    constructor(originalError?: any) {
        this.originalError = originalError;
    }
}