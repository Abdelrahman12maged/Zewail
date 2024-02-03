import 'package:dio/dio.dart';

abstract class failure {
  final dynamic errormessage;

  failure(this.errormessage);
}

class serverFailure extends failure {
  serverFailure(super.errormessage);
  factory serverFailure.fromDioerro(DioException dioerro) {
    switch (dioerro.type) {
      case DioExceptionType.connectionTimeout:
        return serverFailure("connetion timout withApi server");
      // TODO: Handle this case.

      case DioExceptionType.sendTimeout:
        return serverFailure("Send timout withApi server");
      // TODO: Handle this case.

      case DioExceptionType.receiveTimeout:
        return serverFailure("Receive timout withApi server");

      case DioExceptionType.badCertificate:
        return serverFailure("badcertificate");

      case DioExceptionType.badResponse:
        return serverFailure.fromResposnse(
            dioerro.response!.statusCode!, dioerro.response!.data);
      case DioExceptionType.cancel:
        return serverFailure("Requst canceled");
      case DioExceptionType.connectionError:
        if (dioerro.message!.contains('SocketException')) {
          return serverFailure("no internet connection");
        } else {
          return serverFailure(" unexpected error try again");
        }

      case DioExceptionType.unknown:
        return serverFailure(" خطأ غير متوقع تأكد من الاتصال بالانترنت");

      default:
        return serverFailure(" خطأ غير متوقع تأكد من الاتصال بالانترنت");
    }
  }
  factory serverFailure.fromResposnse(int statuscode, dynamic response) {
    if (statuscode == 400 || statuscode == 401 || statuscode == 403) {
      return serverFailure(response);
    } else if (statuscode == 404) {
      return serverFailure("you request not found try later");
    } else if (statuscode == 500) {
      return serverFailure('internal server error');
    } else if (statuscode == 422) {
      return serverFailure(response);
    } else {
      return serverFailure("oops there was an errro");
    }
  }
}
