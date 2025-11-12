// ignore_for_file: constant_identifier_names

class BasicModel {

  static const BASIC_SUCCESS = "success";
  static const BASIC_MESSAGE = "message";
  static const BASIC_DATA = "data";
  static const BASIC_ERROR = "error";
  
  bool success = false;
  String? message;
  dynamic error;
  dynamic data;

  BasicModel({this.success = false, this.message, this.error, this.data});

  BasicModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      success = false;
    } else {
      success = json[BASIC_SUCCESS] ?? true;
      message = json[BASIC_MESSAGE];
      data = json[BASIC_DATA];
      error = json[BASIC_ERROR];
    }
  }

  Map<String, dynamic> toJson(BasicModel model) => <String, dynamic>{
    BASIC_SUCCESS: model.success,
    BASIC_MESSAGE: model.message,
    BASIC_ERROR: model.error,
    BASIC_DATA: model.data,
  };
}