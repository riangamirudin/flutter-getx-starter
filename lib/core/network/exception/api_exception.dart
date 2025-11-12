import 'package:flutter_getx_starter/core/network/models/failure_model.dart';

class ApiException implements Exception {
  final FailureModel failureModel;

  ApiException(this.failureModel);

}