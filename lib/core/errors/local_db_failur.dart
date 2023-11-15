import 'failure.dart';

class LocalDBFailure extends Failure {
  LocalDBFailure(super.message);

  factory LocalDBFailure.prefsError(String message) {
    return LocalDBFailure(message);
  }
}

String handleLocalDBError(e) {
  String error = LocalDBFailure(e.toString()).message;
  return error;
}
