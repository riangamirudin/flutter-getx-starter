import 'package:flutter_getx_starter/core/network/models/failure_model.dart';

enum StatusRequest { none, loading, success, empty, error }

class StatusRequestModel<T> {
  StatusRequest statusRequest = StatusRequest.none;
  T? data;
  FailureModel? failure;

  StatusRequestModel({
    this.statusRequest = StatusRequest.none,
    this.data,
    this.failure,
  });

  factory StatusRequestModel.fromStatus(StatusRequest status, {T? data, FailureModel? failure}) {
    switch (status) {
      case StatusRequest.empty:
        return StatusRequestModel.empty();
      case StatusRequest.loading:
        return StatusRequestModel.loading();
      case StatusRequest.success:
        return StatusRequestModel.success(data);
      case StatusRequest.error:
        return StatusRequestModel.error(failure);
      default:
        return StatusRequestModel.empty();
    }
  }

  StatusRequestModel.empty() {
    statusRequest = StatusRequest.empty;
    data = null;
    failure = null;
  }

  StatusRequestModel.loading() {
    statusRequest = StatusRequest.loading;
    data = null;
    failure = null;
  }

  StatusRequestModel.success(T? response) {
    statusRequest = StatusRequest.success;
    data = response;
    failure = null;
  }

  StatusRequestModel.error(FailureModel? error) {
    statusRequest = StatusRequest.empty;
    data = null;
    failure = error;
  }

  void handle({
    Function? onLoading,
    Function(T? data)? onSuccess,
    Function? onEmpty,
    Function(FailureModel? failure)? onError
  }) {
    switch (statusRequest) {
      case StatusRequest.loading:
        if (onLoading != null) onLoading();
        break;
      case StatusRequest.success:
        if (onSuccess != null) onSuccess(data);
        break;
      case StatusRequest.error:
        if (onError != null) onError(failure);
        break;
      case StatusRequest.none:
      case StatusRequest.empty:
        if (onEmpty != null) onEmpty();
        break;
    }
  }
}
