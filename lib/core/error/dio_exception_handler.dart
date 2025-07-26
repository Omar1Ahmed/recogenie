

 // custom Failure and FailureType

import 'package:dio/dio.dart';
import 'package:recogenie/core/error/failure.dart';

import 'api_response_codes.dart';
import 'errorResponseModel.dart';

class ApiErrorHandler {
  static Failure handle(DioException e) {
    final response = e.response;
    final statusCode = response?.statusCode;

    // Handle status codes First
    switch (statusCode) {
    // ✅ Informational
      case 100:
        return Failure(message: 'Continue', type: FailureType.general, statusCode: statusCode!);
      case 101:
        return Failure(message: 'Switching Protocols', type: FailureType.general, statusCode: statusCode!);
      case 102:
        return Failure(message: 'Processing', type: FailureType.general, statusCode: statusCode!);

    //  Redirection
      case 300:
        return Failure(message: 'Multiple Choices', type: FailureType.general, statusCode: statusCode!);
      case 301:
        return Failure(message: 'Moved Permanently', type: FailureType.general, statusCode: statusCode!);
      case 302:
        return Failure(message: 'Found (Redirect)', type: FailureType.general, statusCode: statusCode!);
      case 304:
        return Failure(message: 'Not Modified', type: FailureType.general, statusCode: statusCode!);

    //  Client Errors
      case StatusCodes.BadRequest: // There is Error Response in This case
        return ApiErrorHandler()._HandleErrorResponse(response!, statusCode!);
      case 401:
        return Failure(message: 'Unauthorized', type: FailureType.unauthorized, statusCode: statusCode!);
      case 403:
        return Failure(message: 'Forbidden', type: FailureType.permission, statusCode: statusCode!);
      case 404:
        return Failure(message: 'Not found', type: FailureType.notFound, statusCode: statusCode!);
      case 408:
        return Failure(message: 'Request timeout', type: FailureType.timeout, statusCode: statusCode!);
      case 409:
        return Failure(message: 'Conflict', type: FailureType.validation, statusCode: statusCode!);
      case 410:
        return Failure(message: 'Gone', type: FailureType.general, statusCode: statusCode!);
      case 422:
        return Failure(message: 'Invalid data', type: FailureType.validation, statusCode: statusCode!);
      case 429:
        return Failure(message: 'Too many requests', type: FailureType.rateLimit, statusCode: statusCode!);

    //  Server Errors
      case StatusCodes.InternalServerError:


        return Failure(message: 'Internal Server Error', type: FailureType.server, statusCode: statusCode!);
      case 501:
        return Failure(message: 'Not implemented', type: FailureType.server, statusCode: statusCode!);
      case 502:
        return Failure(message: 'Bad gateway', type: FailureType.server, statusCode: statusCode!);
      case 503:
        return Failure(message: 'Service unavailable', type: FailureType.server, statusCode: statusCode!);
      case 504:
        return Failure(message: 'Gateway timeout', type: FailureType.timeout, statusCode: statusCode!);
      case 505:
        return Failure(message: 'HTTP version not supported', type: FailureType.server, statusCode: statusCode!);

    // ✅ Unknown / unexpected status code
      default:
        return Failure(
          message: 'Unexpected error',
          type: FailureType.general,
          statusCode: statusCode ?? -1,
        );
    }
  }

  Failure _HandleErrorResponse(Response response, int statusCode) {

    ErrorResponseModel errorBody = errorResponseModelFromJson(response.toString());

    switch (errorBody.code) {
        case ResponseCodes.UserNotFound:
          return Failure(message: 'User Not Found', type: FailureType.validation, statusCode: statusCode, responseCode: errorBody.code!);

        case ResponseCodes.UserNotActivated:
          return Failure(message: 'User Is Not Activated', type: FailureType.validation, statusCode: statusCode, responseCode: errorBody.code!);

        default:
          return Failure(message: 'Unknown error', type: FailureType.general);
      }

  }
}